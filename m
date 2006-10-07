From: Sean <seanlkml@sympatico.ca>
Subject: [RFC PATCH] Add WEBDAV timeout to http-fetch.
Date: Fri, 6 Oct 2006 22:04:01 -0400
Message-ID: <BAYC1-PASMTP11CF83A008B0B3BA5F6B15AE100@CEZ.ICE>
References: <20061006212616.GA5175@lumumba.uhasselt.be>
	<20061006220542.GA5890@lumumba.uhasselt.be>
	<BAYC1-PASMTP08A34A8FB0703E4D2ABAF9AE130@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: takis@lumumba.uhasselt.be (Panagiotis Issaris), git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 07 04:05:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GW1Xt-0005EW-UV
	for gcvg-git@gmane.org; Sat, 07 Oct 2006 04:04:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422886AbWJGCEG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Oct 2006 22:04:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423049AbWJGCEG
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Oct 2006 22:04:06 -0400
Received: from bayc1-pasmtp11.bayc1.hotmail.com ([65.54.191.171]:45108 "EHLO
	BAYC1-PASMTP11.CEZ.ICE") by vger.kernel.org with ESMTP
	id S1422886AbWJGCED (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Oct 2006 22:04:03 -0400
X-Originating-IP: [65.93.42.136]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([65.93.42.136]) by BAYC1-PASMTP11.CEZ.ICE over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 6 Oct 2006 19:12:29 -0700
Received: from guru.attic.local ([10.10.10.28])
	by linux1.attic.local with esmtp (Exim 4.43)
	id 1GW1Xl-0004EW-QF; Fri, 06 Oct 2006 22:04:01 -0400
To: Sean <seanlkml@sympatico.ca>
Message-Id: <20061006220401.a4485d67.seanlkml@sympatico.ca>
In-Reply-To: <BAYC1-PASMTP08A34A8FB0703E4D2ABAF9AE130@CEZ.ICE>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.10.4; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 07 Oct 2006 02:12:30.0140 (UTC) FILETIME=[0AD097C0:01C6E9B6]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


If a server is having problems delivering the Git repo over WEBDAV,
timeout after two minutes so that a regular http transfer can
be tried.

---

 http-fetch.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

Not sure if this is the correct fix, but it should improve the situation
for cloning and fetching from servers like Takis's.  When connecting to
his server WEBDAV doesn't respond after the initial connection.  Nothing
proceeds until the OS connection times out many minutes later.

This patch sets the CURL timeout to two minutes so that things proceed
sooner.  Even with this patch it takes two extra minutes of "dead time"
to complete all operations; obivously this still sucks.

However, I don't know if the two minute timeout is long enough for
all cases with a server where WEBDAV is functioning properly.
Hopefully someone who knows more about Curl can comment and perhaps
offer another solution.

Maybe the real solution is just to figure out and fix whatever is
going on with the WEBDAV server and forget this patch.

Sean


diff --git a/http-fetch.c b/http-fetch.c
index bc74f30..046245a 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -861,6 +861,7 @@ static int remote_ls(struct alt_base *re
 	curl_easy_setopt(slot->curl, CURLOPT_UPLOAD, 1);
 	curl_easy_setopt(slot->curl, CURLOPT_CUSTOMREQUEST, DAV_PROPFIND);
 	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, dav_headers);
+	curl_easy_setopt(slot->curl, CURLOPT_TIMEOUT, 120);
 
 	if (start_active_slot(slot)) {
 		run_active_slot(slot);
-- 
1.4.2.3.gabd697
