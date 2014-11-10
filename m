From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v2 1/2] Clean stale environment pointer in finish_command()
Date: Mon, 10 Nov 2014 15:38:36 +0100 (CET)
Message-ID: <df1b16208e443416f7185c8c8c110e637ea97ac4.1415630072.git.johannes.schindelin@gmx.de>
References: <cover.1415368490.git.johannes.schindelin@gmx.de> <cover.1415630072.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Nov 10 15:38:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xnq7B-00009i-Ex
	for gcvg-git-2@plane.gmane.org; Mon, 10 Nov 2014 15:38:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752814AbaKJOil (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2014 09:38:41 -0500
Received: from mout.gmx.net ([212.227.15.18]:65366 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752728AbaKJOij (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2014 09:38:39 -0500
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx001) with ESMTPSA (Nemesis) id 0Mdren-1Xe9K531ED-00PcHD;
 Mon, 10 Nov 2014 15:38:36 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <cover.1415630072.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:rQuxpGOg+2XVzA5nsgd6lM0PTIA32cJfGHYdYZuD1duwcG3WZn/
 XNMXbk5+TzCfcMv4ak4A/avnARldoXFMgVPmIynM9zzTP+0ZVpWc+8Xl3Ma2OcRfzNB744l
 WDdRlHhNnyktTri/liZ3GLwv0dySZ+GgRcZcbBbjyOnb3TFoKop12jLDskAGGn+WYYaGl/t
 KP+8Y/3OtP1hhJ5NOp8yQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In start_command(), unset "env" fields are initialized via "env_array". In
finish_command(), the "env_array" is cleared, therefore the "env" field
will point to free()d data.

However, start_command() will set "env" to env_array.argv only if "env"
was unset to begin with, and if it was already set, the caller will need
the original value. Therefore, we need to be very careful only to reset
"env" in finish_command() when it has been initialized in start_command().

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 run-command.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/run-command.c b/run-command.c
index 79a0a76..85578da 100644
--- a/run-command.c
+++ b/run-command.c
@@ -555,6 +555,9 @@ int finish_command(struct child_process *cmd)
 {
 	int ret = wait_or_whine(cmd->pid, cmd->argv[0]);
 	argv_array_clear(&cmd->args);
+	/* Avoid pointing to a stale environment */
+	if (cmd->env == cmd->env_array.argv)
+		cmd->env = NULL;
 	argv_array_clear(&cmd->env_array);
 	return ret;
 }
-- 
2.0.0.rc3.9669.g840d1f9
