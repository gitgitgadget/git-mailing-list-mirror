From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2] transport-helper: check if the dry-run is supported
Date: Mon, 20 May 2013 20:32:04 -0500
Message-ID: <1369099924-13763-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 21 03:33:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UebSQ-00079t-VX
	for gcvg-git-2@plane.gmane.org; Tue, 21 May 2013 03:33:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757482Ab3EUBdj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 May 2013 21:33:39 -0400
Received: from mail-oa0-f53.google.com ([209.85.219.53]:37845 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757402Ab3EUBdi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 May 2013 21:33:38 -0400
Received: by mail-oa0-f53.google.com with SMTP id g12so102515oah.40
        for <git@vger.kernel.org>; Mon, 20 May 2013 18:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=xbQPxHuLAwKWPa4EazH+RgjeTIko6yWmwGqbMHd87vw=;
        b=IK4mooGneoKFfzBzPMsv1XU4264GEt+Gofo9aK5WHdGxOthu8RKxo3/H8E0top04gf
         HXhsQ3EJRiEEpo5Nos11CEQM5+PsjVq15EqQOyfyVT+SC7Lf/VdD2+NCHrmoTzTRyZXr
         nlv+8IhRVRsmtCKnWTp3cuMopzCROvNaypzpNMU+kc38q3OzZfO0gY4kPXy/r448FdAs
         dl+sPNHa2C45tQR1xVa8xgi0knbKXfr4C2paMCmGepSxLpY+e5Aorj/lLjPq0ejOEAGv
         XBg4vZ4AbZCW96HQ5tBwrcE/4VLC++lAGJdonrHOlIZ76eHIhApLeZUJjaKKNspflrSN
         pgJw==
X-Received: by 10.182.138.4 with SMTP id qm4mr41208obb.101.1369100017907;
        Mon, 20 May 2013 18:33:37 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id z5sm455942obw.4.2013.05.20.18.33.36
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 20 May 2013 18:33:36 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.1.gf11a2b7.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225012>

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
index 522d791..c8c39fc 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -789,6 +789,11 @@ static int push_refs_with_export(struct transport *transport,
 	struct string_list revlist_args = STRING_LIST_INIT_NODUP;
 	struct strbuf buf = STRBUF_INIT;
 
+	if (flags & TRANSPORT_PUSH_DRY_RUN) {
+		if (set_helper_option(transport, "dry-run", "true") != 0)
+			die("helper %s does not support dry-run", data->name);
+	}
+
 	helper = get_helper(transport);
 
 	write_constant(helper->in, "export\n");
-- 
1.8.3.rc3.1.gf11a2b7.dirty
