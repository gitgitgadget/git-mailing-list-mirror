From: Tom Grennan <tmgrennan@gmail.com>
Subject: [PATCHv2 2/4] tag: use refs.c:refname_match_patterns()
Date: Fri, 10 Feb 2012 18:16:56 -0800
Message-ID: <1328926618-17167-3-git-send-email-tmgrennan@gmail.com>
References: <1328926618-17167-1-git-send-email-tmgrennan@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, krh@redhat.com,
	jasampler@gmail.com
To: pclouds@gmail.com
X-From: git-owner@vger.kernel.org Sat Feb 11 03:18:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rw2XI-0002so-Nn
	for gcvg-git-2@plane.gmane.org; Sat, 11 Feb 2012 03:18:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761210Ab2BKCRx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Feb 2012 21:17:53 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:39102 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754854Ab2BKCRt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Feb 2012 21:17:49 -0500
Received: by qadc10 with SMTP id c10so674260qad.19
        for <git@vger.kernel.org>; Fri, 10 Feb 2012 18:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references;
        bh=0ivXem83o1GKnUHwrDkkM+s1UpnLsJk8n5wDdjYbcio=;
        b=tlak+AfXresnELRNt43To/XsORfYO9KVnMc/KotNwG2N+jz9NtOv8RpSfjCnPTdLLw
         tP0w9el0UcEJJtXgkz2F1lCp/HsjeX3o+ilQd+xgCjjWHYztRN78+JrvrSyQqJ+pewN5
         CzGTFdvs6VJoRvcLqdug579t+EpNR5ImriKzE=
Received: by 10.224.116.144 with SMTP id m16mr1582058qaq.19.1328926637563;
        Fri, 10 Feb 2012 18:17:17 -0800 (PST)
Received: from tgrennan-laptop.lab.redback.com ([129.192.185.163])
        by mx.google.com with ESMTPS id fd1sm16844239qab.1.2012.02.10.18.17.15
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 10 Feb 2012 18:17:16 -0800 (PST)
X-Mailer: git-send-email 1.7.8
In-Reply-To: <1328926618-17167-1-git-send-email-tmgrennan@gmail.com>
In-Reply-To: <20120210185516.GA4903@tgrennan-laptop>
References: <20120210185516.GA4903@tgrennan-laptop>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190478>

This will exclude tags matching patterns prefaced with the '!'
character.  This has precedence over other matching patterns.
For example,

  $ git tag -l \!*-rc? v1.7.8*
  v1.7.8
  v1.7.8.1
  v1.7.8.2
  v1.7.8.3
  v1.7.8.4
  $ git tag -l v1.7.8* \!*-rc?
  v1.7.8
  v1.7.8.1
  v1.7.8.2
  v1.7.8.3
  v1.7.8.4

This is equivalent to,

  $ git tag -l v1.7.8* | grep -v '\-rc.'

Without a matching pattern, filter all tags with the "!" patterns,
  $ ./git-tag -l \!*-rc?
  gitgui-0.10.0
  gitgui-0.10.1
  gitgui-0.10.2
  ...
  v1.7.8.3
  v1.7.8.4
  v1.7.9

That is equivalent to,

  $ git tag -l | grep -v '\-rc.'

Signed-off-by: Tom Grennan <tmgrennan@gmail.com>
---
 Documentation/git-tag.txt |   10 ++++++----
 builtin/tag.c             |   15 ++-------------
 2 files changed, 8 insertions(+), 17 deletions(-)

diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 53ff5f6..56ea2fa 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -12,7 +12,7 @@ SYNOPSIS
 'git tag' [-a | -s | -u <key-id>] [-f] [-m <msg> | -F <file>]
 	<tagname> [<commit> | <object>]
 'git tag' -d <tagname>...
-'git tag' [-n[<num>]] -l [--contains <commit>] [<pattern>...]
+'git tag' [-n[<num>]] -l [--contains <commit>] [[!]<pattern>...]
 'git tag' -v <tagname>...
 
 DESCRIPTION
@@ -75,13 +75,15 @@ OPTIONS
 	If no number is given to `-n`, only the first line is printed.
 	If the tag is not annotated, the commit message is displayed instead.
 
--l <pattern>::
---list <pattern>::
+-l [!]<pattern>::
+--list [!]<pattern>::
 	List tags with names that match the given pattern (or all if no
 	pattern is given).  Running "git tag" without arguments also
 	lists all tags. The pattern is a shell wildcard (i.e., matched
 	using fnmatch(3)).  Multiple patterns may be given; if any of
-	them matches, the tag is shown.
+	them matches, the tag is shown.  If the pattern is prefaced with
+	the '!' character, all tags matching the pattern are filtered
+	from the list.
 
 --contains <commit>::
 	Only list tags which contain the specified commit.
diff --git a/builtin/tag.c b/builtin/tag.c
index 31f02e8..7f99424 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -19,7 +19,7 @@
 static const char * const git_tag_usage[] = {
 	"git tag [-a|-s|-u <key-id>] [-f] [-m <msg>|-F <file>] <tagname> [<head>]",
 	"git tag -d <tagname>...",
-	"git tag -l [-n[<num>]] [<pattern>...]",
+	"git tag -l [-n[<num>]] [[!]<pattern>...]",
 	"git tag -v <tagname>...",
 	NULL
 };
@@ -30,17 +30,6 @@ struct tag_filter {
 	struct commit_list *with_commit;
 };
 
-static int match_pattern(const char **patterns, const char *ref)
-{
-	/* no pattern means match everything */
-	if (!*patterns)
-		return 1;
-	for (; *patterns; patterns++)
-		if (!fnmatch(*patterns, ref, 0))
-			return 1;
-	return 0;
-}
-
 static int in_commit_list(const struct commit_list *want, struct commit *c)
 {
 	for (; want; want = want->next)
@@ -88,7 +77,7 @@ static int show_reference(const char *refname, const unsigned char *sha1,
 {
 	struct tag_filter *filter = cb_data;
 
-	if (match_pattern(filter->patterns, refname)) {
+	if (refname_match_patterns(filter->patterns, refname)) {
 		int i;
 		unsigned long size;
 		enum object_type type;
-- 
1.7.8
