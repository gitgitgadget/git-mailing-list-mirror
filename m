From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 1/3] update-ref: test handling large transactions properly
Date: Tue, 14 Apr 2015 15:25:06 -0700
Message-ID: <1429050308-9617-2-git-send-email-sbeller@google.com>
References: <1429050308-9617-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Wed Apr 15 00:25:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yi9Gs-0003zF-Gl
	for gcvg-git-2@plane.gmane.org; Wed, 15 Apr 2015 00:25:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932227AbbDNWZX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Apr 2015 18:25:23 -0400
Received: from mail-ig0-f172.google.com ([209.85.213.172]:35388 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754101AbbDNWZT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Apr 2015 18:25:19 -0400
Received: by igbyr2 with SMTP id yr2so51887040igb.0
        for <git@vger.kernel.org>; Tue, 14 Apr 2015 15:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lc0qAJTDWW5V+27gKQlSabgJrsQcJ+T2TEr7qrGNreA=;
        b=li1oxF9uIApTnVI9FyjE/crR07o94exV7cWCAg4JTyWyntia/fesNOiPEoNdZ7YHkM
         8A3+OM6ZIp1hJtyeP6vBRo6cTE+gpBrsIfM+R/86w7WtWO4v/Ur3tqatSrY5tnuIOxXp
         xzkXdcm+GfI7+5xCCHK4qsYRlTpSm4Erkf852SM/coUqVJ+s8md3R6KAq3uSPC3YAVLL
         wZw5PFOwroaLPx6C2142yCKtnoElc98qJHnGi2HnuwqQ9Re4w69mBHnLP1mSa2cDDEUM
         2pa8BrkHFojpurvaT8Zk00fJGa1BhmWyKenyEfl8EjYy8r1f/8S6tywMfxv65Clqn6bn
         x8OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lc0qAJTDWW5V+27gKQlSabgJrsQcJ+T2TEr7qrGNreA=;
        b=Gkd5ZYOq/8J21FDqlPsXHlMygVoWR6yBjRPx3WfxmHUMJBMOJwpTs3NmQKYWUq7VOA
         lAxtQHinpC8SLiqftbvY/EOtO4oyxVspP4lqukf503ESJsYyNjqdFuw6ITC3ITrrfOk/
         IqVUyQUI6uu+LVM5qYDjbf77OK93Vl+y0wtLyIo3VTtWDoGKGu0r75tvHqNttB7bTgxL
         c0K6cvu8K0qtowVJDXWIvYfLzdITMRglTRM5ICn2J9gDUv1pzITn6EJjpktBu6JRgz2Y
         BFCqTx062ZLM2BAhAbDw+MVGrJELZqB6SxO4JbvTAFaOR3TNHijPTCfaJZMiPbRY6bwa
         XP/Q==
X-Gm-Message-State: ALoCoQnSKmJoqddPy/zRm79BROujv/uwR9cV2Ur84o+60GmdEYOSRxGpBv7R8biWdHMurI82vqmb
X-Received: by 10.107.168.167 with SMTP id e39mr32218398ioj.4.1429050319146;
        Tue, 14 Apr 2015 15:25:19 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:f14f:277:5d87:2236])
        by mx.google.com with ESMTPSA id w3sm8201595igz.4.2015.04.14.15.25.17
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 14 Apr 2015 15:25:18 -0700 (PDT)
X-Mailer: git-send-email 2.3.0.81.gc37f363
In-Reply-To: <1429050308-9617-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267167>

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t1400-update-ref.sh | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index 7b4707b..47d2fe9 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -973,4 +973,32 @@ test_expect_success 'stdin -z delete refs works with packed and loose refs' '
 	test_must_fail git rev-parse --verify -q $c
 '
 
+run_with_limited_open_files () {
+	(ulimit -n 32 && "$@")
+}
+
+test_lazy_prereq ULIMIT_FILE_DESCRIPTORS 'run_with_limited_open_files true'
+
+test_expect_failure ULIMIT_FILE_DESCRIPTORS 'large transaction creating branches does not burst open file limit' '
+(
+	for i in $(test_seq 33)
+	do
+		echo "create refs/heads/$i HEAD"
+	done >large_input &&
+	run_with_limited_open_files git update-ref --stdin <large_input &&
+	git rev-parse --verify -q refs/heads/33
+)
+'
+
+test_expect_failure ULIMIT_FILE_DESCRIPTORS 'large transaction deleting branches does not burst open file limit' '
+(
+	for i in $(test_seq 33)
+	do
+		echo "delete refs/heads/$i HEAD"
+	done >large_input &&
+	run_with_limited_open_files git update-ref --stdin <large_input &&
+	test_must_fail git rev-parse --verify -q refs/heads/33
+)
+'
+
 test_done
-- 
2.3.0.81.gc37f363
