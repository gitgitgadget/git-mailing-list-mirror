From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCHv4 2/5] am: suppress apply errors when using 3-way
Date: Tue, 16 Jun 2009 15:32:58 -0700
Message-ID: <1245191581-11127-3-git-send-email-bebarino@gmail.com>
References: <1245117905-19351-1-git-send-email-bebarino@gmail.com>
 <1245191581-11127-1-git-send-email-bebarino@gmail.com>
 <1245191581-11127-2-git-send-email-bebarino@gmail.com>
Cc: Thomas Adam <thomas.adam22@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 17 00:34:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGhEN-0001yF-Cw
	for gcvg-git-2@gmane.org; Wed, 17 Jun 2009 00:34:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761258AbZFPWdO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jun 2009 18:33:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760681AbZFPWdL
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Jun 2009 18:33:11 -0400
Received: from mail-pz0-f187.google.com ([209.85.222.187]:44890 "EHLO
	mail-pz0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760395AbZFPWdH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jun 2009 18:33:07 -0400
Received: by pzk17 with SMTP id 17so2968971pzk.33
        for <git@vger.kernel.org>; Tue, 16 Jun 2009 15:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=1gwsmtng7xfpGonNhpCQ5MyQC6mpUxTF7HGNkoss870=;
        b=mtk0esf2q75oWwxXrhDphx/omGDvu31yC7pR4qqlv8L8ymvMODmnenLytxE+94w5tF
         j0B3keZuwh97CXLLBsWryAYgSfMgxyqnsXIchvxPoAPljRmpMTFaXbRS/k2jYZSbzzc2
         4SNePTfXVAb1u2jmk1IcSstCdOSvr0MA2IWSI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=nHRqSKb6ka3lb9RzCG77/IUmzGh2olbnUDHUUS6YQwg8jY3dFiBHhHX2mSuc52tg1B
         56A1EdMhhXjq86URGqlDSRi+mT9HCyVkwDBbXD/s2EUTIkHcC0ovrurZQBflcgnPGPUY
         040yMkS7EU4e9TaZPVwmGl98sQ41rM/y/RN9k=
Received: by 10.115.19.18 with SMTP id w18mr14270093wai.96.1245191589566;
        Tue, 16 Jun 2009 15:33:09 -0700 (PDT)
Received: from earth (user-0c9haco.cable.mindspring.com [24.152.169.152])
        by mx.google.com with ESMTPS id m31sm1788533wag.66.2009.06.16.15.33.07
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 16 Jun 2009 15:33:09 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Tue, 16 Jun 2009 15:33:07 -0700
X-Mailer: git-send-email 1.6.3.2.306.g4f4fa
In-Reply-To: <1245191581-11127-2-git-send-email-bebarino@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121717>

git-am with 3-way outputs errors when applying, even though the
3-way will usually be successful. We suppress these errors from
git-apply because they are not "true" errors until the 3-way has been
attempted.

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---

Seems to me like we should always suppress these errors if we're
falling back to 3-way. So I've removed the test for GIT_QUIET
and pushed this earlier in the series.

 git-am.sh |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index 578780b..e26c54a 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -502,7 +502,14 @@ do
 
 	case "$resolved" in
 	'')
-		eval 'git apply '"$git_apply_opt"' --index "$dotest/patch"'
+		# When we are allowed to fall back to 3-way later, don't give
+		# false errors during the initial attempt.
+		squelch=
+		if test "$threeway" = t
+		then
+			squelch='>/dev/null 2>&1 '
+		fi
+		eval "git apply $squelch$git_apply_opt"' --index "$dotest/patch"'
 		apply_status=$?
 		;;
 	t)
-- 
1.6.3.2.306.g4f4fa
