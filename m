From: Ivan Todoroski <grnch@gmx.net>
Subject: [PATCH/RFC v2 1/4] fetch-pack: new --stdin option to read refs from
 stdin
Date: Tue, 27 Mar 2012 08:25:25 +0200
Message-ID: <4F715D55.8020109@gmx.net>
References: <loom.20120318T083216-96@post.gmane.org> <m3fwd550j3.fsf@localhost.localdomain> <20120318190659.GA24829@sigill.intra.peff.net> <CACsJy8BNT-dY+wDONY_TgLnv0135RZ-47BEVMzX6c3ddH=83Zw@mail.gmail.com> <20120319024436.GB10426@sigill.intra.peff.net> <4F69B5F0.2060605@gmx.net> <CAJo=hJu0H5wfXB_y5XQ6=S0VJ9t4pxHWkuy_=rehJL_6psf00g@mail.gmail.com> <20120321171423.GA13140@sigill.intra.peff.net> <4F715CF7.5070903@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Shawn Pearce <spearce@spearce.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 27 08:25:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCPq3-0001Dk-Nt
	for gcvg-git-2@plane.gmane.org; Tue, 27 Mar 2012 08:25:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756920Ab2C0GY5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Mar 2012 02:24:57 -0400
Received: from mailout-de.gmx.net ([213.165.64.22]:42420 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751318Ab2C0GY4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2012 02:24:56 -0400
Received: (qmail invoked by alias); 27 Mar 2012 06:24:54 -0000
Received: from unknown (EHLO [127.0.0.1]) [77.28.160.201]
  by mail.gmx.net (mp034) with SMTP; 27 Mar 2012 08:24:54 +0200
X-Authenticated: #7905487
X-Provags-ID: V01U2FsdGVkX1/8Zf42Dbf8lUhNxJ719SqXTkdWh1OuWxiA9/Xwfx
	G3of4pK8aQOaKk
User-Agent: Thunderbird 2.0.0.24 (Windows/20100228)
In-Reply-To: <4F715CF7.5070903@gmx.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194020>

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
for ((i=0; i<50000; i++)); do
	echo $sha refs/tags/artificially-long-tag-name-to-more-easily-\
demonstrate-the-problem-$i >> .git/packed-refs
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

If we were going to sneak refs on stdin line by line in the presence of
--stateless-rpc it would have to be done very carefully, because when
reading refs one by line we might buffer too much data ahead and eat
some of the remote protocol data also coming on stdin.

One way to solve this would be refactor get_remote_heads() in
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
---
 Documentation/git-fetch-pack.txt |   10 +++++++++
 builtin/fetch-pack.c             |   45 +++++++++++++++++++++++++++++++++++++-
 fetch-pack.h                     |    3 ++-
 3 files changed, 56 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-fetch-pack.txt b/Documentation/git-fetch-pack.txt
index ed1bdaacd1..1dd44fd348 100644
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
+the list of refs must be in packet format (pkt-line) with a flush
+packet terminating the list.
+
 -q::
 --quiet::
 	Pass '-q' flag to 'git unpack-objects'; this makes the
diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index a4d3e90a86..1a90fa852f 100644
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
+				args.refs_from_stdin = 1;
+				continue;
+			}
 			if (!strcmp("-v", arg)) {
 				args.verbose = 1;
 				continue;
@@ -972,6 +978,43 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 	if (!dest)
 		usage(fetch_pack_usage);
 
+	if (args.refs_from_stdin) {
+		/* copy refs from cmdline to new growable list,
+		   then append the refs from stdin */
+		int alloc_heads = nr_heads;
+		int size = nr_heads * sizeof(*heads);
+		heads = memcpy(xmalloc(size), heads, size);
+		if (args.stateless_rpc) {
+			/* in stateless RPC mode we use pkt-line to read
+			   from stdin, until we get a flush packet */
+			static char line[1000];
+			for (;;) {
+				int n = packet_read_line(0, line, sizeof(line));
+				if (!n)
+					break;
+				if (line[n-1] == '\n')
+					line[--n] = '\0';
+				ALLOC_GROW(heads, nr_heads + 1, alloc_heads);
+				heads[nr_heads++] = xmemdupz(line, n);
+			}
+		}
+		else {
+			/* read from stdin one ref per line, until EOF */
+			struct strbuf line;
+			strbuf_init(&line, 0);
+			for (;;) {
+				if (strbuf_getline(&line, stdin, '\n') == EOF)
+					break;
+				strbuf_trim(&line);
+				if (!line.len)
+					continue; /* skip empty lines */
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
index 0608edae3f..292d69389e 100644
--- a/fetch-pack.h
+++ b/fetch-pack.h
@@ -13,7 +13,8 @@ struct fetch_pack_args {
 		verbose:1,
 		no_progress:1,
 		include_tag:1,
-		stateless_rpc:1;
+		stateless_rpc:1,
+		refs_from_stdin:1;
 };
 
 struct ref *fetch_pack(struct fetch_pack_args *args,
-- 
1.7.9.5.4.g4f508
