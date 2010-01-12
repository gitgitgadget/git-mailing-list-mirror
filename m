From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 04/18] date.c: mark file-local function static
Date: Tue, 12 Jan 2010 10:43:36 +0100
Message-ID: <4B4C4448.9060908@viscovery.net>
References: <1263282781-25596-1-git-send-email-gitster@pobox.com> <1263282781-25596-5-git-send-email-gitster@pobox.com> <4B4C34B3.3010508@viscovery.net> <7vr5pv3d7w.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 12 10:43:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUdHt-0007uU-Ih
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jan 2010 10:43:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753852Ab0ALJnm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2010 04:43:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753791Ab0ALJnm
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jan 2010 04:43:42 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:58450 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751520Ab0ALJnl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2010 04:43:41 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1NUdHl-0007ku-1h; Tue, 12 Jan 2010 10:43:37 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id BECA31660F;
	Tue, 12 Jan 2010 10:43:36 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <7vr5pv3d7w.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.9 (+)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136709>

Junio C Hamano schrieb:
> Johannes Sixt <j.sixt@viscovery.net> writes:
>> This one is used from compat/mingw.c for the gettimeofday emulation.
>> Please leave it extern.

I'll add this patch to may windows-update series to avoids this hack.

--- 8< ---
From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH] compat/mingw.c: do not use tm_to_time_t from date.c

To implement gettimeofday(), a broken-down UTC time was requested from the
system using GetSystemTime() and converted using tm_to_time_t() because it
does not look at the current timezone, which mktime() would do. But
meanwhile we have grown infrastructure in mingw.c, so that we can use a
different conversion path. This way we can avoid the ugly back-reference
from the compatibility layer to the generic git code.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 compat/mingw.c |   18 +++++-------------
 1 files changed, 5 insertions(+), 13 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index faaaade..3c78f39 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -281,19 +281,11 @@ int mkstemp(char *template)
 
 int gettimeofday(struct timeval *tv, void *tz)
 {
-	SYSTEMTIME st;
-	struct tm tm;
-	GetSystemTime(&st);
-	tm.tm_year = st.wYear-1900;
-	tm.tm_mon = st.wMonth-1;
-	tm.tm_mday = st.wDay;
-	tm.tm_hour = st.wHour;
-	tm.tm_min = st.wMinute;
-	tm.tm_sec = st.wSecond;
-	tv->tv_sec = tm_to_time_t(&tm);
-	if (tv->tv_sec < 0)
-		return -1;
-	tv->tv_usec = st.wMilliseconds*1000;
+	FILETIME ft;
+	GetSystemTimeAsFileTime(&ft);
+	tv->tv_sec = filetime_to_time_t(&ft);
+	/* the unit is 100-nanoseconds, ie., a 10th of a microsecond */
+	tv->tv_usec = (ft.dwLowDateTime % 10000000) / 10;
 	return 0;
 }
 
-- 
1.6.6.1207.g714a1.dirty
