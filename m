From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH v2] Windows: correct detection of EISDIR in mingw_open()
Date: Sun, 16 Nov 2014 22:06:26 +0100
Message-ID: <546911D2.6060007@kdbg.org>
References: <CAO2U3QiFvwMiwVCdVju_vJKK_HVndpQf4VyrEaHeeVVN6rgYgA@mail.gmail.com>	<20141109014354.GA23883@peff.net> <20141109015918.GA24736@peff.net>	<5463C106.5090803@kdbg.org> <20141112215923.GB6801@peff.net>	<546470D0.3080809@kdbg.org> <20141113090832.GA8329@peff.net>	<546653D6.7040505@kdbg.org> <87zjbtlcj0.fsf@igel.home> <54670E8E.5040901@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Andreas Schwab <schwab@linux-m68k.org>, 
 Michael Blume <blume.mike@gmail.com>,
 Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, 
 msysGit <msysgit@googlegroups.com>
To: Jeff King <peff@peff.net>
X-From: msysgit+bncBCJYV6HBKQINLI5EUMCRUBHISNFWS@googlegroups.com Sun Nov 16 22:06:31 2014
Return-path: <msysgit+bncBCJYV6HBKQINLI5EUMCRUBHISNFWS@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-la0-f64.google.com ([209.85.215.64])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCJYV6HBKQINLI5EUMCRUBHISNFWS@googlegroups.com>)
	id 1Xq71i-0003Ht-IX
	for gcvm-msysgit@m.gmane.org; Sun, 16 Nov 2014 22:06:30 +0100
Received: by mail-la0-f64.google.com with SMTP id gm9sf86782lab.9
        for <gcvm-msysgit@m.gmane.org>; Sun, 16 Nov 2014 13:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe;
        bh=v3Cv0outfJJ49yYcjBxa3UYchLLAyYiJt5GwF85R7rM=;
        b=jKTAbNpk1FVdVLgDA2P3oxmxEoa/I/j/GiD7mEkHsQHJrUlp9QIGiKnJc0mq3NMQON
         FzESIT4cBVTje9rSQorqO6mgE3R04b8sPf3GsrM9676Aj2Z4MjNC90I7127D/Ah4s5oq
         MFDimYGlCKxyB1H3+ccveSunAsxfMc+mnbEeTmfJM3Qts9ScEXGJVCUYQpk9jX7FfkNI
         8lUYz1JyD35CNogiS5VWEe0Q7I7XxxwRHFwixOUSIsyivZjnqNo1BcQB3aM7vMXeEvZo
         +IC2QAQfZKlB3HuxxTQ4QwbbkFD5xAqZ+YbKd0mUMM87i3RiU7FLMpIwpTmMxWxRGuBC
         2gPA==
X-Received: by 10.180.101.68 with SMTP id fe4mr88744wib.18.1416171990366;
        Sun, 16 Nov 2014 13:06:30 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.107.135 with SMTP id hc7ls3842wib.20.canary; Sun, 16 Nov
 2014 13:06:29 -0800 (PST)
X-Received: by 10.180.189.116 with SMTP id gh20mr471147wic.2.1416171989303;
        Sun, 16 Nov 2014 13:06:29 -0800 (PST)
Received: from bsmtp.bon.at (bsmtp3.bon.at. [213.33.87.17])
        by gmr-mx.google.com with ESMTPS id el8si485186wib.3.2014.11.16.13.06.29
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Nov 2014 13:06:29 -0800 (PST)
Received-SPF: none (google.com: j6t@kdbg.org does not designate permitted sender hosts) client-ip=213.33.87.17;
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 3jgmDg520Gz5tlC;
	Sun, 16 Nov 2014 22:06:27 +0100 (CET)
Received: from dx.sixt.local (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id E081419F788;
	Sun, 16 Nov 2014 22:06:26 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
In-Reply-To: <54670E8E.5040901@kdbg.org>
X-Original-Sender: j6t@kdbg.org
X-Original-Authentication-Results: gmr-mx.google.com;       spf=neutral
 (google.com: j6t@kdbg.org does not designate permitted sender hosts) smtp.mail=j6t@kdbg.org
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/msysgit/subscribe>

According to the Linux open(2) man page, open() returns EISDIR if a
directory was attempted to be opened for writing. Our emulation in
mingw_open() does not get this right: it checks only for O_CREAT. Fix
it to check for a write request.

This fixes a failure in reflog handling, which opens files with
O_APPEND|O_WRONLY, but without O_CREAT, and expects EISDIR when the
named file happens to be a directory.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 This version of the patch uses O_ACCMODE.

 compat/mingw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 2ee3fe3..c702731 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -312,7 +312,7 @@ int mingw_open (const char *filename, int oflags, ...)
 		return -1;
 	fd = _wopen(wfilename, oflags, mode);
 
-	if (fd < 0 && (oflags & O_CREAT) && errno == EACCES) {
+	if (fd < 0 && (oflags & O_ACCMODE) != O_RDONLY && errno == EACCES) {
 		DWORD attrs = GetFileAttributesW(wfilename);
 		if (attrs != INVALID_FILE_ATTRIBUTES && (attrs & FILE_ATTRIBUTE_DIRECTORY))
 			errno = EISDIR;
-- 
2.0.0.12.gbcf935e

-- 
-- 
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=en_US?hl=en

--- 
You received this message because you are subscribed to the Google Groups "Git for Windows" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
