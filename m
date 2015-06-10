From: Mike Edgar <adgar@google.com>
Subject: [PATCH] clone: check if server supports shallow clones
Date: Wed, 10 Jun 2015 14:35:20 -0400
Message-ID: <1433961320-1366-1-git-send-email-adgar@google.com>
Cc: peff@peff.net, pclouds@gmail.com, Mike Edgar <adgar@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 10 20:35:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2kqk-0005vM-Lb
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jun 2015 20:35:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754430AbbFJSfi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2015 14:35:38 -0400
Received: from mail-yh0-f50.google.com ([209.85.213.50]:35846 "EHLO
	mail-yh0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754076AbbFJSfh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2015 14:35:37 -0400
Received: by yhan67 with SMTP id n67so24471496yha.3
        for <git@vger.kernel.org>; Wed, 10 Jun 2015 11:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=SM5inpMHjXJmFZMSrs4ZxV+3uUx30LUUSETTnB50iJ8=;
        b=hjfZIgSTiT61PZ/K7rJkYUXEtlLkauj5TY1UftqA0u6niEGIFlKV1hzl8RJjnm5pF9
         +yOPmrfmQvQOew6imwG9WJmQWVNrnf+kRsGZIWthY/sRfPUBp5/dcbN12Gtck/9Md9N2
         ya363fQr1DVRsVO/xk5JppVvSHx5XBdxi57F8fFyX5hY2E2TAlNd9fSLrnvvx0U4Ry2i
         aYlNWLBbgQTq0gcgJufAsRQYNbube/JI2gjoZgi0sAdcKni19Ar0Mf9mkw2wxVhe2KOQ
         6+O9WCWLbsKpPaSE/d7DWVGQGNEpqpjEfijB87GRQT7QhuS6BiPWMHACjGPJ67ACxQ3G
         P4tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=SM5inpMHjXJmFZMSrs4ZxV+3uUx30LUUSETTnB50iJ8=;
        b=I8OI9ozNVeFuGH5lj6d9JEuwidApj/i5IZR06fcfN17BRJwvM/hq0PrOSUapgZRtAO
         HxqIU8Sx02g4Jh9/iUtNwVRFyCxOiHUdlL1G+KiHBQ1r5oZmf6RRPz9E0EoVNGyTD1YV
         zn6Ln7gI63WKZ1MOzMQQ+5Vuh3K3XZWBmTYtspzbCqjYotPrkTLlr3pfSHCbloLGHPle
         3fDj26EO2/rSOAWSfr2Lc21eSHdTa4PmJlMZu9ZDL8pliERtlLQQZYdg90ln3bW6Hoxx
         G/p1UUIH/Op0sjGeHDsvTKLHmvjWZQZnmsiMDJzrGCGJEQY3neF3jiOQ6R0F7bOjrKpR
         mYnA==
X-Gm-Message-State: ALoCoQnxFOYGvzkcC52Pv1PeV9CIVVmwQM8XiHO0T5vgiN+G/XWEipkkh1qZXI+PnFg35pAvRLOo
X-Received: by 10.170.91.131 with SMTP id i125mr6042951yka.12.1433961336415;
        Wed, 10 Jun 2015 11:35:36 -0700 (PDT)
Received: from smtp.gmail.com ([172.29.150.31])
        by mx.google.com with ESMTPSA id w205sm7081789ywd.39.2015.06.10.11.35.33
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 10 Jun 2015 11:35:34 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.494.g515ed4a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271341>

When the user passes --depth to git-clone the server's capabilities are
not currently consulted. The client will send shallow requests even if
the server does not understand them, and the resulting error may be
unhelpful to the user. This change pre-emptively checks so git-clone can
exit with a helpful error if necessary.

Signed-off-by: Mike Edgar <adgar@google.com>
---
 builtin/clone.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/builtin/clone.c b/builtin/clone.c
index b878252..b4e9846 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -944,6 +944,9 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 
 	refs = transport_get_remote_refs(transport);
 
+	if (option_depth && !is_local && !server_supports("shallow"))
+		die(_("Server does not support shallow clients"));
+
 	if (refs) {
 		mapped_refs = wanted_peer_refs(refs, refspec);
 		/*
-- 
2.2.0.rc0.207.ga3a616c
