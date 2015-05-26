From: Stefan Beller <sbeller@google.com>
Subject: [RFC/WIP PATCH 08/11] transport: connect_setup appends protocol version number
Date: Tue, 26 May 2015 15:01:12 -0700
Message-ID: <1432677675-5118-9-git-send-email-sbeller@google.com>
References: <1432677675-5118-1-git-send-email-sbeller@google.com>
Cc: pclouds@gmail.com, peff@peff.net, gitster@pobox.com,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 27 00:01:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxMv8-00025s-88
	for gcvg-git-2@plane.gmane.org; Wed, 27 May 2015 00:01:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752371AbbEZWBz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 May 2015 18:01:55 -0400
Received: from mail-ie0-f178.google.com ([209.85.223.178]:34032 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751237AbbEZWBk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 May 2015 18:01:40 -0400
Received: by ieczm2 with SMTP id zm2so55215iec.1
        for <git@vger.kernel.org>; Tue, 26 May 2015 15:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nYC4hHcnVkV3wPKSfsV5PXttWGnQnuza+JhLpcq7/J8=;
        b=HyevOllZ16Q/rwfVP+RiTNVQa3+++HHu6BApDnYdSYYvA6pD53NOltB8mypVYeAW7B
         Nxwf0VaSNjMYDScLImGppqoztz/xFw9AhXRhMwepHY7yLMI3WY28x/tyYdzNvlddRaUi
         2K2k+maTsfGLqYiCG4Q3jyPOY23pFr7cshrqqCPlFzriUMgmulGzjxriL/C6BLzpMoUC
         qchMLrhUJ8dOX3tP1obAXuSz/J1K76WWHEm2f83jOHjIn4ILp/1uuRU8RM5wEnZoCIuN
         rVTo2umYWhGIfxSEcKY5/nYdWTVIC56AMtoh7DT3tKrHQJ8xW1uPn/iMaelXuaVfsLz+
         EXJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nYC4hHcnVkV3wPKSfsV5PXttWGnQnuza+JhLpcq7/J8=;
        b=WA+lN1rAvV5nuCwTHeoEbZxpgEfehHDtoo+SFAf0tlO8+LwsHWQspSjdtQguIhswNY
         kkXJPMpSaQ92ksbLG+gKNSbq29R2udadJaj//bx9JG6yWP5wsdoyjzdKW5dhADEEyKgp
         8aslg0fQ3sm6dkbSEZk7Wuwu0em5ttU2ZIgu+j+4hb20hXFwnMeSf5FXH0bLqDcBc/lq
         DD/mjjnb7Qj9tv72Ttf7rrvFzZpzsiYGB8iDFxgxyXWNZD8Eq0Zu8mW5YuYsar2oxbhe
         lwjTmYedkjHb1FW5l2dsr71LZY/72mMlEo1lz6aPeVgWxic/4Kd6/tIimD+88l22Izh6
         63Lw==
X-Gm-Message-State: ALoCoQmCoM2S70zKxf0GZWnvS6n1EgLQyV6cxTuQog/hMqbRz1PtwG0LTQBuisOdc1igXbLIi3w0
X-Received: by 10.50.36.72 with SMTP id o8mr29128955igj.16.1432677699551;
        Tue, 26 May 2015 15:01:39 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:6430:9229:a464:d5f6])
        by mx.google.com with ESMTPSA id i4sm9356337igm.2.2015.05.26.15.01.38
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 26 May 2015 15:01:38 -0700 (PDT)
X-Mailer: git-send-email 2.4.1.345.gab207b6.dirty
In-Reply-To: <1432677675-5118-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269992>

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 transport.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/transport.c b/transport.c
index 3ef15f6..33644a6 100644
--- a/transport.c
+++ b/transport.c
@@ -496,15 +496,29 @@ static int set_git_option(struct git_transport_options *opts,
 static int connect_setup(struct transport *transport, int for_push, int verbose)
 {
 	struct git_transport_data *data = transport->data;
+	const char *remote_program;
+	char *buf = 0;
 
 	if (data->conn)
 		return 0;
 
+	remote_program = (for_push ? data->options.receivepack
+				   : data->options.uploadpack);
+
+	if (transport->smart_options
+	    && transport->smart_options->transport_version) {
+		buf = xmalloc(strlen(remote_program) + 12);
+		sprintf(buf, "%s-%d", remote_program,
+			transport->smart_options->transport_version);
+		remote_program = buf;
+	}
+
 	data->conn = git_connect(data->fd, transport->url,
-				 for_push ? data->options.receivepack :
-				 data->options.uploadpack,
+				 remote_program,
 				 verbose ? CONNECT_VERBOSE : 0);
 
+	free(buf);
+
 	return 0;
 }
 
-- 
2.4.1.345.gab207b6.dirty
