From: Tom Grennan <tmgrennan@gmail.com>
Subject: [PATCHv3 5/5] for-each-ref --exclude option
Date: Tue, 21 Feb 2012 17:28:50 -0800
Message-ID: <1329874130-16818-6-git-send-email-tmgrennan@gmail.com>
References: <1329874130-16818-1-git-send-email-tmgrennan@gmail.com>
Cc: gitster@pobox.com, peff@peff.net, jasampler@gmail.com,
	pclouds@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 22 02:29:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S011I-0004IQ-51
	for gcvg-git-2@plane.gmane.org; Wed, 22 Feb 2012 02:29:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753816Ab2BVB3P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Feb 2012 20:29:15 -0500
Received: from mail-qw0-f53.google.com ([209.85.216.53]:56034 "EHLO
	mail-qw0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753710Ab2BVB3L (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Feb 2012 20:29:11 -0500
Received: by mail-qw0-f53.google.com with SMTP id k1so7771133qaf.19
        for <git@vger.kernel.org>; Tue, 21 Feb 2012 17:29:11 -0800 (PST)
Received-SPF: pass (google.com: domain of tmgrennan@gmail.com designates 10.229.136.19 as permitted sender) client-ip=10.229.136.19;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of tmgrennan@gmail.com designates 10.229.136.19 as permitted sender) smtp.mail=tmgrennan@gmail.com; dkim=pass header.i=tmgrennan@gmail.com
Received: from mr.google.com ([10.229.136.19])
        by 10.229.136.19 with SMTP id p19mr21325356qct.133.1329874151508 (num_hops = 1);
        Tue, 21 Feb 2012 17:29:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references;
        bh=nE0xKMw01D6+uWQCRy+W1EqNsIEPPuzMIrD68/KDY1g=;
        b=XjbpevJlgU8gXGXHnxoiRdkVfLifl3k5Mf8FGwBrkYBaKRaFoDkNYZKsM7ZoFWFNfq
         B0uOH7ov52q6sbje/3qVL7q8mgFgre1iI8tSVK+HT5cVWAKhr7HXhSMaLeFbl13fwUNl
         E+KxD9AGdSWIhUtwy3cjjx6L5c2DOI0oQFRJQ=
Received: by 10.229.136.19 with SMTP id p19mr18058048qct.133.1329874151428;
        Tue, 21 Feb 2012 17:29:11 -0800 (PST)
Received: from tgrennan-laptop.lab.redback.com ([129.192.185.163])
        by mx.google.com with ESMTPS id n8sm2148026qan.12.2012.02.21.17.29.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 21 Feb 2012 17:29:10 -0800 (PST)
X-Mailer: git-send-email 1.7.8
In-Reply-To: <1329874130-16818-1-git-send-email-tmgrennan@gmail.com>
In-Reply-To: <20120211190856.GB4903@tgrennan-laptop>
References: <20120211190856.GB4903@tgrennan-laptop>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191213>

Example,
  $ git for-each-ref --format="%(refname)" refs/remotes/origin
  refs/remotes/origin/HEAD
  refs/remotes/origin/maint
  refs/remotes/origin/master
  refs/remotes/origin/next
  refs/remotes/origin/pu
  refs/remotes/origin/todo
  $ ./git-for-each-ref --format="%(refname)" --exclude "*/HEAD" refs/remotes/origin
  refs/remotes/origin/maint
  refs/remotes/origin/master
  refs/remotes/origin/next
  refs/remotes/origin/pu
  refs/remotes/origin/todo

Signed-off-by: Tom Grennan <tmgrennan@gmail.com>
---
 Documentation/git-for-each-ref.txt |    7 ++++++-
 builtin/for-each-ref.c             |    8 +++++++-
 t/t6300-for-each-ref.sh            |   11 +++++++++++
 3 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index c872b88..5f19a8b 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -9,7 +9,8 @@ SYNOPSIS
 --------
 [verse]
 'git for-each-ref' [--count=<count>] [--shell|--perl|--python|--tcl]
-		   [(--sort=<key>)...] [--format=<format>] [<pattern>...]
+		   [(--sort=<key>)...] [--format=<format>]
+		   [--exclude=<pattern>] [<pattern>...]
 
 DESCRIPTION
 -----------
@@ -47,6 +48,10 @@ OPTIONS
 	`xx`; for example `%00` interpolates to `\0` (NUL),
 	`%09` to `\t` (TAB) and `%0a` to `\n` (LF).
 
+--exclude <pattern>::
+	Ignore refs matching the given pattern.  This has precedence
+	over any other pattern match arguments.
+
 <pattern>...::
 	If one or more patterns are given, only refs are shown that
 	match against at least one pattern, either using fnmatch(3) or
diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index bd6a114..783f59f 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -91,6 +91,9 @@ static const char **used_atom;
 static cmp_type *used_atom_type;
 static int used_atom_cnt, sort_atom_limit, need_tagged, need_symref;
 
+/* list of ref patterns and ref groups (i.e. foo/) to ignore */
+static struct string_list exclude = STRING_LIST_INIT_NODUP;
+
 /*
  * Used to parse format string and sort specifiers
  */
@@ -781,7 +784,7 @@ static int grab_single_ref(const char *refname, const unsigned char *sha1, int f
 	struct refinfo *ref;
 	int cnt;
 
-	if (!match_pattern(refname, cb->grab_pattern, NULL, FNM_PATHNAME))
+	if (!match_pattern(refname, cb->grab_pattern, &exclude, FNM_PATHNAME))
 		return 0;
 
 	/*
@@ -985,6 +988,9 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 		OPT_STRING(  0 , "format", &format, "format", "format to use for the output"),
 		OPT_CALLBACK(0 , "sort", sort_tail, "key",
 		            "field name to sort on", &opt_parse_sort),
+		OPT_CALLBACK(0, "exclude", &exclude, "pattern",
+			     "ignore pattern matching refs",
+			     parse_opt_string_list),
 		OPT_END(),
 	};
 
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 1721784..26df442 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -243,6 +243,17 @@ test_expect_success 'Verify descending sort' '
 '
 
 cat >expected <<\EOF
+refs/tags/testtag
+refs/heads/master
+EOF
+
+test_expect_success 'Verify exclusion with sort' '
+	git for-each-ref --format="%(refname)" --sort=-refname \
+		--exclude "*origin*" >actual &&
+	test_cmp expected actual
+'
+
+cat >expected <<\EOF
 'refs/heads/master'
 'refs/remotes/origin/master'
 'refs/tags/testtag'
-- 
1.7.8
