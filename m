From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH] git config: do not create .git/ if it does not exist yet
Date: Wed, 24 Feb 2016 08:47:00 +0100 (CET)
Message-ID: <c4027d758b0914dbc2e1ff5df344b0669aac4447.1456299545.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 24 08:47:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYUAG-000286-Ug
	for gcvg-git-2@plane.gmane.org; Wed, 24 Feb 2016 08:47:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757582AbcBXHrN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2016 02:47:13 -0500
Received: from mout.gmx.net ([212.227.15.19]:56368 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756730AbcBXHrM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2016 02:47:12 -0500
Received: from virtualbox ([37.24.143.82]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0LuxG5-1ZqJYV02ef-0107lk; Wed, 24 Feb 2016 08:47:02
 +0100
X-X-Sender: virtualbox@virtualbox
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:7YV9qTqCDf5mzPeyf5mYGkvOG0zd6ybWGgoGD7wtFT5ijuX/G2L
 +ok7d9ElURqNAQM6bebqsMz1kYvMX16gTPc6VxG/EIhr1jQhjnjiv5DDJ8IY8/EN8fZl1qa
 g44xaR1AfqA5BHyNIDDbqyehSxJbHQhgS2SxHZQdwq6q0cqKvkw8Alh6+J/59Pk2nJQkvhu
 mHayfXvfs8MzC0RXEyXGQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:GI3k/HVv+v8=:Q6yi4pEgV3xcfdjdsxEqfL
 S7b5+h90Lpsv3Ct8LWAXj7uSAEyXKdJvI22Gp6pM/dF32ulX8nDZaDYiXN87BRXOj3rH506cE
 MlXjf7njtSNoDZ4hyh4TXcbVi64hB9D9mQ9acHeokB+r2Vq6Tx2zs9AwVGIpg4i9/bQJkkW1Y
 ZBVX7/EJCX1b896YeRm8lIkJX/kYPP9tTwxKr8CL1FtI0qZ7XvY033JRfxlQEi00holFcSrJ+
 lKM594qNgsV/nVw8a+TqE6myJq0ecMIzKeBGBWDrG4jVREV7whgnWgJI2SlH/A0s76RBnw5KV
 vKQJ/W0lk3K/Vl5NY5FtvNglSPpAv2aOs2BPLzCWn/hIBDPqv4/FQHdM6We6ovkxS+fr3Tx7q
 23KGeA4VtUk7e+x9/hc6pASK50FyTbFwM6VqBQL0TCkwZW8gfoU5yw2C9uzoHCx0Iyh+gF/Ps
 GhHhrNpzQTc0LcnJakB51b22FztpGt+05hPWwqhu/KHFtkPy5KTvAqPcP7iyCmoNNwdlyTmA6
 Uo6zokj6rE4gY0OezXE21orXzCXw16aNC1HkxRMaswic7W7Y70S9TmEYtLf8EGWZ5IbtVGuUI
 wbzhxV9GCyzejH0Fzb/n6oBD/KCSc/TQ8aU0TiiSWBNX2/4Kf43y+I3/lYVKBj5Kbm3Ss9PUw
 WMs2VGJDxb3AIh1u3u/psNDtVLy8ORUR9FtyOua5xpdUzS9TCVXqaLOoLVZaM2rSpsJ0uEpZU
 WQQYWrY5AvH2ZQ9kwLgGa+XV9PaxDsi+HjIc75D/lGKHdaayZ5DF09WnDV/olkvw/JyWdayQ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287180>

It is a pilot error to call `git config section.key value` outside of
any Git worktree.

Let's report that error instead of creating the .git/ directory and
writing a fresh config into it.

This addresses https://github.com/git-for-windows/git/issues/643 and
https://groups.google.com/forum/#!topic/git-for-windows/fVRdnDIKVuw

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	I cannot think of a way how to test this: all of the regression
	tests run inside Git's own worktree, and we cannot even assume
	that /tmp/ is outside of a worktree (or that it exists).

 builtin/config.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/builtin/config.c b/builtin/config.c
index adc7727..78aab95 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -352,6 +352,9 @@ static int get_colorbool(const char *var, int print)
 
 static void check_write(void)
 {
+	if (!given_config_source.file && !startup_info->have_repository)
+		die("not in a git directory");
+
 	if (given_config_source.use_stdin)
 		die("writing to stdin is not supported");
 
-- 
2.7.2.windows.1.2.gbc859c8
