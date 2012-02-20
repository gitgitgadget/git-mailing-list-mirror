From: Jehan Bing <jehan@orb.com>
Subject: [PATCH] Ignore SIGPIPE when running a filter driver
Date: Mon, 20 Feb 2012 12:53:37 -0800
Message-ID: <1329771217-9088-1-git-send-email-jehan@orb.com>
Mime-Version: 1.0
Cc: gitster@pobox.com, j.sixt@viscovery.net, peff@peff.net,
	jrnieder@gmail.com, jehan@orb.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 20 21:53:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RzaEz-00050j-UN
	for gcvg-git-2@plane.gmane.org; Mon, 20 Feb 2012 21:53:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753654Ab2BTUxl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Feb 2012 15:53:41 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:62636 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752174Ab2BTUxk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Feb 2012 15:53:40 -0500
Received: by pbcun15 with SMTP id un15so6612825pbc.19
        for <git@vger.kernel.org>; Mon, 20 Feb 2012 12:53:40 -0800 (PST)
Received-SPF: pass (google.com: domain of jehan@orb.com designates 10.68.219.138 as permitted sender) client-ip=10.68.219.138;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of jehan@orb.com designates 10.68.219.138 as permitted sender) smtp.mail=jehan@orb.com
Received: from mr.google.com ([10.68.219.138])
        by 10.68.219.138 with SMTP id po10mr66636965pbc.81.1329771220515 (num_hops = 1);
        Mon, 20 Feb 2012 12:53:40 -0800 (PST)
Received: by 10.68.219.138 with SMTP id po10mr54874662pbc.81.1329771220460;
        Mon, 20 Feb 2012 12:53:40 -0800 (PST)
Received: from jehan-Ubuntu-VBox.orb.com (173-167-111-189-sfba.hfc.comcastbusiness.net. [173.167.111.189])
        by mx.google.com with ESMTPS id q8sm14044427pbn.20.2012.02.20.12.53.39
        (version=SSLv3 cipher=OTHER);
        Mon, 20 Feb 2012 12:53:39 -0800 (PST)
X-Mailer: git-send-email 1.7.9
X-Gm-Message-State: ALoCoQmp64VcWAqwN5iToLGitj1HnAoHHo8fcedCuBTm63p0TLskZeMgnOucNMmnmECPOOj0n0HF
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191103>

If a filter is not defined or if it fails, git behaves as if the filter
is a no-op passthru. However, if the filter exits before reading all
the content, and depending on the timing git, could be kill with
SIGPIPE instead.

Ignore SIGPIPE while processing the filter to detect when it exits
early and fallback to using the unfiltered content.

Signed-off-by: Jehan Bing <jehan@orb.com>
---
Since it's not really a problem in the "required-filter" patch but a
general one with filter drivers, I'm submitting this patch
independently. I'm also wording it as a pre-patch to "required-filter".

-Jehan

 convert.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/convert.c b/convert.c
index c06309f..5d312cb 100644
--- a/convert.c
+++ b/convert.c
@@ -2,6 +2,7 @@
 #include "attr.h"
 #include "run-command.h"
 #include "quote.h"
+#include "sigchain.h"
 
 /*
  * convert.c - convert a file when checking it out and checking it in.
@@ -360,12 +361,16 @@ static int filter_buffer(int in, int out, void *data)
 	if (start_command(&child_process))
 		return error("cannot fork to run external filter %s", params->cmd);
 
+	sigchain_push(SIGPIPE, SIG_IGN);
+
 	write_err = (write_in_full(child_process.in, params->src, params->size) < 0);
 	if (close(child_process.in))
 		write_err = 1;
 	if (write_err)
 		error("cannot feed the input to external filter %s", params->cmd);
 
+	sigchain_pop(SIGPIPE);
+
 	status = finish_command(&child_process);
 	if (status)
 		error("external filter %s failed %d", params->cmd, status);
-- 
1.7.9
