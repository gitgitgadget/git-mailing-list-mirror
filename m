From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 3/7] submodule update --init: test path handling in recursive submodules
Date: Mon, 28 Mar 2016 16:28:19 -0700
Message-ID: <1459207703-1635-4-git-send-email-sbeller@google.com>
References: <1459207703-1635-1-git-send-email-sbeller@google.com>
Cc: Jens.Lehmann@web.de, jacob.keller@gmail.com,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Mar 29 01:28:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1akgaK-0004rF-TC
	for gcvg-git-2@plane.gmane.org; Tue, 29 Mar 2016 01:28:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755503AbcC1X2e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2016 19:28:34 -0400
Received: from mail-pf0-f172.google.com ([209.85.192.172]:35142 "EHLO
	mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755308AbcC1X2a (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2016 19:28:30 -0400
Received: by mail-pf0-f172.google.com with SMTP id n5so148367829pfn.2
        for <git@vger.kernel.org>; Mon, 28 Mar 2016 16:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=whv5u0T8byNMOEoXxjZgtvP7kvmTHyberuu0xm47/R0=;
        b=QfCyPMoAmY4377nOJnlDshu3passzTzILDj2TG/jQ/q7eLRyv1S/zf+GpgiUw1nmpc
         sbSQHYZ/IS5nxPO51/CRwxDE62Psm+Oxwll4uGuXMyLk5JYK3c7L4buzEeka2z/Tw5BZ
         3EQ4XZgNCFY8cuO8PbFGd9dx5ptPIo/I4IheaKSALCJ0PKIWMDGleN4Spc9yVTRj3oHl
         btP2jYBjDXVM4MqWtzzJJg/3VduDRyybvf9J6KUXUKG1bGRcPV95+pM84WBvW8cQZYcM
         lpw0NsFk6w6rgFi3WFuEZEzsybyyGaKzLFbPxEm3HUHVJddIbo2vyVgAXuhh7x4W/L3t
         ALaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=whv5u0T8byNMOEoXxjZgtvP7kvmTHyberuu0xm47/R0=;
        b=kxldXtZ5+A11zEVBr3LMM9gs1f2KAeGM8MZCh+Id29nyHCpQuhx7eJnqzlPtAN72mu
         yVevz+LyMBhlGlQNKZvIYeejO5o+G/WsB6dUq3gOOabPfYzbyONVNMdKoWgjImQaVI5h
         lLsZBpTN3+a4Qp4so+h0gZVW85VdOFE41dPf9dhea52sm6ASopPTeq0qXNkzXw/UwdLx
         0gidNiypJeCl1NYbdkXdddhbTpopcm8TRHWBKgPHPTSSAfd438AjRrUZVOJW9XBx7xg+
         GEUqOcX49/MMce7uO6YgINO8dEc351Ux5vTA9MnPWGboFx36GB9kBxSuTxVRF0+x766O
         e8iw==
X-Gm-Message-State: AD7BkJLAUztb4d+sgt7HDxPFtJP4VwfUfCayinCS9EhddG76A6O0Yr88MPLTRc+qBd5rWHNf
X-Received: by 10.98.93.155 with SMTP id n27mr46705001pfj.88.1459207709583;
        Mon, 28 Mar 2016 16:28:29 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:e99f:70e4:359b:ad6b])
        by smtp.gmail.com with ESMTPSA id uh1sm38205897pab.26.2016.03.28.16.28.28
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 28 Mar 2016 16:28:28 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.rc4.23.gd22361a.dirty
In-Reply-To: <1459207703-1635-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290085>

This demonstrates a failure to handle paths correctly.
Instead of getting the expected
    Submodule 'submodule' (${pwd}/submodule) registered for path '../super/submodule'
the `super` directory is omitted and you get
    Submodule 'submodule' (${pwd}/submodule) registered for path '../submodule'
instead.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 t/t7406-submodule-update.sh | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index 68ea31d..c1b9ffa 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -63,6 +63,10 @@ test_expect_success 'setup a submodule tree' '
 	 git submodule add ../none none &&
 	 test_tick &&
 	 git commit -m "none"
+	) &&
+	git clone . recursivesuper &&
+	( cd recursivesuper
+	 git submodule add ../super super
 	)
 '
 
@@ -95,6 +99,35 @@ test_expect_success 'submodule update from subdirectory' '
 	)
 '
 
+supersha1=$(cd super && git rev-parse HEAD)
+mergingsha1=$(cd super/merging && git rev-parse HEAD)
+nonesha1=$(cd super/none && git rev-parse HEAD)
+rebasingsha1=$(cd super/rebasing && git rev-parse HEAD)
+submodulesha1=$(cd super/submodule && git rev-parse HEAD)
+pwd=$(pwd)
+
+cat <<EOF >expect
+Submodule path '../super': checked out '${supersha1}'
+Submodule 'merging' (${pwd}/merging) registered for path '../super/merging'
+Submodule 'none' (${pwd}/none) registered for path '../super/none'
+Submodule 'rebasing' (${pwd}/rebasing) registered for path '../super/rebasing'
+Submodule 'submodule' (${pwd}/submodule) registered for path '../super/submodule'
+Submodule path '../super/merging': checked out '${mergingsha1}'
+Submodule path '../super/none': checked out '${nonesha1}'
+Submodule path '../super/rebasing': checked out '${rebasingsha1}'
+Submodule path '../super/submodule': checked out '${submodulesha1}'
+EOF
+
+test_expect_failure 'submodule update --init --recursive from subdirectory' '
+	git -C recursivesuper/super reset --hard HEAD^ &&
+	(cd recursivesuper &&
+	 mkdir tmp &&
+	 cd tmp &&
+	 git submodule update --init --recursive ../super >../../actual
+	) &&
+	test_cmp expect actual
+'
+
 apos="'";
 test_expect_success 'submodule update does not fetch already present commits' '
 	(cd submodule &&
-- 
2.8.0.rc4.23.gd22361a.dirty
