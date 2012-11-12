From: Drew Northup <n1xim.email@gmail.com>
Subject: Re: [BUG] gitweb: XSS vulnerability of RSS feed
Date: Mon, 12 Nov 2012 13:55:46 -0500
Message-ID: <CAM9Z-n=6xsC7yiKJ+NU-CxNPxEXWmJzvXLUocgZgWPQnuK6G4Q@mail.gmail.com>
References: <20121111232820.284510@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, jnareb@gmail.com,
	Junio C Hamano <gitster@pobox.com>
To: glpk xypron <xypron.glpk@gmx.de>
X-From: git-owner@vger.kernel.org Mon Nov 12 19:56:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXzAv-0008Lq-DP
	for gcvg-git-2@plane.gmane.org; Mon, 12 Nov 2012 19:56:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751777Ab2KLSzs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2012 13:55:48 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:49072 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751076Ab2KLSzs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2012 13:55:48 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so230530bkw.19
        for <git@vger.kernel.org>; Mon, 12 Nov 2012 10:55:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=OZvTDK8Bj4r11tYm3EvA+lkz7s1rirsxCDy1HBEs0SE=;
        b=igkRX0RO54E8phibwKtitvBXZhQXfMKu8mF/3+eGLtW3Onm1FVFSSbPx22ULoT3xnt
         /OyHqf+hbXJknl2PRqZLS2EfIORZx87wx7ewJ8yJGgzFzMQQiTd89HoOQI4DHIppKdQY
         WvRr+Nc5e7gtLAwzpo/E64tlNbLRRfbQB/wPyIxD/xDCf/nPIZuZ38vlaQIK5OsU0G26
         eziAmIOGVQa1x1JZygRjQqy5NTVZg2pzxxvVBqdG3KkOPWrbSWRW+sEKLYyj9+h0KMHw
         8VIayC/fXVLC5b7NxYuXJ9JHG9l0MaOUoyIoh72+Zrf7UwocgCZnqeYFN87lfh16V/WI
         P44Q==
Received: by 10.204.4.80 with SMTP id 16mr918068bkq.73.1352746546535; Mon, 12
 Nov 2012 10:55:46 -0800 (PST)
Received: by 10.205.122.144 with HTTP; Mon, 12 Nov 2012 10:55:46 -0800 (PST)
In-Reply-To: <20121111232820.284510@gmx.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209509>

On Sun, Nov 11, 2012 at 6:28 PM, glpk xypron <xypron.glpk@gmx.de> wrote:
> Gitweb can be used to generate an RSS feed.
>
> Arbitrary tags can be inserted into the XML document describing
> the RSS feed by careful construction of the URL.
>
> Example
> http://server/?p=project.git&a=rss&f=</title><script>alert(document.cookie)</script><title>
>
> The generated XML contains
> <script>alert(document.cookie)</script>
>
> Depending on the system used to render the XML this might lead
> to the execution of javascript in the security context of the
> gitweb server pages.
>
> Please, escape all URL parameters.
>
> Version tested:
> gitweb v.1.8.0.dirty with git 1.7.2.5
>
> Best regards
>> Heinrich Schuchardt

Something like this may be useful to defuse the "file" parameter, but
I presume a more definitive fix is in order...

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 10ed9e5..af93e65 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1447,6 +1447,10 @@ sub validate_pathname {
        if ($input =~ m!\0!) {
                return undef;
        }
+       # No XSS <script></script> inclusions
+       if ($input =~ m!(<script>)(.*)(</script>)!){
+               return undef;
+       }
        return $input;
 }


(I am not a perl god, so this was the lowest hanging fruit.)

If desired I'll fashion this up into a proper patch.

-- 
-Drew Northup
--------------------------------------------------------------
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
