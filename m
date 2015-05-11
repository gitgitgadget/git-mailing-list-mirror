From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 18/18] reflog_expire(): integrate lock_ref_sha1_basic() errors into ours
Date: Mon, 11 May 2015 17:25:20 +0200
Message-ID: <1431357920-25090-19-git-send-email-mhagger@alum.mit.edu>
References: <1431357920-25090-1-git-send-email-mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 11 17:26:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yrpax-0002iU-J3
	for gcvg-git-2@plane.gmane.org; Mon, 11 May 2015 17:26:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754466AbbEKP0J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2015 11:26:09 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:48239 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754430AbbEKP0F (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 May 2015 11:26:05 -0400
X-AuditID: 12074412-f79e46d0000036b4-85-5550ca0a88a6
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 41.C7.14004.A0AC0555; Mon, 11 May 2015 11:26:02 -0400 (EDT)
Received: from michael.fritz.box (p5DDB195E.dip0.t-ipconnect.de [93.219.25.94])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t4BFPNnU002156
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 11 May 2015 11:26:00 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1431357920-25090-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIIsWRmVeSWpSXmKPExsUixO6iqMt1KiDUoKWVzaLrSjeTRUPvFWaL
	2yvmM1v8aOlhtti8uZ3F4sybRkYHNo+/7z8weSzYVOrxrHcPo8fFS8oeix94eXzeJBfAFsVt
	k5RYUhacmZ6nb5fAnbHszz7WglNsFb9u3mdqYFzO2sXIySEhYCLx6sRfKFtM4sK99WxdjFwc
	QgKXGSV2vX/FCuEcZ5I48PweI0gVm4CuxKKeZiYQW0RATWJi2yEWkCJmgV2MEveWTgVyODiE
	BaIlDqzTBalhEVCV6Jn/jhnE5hVwlVjfcI8JYpucxPnjP8HinEDxpVcvs4DYQgIuEk2P77FM
	YORdwMiwilEuMac0Vzc3MTOnODVZtzg5MS8vtUjXTC83s0QvNaV0EyMkyIR2MK4/KXeIUYCD
	UYmH1+CCf6gQa2JZcWXuIUZJDiYlUd5fewNChfiS8lMqMxKLM+KLSnNSiw8xSnAwK4nwKq8B
	yvGmJFZWpRblw6SkOViUxHl/Llb3ExJITyxJzU5NLUgtgsnKcHAoSfC+OQHUKFiUmp5akZaZ
	U4KQZuLgBBnOJSVSnJqXklqUWFqSEQ+KjfhiYHSApHiA9n4FaectLkjMBYpCtJ5i1OW4M+X/
	IiYhlrz8vFQpcd57IEUCIEUZpXlwK2Ap5RWjONDHwrwfQap4gOkIbtIroCVMQEsc48CWlCQi
	pKQaGLNONVTF/uqNC9o481V51WX7j1pVpmuuhHam7LTd8l1NsTZYruppccDr6zsUFj/576Hl
	9XpD9Ry+5l2ShhmBH5kX71634EOEmf/Ov+Wsl5hUmJhKBVuuda4J/Sk0j2PJsVnz 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268788>

Now that lock_ref_sha1_basic() gives us back its error messages via a
strbuf, incorporate its error message into our error message rather
than emitting two separate error messages.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index bc4b1ab..97043fd 100644
--- a/refs.c
+++ b/refs.c
@@ -4118,9 +4118,9 @@ int reflog_expire(const char *refname, const unsigned char *sha1,
 	 */
 	lock = lock_ref_sha1_basic(refname, sha1, NULL, NULL, 0, &type, &err);
 	if (!lock) {
-		error("%s", err.buf);
+		error("cannot lock ref '%s': %s", refname, err.buf);
 		strbuf_release(&err);
-		return error("cannot lock ref '%s'", refname);
+		return -1;
 	}
 	if (!reflog_exists(refname)) {
 		unlock_ref(lock);
-- 
2.1.4
