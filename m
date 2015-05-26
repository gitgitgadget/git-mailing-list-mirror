From: Stefan Beller <sbeller@google.com>
Subject: [RFC/WIP PATCH 09/11] transport: get_refs_via_connect exchanges capabilities before refs.
Date: Tue, 26 May 2015 15:01:13 -0700
Message-ID: <1432677675-5118-10-git-send-email-sbeller@google.com>
References: <1432677675-5118-1-git-send-email-sbeller@google.com>
Cc: pclouds@gmail.com, peff@peff.net, gitster@pobox.com,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 27 00:02:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxMv7-00025s-3O
	for gcvg-git-2@plane.gmane.org; Wed, 27 May 2015 00:01:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752354AbbEZWBs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 May 2015 18:01:48 -0400
Received: from mail-ig0-f182.google.com ([209.85.213.182]:35503 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751918AbbEZWBm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 May 2015 18:01:42 -0400
Received: by igbyr2 with SMTP id yr2so70310381igb.0
        for <git@vger.kernel.org>; Tue, 26 May 2015 15:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eO5HtTjHrU3IfE/meQZH8PzyjJReTQF0Btc947R+5gA=;
        b=eCDHFcAjWcDUsgEFWpwqZSVQ56r6WteZWLQ3rUuhAGV/iB/8mymAWAM4tnsr56Hps3
         U3MXObADw2VaG7kTD+z+egfZ2RzoHF4HTMZu826ZOLnpx3Rl8iX+dns6vGlsS9Q348Vw
         E1BfgdtjOZ0tsyg//KPy+4lIW2XFFJqqu0QbUrX5L0E7nEk3eMv59IjxJqZKAugIRU1S
         K6lQXi6Yjq1dHh/TdLZoqRYXKccjcRQjriAfdy3zFYnWtsWfz4aWGzdNGtjXYSxsTXz8
         Lb+fvrRmovQjpee3g/6/zDIIf4uCOPk/yR1JXQTzRzhvi1TfgB7qJ0JbDTkLFOFHiPUr
         2cBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eO5HtTjHrU3IfE/meQZH8PzyjJReTQF0Btc947R+5gA=;
        b=XejRp5Sdw9ZwIVlCB/Nq6aUNLnWVBp4kviRsD7If2x7scyxRZJYfqdHB6wO5Pf/dR7
         DnF9JZNdWIRLfbI5Vvai2zSFjjUJR90Z48Ys0XHkmvPgdVJn+akm4l0oRIP9uzbiJ0jL
         tmWnZDx9VF4wQWP3z1JOWicwuYdJp6H03SIbYTeF/t9k5rfSR+1watbrnCTXkKPbMp1d
         ds++B2nKnbsToE7H5wGBKhArbpcVedZoc4EyDZ8KV0drpMh27ryxmpABm96Nl74qkTSm
         kWSzzTXmpC1Jw5dYVhOShY/N7DvS15tR2vNTwob2tChldrlR5TwaDm7JyTE0ec7IINwf
         gv8Q==
X-Gm-Message-State: ALoCoQmBuA409VFblHoLyyxieJeg62LPIzJmE/eMxO8YDYCv8zxbh4YmHsfqE6us1XjeE/nEErAB
X-Received: by 10.50.4.67 with SMTP id i3mr32394376igi.47.1432677700950;
        Tue, 26 May 2015 15:01:40 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:6430:9229:a464:d5f6])
        by mx.google.com with ESMTPSA id l128sm12017523iol.1.2015.05.26.15.01.40
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 26 May 2015 15:01:40 -0700 (PDT)
X-Mailer: git-send-email 2.4.1.345.gab207b6.dirty
In-Reply-To: <1432677675-5118-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269993>

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 transport.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/transport.c b/transport.c
index 33644a6..1cd9b77 100644
--- a/transport.c
+++ b/transport.c
@@ -526,12 +526,33 @@ static struct ref *get_refs_via_connect(struct transport *transport, int for_pus
 {
 	struct git_transport_data *data = transport->data;
 	struct ref *refs;
+	int version = 0;
 
+	if (transport->smart_options)
+		version = transport->smart_options->transport_version;
 	connect_setup(transport, for_push, 0);
-	get_remote_heads(data->fd[0], NULL, 0, &refs,
-			 for_push ? REF_NORMAL : 0,
-			 &data->extra_have,
-			 &data->shallow);
+	switch (version) {
+		default: /*
+			  * Configured a protocol version > 2?
+			  * Try version 2 as it's the most future proof.
+			  */
+			/* fall through */
+		case 2: /* first talk about capabilities, then get the heads */
+			get_remote_capabilities(data->fd[0], NULL, 0);
+			request_capabilities(data->fd[1]);
+			get_remote_heads(data->fd[0], NULL, 0, &refs,
+					 for_push ? REF_NORMAL : 0,
+					 &data->extra_have,
+					 &data->shallow);
+			break;
+		case 1: /* configured version 1, fall through */
+		case 0: /* unconfigured, use first protocol */
+			get_remote_heads(data->fd[0], NULL, 0, &refs,
+					 for_push ? REF_NORMAL : 0,
+					 &data->extra_have,
+					 &data->shallow);
+			break;
+	}
 	data->got_remote_heads = 1;
 
 	return refs;
-- 
2.4.1.345.gab207b6.dirty
