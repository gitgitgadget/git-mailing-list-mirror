From: Ivan Todoroski <grnch@gmx.net>
Subject: [PATCH v3 1/4] fetch-pack: new --stdin option to read refs from stdin
Date: Mon, 02 Apr 2012 17:13:48 +0200
Message-ID: <4F79C22C.9080702@gmx.net>
References: <4F79C195.6090905@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 02 17:13:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SEiwg-0004eI-5D
	for gcvg-git-2@plane.gmane.org; Mon, 02 Apr 2012 17:13:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752807Ab2DBPNV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Apr 2012 11:13:21 -0400
Received: from mailout-de.gmx.net ([213.165.64.23]:48166 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751854Ab2DBPNU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Apr 2012 11:13:20 -0400
Received: (qmail invoked by alias); 02 Apr 2012 15:13:18 -0000
Received: from unknown (EHLO [127.0.0.1]) [77.28.163.38]
  by mail.gmx.net (mp041) with SMTP; 02 Apr 2012 17:13:18 +0200
X-Authenticated: #7905487
X-Provags-ID: V01U2FsdGVkX19yl8FMxaNyA/yI7y1LdNhfrXy/5aGLVLEdvGcqRa
	FU6/JzjVJyaUwx
User-Agent: Thunderbird 2.0.0.24 (Windows/20100228)
In-Reply-To: <4F79C195.6090905@gmx.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194517>

If a remote repo has too many tags (or branches), cloning it over the
smart HTTP transport can fail because remote-curl.c puts all the refs
from the remote repo on the fetch-pack command line. This can make the
command line longer than the global OS command line limit, causing
fetch-pack to fail.

This is especially a problem on Windows where the command line limit is
orders of magnitude shorter than Linux. There are already real repos out
there that msysGit cannot clone over smart HTTP due to this problem.

Here is an easy way to trigger this problem:

	git init too-many-refs
	cd too-many-refs
	echo bla > bla.txt
	git add .
	git commit -m test
	sha=$(git rev-parse HEAD)
	tag=$(perl -e 'print "bla" x 30')
	for i in `seq 50000`; do
		echo $sha refs/tags/$tag-$i >> .git/packed-refs
	done

Then share this repo over the smart HTTP protocol and try cloning it:

	$ git clone http://localhost/.../too-many-refs/.git
	Cloning into 'too-many-refs'...
	fatal: cannot exec 'fetch-pack': Argument list too long

50k tags is obviously an absurd number, but it is required to
demonstrate the problem on Linux because it has a much more generous
command line limit. On Windows the clone fails with as little as 500
tags in the above loop, which is getting uncomfortably close to the
number of tags you might see in real long lived repos.

This is not just theoretical, msysGit is already failing to clone our
company repo due to this. It's a large repo converted from CVS, nearly
10 years of history.

Four possible solutions were discussed on the Git mailing list (in no
particular order):

1) Call fetch-pack multiple times with smaller batches of refs.

This was dismissed as inefficient and inelegant.

2) Add option --refs-fd=$n to pass a an fd from where to read the refs.

This was rejected because inheriting descriptors other than
stdin/stdout/stderr through exec() is apparently problematic on Windows,
plus it would require changes to the run-command API to open extra
pipes.

3) Add option --refs-from=$tmpfile to pass the refs using a temp file.

This was not favored because of the temp file requirement.

4) Add option --stdin to pass the refs on stdin, one per line.

In the end this option was chosen as the most efficient and most
desirable from scripting perspective.

There was however a small complication when using stdin to pass refs to
fetch-pack. The --stateless-rpc option to fetch-pack also uses stdin for
communication with the remote server.

If we are going to sneak refs on stdin line by line, it would have to be
done very carefully in the presence of --stateless-rpc, because when
reading refs line by line we might read ahead too much data into our
buffer and eat some of the remote protocol data which is also coming on
stdin.

One way to solve this would be to refactor get_remote_heads() in
fetch-pack.c to accept a residual buffer from our stdin line parsing
above, but this function is used in several places so other callers
would be burdened by this residual buffer interface even when most of
them don't need it.

In the end we settled on the following solution:

If --stdin is specified without --stateless-rpc, fetch-pack would read
the refs from stdin one per line, in a script friendly format.

However if --stdin is specified together with --stateless-rpc,
fetch-pack would read the refs from stdin in packetized format
(pkt-line) with a flush packet terminating the list of refs. This way we
can read the exact number of bytes that we need from stdin, and then
get_remote_heads() can continue reading from the same fd without losing
a single byte of remote protocol data.

This way the --stdin option only loses generality and scriptability when
used together with --stateless-rpc, which is not easily scriptable
anyway because it also uses pkt-line when talking to the remote server.

Signed-off-by: Ivan Todoroski <grnch@gmx.net>
---
 Documentation/git-fetch-pack.txt |   10 +++++++++
 builtin/fetch-pack.c             |   42 +++++++++++++++++++++++++++++++++++++-
 fetch-pack.h                     |    1 +
 3 files changed, 52 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-fetch-pack.txt b/Documentation/git-fetch-pack.txt
index ed1bdaacd1..474fa307a0 100644
--- a/Documentation/git-fetch-pack.txt
+++ b/Documentation/git-fetch-pack.txt
@@ -32,6 +32,16 @@ OPTIONS
 --all::
 	Fetch all remote refs.
 
+--stdin::
+	Take the list of refs from stdin, one per line. If there
+	are refs specified on the command line in addition to this
+	option, then the refs from stdin are processed after those
+	on the command line.
++
+If '--stateless-rpc' is specified together with this option then
+the list of refs must be in packet format (pkt-line). Each ref must
+be in a separate packet, and the list must end with a flush packet.
+
 -q::
 --quiet::
 	Pass '-q' flag to 'git unpack-objects'; this makes the
diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index a4d3e90a86..36bc83975a 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -23,7 +23,9 @@ static struct fetch_pack_args args = {
 };
 
 static const char fetch_pack_usage[] =
-"git fetch-pack [--all] [--quiet|-q] [--keep|-k] [--thin] [--include-tag] [--upload-pack=<git-upload-pack>] [--depth=<n>] [--no-progress] [-v] [<host>:]<directory> [<refs>...]";
+"git fetch-pack [--all] [--stdin] [--quiet|-q] [--keep|-k] [--thin] "
+"[--include-tag] [--upload-pack=<git-upload-pack>] [--depth=<n>] "
+"[--no-progress] [-v] [<host>:]<directory> [<refs>...]";
 
 #define COMPLETE	(1U << 0)
 #define COMMON		(1U << 1)
@@ -941,6 +943,10 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 				args.fetch_all = 1;
 				continue;
 			}
+			if (!strcmp("--stdin", arg)) {
+				args.stdin_refs = 1;
+				continue;
+			}
 			if (!strcmp("-v", arg)) {
 				args.verbose = 1;
 				continue;
@@ -972,6 +978,40 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 	if (!dest)
 		usage(fetch_pack_usage);
 
+	if (args.stdin_refs) {
+		/* copy refs from cmdline to new growable list,
+		 * then append the refs from stdin
+		 */
+		int alloc_heads = nr_heads;
+		int size = nr_heads * sizeof(*heads);
+		heads = memcpy(xmalloc(size), heads, size);
+		if (args.stateless_rpc) {
+			/* in stateless RPC mode we use pkt-line to read
+			 * from stdin, until we get a flush packet
+			 */
+			static char line[1000];
+			for (;;) {
+				int n = packet_read_line(0, line, sizeof(line));
+				if (!n)
+					break;
+				if (line[n-1] == '\n')
+					n--;
+				ALLOC_GROW(heads, nr_heads + 1, alloc_heads);
+				heads[nr_heads++] = xmemdupz(line, n);
+			}
+		}
+		else {
+			/* read from stdin one ref per line, until EOF */
+			struct strbuf line;
+			strbuf_init(&line, 0);
+			while (strbuf_getline(&line, stdin, '\n') != EOF) {
+				ALLOC_GROW(heads, nr_heads + 1, alloc_heads);
+				heads[nr_heads++] = strbuf_detach(&line, NULL);
+			}
+			strbuf_release(&line);
+		}
+	}
+
 	if (args.stateless_rpc) {
 		conn = NULL;
 		fd[0] = 0;
diff --git a/fetch-pack.h b/fetch-pack.h
index 0608edae3f..7c2069c972 100644
--- a/fetch-pack.h
+++ b/fetch-pack.h
@@ -10,6 +10,7 @@ struct fetch_pack_args {
 		lock_pack:1,
 		use_thin_pack:1,
 		fetch_all:1,
+		stdin_refs:1,
 		verbose:1,
 		no_progress:1,
 		include_tag:1,
-- 
1.7.9.5.4.g4f508
