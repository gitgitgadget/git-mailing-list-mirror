From: "Steinmann  Ruedi" <ruediste@student.ethz.ch>
Subject: [PATCH] Fix https interactive authentication problem
Date: Wed, 23 Nov 2011 07:58:02 +0000
Message-ID: <F6A589D6B10801478E0DE246A9EF187C1BD5E8@MBX12.d.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>,
	"gitster@pobox.com" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 23 09:04:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RT7ob-000338-UR
	for gcvg-git-2@lo.gmane.org; Wed, 23 Nov 2011 09:04:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758720Ab1KWIEQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Nov 2011 03:04:16 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:16342 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752576Ab1KWIEQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Nov 2011 03:04:16 -0500
X-Greylist: delayed 370 seconds by postgrey-1.27 at vger.kernel.org; Wed, 23 Nov 2011 03:04:16 EST
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.339.1; Wed, 23 Nov
 2011 08:58:01 +0100
Received: from MBX12.d.ethz.ch ([fe80::fcbd:f3f9:2031:cf24]) by
 CAS22.d.ethz.ch ([fe80::dd0e:466a:b055:c090%10]) with mapi id 14.01.0339.001;
 Wed, 23 Nov 2011 08:58:03 +0100
Thread-Topic: [PATCH] Fix https interactive authentication problem
Thread-Index: AcyptUaJjqOdDLGZTkaNc3d3IkAACg==
Accept-Language: de-CH, en-US
Content-Language: de-CH
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [80.218.216.248]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185823>

>From 986e29085ee2215a3e0a412ee7874dc2d0ef36be Mon Sep 17 00:00:00 2001
From: Ruedi Steinmann <ruediste@student.ethz.ch>
Date: Wed, 23 Nov 2011 08:41:52 +0100
Subject: [PATCH] Fix https interactive authentication problem

Cloning a repository over https works fine when the username/password is
given in the URL. But if it is queried interactively, an error occurs(see below).
I found that the username/password is not set when a connection is reused.

With this patch, the username/password is set whenever a connection is reused.

Sample output showing the error:

git clone https://n.ethz.ch/student/...
Cloning into ...
Username:
Password:
error: Unable to get pack file https://n.ethz.ch/student/.../objects/pack/pack-1ced2ebff0c9fc1f07e0c7cc9dd3fc75f6ac6962.pack
The requested URL returned error: 401
...
error: Fetch failed.


Signed-off-by: Ruedi Steinmann <ruediste@student.ethz.ch>
---
 http.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/http.c b/http.c
index e6c7597..c7b3558 100644
--- a/http.c
+++ b/http.c
@@ -550,7 +550,10 @@ struct active_request_slot *get_active_slot(void)
     curl_easy_setopt(slot->curl, CURLOPT_POSTFIELDS, NULL);
     curl_easy_setopt(slot->curl, CURLOPT_UPLOAD, 0);
     curl_easy_setopt(slot->curl, CURLOPT_HTTPGET, 1);
-
+
+    // set username and password if already set
+    init_curl_http_auth(slot->curl);
+
     return slot;
 }

--
1.7.5.4
