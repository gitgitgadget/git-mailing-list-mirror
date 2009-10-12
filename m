From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH/RFC 3/4] git check-ref-format --print
Date: Mon, 12 Oct 2009 00:31:42 -0500
Message-ID: <20091012053141.GD11106@progeny.tock>
References: <4AD0C93C.6050306@web.de>
 <7vws327wbp.fsf@alter.siamese.dyndns.org>
 <20091012052536.GA11106@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 12 07:29:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxDTP-0000T2-FN
	for gcvg-git-2@lo.gmane.org; Mon, 12 Oct 2009 07:29:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752543AbZJLFXx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2009 01:23:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752505AbZJLFXw
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Oct 2009 01:23:52 -0400
Received: from mail-yx0-f188.google.com ([209.85.210.188]:37955 "EHLO
	mail-yx0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752334AbZJLFXw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2009 01:23:52 -0400
Received: by yxe26 with SMTP id 26so3251827yxe.4
        for <git@vger.kernel.org>; Sun, 11 Oct 2009 22:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=bgEeFtgOJqUk1w43iejEhh+yBN1SI14qJDmNdV8QvhU=;
        b=i4Yv5Vo++gwTwWk5mS/TSwKfsQvft0FJs0YuM2/OWnpj2fIHHODwJJZ/Wz81suPHII
         zODDBJlId6rInEB1RsGr+gvk6+Db394H4eh4+jceEfyOcSCLDYJyEJf7drE0RZ3hrsSh
         enfqUSG+M9plXgvvfW6xzxMhMq5PsMnasynik=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=S0y8YmWK4L7QHZMpg8oRdfA7jjhivmW/KEgPrzfq/3QNzysPK+UKp6XnWnJT67GdPp
         Rh10EAo4EK7FAwrlRSSEH3bJIq2izeGEI9p9P42xkK2cztlVx8vAeN3uLIp7bydmd3QC
         c7LgtY5IA9dguxSQM7AyG3g4xRYHsZ1bfkKI8=
Received: by 10.151.28.10 with SMTP id f10mr9403498ybj.71.1255324995800;
        Sun, 11 Oct 2009 22:23:15 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 16sm270304gxk.7.2009.10.11.22.23.14
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 11 Oct 2009 22:23:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20091012052536.GA11106@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129982>

Tolerating empty path components in ref names means each ref does
not have a unique name.  This creates difficulty for porcelains
that want to see if two branches are equal.  Add a helper associating
to each ref a canonical name.

If a user asks a porcelain to create a ref "refs/heads//master",
the porcelain can run "git check-ref-format --print refs/heads//master"
and only deal with "refs/heads/master" from then on.

In the future, it would be very nice if this command could be
modified to transform Unicode ref names to some appropriate
normalization form, to make Unicode ref names usable in Mac OS X,
too, and less confusing everywhere.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/git-check-ref-format.txt |   25 +++++++++++++++++++------
 builtin-check-ref-format.c             |   10 ++++++++++
 t/t1402-check-ref-format.sh            |   17 +++++++++++++++++
 3 files changed, 46 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-check-ref-format.txt b/Documentation/git-check-ref-format.txt
index e9b3b40..0aeef24 100644
--- a/Documentation/git-check-ref-format.txt
+++ b/Documentation/git-check-ref-format.txt
@@ -9,6 +9,7 @@ SYNOPSIS
 --------
 [verse]
 'git check-ref-format' <refname>
+'git check-ref-format' --print <refname>
 'git check-ref-format' --branch <branchname-shorthand>
 
 DESCRIPTION
@@ -63,19 +64,31 @@ reference name expressions (see linkgit:git-rev-parse[1]):
 
 . at-open-brace `@{` is used as a notation to access a reflog entry.
 
+With the `--print` option, if 'refname' is acceptable, it prints the
+canonicalized name of a hypothetical reference with that name.  That is,
+it prints 'refname' with any extra `/` characters removed.
+
 With the `--branch` option, it expands the ``previous branch syntax''
 `@{-n}`.  For example, `@{-1}` is a way to refer the last branch you
 were on.  This option should be used by porcelains to accept this
 syntax anywhere a branch name is expected, so they can act as if you
 typed the branch name.
 
-EXAMPLE
--------
-
-git check-ref-format --branch @{-1}::
-
-Print the name of the previous branch.
+EXAMPLES
+--------
 
+* Print the name of the previous branch:
++
+------------
+$ git check-ref-format --branch @{-1}
+------------
+
+* Determine the reference name to use for a new branch:
++
+------------
+$ ref=$(git check-ref-format --print "refs/heads/$newbranch") ||
+die "we do not like '$newbranch' as a branch name."
+------------
 
 GIT
 ---
diff --git a/builtin-check-ref-format.c b/builtin-check-ref-format.c
index f9381e0..b97b61a 100644
--- a/builtin-check-ref-format.c
+++ b/builtin-check-ref-format.c
@@ -17,6 +17,16 @@ int cmd_check_ref_format(int argc, const char **argv, const char *prefix)
 		printf("%s\n", sb.buf + 11);
 		exit(0);
 	}
+	if (argc == 3 && !strcmp(argv[1], "--print")) {
+		char *refname = xmalloc(strlen(argv[2]) + 1);
+
+		if (check_ref_format(argv[2]))
+			exit(1);
+		if (normalize_path_copy(refname, argv[2]))
+			die("Could not normalize ref name '%s'", argv[2]);
+		printf("%s\n", refname);
+		exit(0);
+	}
 	if (argc != 2)
 		usage("git check-ref-format refname");
 	return !!check_ref_format(argv[1]);
diff --git a/t/t1402-check-ref-format.sh b/t/t1402-check-ref-format.sh
index 382bc6e..eb45afb 100644
--- a/t/t1402-check-ref-format.sh
+++ b/t/t1402-check-ref-format.sh
@@ -41,4 +41,21 @@ test_expect_success "check-ref-format --branch @{-1}" '
 	refname2=$(git check-ref-format --branch @{-2}) &&
 	test "$refname2" = master'
 
+valid_ref_normalized() {
+	test_expect_success "ref name '$1' simplifies to '$2'" "
+		refname=\$(git check-ref-format --print '$1') &&
+		test \"\$refname\" = '$2'"
+}
+invalid_ref_normalized() {
+	test_expect_success "check-ref-format --print rejects '$1'" "
+		test_must_fail git check-ref-format --print '$1'"
+}
+
+valid_ref_normalized 'heads/foo' 'heads/foo'
+valid_ref_normalized 'refs///heads/foo' 'refs/heads/foo'
+invalid_ref_normalized 'foo'
+invalid_ref_normalized 'heads/foo/../bar'
+invalid_ref_normalized 'heads/./foo'
+invalid_ref_normalized 'heads\foo'
+
 test_done
-- 
1.6.5.rc1.199.g596ec
