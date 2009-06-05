From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 03/23] http*: cleanup slot->local after fclose
Date: Sat, 6 Jun 2009 00:01:33 +0800
Message-ID: <20090606000133.33101b1e.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mike Hommey <mh@glandium.org>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 05 18:09:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCbzA-00053w-18
	for gcvg-git-2@gmane.org; Fri, 05 Jun 2009 18:09:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754668AbZFEQIQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2009 12:08:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754570AbZFEQIP
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jun 2009 12:08:15 -0400
Received: from wf-out-1314.google.com ([209.85.200.172]:10154 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754184AbZFEQIO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2009 12:08:14 -0400
Received: by wf-out-1314.google.com with SMTP id 26so716862wfd.4
        for <git@vger.kernel.org>; Fri, 05 Jun 2009 09:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=/PbYX0wCL/SjCGSzQngDr5WoQtoi4fSppv6z9c01gzE=;
        b=wKXGXyscKqccpHNVLAxR/K02BNjbeR2XImwqj2vITVtM8/QJKzQpNIfV4ZsmiubDkU
         oaJbNf1EOuHTt2fx80gUm1MKJUaoCc0p2yuX1qaVB33KTu7bjbkkEmLtWGpt/3aRew09
         vLDpTL/g1tloePuIKiCUWFkW2UqxHADCDSdGk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=Blq+Jozx7PUi/3WFp7M66FzGjEtgOh3IhU6AVP/AU4Itq7fRbQTKLcDq9rzCzhxgI/
         IKBsLxWmG2AxJ6MmDpFriU8DPP78CmhaeXjjJvHaNocvHO6oE+2NsYV5+eLJsDty39p/
         9Uz+q2hn7z4taer1oIFmUTODOPzVhhul4hrVQ=
Received: by 10.142.188.12 with SMTP id l12mr179376wff.124.1244218097245;
        Fri, 05 Jun 2009 09:08:17 -0700 (PDT)
Received: from your-cukc5e3z5n (cm97.zeta149.maxonline.com.sg [116.87.149.97])
        by mx.google.com with ESMTPS id 30sm395293wfc.38.2009.06.05.09.08.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 05 Jun 2009 09:08:16 -0700 (PDT)
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120788>

Set slot->local to NULL after doing a fclose on the FILE* pointer it
points to. This prevents an invalid FILE* pointer from being passed to
ftell() in http.c::run_active_slot().

This issue was raised by Clemens Buchacher on 30th May:

  http://www.spinics.net/lists/git/msg104623.html

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---

I've made it more clear what issue this patch is fixing.

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
