From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 1/9] transport-helper: check if the dry-run is supported
Date: Fri, 24 May 2013 21:47:32 -0500
Message-ID: <1369450060-19011-2-git-send-email-felipe.contreras@gmail.com>
References: <1369450060-19011-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 25 04:49:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ug4Xv-0004fb-KZ
	for gcvg-git-2@plane.gmane.org; Sat, 25 May 2013 04:49:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755839Ab3EYCtW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 May 2013 22:49:22 -0400
Received: from mail-ob0-f179.google.com ([209.85.214.179]:58669 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755755Ab3EYCtV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 May 2013 22:49:21 -0400
Received: by mail-ob0-f179.google.com with SMTP id wo10so2807517obc.38
        for <git@vger.kernel.org>; Fri, 24 May 2013 19:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=SS9ZF6arcjTyJltrX85enUOXlRD+lM6CXJc1wvvyjlE=;
        b=TJaxMJY4MblUawYBo/IimXsk8a3BwpXNymHP9/5Bdkl1pV73y4/zPqyrIv1LcFD80f
         O1EQySlqGjJPf9tBo1l4p0BxG3YlIwxaf0fuEE6440GJsz/AUlFrLCmMGdtzu5p3Y3YE
         NxNvZt4XaaRLlJNjp7XE4IPahzTs/TVvo/8GqSK7K9FSVnqDB1S2geshszVDA7jVUdKw
         iZ6Kjcsp3M2I6ipxnAGCG4Lz6AaNwjBgswM0i+FF7TaNjubNipU+AZXyQWZ3AxKBSSc3
         gHRhhicveiGxvA0B7WitdkLpGRrhUnhvGkBRZXLHvwi7S8GjAyt66Da1ay9yypaSxJHL
         XPdQ==
X-Received: by 10.182.60.136 with SMTP id h8mr13458112obr.47.1369450160893;
        Fri, 24 May 2013 19:49:20 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id zn5sm20101254obc.10.2013.05.24.19.49.19
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 24 May 2013 19:49:20 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.312.g47657de
In-Reply-To: <1369450060-19011-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225476>

Certain remote-helpers (the ones with 'export') would try to push
regardless.

Obviously this is not what the user wants.

Also, add a check for the 'dry-run' option, so remote-helpers can
implement it.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 transport-helper.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/transport-helper.c b/transport-helper.c
index 2f5ac3f..85c951f 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -809,6 +809,11 @@ static int push_refs_with_export(struct transport *transport,
 	if (!data->refspecs)
 		die("remote-helper doesn't support push; refspec needed");
 
+	if (flags & TRANSPORT_PUSH_DRY_RUN) {
+		if (set_helper_option(transport, "dry-run", "true") != 0)
+			die("helper %s does not support dry-run", data->name);
+	}
+
 	helper = get_helper(transport);
 
 	write_constant(helper->in, "export\n");
-- 
1.8.3.rc3.312.g47657de
