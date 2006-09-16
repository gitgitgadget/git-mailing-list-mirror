From: Sasha Khapyorsky <sashak@voltaire.com>
Subject: Re: [PATCH] Trivial support for cloning and fetching via ftp://.
Date: Sat, 16 Sep 2006 05:37:17 +0300
Message-ID: <20060916023717.GA13570@sashak.voltaire.com>
References: <20060914022404.GA900@sashak.voltaire.com> <7vk6475408.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 16 04:32:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GOPyF-0002l8-3A
	for gcvg-git@gmane.org; Sat, 16 Sep 2006 04:31:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932384AbWIPCb2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Sep 2006 22:31:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932385AbWIPCb2
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Sep 2006 22:31:28 -0400
Received: from taurus.voltaire.com ([193.47.165.240]:19979 "EHLO
	taurus.voltaire.com") by vger.kernel.org with ESMTP id S932384AbWIPCb1
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Sep 2006 22:31:27 -0400
Received: from sashak ([172.25.5.107]) by taurus.voltaire.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Sat, 16 Sep 2006 05:31:25 +0300
Received: by sashak (sSMTP sendmail emulation); Sat, 16 Sep 2006 05:37:17 +0300
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vk6475408.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-OriginalArrivalTime: 16 Sep 2006 02:31:25.0994 (UTC) FILETIME=[352968A0:01C6D938]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27106>

On 23:57 Wed 13 Sep     , Junio C Hamano wrote:
> Sasha Khapyorsky <sashak@voltaire.com> writes:
> 
> > This adds trivial support for cloning and fetching via ftp://.
> 
> Interesting.
> 
> I was wondering myself if our use of curl libraries in
> http-fetch allows us to do this when I was looking at the
> alternates breakage yesterday.
> 
> At a few places we do look at http error code that is returned
> from the curl library, and change our behaviour based on that.
> But it appears the difference between error code from ftp and
> http has no bad effect on us.  In an empty repository, we can
> run this:
> 
> 	$ git-http-fetch -a -v heads/merge \
> 	  ftp://ftp.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git
> 
> (of course, this should normally be with http://www.kernel.org).
> We notice that we get an error from a request for one object,
> and switch to pack & alternates transfer.  The only difference
> between http://www and ftp://ftp is that for the former we know
> error code 404 and supress the error message but for the latter
> we do not treat error 550 from RETR response any specially and
> show an error message.  We still fall back to retrieve packs,
> hoping that the missing object is in a pack.
> 
> I'd take this patch as is, but we might want to add some error
> message supression logic just like we do for http.

Something like this?

With this change I'm able to clone
ftp://ftp.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git


diff --git a/http-fetch.c b/http-fetch.c
index a113bb8..46d6029 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -324,7 +324,9 @@ static void process_object_response(void
 
 	/* Use alternates if necessary */
 	if (obj_req->http_code == 404 ||
-	    obj_req->curl_result == CURLE_FILE_COULDNT_READ_FILE) {
+	    obj_req->curl_result == CURLE_FILE_COULDNT_READ_FILE ||
+	    (obj_req->http_code == 550 &&
+	     obj_req->curl_result == CURLE_FTP_COULDNT_RETR_FILE)) {
 		fetch_alternates(alt->base);
 		if (obj_req->repo->next != NULL) {
 			obj_req->repo =
@@ -538,7 +540,9 @@ static void process_alternates_response(
 		}
 	} else if (slot->curl_result != CURLE_OK) {
 		if (slot->http_code != 404 &&
-		    slot->curl_result != CURLE_FILE_COULDNT_READ_FILE) {
+		    slot->curl_result != CURLE_FILE_COULDNT_READ_FILE &&
+		    (slot->http_code != 550 &&
+		     slot->curl_result != CURLE_FTP_COULDNT_RETR_FILE)) {
 			got_alternates = -1;
 			return;
 		}
@@ -942,7 +946,9 @@ #endif
 		run_active_slot(slot);
 		if (results.curl_result != CURLE_OK) {
 			if (results.http_code == 404 ||
-			    results.curl_result == CURLE_FILE_COULDNT_READ_FILE) {
+			    results.curl_result == CURLE_FILE_COULDNT_READ_FILE ||
+			    (results.http_code == 550 &&
+			     results.curl_result == CURLE_FTP_COULDNT_RETR_FILE)) {
 				repo->got_indices = 1;
 				free(buffer.buffer);
 				return 0;
@@ -1124,7 +1130,9 @@ #endif
 	} else if (obj_req->curl_result != CURLE_OK &&
 		   obj_req->http_code != 416) {
 		if (obj_req->http_code == 404 ||
-		    obj_req->curl_result == CURLE_FILE_COULDNT_READ_FILE)
+		    obj_req->curl_result == CURLE_FILE_COULDNT_READ_FILE ||
+		    (obj_req->http_code == 550 &&
+		     obj_req->curl_result == CURLE_FTP_COULDNT_RETR_FILE))
 			ret = -1; /* Be silent, it is probably in a pack. */
 		else
 			ret = error("%s (curl_result = %d, http_code = %ld, sha1 = %s)",
