From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 03/23] http*: cleanup slot->local after fclose
Date: Sat, 6 Jun 2009 16:43:26 +0800
Message-ID: <20090606164326.164ce1e7.rctay89@gmail.com>
References: <cover.1244277116.git.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mike Hommey <mh@glandium.org>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 06 10:48:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCrZy-0003d4-PM
	for gcvg-git-2@gmane.org; Sat, 06 Jun 2009 10:48:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753879AbZFFIsZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Jun 2009 04:48:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753787AbZFFIsZ
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Jun 2009 04:48:25 -0400
Received: from mail-pz0-f171.google.com ([209.85.222.171]:57058 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753860AbZFFIsY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jun 2009 04:48:24 -0400
Received: by mail-pz0-f171.google.com with SMTP id 1so1305125pzk.33
        for <git@vger.kernel.org>; Sat, 06 Jun 2009 01:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:in-reply-to:references:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=oJkOHmVYyfu588U7QP4eCmFLFAOFGEGtJttAfrvFrfw=;
        b=wPw2U1fJw8DRl7ab0QnBUVxc9nn5da3JR6z3REoeKGCHnaCVrAAjn9jn58xmVb3ruW
         pMa+RVNmDDAqyzu8l4w1zPMdR3doRx7nF0B6F42UICKH8Bkxb4BUIAtMopAgQEVrpYL+
         2KFG+tq2GA7al0aG2drwqYHZscskXxX1kLqdw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        b=nm4ZcSWaG04MUdSayGhYcK7VMOzdWN8FSv8tLBD67wcrst87SemRvlGeCnnxqW3Kvd
         8NWb/sMJvKS8A7h/oOdV4XCnyiDPyHG3NQZdwLV3Fgdt8qGWIp6/8aVcKA35y/KJP+p3
         urMOGrDKsEJ29ZSAl+ct9y0cs4tYLqYUwu7Jg=
Received: by 10.142.50.6 with SMTP id x6mr1649015wfx.195.1244278106770;
        Sat, 06 Jun 2009 01:48:26 -0700 (PDT)
Received: from your-cukc5e3z5n (cm97.zeta149.maxonline.com.sg [116.87.149.97])
        by mx.google.com with ESMTPS id 30sm2802106wfa.35.2009.06.06.01.48.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 06 Jun 2009 01:48:26 -0700 (PDT)
In-Reply-To: <cover.1244277116.git.rctay89@gmail.com>
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120885>

Set slot->local to NULL after doing a fclose() on the file it points
to. This prevents the passing of a FILE* pointer to a fclose()'d file
to ftell() in http.c::run_active_slot().

This issue was raised by Clemens Buchacher on 30th May 2009:

  http://www.spinics.net/lists/git/msg104623.html

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 http-push.c   |    6 ++++++
 http-walker.c |    6 ++++++
 2 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/http-push.c b/http-push.c
index e16a0ad..0b12ffe 100644
--- a/http-push.c
+++ b/http-push.c
@@ -724,9 +724,11 @@ static void finish_request(struct transfer_request *request)
 	struct stat st;
 	struct packed_git *target;
 	struct packed_git **lst;
+	struct active_request_slot *slot;

 	request->curl_result = request->slot->curl_result;
 	request->http_code = request->slot->http_code;
+	slot = request->slot;
 	request->slot = NULL;

 	/* Keep locks active */
@@ -823,6 +825,7 @@ static void finish_request(struct transfer_request *request)

 			fclose(request->local_stream);
 			request->local_stream = NULL;
+			slot->local = NULL;
 			if (!move_temp_to_file(request->tmpfile,
 					       request->filename)) {
 				target = (struct packed_git *)request->userData;
@@ -1024,17 +1027,20 @@ static int fetch_index(unsigned char *sha1)
 		if (results.curl_result != CURLE_OK) {
 			free(url);
 			fclose(indexfile);
+			slot->local = NULL;
 			return error("Unable to get pack index %s\n%s", url,
 				     curl_errorstr);
 		}
 	} else {
 		free(url);
 		fclose(indexfile);
+		slot->local = NULL;
 		return error("Unable to start request");
 	}

 	free(url);
 	fclose(indexfile);
+	slot->local = NULL;

 	return move_temp_to_file(tmpfile, filename);
 }
diff --git a/http-walker.c b/http-walker.c
index 7321ccc..9377851 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -418,15 +418,18 @@ static int fetch_index(struct walker *walker, struct alt_base *repo, unsigned ch
 		run_active_slot(slot);
 		if (results.curl_result != CURLE_OK) {
 			fclose(indexfile);
+			slot->local = NULL;
 			return error("Unable to get pack index %s\n%s", url,
 				     curl_errorstr);
 		}
 	} else {
 		fclose(indexfile);
+		slot->local = NULL;
 		return error("Unable to start request");
 	}

 	fclose(indexfile);
+	slot->local = NULL;

 	return move_temp_to_file(tmpfile, filename);
 }
@@ -776,16 +779,19 @@ static int fetch_pack(struct walker *walker, struct alt_base *repo, unsigned cha
 		run_active_slot(slot);
 		if (results.curl_result != CURLE_OK) {
 			fclose(packfile);
+			slot->local = NULL;
 			return error("Unable to get pack file %s\n%s", url,
 				     curl_errorstr);
 		}
 	} else {
 		fclose(packfile);
+		slot->local = NULL;
 		return error("Unable to start request");
 	}

 	target->pack_size = ftell(packfile);
 	fclose(packfile);
+	slot->local = NULL;

 	ret = move_temp_to_file(tmpfile, filename);
 	if (ret)
--
1.6.3.1
