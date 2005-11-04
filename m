From: Nick Hengeveld <nickh@reactrix.com>
Subject: Re: Empty temp files in the .git/objects subdirectories
Date: Thu, 3 Nov 2005 17:54:52 -0800
Message-ID: <20051104015452.GB3001@reactrix.com>
References: <dkebkq$ova$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 04 02:56:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EXqnH-00010n-Rk
	for gcvg-git@gmane.org; Fri, 04 Nov 2005 02:55:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030578AbVKDBzA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 Nov 2005 20:55:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030583AbVKDBzA
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Nov 2005 20:55:00 -0500
Received: from 195.37.26.69.virtela.com ([69.26.37.195]:15215 "EHLO
	teapot.corp.reactrix.com") by vger.kernel.org with ESMTP
	id S1030578AbVKDBzA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Nov 2005 20:55:00 -0500
Received: from teapot.corp.reactrix.com (localhost.localdomain [127.0.0.1])
	by teapot.corp.reactrix.com (8.12.11/8.12.11) with ESMTP id jA41sqoQ023570;
	Thu, 3 Nov 2005 17:54:53 -0800
Received: (from nickh@localhost)
	by teapot.corp.reactrix.com (8.12.11/8.12.11/Submit) id jA41sqQe023568;
	Thu, 3 Nov 2005 17:54:52 -0800
To: walt <wa1ter@myrealbox.com>
Content-Disposition: inline
In-Reply-To: <dkebkq$ova$1@sea.gmane.org>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11115>

On Thu, Nov 03, 2005 at 04:56:58PM -0800, walt wrote:

> I've noticed (sometimes) after using cg-update to
> pull from Linus's kernel tree, that I have multiple
> empty files named *.temp in the various subdirectories
> of .git/objects/.

These are created by git-http-fetch to hold data as it's being
fetch from the remote repository.  They are left behind after a transfer
error so that the next time git-http-fetch runs it can pick up where it
left off.  If they're empty though, it would make more sense to delete
them rather than leaving them behind for the next attempt.

This should fix it:

[PATCH] Remove the temp file if it is empty after the request has failed

Signed-off-by: Nick Hengeveld <nickh@reactrix.com>


---

 http-fetch.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

applies-to: 55caf3fd962e3b5a25ee12e09c781e6f5a240672
28738a32636e9f0a326f5d9e662df1e6c594851f
diff --git a/http-fetch.c b/http-fetch.c
index a1b03cd..b12779d 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -520,12 +520,17 @@ static void start_request(struct transfe
 
 static void finish_request(struct transfer_request *request)
 {
+	struct stat st;
+
 	fchmod(request->local, 0444);
 	close(request->local);
 
 	if (request->http_code == 416) {
 		fprintf(stderr, "Warning: requested range invalid; we may already have all the data.\n");
 	} else if (request->curl_result != CURLE_OK) {
+		if (stat(request->tmpfile, &st) == 0)
+			if (st.st_size == 0)
+				unlink(request->tmpfile);
 		return;
 	}
 
---
0.99.9.GIT
