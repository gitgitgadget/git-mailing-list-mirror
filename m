From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv6 05/16] t4002 (diff-basic): use test_might_fail for commands that might fail
Date: Sun,  3 Oct 2010 14:00:03 -0600
Message-ID: <1286136014-7728-6-git-send-email-newren@gmail.com>
References: <1286136014-7728-1-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, avarab@gmail.com, jrnieder@gmail.com,
	Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 03 21:59:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2Uia-0002yx-RI
	for gcvg-git-2@lo.gmane.org; Sun, 03 Oct 2010 21:59:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754838Ab0JCT64 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Oct 2010 15:58:56 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:58678 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754755Ab0JCT6y (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Oct 2010 15:58:54 -0400
Received: by pwj5 with SMTP id 5so946630pwj.19
        for <git@vger.kernel.org>; Sun, 03 Oct 2010 12:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=OQ1S5NymJTwNjVmjHpq5xG8csjIINjyKanfEj/YIYUw=;
        b=jTjcz0ubpY4Io7DIXAgl94HGP1UxfysLvKoOvqTvJaGIgk3Of/IC0iZ4tLHI1GLmLC
         Ffa1Q2XpgD4rd4+vWOQv8S2sNta0y3nXBPEZ8we0pUsmnu8WsELb9gZxbikpegC8AdWB
         hrUnAUSno3LO4+Im8gvwPwJETcTvsmeZPnjKI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=re1Ma+VTcC+6zZiCjqVzocZnN2wImpaingt25fE0v6jPgshTyMGR1U8SAy5OhBEeef
         DKaI+vDCUSx9HD5JGnX3uoawecComgZKMdLpUmwBo0il20Rhe9b8Ak3vAmK2T9/qkg56
         ufThQwhN0tmKxs6B08OTfOTRYjX4Spb3809iQ=
Received: by 10.114.66.8 with SMTP id o8mr10031368waa.215.1286135934530;
        Sun, 03 Oct 2010 12:58:54 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id d2sm7661138wam.14.2010.10.03.12.58.52
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 03 Oct 2010 12:58:53 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.1.66.gab790
In-Reply-To: <1286136014-7728-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157904>

Also replace '|| return 1' by '&&' to allow chain of operations to be
checked for proper return status, and modify the update-index command
as suggested by Jonathan Nieder to not exit early but try to make sure
files that match the work tree are marked as matching.

Acked-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
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
