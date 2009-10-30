From: Jeff King <peff@peff.net>
Subject: Re: Bug#553296: gitignore broken completely
Date: Fri, 30 Oct 2009 15:05:52 -0400
Message-ID: <20091030190552.GA3528@coredump.intra.peff.net>
References: <20091029233458.GA32764@ikki.ethgen.de>
 <20091030162857.26604.qmail@67b7e3b41a17c8.315fe32.mid.smarden.org>
 <20091030165903.GA10671@ikki.ethgen.de>
 <20091030173838.GB18583@coredump.intra.peff.net>
 <20091030182331.GC10671@ikki.ethgen.de>
 <20091030184155.GC19901@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: 553296@bugs.debian.org, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Klaus Ethgen <Klaus@Ethgen.de>
X-From: git-owner@vger.kernel.org Fri Oct 30 20:07:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3wp3-000717-BU
	for gcvg-git-2@lo.gmane.org; Fri, 30 Oct 2009 20:07:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757339AbZJ3TF5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2009 15:05:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757328AbZJ3TF5
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Oct 2009 15:05:57 -0400
Received: from peff.net ([208.65.91.99]:54057 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756350AbZJ3TF4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2009 15:05:56 -0400
Received: (qmail 2290 invoked by uid 107); 30 Oct 2009 19:09:40 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 30 Oct 2009 15:09:40 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 30 Oct 2009 15:05:52 -0400
Content-Disposition: inline
In-Reply-To: <20091030184155.GC19901@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131730>

On Fri, Oct 30, 2009 at 02:41:55PM -0400, Jeff King wrote:

> >    6. Revert the patch and rework it so that it will only have effect if
> >       there is no -i option on the command line. (That is similiar to a
> >       mix of 3 and 4.)
> 
> Yeah, that would actually be the least invasive change, and would keep
> "-i" just as it is. If we do anything except a simple, I think your (6)
> makes the most sense.
> 
> Let me see if I can make a patch.

Here it is. I think this is the right thing to do. Junio?

-- >8 --
Subject: [PATCH] ls-files: unbreak "ls-files -i"

Commit b5227d8 changed the behavior of "ls-files" with
respect to includes, but accidentally broke the "-i" option
The original behavior was:

  1. if no "-i" is given, cull all results according to --exclude*
  2. if "-i" is given, show the inverse of (1)

The broken behavior was:

  1. if no "-i" is given:
     a. for "-o", cull results according to --exclude*
     b. for index files, always show all
  2. if "-i" is given:
     a. for "-o", shows the inverse of (1a)
     b. for index files, always show all

The fixed behavior keeps the new (1b) behavior introduced
by b5227d8, but fixes the (2b) behavior to show only ignored
files, not all files.

This patch also tweaks the documentation. The original text
was somewhat obscure in the first place, but it is also now
inaccurate (the relationship between (1b) and (2b) is not
quite a "reverse").

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/git-ls-files.txt |    6 ++++--
 builtin-ls-files.c             |    8 ++++++++
 t/t3003-ls-files-exclude.sh    |    8 ++++++++
 3 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
index 021066e..625723e 100644
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -48,8 +48,10 @@ OPTIONS
 
 -i::
 --ignored::
-	Show ignored files in the output.
-	Note that this also reverses any exclude list present.
+	Show only ignored files in the output. When showing files in the
+	index, print only those matched by an exclude pattern. When
+	showing "other" files, show only those matched by an exclude
+	pattern.
 
 -s::
 --stage::
diff --git a/builtin-ls-files.c b/builtin-ls-files.c
index c5c0407..c9a03e5 100644
--- a/builtin-ls-files.c
+++ b/builtin-ls-files.c
@@ -170,6 +170,10 @@ static void show_files(struct dir_struct *dir, const char *prefix)
 	if (show_cached | show_stage) {
 		for (i = 0; i < active_nr; i++) {
 			struct cache_entry *ce = active_cache[i];
+			int dtype = ce_to_dtype(ce);
+			if (dir->flags & DIR_SHOW_IGNORED &&
+			    !excluded(dir, ce->name, &dtype))
+				continue;
 			if (show_unmerged && !ce_stage(ce))
 				continue;
 			if (ce->ce_flags & CE_UPDATE)
@@ -182,6 +186,10 @@ static void show_files(struct dir_struct *dir, const char *prefix)
 			struct cache_entry *ce = active_cache[i];
 			struct stat st;
 			int err;
+			int dtype = ce_to_dtype(ce);
+			if (dir->flags & DIR_SHOW_IGNORED &&
+			    !excluded(dir, ce->name, &dtype))
+				continue;
 			if (ce->ce_flags & CE_UPDATE)
 				continue;
 			err = lstat(ce->name, &st);
diff --git a/t/t3003-ls-files-exclude.sh b/t/t3003-ls-files-exclude.sh
index fc1e379..d5ec333 100755
--- a/t/t3003-ls-files-exclude.sh
+++ b/t/t3003-ls-files-exclude.sh
@@ -29,4 +29,12 @@ test_expect_success 'add file to gitignore' '
 '
 check_all_output
 
+test_expect_success 'ls-files -i lists only tracked-but-ignored files' '
+	echo content >other-file &&
+	git add other-file &&
+	echo file >expect &&
+	git ls-files -i --exclude-standard >output &&
+	test_cmp expect output
+'
+
 test_done
-- 
1.6.5.2.224.g22719.dirty
