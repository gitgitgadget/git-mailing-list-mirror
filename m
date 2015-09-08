From: Raymond Jennings <shentino@gmail.com>
Subject: Re: Bug in default commit hook (improperly forbidding a single blank
 line at EOF)
Date: Mon, 7 Sep 2015 22:03:02 -0700
Message-ID: <55EE6C06.7010403@gmail.com>
References: <55EE3BD9.7020707@gmail.com>
 <20150908045504.GA26331@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Sep 08 07:03:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZZB3q-0001T7-TE
	for gcvg-git-2@plane.gmane.org; Tue, 08 Sep 2015 07:03:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751803AbbIHFDK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Sep 2015 01:03:10 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:35160 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751344AbbIHFDJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Sep 2015 01:03:09 -0400
Received: by pacfv12 with SMTP id fv12so116002554pac.2
        for <git@vger.kernel.org>; Mon, 07 Sep 2015 22:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-type:content-transfer-encoding;
        bh=tZrxbMEDr0sK4Lc/zRp03LCIWKWzrYMZF9qyxtlzhI0=;
        b=IxKLgcAa5H8agqj0uXvum2KOU51qNf/3Gslk5d/s7jraT5waxiEKkko/nQgLqWUet9
         e5DXu7x03uHt9Hq23FfHJ8YL7ZynGr7I8f3S8ZjhkGETGd42JNZkQkLRFYf1fsikKLZe
         kIZLVPD+h6bIylrir8WahRfOub8F6HOqpJlHo7aQr8Qwprs3c0ok5Fq3e+qBcM24le3y
         BDU7XByAuoxEQtcY7IG4LG2cHFc4UKQhVUBLd9msfwNUR6N4DekMXqFI9wyq13qkHge5
         tULE6izVW8LHip5q1FDhuZdyqdh/gh0JARPiw4hUsXYAzd8hr3+R/gwfQ0GHvEcKCVLb
         qQGg==
X-Received: by 10.68.195.231 with SMTP id ih7mr54453846pbc.26.1441688588902;
        Mon, 07 Sep 2015 22:03:08 -0700 (PDT)
Received: from [192.168.1.3] ([104.36.236.78])
        by smtp.gmail.com with ESMTPSA id p11sm1627998pdn.55.2015.09.07.22.03.07
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Sep 2015 22:03:08 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
In-Reply-To: <20150908045504.GA26331@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277486>

On 09/07/15 21:55, Jeff King wrote:
> On Mon, Sep 07, 2015 at 06:37:29PM -0700, Raymond Jennings wrote:
>
>> Please see https://bugs.gentoo.org/show_bug.cgi?id=559920 for further
>> details.
>>
>> Files *should* have a single blank line at the end, because a line should
>> always have a newline at the end.
> I'm not sure I follow. Lines should have a newline at the end, but there
> is no need to start a _new_ blank line. So a file with zero bytes has no
> lines (and no newline).
>
> A file that contains a single line, like "one\n", has each line end in a
> newline, and the file ends in a newline. There is no blank line.
>
> A file like "one\n\n" has two lines: one with text, and a blank line at
> the end.
>
> Can you clarify (preferably by showing a byte sequence of the file in
> question) what file you are feeding to the hook, what output you get,
> and what output you expect?
>
>> Adding a newline to the end of a file whose last line doesn't have one
>> should be legal...as long as you don't create empty lines at the end.
> If you mean turning "foo" (a file with no newline!) into "foo\n", I
> agree that is legal, and does not create an empty blank line at the end.
> But I don't think the hook complains about that.
Sorry, my mistake.  I just took a look at the file on console with 
mcedit, and it looks like gedit lied to me.

I'll be contacting gedit's maintainers with this instead, sorry for the 
spam.
> E.g., we can create a sequence of file content:
>
>    git init
>
>    echo -n one >file
>    git add file
>    git commit -m 'no newline'
>
>    echo >>file
>    git add file
>    git commit -m 'complete line'
>
>    echo >>file
>    git add file
>    git commit -m 'add a blank line'
>
> and run "log --check", which runs the same code that the pre-commit hook
> does:
>
>    git log --check
>
> Git complains only about the final, which looks right to me. If you want
> to redefine git's idea of which whitespace is worth complaining about,
> try:
>
>    git config core.whitespace -blank-at-eof
>
> See the description of core.whitespace in "git help config" for the
> complete list.  You can also set it per-file using gitattributes. See
> "git help attributes", section "Checking whitespace errors".
>
> -Peff
