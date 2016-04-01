From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 1/2] imap-send.c: implements the GIT_CURL_DEBUG environment variable
Date: Fri,  1 Apr 2016 10:44:41 +0000
Message-ID: <1459507482-36678-1-git-send-email-gitter.spiros@gmail.com>
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 01 12:45:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alwZW-00049j-MJ
	for gcvg-git-2@plane.gmane.org; Fri, 01 Apr 2016 12:44:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758144AbcDAKow (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Apr 2016 06:44:52 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35087 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752406AbcDAKov (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Apr 2016 06:44:51 -0400
Received: by mail-wm0-f68.google.com with SMTP id 139so3579131wmn.2
        for <git@vger.kernel.org>; Fri, 01 Apr 2016 03:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=CvYlnq7NbRZ63YSs+eF6jLbuZVEyVf585Hdnvn0GghY=;
        b=Ny2Lm4eMneCxicYiPhBnsmyAL8Ai1PZCHuRIIyWpyel0CMD/eBa22tIRy9uuuVgoCA
         I20ZMLhb43FFLKET5al/b+ZMd4RITNiI5sE7bsZABWaR+67KkcxKKjarnCvhpyaSgY1q
         Bp9EGiBo/U+UEMir7aom+IRXzW6z1ozrTrfFAL10shYkdiOxScOwjPsP5pUbBoOGOovy
         cM0kVop+PVIcTGBw/M74pH6MOaUIFk0hh7MRfS+w9rOwC9ZWoa9s+8dSvZntFkFBE415
         F0QNNdHfPaEvrwlz9xumUvYJErXkF8EWe4S92XiqKPj+LwfLP54U0ESbg68+lTN7dkZo
         C5mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=CvYlnq7NbRZ63YSs+eF6jLbuZVEyVf585Hdnvn0GghY=;
        b=lun4fvKnoCyEpMPtdiDKkA4mn7fTb1ic4V2JW6KT4xZ52lG236zzVOZmtg8BlONSCM
         8XjiE1J0RtY/o/Vb/w5j5U7BmvKROfXaHl3D0RDcTcLRh8WKFzTGzh8fHSAOeAnMhC7P
         OsEJNIdJY8FUy8ZT0QiuxgizYL8dYgHo2XdtyuuAmHE7A2PqP4/IZcmVPrAEBB4sC9wv
         Q/wdidE9A7jqpy6kEy1ML0DXN7wuGcwJ1Ys/T0sgbAUPYnKU8h5SbepxL/E9IDiMheLw
         iE5IymnJMOtfVaD/dvtwkMkPhGldDZRu9OrvbgKhURSfsm1dLYg+PcujayjDq8vGtS47
         kwpA==
X-Gm-Message-State: AD7BkJK+hCNnbUbTtxa8DMABIMvSd5W45srt9V7gMy2QA1iE2ckzai2UC2jUsWD8ueasjA==
X-Received: by 10.28.8.139 with SMTP id 133mr3290686wmi.26.1459507490019;
        Fri, 01 Apr 2016 03:44:50 -0700 (PDT)
Received: from ubuntu2pinto.pd5x2phgis1evm2itoce0l41ib.ax.internal.cloudapp.net ([23.101.69.192])
        by smtp.gmail.com with ESMTPSA id hq2sm13467438wjb.3.2016.04.01.03.44.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 01 Apr 2016 03:44:49 -0700 (PDT)
X-Mailer: git-send-email 2.7.0.416.gbf6b42c.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290521>

Implements the GIT_CURL_DEBUG environment variable to allow a greater
degree of detail of GIT_CURL_VERBOSE, in particular the complete
transport header and all the data payload exchanged.
It might be useful if a particular situation could require a more
thorough debugging analysis.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 imap-send.c | 99 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 97 insertions(+), 2 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index 4d3b773..cf79e7f 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1395,6 +1395,96 @@ static int append_msgs_to_imap(struct imap_server_conf *server,
 }
 
 #ifdef USE_CURL_FOR_IMAP_SEND
+
+static
+void curl_dump(const char *text,
+	  FILE * stream, unsigned char *ptr, size_t size, char nohex)
+{
+	size_t i;
+	size_t c;
+
+	unsigned int width = 0x10;
+
+	if (nohex)
+		/* without the hex output, we can fit more on screen */
+		width = 0x40;
+
+	fprintf(stream, "%s, %10.10ld bytes (0x%8.8lx)\n",
+		text, (long)size, (long)size);
+
+	for (i = 0; i < size; i += width) {
+
+		fprintf(stream, "%4.4lx: ", (long)i);
+
+		if (!nohex) {
+			/* hex not disabled, show it */
+			for (c = 0; c < width; c++)
+				if (i + c < size)
+					fprintf(stream, "%02x ", ptr[i + c]);
+				else
+					fputs("   ", stream);
+		}
+
+		for (c = 0; (c < width) && (i + c < size); c++) {
+			/* check for 0D0A; if found, skip past and start a new line of output */
+			if (nohex && (i + c + 1 < size) && ptr[i + c] == 0x0D
+			    && ptr[i + c + 1] == 0x0A) {
+				i += (c + 2 - width);
+				break;
+			}
+			fprintf(stream, "%c",
+				(ptr[i + c] >= 0x20)
+				&& (ptr[i + c] < 0x80) ? ptr[i + c] : '.');
+			/* check again for 0D0A, to avoid an extra \n if it's at width */
+			if (nohex && (i + c + 2 < size)
+			    && ptr[i + c + 1] == 0x0D
+			    && ptr[i + c + 2] == 0x0A) {
+				i += (c + 3 - width);
+				break;
+			}
+		}
+		fputc('\n', stream);	/* newline */
+	}
+	fflush(stream);
+}
+
+static
+int curl_trace(CURL * handle, curl_infotype type,
+	     char *data, size_t size, void *userp)
+{
+	const char *text;
+	(void)handle;		/* prevent compiler warning */
+
+	switch (type) {
+	case CURLINFO_TEXT:
+		fprintf(stderr, "== Info: %s", data);
+	default:		/* in case a new one is introduced to shock us */
+		return 0;
+
+	case CURLINFO_HEADER_OUT:
+		text = "=> Send header";
+		break;
+	case CURLINFO_DATA_OUT:
+		text = "=> Send data";
+		break;
+	case CURLINFO_SSL_DATA_OUT:
+		text = "=> Send SSL data";
+		break;
+	case CURLINFO_HEADER_IN:
+		text = "<= Recv header";
+		break;
+	case CURLINFO_DATA_IN:
+		text = "<= Recv data";
+		break;
+	case CURLINFO_SSL_DATA_IN:
+		text = "<= Recv SSL data";
+		break;
+	}
+
+	curl_dump(text, stderr, (unsigned char *)data, size, 1);
+	return 0;
+}
+
 static CURL *setup_curl(struct imap_server_conf *srvc)
 {
 	CURL *curl;
@@ -1442,8 +1532,13 @@ static CURL *setup_curl(struct imap_server_conf *srvc)
 
 	curl_easy_setopt(curl, CURLOPT_UPLOAD, 1L);
 
-	if (0 < verbosity || getenv("GIT_CURL_VERBOSE"))
-		curl_easy_setopt(curl, CURLOPT_VERBOSE, 1L);
+	if (0 < verbosity )
+		if (getenv("GIT_CURL_DEBUG")) {
+			curl_easy_setopt(curl, CURLOPT_VERBOSE, 1);
+			curl_easy_setopt(curl, CURLOPT_DEBUGFUNCTION, curl_trace);
+		} else if (getenv("GIT_CURL_VERBOSE"))
+			curl_easy_setopt(curl, CURLOPT_VERBOSE, 1);
+
 
 	return curl;
 }
-- 
2.7.0.416.gbf6b42c.dirty
