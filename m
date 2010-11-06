From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 8/8] Remove pack file handling dependency from wrapper.o
Date: Sat, 6 Nov 2010 06:52:37 -0500
Message-ID: <20101106115237.GH27641@burratino>
References: <20101106113905.GA27405@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	David Barr <david.barr@cordelta.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 06 12:52:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PEhKG-0005EE-9r
	for gcvg-git-2@lo.gmane.org; Sat, 06 Nov 2010 12:52:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754207Ab0KFLwq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Nov 2010 07:52:46 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:56115 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754176Ab0KFLwp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Nov 2010 07:52:45 -0400
Received: by gxk23 with SMTP id 23so2657856gxk.19
        for <git@vger.kernel.org>; Sat, 06 Nov 2010 04:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=KgEqEiIrtvkql9PLOoq6n3AVo6SmhD1IkP8QdIWgRsQ=;
        b=GRL8a9rFayIGaM7YqqMPXLakXe8I9WlZiZeZlUgP84oWUGfjv8XH1OSMtdO+P+/M4Y
         VHqoBsBtepFOhcCpoIVmWTk/CQ4r/fzv2hsUVz7SyWNF2ju/P889AvwzpSBUlS5+PotL
         /7ZMPSo+I1BH5SH8FSNZHUXcWdrZpYin+HfJY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=EdW4hqA0vx/WK8hd0Wz4qWFkElTqyrSw3hsByQyA2IlwqNX/1yl9ldYKEimzgdHDQg
         +Aiyzc9OjUnVyWqOQtZ78U3bKzanipu7u++lh+WYkG0fcOFgFE/qvsVWT6o+5sWVo2LS
         XvjvvXWStoiaKKhmhcA9NEq8oMKdQr3FeWP24=
Received: by 10.151.100.7 with SMTP id c7mr5171625ybm.223.1289044365069;
        Sat, 06 Nov 2010 04:52:45 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id r29sm505058ybn.10.2010.11.06.04.52.43
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 06 Nov 2010 04:52:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101106113905.GA27405@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160850>

Commands that might access a git repository should discard pack
windows when memory is tight, but helpers like show-index do not need
to.

So stop setting try_to_free_pack_memory as the default
try_to_free_routine and instead set up the try_to_free handler
explicitly in main() for callers that require it.

After this change, a simple program using xmalloc() and no other
functions will not pull in any code from libgit.a aside from wrapper.o
and usage.o.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Thanks for reading.  I hope it was not too dull.

Hopefully this will make svn-fe small again (it got big when the
vcs-svn lib started using strbufs).

Good night,
Jonathan

 check-racy.c                              |    1 +
 contrib/convert-objects/convert-objects.c |    1 +
 daemon.c                                  |    1 +
 fast-import.c                             |    1 +
 git.c                                     |    2 ++
 http-backend.c                            |    1 +
 http-fetch.c                              |    1 +
 http-push.c                               |    1 +
 imap-send.c                               |    1 +
 remote-curl.c                             |    1 +
 test-dump-cache-tree.c                    |    4 +++-
 test-match-trees.c                        |    1 +
 upload-pack.c                             |    1 +
 wrapper.c                                 |    6 +++++-
 14 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/check-racy.c b/check-racy.c
index 00d92a1..d4b2557 100644
--- a/check-racy.c
+++ b/check-racy.c
@@ -6,6 +6,7 @@ int main(int ac, char **av)
 	int dirty, clean, racy;
 
 	dirty = clean = racy = 0;
+	set_try_to_free_routine(try_to_free_pack_memory);
 	read_cache();
 	for (i = 0; i < active_nr; i++) {
 		struct cache_entry *ce = active_cache[i];
diff --git a/contrib/convert-objects/convert-objects.c b/contrib/convert-objects/convert-objects.c
index f3b57bf..983b917 100644
--- a/contrib/convert-objects/convert-objects.c
+++ b/contrib/convert-objects/convert-objects.c
@@ -317,6 +317,7 @@ int main(int argc, char **argv)
 	struct entry *entry;
 
 	setup_git_directory();
+	set_try_to_free_routine(try_to_free_pack_memory);
 
 	if (argc != 2)
 		usage("git-convert-objects <sha1>");
diff --git a/daemon.c b/daemon.c
index 9326d3a..ccf8960 100644
--- a/daemon.c
+++ b/daemon.c
@@ -976,6 +976,7 @@ int main(int argc, char **argv)
 	int i;
 
 	git_extract_argv0_path(argv[0]);
+	set_try_to_free_routine(try_to_free_pack_memory);
 
 	for (i = 1; i < argc; i++) {
 		char *arg = argv[i];
diff --git a/fast-import.c b/fast-import.c
index eab68d5..ccf81b1 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -2917,6 +2917,7 @@ int main(int argc, const char **argv)
 	unsigned int i;
 
 	git_extract_argv0_path(argv[0]);
+	set_try_to_free_routine(try_to_free_pack_memory);
 
 	if (argc == 2 && !strcmp(argv[1], "-h"))
 		usage(fast_import_usage);
diff --git a/git.c b/git.c
index 0409ac9..6386404 100644
--- a/git.c
+++ b/git.c
@@ -272,6 +272,8 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
 
 	trace_argv_printf(argv, "trace: built-in: git");
 
+	set_try_to_free_routine(try_to_free_pack_memory);
+
 	status = p->fn(argc, argv, prefix);
 	if (status)
 		return status;
diff --git a/http-backend.c b/http-backend.c
index 14c90c2..7d02e55 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -551,6 +551,7 @@ int main(int argc, char **argv)
 	int i;
 
 	git_extract_argv0_path(argv[0]);
+	set_try_to_free_routine(try_to_free_pack_memory);
 	set_die_routine(die_webcgi);
 
 	if (!method)
diff --git a/http-fetch.c b/http-fetch.c
index 762c750..98cefc7 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -25,6 +25,7 @@ int main(int argc, const char **argv)
 	int get_recover = 0;
 
 	git_extract_argv0_path(argv[0]);
+	set_try_to_free_routine(try_to_free_pack_memory);
 
 	while (arg < argc && argv[arg][0] == '-') {
 		if (argv[arg][1] == 't') {
diff --git a/http-push.c b/http-push.c
index c9bcd11..fc25aeb 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1792,6 +1792,7 @@ int main(int argc, char **argv)
 	char *rewritten_url = NULL;
 
 	git_extract_argv0_path(argv[0]);
+	set_try_to_free_routine(try_to_free_pack_memory);
 
 	repo = xcalloc(sizeof(*repo), 1);
 
diff --git a/imap-send.c b/imap-send.c
index 71506a8..8056144 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1538,6 +1538,7 @@ int main(int argc, char **argv)
 	int nongit_ok;
 
 	git_extract_argv0_path(argv[0]);
+	set_try_to_free_routine(try_to_free_pack_memory);
 
 	if (argc != 1)
 		usage(imap_send_usage);
diff --git a/remote-curl.c b/remote-curl.c
index 04d4813..4c2b03a 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -788,6 +788,7 @@ int main(int argc, const char **argv)
 	int nongit;
 
 	git_extract_argv0_path(argv[0]);
+	set_try_to_free_routine(try_to_free_pack_memory);
 	setup_git_directory_gently(&nongit);
 	if (argc < 2) {
 		fprintf(stderr, "Remote needed\n");
diff --git a/test-dump-cache-tree.c b/test-dump-cache-tree.c
index 1f73f1e..a6faa89 100644
--- a/test-dump-cache-tree.c
+++ b/test-dump-cache-tree.c
@@ -56,7 +56,9 @@ static int dump_cache_tree(struct cache_tree *it,
 
 int main(int ac, char **av)
 {
-	struct cache_tree *another = cache_tree();
+	struct cache_tree *another;
+	set_try_to_free_routine(try_to_free_pack_memory);
+	another = cache_tree();
 	if (read_cache() < 0)
 		die("unable to read index file");
 	cache_tree_update(another, active_cache, active_nr, 0, 1);
diff --git a/test-match-trees.c b/test-match-trees.c
index a3c4688..c543fee 100644
--- a/test-match-trees.c
+++ b/test-match-trees.c
@@ -6,6 +6,7 @@ int main(int ac, char **av)
 	unsigned char hash1[20], hash2[20], shifted[20];
 	struct tree *one, *two;
 
+	set_try_to_free_routine(try_to_free_pack_memory);
 	if (get_sha1(av[1], hash1))
 		die("cannot parse %s as an object name", av[1]);
 	if (get_sha1(av[2], hash2))
diff --git a/upload-pack.c b/upload-pack.c
index f05e422..d654e8b 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -683,6 +683,7 @@ int main(int argc, char **argv)
 	int strict = 0;
 
 	git_extract_argv0_path(argv[0]);
+	set_try_to_free_routine(try_to_free_pack_memory);
 	read_replace_refs = 0;
 
 	for (i = 1; i < argc; i++) {
diff --git a/wrapper.c b/wrapper.c
index 6c6579b..4c1639f 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -3,7 +3,11 @@
  */
 #include "cache.h"
 
-static void (*try_to_free_routine)(size_t size) = try_to_free_pack_memory;
+static void do_nothing(size_t size)
+{
+}
+
+static void (*try_to_free_routine)(size_t size) = do_nothing;
 
 try_to_free_t set_try_to_free_routine(try_to_free_t routine)
 {
-- 
1.7.2.3.557.gab647.dirty
