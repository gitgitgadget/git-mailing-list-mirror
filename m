Return-Path: <SRS0=6EDX=DO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C612C4363C
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 19:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80AA9207EA
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 19:41:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xapek.org header.i=@xapek.org header.b="t9/ss4rd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728409AbgJGTlB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Oct 2020 15:41:01 -0400
Received: from mail.ghostdub.de ([95.216.78.222]:33644 "EHLO mail.ghostdub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728387AbgJGTlB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Oct 2020 15:41:01 -0400
X-Greylist: delayed 515 seconds by postgrey-1.27 at vger.kernel.org; Wed, 07 Oct 2020 15:41:00 EDT
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by mail.ghostdub.de (Postfix) with ESMTPA id 27B3147A1D7E
        for <git@vger.kernel.org>; Wed,  7 Oct 2020 19:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xapek.org; s=dkim;
        t=1602099143;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=gxCesvsjio8v8NnEH/buhOdL0dMPedXPcHN2y3v1WDU=;
        b=t9/ss4rdhcg9gspB4K07RXQMWcIPIyeXaBHViSLVo3QDSrJzO+isNdvLXBLD9oojJpr86x
        JktxO4UEJkAFoqVPjqZ/+IKqlO1R2/57fHoidHDZ2o3RDBBG/BkMGiUEtc/DgX+6Sk1eHR
        D3YNQFDSCVkYRhy01vUlq8FFvDEQWB4=
MIME-Version: 1.0
Date:   Wed, 07 Oct 2020 19:32:22 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From:   "Yves Fischer" <yvesf@xapek.org>
Message-ID: <995c4c10c68d39e84aa48ae967f81da6@xapek.org>
Subject: git clean -X deletes ignored directory
To:     git@vger.kernel.org
Authentication-Results: mail.ghostdub.de;
        auth=pass smtp.auth=yvesf@ghostdub.de smtp.mailfrom=yvesf@xapek.org
X-Spamd-Bar: /
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello everyone,=0A=0AI found a behavior with git-clean that appears to be=
 unexpected.=0A=0AIt is related to the change in 95c11ec which, if I read=
 the history correctly, got later corrected in cada730.=0A=0AExample (in =
git repo after build):=0A=3D=3D=3D=3D=3D=3D=0A./git init test=0Acd test=
=0Amkdir ignored-subdir=0Atouch test.c test.o ignored-subdir/some-file=0A=
echo \*.o > .gitignore=0Aecho ignored-subdir >> .gitignore =0A../git add =
.=0A../git commit -m test=0A../git clean -X -d -n '*.o'=0A# Would remove =
ignored-subdir/  <--- why?=0A# Would remove test.o=0A=3D=3D=3D=3D=3D=3D=
=0A=0AIn the example I would have expected that the "ignored-subdir" is n=
ot deleted because it's not matched by the path argument. The manpage of =
git-clean says:=0A> If any optional <path>... arguments are given, only t=
hose paths are affected.=0A=0AI believe the issue is fixed in cada730 onl=
y for files. It seems to persist for directories.=0A=0AThe attached diff =
has a test that tries to cover this.=0A=0AKind regards,=0AYves=0A=0A----=
=0A=0Adiff --git a/t/t7300-clean.sh b/t/t7300-clean.sh=0Aindex cb5e34d94c=
..77d834d34a 100755=0A--- a/t/t7300-clean.sh=0A+++ b/t/t7300-clean.sh=0A@=
@ -746,4 +746,49 @@ test_expect_success 'clean untracked paths by pathspe=
c' '=0A        test_must_be_empty actual=0A '=0A =0A+# fixed by cada730=
=0A+test_expect_success 'git clean x1' '=0A+=0A+       git init clean-x1 =
&&=0A+       touch clean-x1/test.c clean-x1/test.o clean-x1/other-untrack=
ed-file &&=0A+       echo \*.o >> clean-x1/.gitignore &&=0A+       echo o=
ther-untracked-file >> clean-x1/.gitignore &&=0A+       git -C clean-x1 a=
dd . &&=0A+       git -C clean-x1 commit -m setup &&=0A+       git -C cle=
an-x1 clean -X -d -f "*.o" &&=0A+       ! test -f clean-x1/test.o &&=0A+ =
      test -f clean-x1/other-untracked-file=0A+=0A+'=0A+=0A+# fixed by ca=
da730=0A+test_expect_success 'git clean x2' '=0A+=0A+       git init clea=
n-x2 &&=0A+       touch clean-x2/test.c clean-x2/test.o clean-x2/other-un=
tracked-file &&=0A+       echo \*.o >> clean-x2/.gitignore &&=0A+       e=
cho other-untracked-file >> clean-x2/.gitignore &&=0A+       git -C clean=
-x2 add . &&=0A+       git -C clean-x2 commit -m setup &&=0A+       git -=
C clean-x2 clean -X -f "*.o" &&=0A+       ! test -f clean-x2/test.o &&=0A=
+       test -f clean-x2/other-untracked-file=0A+=0A+'=0A+=0A+test_expect=
_success 'git clean x3' '=0A+=0A+       git init clean-x3 &&=0A+       mk=
dir other-untracked-dir &&=0A+       touch clean-x3/test.c clean-x3/test.=
o clean-x3/other-untracked-dir/foo &&=0A+       echo \*.o >> clean-x3/.gi=
tignore &&=0A+       echo other-untracked-dir >> clean-x3/.gitignore &&=
=0A+       git -C clean-x3 add . &&=0A+       git -C clean-x3 commit -m s=
etup &&=0A+       git -C clean-x3 clean -X -f "*.o" &&=0A+       ! test -=
f clean-x3/test.o &&=0A+       test -f clean-x3/other-untracked-dir/foo=
=0A+=0A+'=0A+=0A test_done
