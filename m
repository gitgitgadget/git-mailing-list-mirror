From: Kevin Stange <kevin@steadfast.net>
Subject: [RFC] Deal with HTTP 401 by requesting credentials.
Date: Thu, 31 May 2012 17:24:55 -0500
Message-ID: <4FC7EFB7.4090704@steadfast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 01 00:34:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SaDvU-00021B-FQ
	for gcvg-git-2@plane.gmane.org; Fri, 01 Jun 2012 00:33:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758566Ab2EaWcs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 May 2012 18:32:48 -0400
Received: from staffmx.steadfast.net ([67.202.100.6]:50681 "EHLO
	staffmx.steadfast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758512Ab2EaWcX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 May 2012 18:32:23 -0400
X-Greylist: delayed 446 seconds by postgrey-1.27 at vger.kernel.org; Thu, 31 May 2012 18:32:23 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by staffmx.steadfast.net (Postfix) with ESMTP id 5488116AC09E
	for <git@vger.kernel.org>; Thu, 31 May 2012 17:24:56 -0500 (CDT)
X-Virus-Scanned: amavisd-new at steadfast.net
Received: from staffmx.steadfast.net ([127.0.0.1])
	by localhost (staffmx.steadfast.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id J9DrFn45Vily for <git@vger.kernel.org>;
	Thu, 31 May 2012 17:24:55 -0500 (CDT)
Received: from ziyal.office.steadfast.net (unknown [IPv6:2607:f128:0:1:222:4dff:fe51:2ed5])
	by staffmx.steadfast.net (Postfix) with ESMTPSA id 9055C16AC09B
	for <git@vger.kernel.org>; Thu, 31 May 2012 17:24:55 -0500 (CDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:12.0) Gecko/20120430 Thunderbird/12.0.1
X-Enigmail-Version: 1.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198951>

Request credentials from the user if none are already defined when a
HTTP 401 is received on a restricted repository.  Then, resubmit the
request and return the final result.

This allows all webdav transactions to obtain credentials without having
to individually handle the case in each request.  Having push working
with HTTP auth is needed for a use case I have where storing the
credentials in .netrc or using SSH keys is inappropriate.

Apologies for anything wrong I might have done here.  I'm not used to
procedures for this sort of patch submission, or terribly familiar with
the code base.  I'm seeking advice on whether this approach is sane or
completely crazy, and I'm willing to adjust it to make it suitable for
inclusion.

Signed-off-by: Kevin <kevin@steadfast.net>
---
 http.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/http.c b/http.c
index 5cb87f1..e1c9e65 100644
--- a/http.c
+++ b/http.c
@@ -668,6 +668,21 @@ void finish_active_slot(struct active_request_slot
*slot)
 	closedown_active_slot(slot);
 	curl_easy_getinfo(slot->curl, CURLINFO_HTTP_CODE, &slot->http_code);

+	if (slot->http_code == 401) {
+		if(!http_auth.username && !http_auth.password) {
+			active_requests++;
+			credential_fill(&http_auth);
+			init_curl_http_auth(slot->curl);
+			(*slot->finished) = 1;
+			if (start_active_slot(slot)) {
+				run_active_slot(slot);
+				return;
+			}
+		} else {
+			fprintf(stderr,"Authentication Failed!\n");
+		}
+	}
+
 	if (slot->finished != NULL)
 		(*slot->finished) = 1;

-- 
1.7.11.rc0.55.gb2478aa

-- 
Kevin Stange
Chief Technology Officer
Steadfast Networks
http://steadfast.net
Phone: 312-602-2689 ext. 203 | Fax: 312-602-2688 | Cell: 312-320-5867
