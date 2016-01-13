From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 4/4] receive-pack: release pack files before
 garbage-collecting
Date: Wed, 13 Jan 2016 18:20:26 +0100 (CET)
Message-ID: <63654ac891616aae8a8e2f9560098f1823e87abe.1452705584.git.johannes.schindelin@gmx.de>
References: <cover.1452705584.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 13 18:20:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJP66-0004tj-A2
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jan 2016 18:20:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932186AbcAMRUd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2016 12:20:33 -0500
Received: from mout.gmx.net ([212.227.15.19]:55534 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932176AbcAMRUc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2016 12:20:32 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0LiDnn-1ZoF4r3ZHX-00nOVG; Wed, 13 Jan 2016 18:20:26
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1452705584.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:1XhUDdT89UWxUjX1HzzsoM1d8HsZ4xHoZIfd6APZW6uiW1yjvca
 hqb31vBTyOdur8Jcp2/sWTOthSpkpmra/k+zZNLxcvdHjqlQrbb9Q68y3fu8zpSrCYNQuzK
 VdO+ZY0CyhLBYtB9WECMZTyFiduGaRZoW9fTFdbiPh1pMOB96MmxgPANb99RmU91O4E/7lV
 3/XW6h1ijhc+ICm5srfqg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:s9uXg8zuvkw=:7xmRbZvpd2Py0tObMt5v+S
 T6uRnn7wwQfKpk3QUq90DSEG+WYCD0RMP8id5tTniPoP4mMNhyuuN0lmP8VkB85CXA8ZhtQvd
 sel1NAMCWmUcoQkSDc5LIjpPuVcY1WnWx/QYgSdAymuC60Y6qw81gtnxfE6USbJsLtZhhocaC
 MufrHMuIlQzgFY4z/zGfYfM7a30jubHwbT5uj08R6UAg00bpKC2UEYGv0ErknDTwT3UA8HN30
 bOMLK0Qf5UZXHFYIbioBSV+slNHqBWvlEmWLBsMOA3qoVEoRvFibRrg2CsUH2/DE6HST1I32M
 kp9n39NI8gGLSxNE4sMeo/c/o/kzw6C7v5nxpLQCk3foHXchiFU5tigDCvbeOMb7WVe9lwGIO
 G0D1SP9r0XWiPbs5sL7WHxpUf63zXSgPSjRvATfKaS3m1oPxC7Unj9EaItN1KOhOrlRtfzBeT
 Xbn+hHbNMt6ogqJpTbvqZuuqhmHhELlqqT9PCLH2+AjiCpbwOuYeXczM0H9sCRnEC4j9seWkc
 yjV6rLSprESqzwBL/D9Iso86R5lTX3X+TZ/7VEsFWUdDo+wmbKB+YYFbnNW9rfbeboBEPsaP2
 Jvd84grgNiCBPetDpusxsxVsMxJFnhiyncLWoD4eM4/VtMsbR2FyJMqckgbUwi3MOn6Sos66S
 nMnuzb3z9z7wClWBoNVZCZEM2pwj04c5GB9nRcqTvKa0XRZyG7xQfRtQ0i9PaYEq8KkjHbA05
 1adZw7PT96Zk8EpG436SzbC80a1XUX6gfjf9joWOB1KJampfXzSDogVgKFTyMEmpZy0bVKsQ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283951>

Before auto-gc'ing, we need to make sure that the pack files are
released in case they need to be repacked and garbage-collected.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/receive-pack.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 2b3b746..f2d6761 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1796,6 +1796,7 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 				"gc", "--auto", "--quiet", NULL,
 			};
 			int opt = RUN_GIT_CMD | RUN_COMMAND_STDOUT_TO_STDERR;
+			close_all_packs();
 			run_command_v_opt(argv_gc_auto, opt);
 		}
 		if (auto_update_server_info)
-- 
2.6.3.windows.1.300.g1c25e49
