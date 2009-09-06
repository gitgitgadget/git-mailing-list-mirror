From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH v7 6/6] fast-import: test the new option command
Date: Sun,  6 Sep 2009 16:35:48 +0200
Message-ID: <1252247748-14507-7-git-send-email-srabbelier@gmail.com>
References: <1252247748-14507-1-git-send-email-srabbelier@gmail.com>
 <1252247748-14507-2-git-send-email-srabbelier@gmail.com>
 <1252247748-14507-3-git-send-email-srabbelier@gmail.com>
 <1252247748-14507-4-git-send-email-srabbelier@gmail.com>
 <1252247748-14507-5-git-send-email-srabbelier@gmail.com>
 <1252247748-14507-6-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git List <git@vger.kernel.org>,
	Ian Clatworthy <ian.cla
X-From: git-owner@vger.kernel.org Sun Sep 06 16:36:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MkIrD-00078l-S1
	for gcvg-git-2@lo.gmane.org; Sun, 06 Sep 2009 16:36:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757985AbZIFOgZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Sep 2009 10:36:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757975AbZIFOgY
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Sep 2009 10:36:24 -0400
Received: from mail-ew0-f206.google.com ([209.85.219.206]:55913 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757979AbZIFOgT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Sep 2009 10:36:19 -0400
Received: by mail-ew0-f206.google.com with SMTP id 2so1511761ewy.17
        for <git@vger.kernel.org>; Sun, 06 Sep 2009 07:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=XMrc7Fgkjuzbi3F1M4GYxLg53Nl42XdBzTBMw6YQvyQ=;
        b=yFLJON551WvNjFi34VMIZ++JruVdf9nW3L67bNz72vO+9kxDW5JTpzSqGGsSTiKM7M
         rQzgEZl/tAcH+CHhxUJX5DMFyixZ/dA0awEueYu4W9BjbNQJTAz8FPR4fVzAw6l+J5jb
         gHcU+3aG9/ajoKuq/YExpfbHVGxQUlAqhpTnI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=P6vFGKaCQ60mvm0E47ayfQhGtH53ea0u+mddZmmHiWS1doBO7Bc5gYfTFHSDx4AA6t
         KnGJ3SltiXui/vZZ3L4kT0AMGVdZmqh9RFe4IMyIaGfQuf5tFDUenRoXNvF8JaRR/FZt
         Ltv5VWKI35OnETRqVwYeJ1Ea2GgwKTZeV9+Wo=
Received: by 10.216.3.196 with SMTP id 46mr2748379weh.205.1252247781824;
        Sun, 06 Sep 2009 07:36:21 -0700 (PDT)
Received: from localhost.localdomain (ip138-114-211-87.adsl2.static.versatel.nl [87.211.114.138])
        by mx.google.com with ESMTPS id q9sm8759493gve.6.2009.09.06.07.36.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 06 Sep 2009 07:36:21 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.16.g72c66.dirty
In-Reply-To: <1252247748-14507-6-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127861>

Test three options (quiet and import/export-marks) and verify that the
commandline options override these.

Also make sure that a option command without a preceeding feature
git-options command is rejected and that non-git options are ignored.

Lastly, make sure that git options that we do not recognise are
ignored as well, but that they are rejected when parsed on the
commandline.

Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
---

  Updated tests for the new behavior.

 t/t9300-fast-import.sh |   89 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 88 insertions(+), 1 deletions(-)

diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 564ed6b..d33fc55 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -1089,7 +1089,7 @@ test_expect_success 'P: fail on blob mark in gitlink' '
     test_must_fail git fast-import <input'
 
 ###
-### series R (feature)
+### series R (feature and option)
 ###
 
 cat >input <<EOF
@@ -1108,4 +1108,91 @@ test_expect_success 'R: supported feature is accepted' '
 	git fast-import <input
 '
 
+cat >input << EOF
+feature git-options
+option git quiet
+blob
+data 3
+hi
+
+EOF
+
+touch empty
+
+test_expect_success 'R: quiet option results in no stats being output' '
+    cat input | git fast-import 2> output &&
+    test_cmp empty output
+'
+
+cat >input << EOF
+feature git-options
+option git export-marks=git.marks
+blob
+mark :1
+data 3
+hi
+
+EOF
+
+test_expect_success \
+    'R: export-marks option results in a marks file being created' \
+    'cat input | git fast-import &&
+    grep :1 git.marks'
+
+test_expect_success \
+    'R: export-marks options can be overriden by commandline options' \
+    'cat input | git fast-import --export-marks=other.marks &&
+    grep :1 other.marks'
+
+cat >input << EOF
+feature git-options
+option git import-marks=marks.out
+option git export-marks=marks.new
+EOF
+
+test_expect_success \
+    'R: import to output marks works without any content' \
+    'cat input | git fast-import &&
+    test_cmp marks.out marks.new'
+
+cat >input <<EOF
+feature git-options
+option git import-marks=nonexistant.marks
+option git export-marks=marks.new
+EOF
+
+test_expect_success \
+    'R: import marks prefers commandline marks file over the stream' \
+    'cat input | git fast-import --import-marks=marks.out &&
+    test_cmp marks.out marks.new'
+
+cat >input <<EOF
+feature git-options
+option git non-existing-option
+EOF
+
+test_expect_success \
+    'R: feature option is accepted and ignores unknown options' \
+    'git fast-import <input'
+
+cat >input <<EOF
+option git quiet
+EOF
+
+test_expect_success 'R: unknown commandline options are rejected' '\
+    test_must_fail git fast-import --non-existing-option < /dev/null
+'
+
+test_expect_success \
+    'R: option without preceeding feature command is rejected' \
+    'test_must_fail git fast-import <input'
+
+cat >input <<EOF
+option non-existing-vcs non-existing-option
+EOF
+
+test_expect_success 'R: ignore non-git options' '
+    git fast-import <input
+'
+
 test_done
-- 
1.6.4.16.g72c66.dirty
