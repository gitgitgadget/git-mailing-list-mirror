From: =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH 2/2] fsck: treat a NUL in a tag header as an error
Date: Thu, 19 Nov 2015 17:25:31 +0100
Message-ID: <564DF7FB.3090704@web.de>
References: <564DF6BE.6020609@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Nov 19 17:26:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZzS2E-0003CG-K8
	for gcvg-git-2@plane.gmane.org; Thu, 19 Nov 2015 17:26:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933969AbbKSQ0B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Nov 2015 11:26:01 -0500
Received: from mout.web.de ([212.227.15.4]:57070 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933201AbbKSQZ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Nov 2015 11:25:58 -0500
Received: from [192.168.178.36] ([79.253.140.34]) by smtp.web.de (mrweb003)
 with ESMTPSA (Nemesis) id 0MXpaR-1Zu78O3nS3-00WlR4; Thu, 19 Nov 2015 17:25:40
 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
In-Reply-To: <564DF6BE.6020609@web.de>
X-Provags-ID: V03:K0:ammXyvLw4WNHRE3vIDuw5s5fPTM2+ONoKLjHd2nRSAC9u9yYFKp
 1aqnzkWHw+jGihioKiwwgXDs6BXHc5WcBuirFN/Yuzub/QkUo+l6ZhQh8dW3rnNMpr87m/D
 E3a9y4fcW+ye12VPuUkVQ0pjJDs00QnA01PLhbFigy1jPrzDlfvQvGagMfoWrk/bisTW0lP
 sAebUjaXNuUKPqR9Sh7YQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ftWqZRnTMzk=:u5wR5vceCxPDeVyuQidB6X
 uqOgE71ha8Q8e8kgE2Dj5ta3XaalorQZrkHnlOYI6GKvYfrOhmt0lTvsWEQVg5HavHgozDyLN
 aSnmSpLYK1SGTRobtf8fpshynbr178mYl8X+v7/Wns6s+VOZttLLewQ2aIodHGBXrMo/cBoBg
 had1+TvDONOz2VW7NtRZkHAAj8943dTf7gTAlk0/9s+nShk1m62BlVmMs4EirnCrHOLawTQ6+
 iLU/KwwvhOt7MhA9E7NSFXLFfT+5pJC97i/AUrvbaIE/+QT0HHpyBDhHX/m+M9x4Lb84t+43K
 DL8t/q8Fq8+F/j9XDq6A46SCuKVH0Gf1NEetIRFMRyleVTX/EwQHDdCZ4uT4Nq/NyxkPJ+jvC
 FHDHsszjV3VQK0ZjlAV5Nd6F/9KxD+EztOyE7Xg5t2Ryw6dgJ3cMwXOUq4pHT7u54n8+LwCR+
 i+JSd39roW3uMgAqjTBGw5N8AlGoIfL+YXC0Gvc2GF3xIjmfc9aacVWt76CEHXZ+3wg8t/qzJ
 znp24U8f4kAgH/VyyOJsIKh0VUXO7BLrg47BySCx+tRX82/Eavei3CbrgJYpuOz/+bxh8GTIj
 6+zZ1V5c0C1o1t5O91FOZvbUkHpO5TwPtArXiYwUsPJMhOlCnPTqJ/hSMJEuFKfT3WePbAhpL
 j93kFl3n6lOTKhnfnTYe4xXZCDwFkKNnn/HblczADFh+CljvoZrlDw6PaZyU8Y7Y2rAbz0WHG
 zzjR/W6N0pWBFbjxqcbn3xTksmjuFKkjeeedZMNgKVPnwt6MzZRq3GcXp3qEX5br8BcTyo8R 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281482>

We check the return value of verify_header() for commits already, so do
the same for tags as well.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 fsck.c          | 3 ++-
 t/t1450-fsck.sh | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/fsck.c b/fsck.c
index e41e753..4060f1f 100644
--- a/fsck.c
+++ b/fsck.c
@@ -711,7 +711,8 @@ static int fsck_tag_buffer(struct tag *tag, const char *data,
 		}
 	}
 
-	if (verify_headers(buffer, size, &tag->object, options))
+	ret = verify_headers(buffer, size, &tag->object, options);
+	if (ret)
 		goto done;
 
 	if (!skip_prefix(buffer, "object ", &buffer)) {
diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 6c96953..e66b7cb 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -288,7 +288,7 @@ test_expect_success 'tag with bad tagger' '
 	grep "error in tag .*: invalid author/committer" out
 '
 
-test_expect_failure 'tag with NUL in header' '
+test_expect_success 'tag with NUL in header' '
 	sha=$(git rev-parse HEAD) &&
 	q_to_nul >tag-NUL-header <<-EOF &&
 	object $sha
-- 
2.6.3
