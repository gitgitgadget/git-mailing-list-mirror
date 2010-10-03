From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv5 05/16] t4002 (diff-basic): use test_might_fail for commands that might fail
Date: Sat,  2 Oct 2010 23:10:33 -0600
Message-ID: <1286082644-31595-6-git-send-email-newren@gmail.com>
References: <1286082644-31595-1-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, avarab@gmail.com, jrnieder@gmail.com,
	Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 03 07:10:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2Gpp-0001zH-Ol
	for gcvg-git-2@lo.gmane.org; Sun, 03 Oct 2010 07:10:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752002Ab0JCFJ1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Oct 2010 01:09:27 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:55800 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751886Ab0JCFJZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Oct 2010 01:09:25 -0400
Received: by mail-pv0-f174.google.com with SMTP id 2so1068412pvg.19
        for <git@vger.kernel.org>; Sat, 02 Oct 2010 22:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=KvvtLbYdrZh3MkF1jNiRVYgo6K/5dcsznaR5ZUL4t5A=;
        b=Z6eQg13OVTKI+iru8kYo8K7NhdnTLNfoiALpgSKedA9KbuR2CWT7AAvzq7Pg9TUlBh
         TCXXmYRKuulu7DRXU8glqhKx07OOTaLqyK1TZojRgqJTCdOCIzRBT4TaC3fVAMzwFOCc
         597C+qiVf2/UtYbJ0NyK2I1opmJw4zK+ZH99Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=xqx2f1KZsgf9PW6ULvVqGoZLqCUSrLIToq+fDBeX+VMHQvz0gvBXgLJXDd21ZjifnZ
         ITz5YMascwOJJ+whA0zvaqTobyMEObJ2zDVmi7y5AzGQ1Z4o46wdcqw1HfGp/m8fwFXs
         2lmD2kKBokOuLoTnEqupXqJQfVnAl6jJ7VQdo=
Received: by 10.143.31.21 with SMTP id i21mr6821351wfj.346.1286082565024;
        Sat, 02 Oct 2010 22:09:25 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id o16sm4140250wfh.19.2010.10.02.22.09.22
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 02 Oct 2010 22:09:23 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.1.66.gab790
In-Reply-To: <1286082644-31595-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157833>

Also replace '|| return 1' by '&&' to allow chain of operations to be
checked for proper return status, and modify the update-index command
as suggested by Jonathan Nieder to not exit early but try to make sure
files that match the work tree are marked as matching.

Acked-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Acked-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t4002-diff-basic.sh |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/t/t4002-diff-basic.sh b/t/t4002-diff-basic.sh
index 73441a5..9fb8ca0 100755
--- a/t/t4002-diff-basic.sh
+++ b/t/t4002-diff-basic.sh
@@ -205,8 +205,8 @@ test_expect_success \
     'rm -fr Z [A-Z][A-Z] &&
      git read-tree $tree_A &&
      git checkout-index -f -a &&
-     git read-tree --reset $tree_O || return 1
-     git update-index --refresh >/dev/null ;# this can exit non-zero
+     git read-tree --reset $tree_O &&
+     test_must_fail git update-index --refresh -q &&
      git diff-files >.test-a &&
      cmp_diff_files_output .test-a .test-recursive-OA'
=20
@@ -215,8 +215,8 @@ test_expect_success \
     'rm -fr Z [A-Z][A-Z] &&
      git read-tree $tree_B &&
      git checkout-index -f -a &&
-     git read-tree --reset $tree_O || return 1
-     git update-index --refresh >/dev/null ;# this can exit non-zero
+     git read-tree --reset $tree_O &&
+     test_must_fail git update-index --refresh -q &&
      git diff-files >.test-a &&
      cmp_diff_files_output .test-a .test-recursive-OB'
=20
@@ -225,8 +225,8 @@ test_expect_success \
     'rm -fr Z [A-Z][A-Z] &&
      git read-tree $tree_B &&
      git checkout-index -f -a &&
-     git read-tree --reset $tree_A || return 1
-     git update-index --refresh >/dev/null ;# this can exit non-zero
+     git read-tree --reset $tree_A &&
+     test_must_fail git update-index --refresh -q &&
      git diff-files >.test-a &&
      cmp_diff_files_output .test-a .test-recursive-AB'
=20
--=20
1.7.3.1.66.gab790
