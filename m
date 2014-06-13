From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH 7/6] Win32: reliably detect console pipe handles
Date: Sat, 14 Jun 2014 00:09:06 +0200
Message-ID: <539B7682.7070308@gmail.com>
References: <20140606183935.GA4197@camelia.ucw.cz> <1402127845-4862-1-git-send-email-kasal@ucw.cz> <1402127845-4862-6-git-send-email-kasal@ucw.cz> <539A95F1.9030900@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>,
	msysGit <msysgit@googlegroups.com>, Karsten Blees <blees@dcon.de>
To: Johannes Sixt <j6t@kdbg.org>, Stepan Kasal <kasal@ucw.cz>
X-From: git-owner@vger.kernel.org Sat Jun 14 00:09:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvZep-0001NU-RU
	for gcvg-git-2@plane.gmane.org; Sat, 14 Jun 2014 00:09:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753924AbaFMWJH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2014 18:09:07 -0400
Received: from mail-we0-f181.google.com ([74.125.82.181]:44763 "EHLO
	mail-we0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753825AbaFMWJG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2014 18:09:06 -0400
Received: by mail-we0-f181.google.com with SMTP id q59so3431195wes.12
        for <git@vger.kernel.org>; Fri, 13 Jun 2014 15:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=IBOFxOdEmpzjsWuVSrcrdCe4/SSTj9OQnHTswmgaiMw=;
        b=ZG2N0WGnbw/rP05LgobnUQpWWwcKRUfoJ3lPmMyg9IFazxxkYfhx8HoyaV9RbtCzwx
         zM7l1gBxelQzo0W6zR9x07hZTBdM1Zm9iZ5s3l/2SUI9YLoLqZH0Mh2LEr8x91kvjq4f
         3k6c6KzDw+uWgQb3IK3OwyVDgli4N0fBOBMUcC396iIeucuT9B14hUj0+2GjhRyowTIL
         N9U5TCiNKpKRu4eyUYTbCm9nA289uM2LZ0k12Q0YGeNwSJlcK/1Wh3YlnORInyo/h6Rc
         xxEcSG3y1EvWKFQiQfjNsQfwkKRPM7bLZCkPZM4+zLxHEbWIxPo1YphE26c/eiBzMued
         IAaQ==
X-Received: by 10.180.72.201 with SMTP id f9mr8244390wiv.41.1402697344901;
        Fri, 13 Jun 2014 15:09:04 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id v7sm14547524eew.37.2014.06.13.15.09.03
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 13 Jun 2014 15:09:04 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <539A95F1.9030900@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251643>

As of "Win32: Thread-safe windows console output", child processes may
print to the console even if stdout has been redirected to a file. E.g.:

 git config tar.cat.command "cat"
 git archive -o test.cat HEAD

Detecting whether stdout / stderr point to our console pipe is currently
based on the assumption that OS HANDLE values are never reused. This is
apparently not true if stdout / stderr is replaced via dup2() (as in
builtin/archive.c:17).

Instead of comparing handle values, check if the file descriptor isatty()
backed by a pipe OS handle. This is only possible by swapping the handles
in MSVCRT's internal data structures, as we do in winansi_init().

Reported-by: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: Karsten Blees <blees@dcon.de>
---

Thanks for reporting this.

The fix applies on top of [6/6] Win32: fix broken pipe detection (should
probably not be squashed, as its obviously not as well tested as the
rest of the series).

Cheers,
Karsten


 compat/winansi.c | 25 +++++++------------------
 1 file changed, 7 insertions(+), 18 deletions(-)

diff --git a/compat/winansi.c b/compat/winansi.c
index f96d5c2..efc5bb3 100644
--- a/compat/winansi.c
+++ b/compat/winansi.c
@@ -20,7 +20,6 @@ static WORD attr;
 static int negative;
 static int non_ascii_used = 0;
 static HANDLE hthread, hread, hwrite;
-static HANDLE hwrite1 = INVALID_HANDLE_VALUE, hwrite2 = INVALID_HANDLE_VALUE;
 static HANDLE hconsole1, hconsole2;
 
 #ifdef __MINGW32__
@@ -435,10 +434,6 @@ static void winansi_exit(void)
 	WaitForSingleObject(hthread, INFINITE);
 
 	/* cleanup handles... */
-	if (hwrite1 != INVALID_HANDLE_VALUE)
-		CloseHandle(hwrite1);
-	if (hwrite2 != INVALID_HANDLE_VALUE)
-		CloseHandle(hwrite2);
 	CloseHandle(hwrite);
 	CloseHandle(hthread);
 }
@@ -565,14 +560,9 @@ void winansi_init(void)
 
 	/* redirect stdout / stderr to the pipe */
 	if (con1)
-		hconsole1 = swap_osfhnd(1, hwrite1 = duplicate_handle(hwrite));
+		hconsole1 = swap_osfhnd(1, duplicate_handle(hwrite));
 	if (con2)
-		hconsole2 = swap_osfhnd(2, hwrite2 = duplicate_handle(hwrite));
-}
-
-static int is_same_handle(HANDLE hnd, int fd)
-{
-	return hnd != INVALID_HANDLE_VALUE && hnd == (HANDLE) _get_osfhandle(fd);
+		hconsole2 = swap_osfhnd(2, duplicate_handle(hwrite));
 }
 
 /*
@@ -581,10 +571,9 @@ static int is_same_handle(HANDLE hnd, int fd)
  */
 HANDLE winansi_get_osfhandle(int fd)
 {
-	if (fd == 1 && is_same_handle(hwrite1, 1))
-		return hconsole1;
-	else if (fd == 2 && is_same_handle(hwrite2, 2))
-		return hconsole2;
-	else
-		return (HANDLE) _get_osfhandle(fd);
+	HANDLE hnd = (HANDLE) _get_osfhandle(fd);
+	if ((fd == 1 || fd == 2) && isatty(fd)
+	    && GetFileType(hnd) == FILE_TYPE_PIPE)
+		return (fd == 1) ? hconsole1 : hconsole2;
+	return hnd;
 }
-- 
1.9.3.10.ge3256ea
