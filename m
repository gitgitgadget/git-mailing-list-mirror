From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: [PATCH] Work around performance bug in subprocess.Popen.communicate()
Date: Thu, 13 Aug 2009 23:18:59 +0100
Message-ID: <b0943d9e0908131518i3ac18331leb4c0c76313b0780@mail.gmail.com>
References: <20090731093632.7018.24435.stgit@october.e.vtech>
	 <b0943d9e0907310427r7e59aa5fi5e5ff5e3f3c03819@mail.gmail.com>
	 <20090804085125.GB27452@lux.e.vtech>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: mandolaerik@gmail.com, git@vger.kernel.org
To: Karl Wiberg <kha@virtutech.com>
X-From: git-owner@vger.kernel.org Fri Aug 14 00:19:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbidY-0005FN-S5
	for gcvg-git-2@gmane.org; Fri, 14 Aug 2009 00:19:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753424AbZHMWTA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Aug 2009 18:19:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752716AbZHMWTA
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Aug 2009 18:19:00 -0400
Received: from mail-bw0-f222.google.com ([209.85.218.222]:39789 "EHLO
	mail-bw0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752664AbZHMWS7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Aug 2009 18:18:59 -0400
Received: by bwz22 with SMTP id 22so858725bwz.18
        for <git@vger.kernel.org>; Thu, 13 Aug 2009 15:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=+b2klHT+nW+r4h95I6ro6G99jVOWwqEOniu3YSsixmc=;
        b=UTJt2RYCuZzRXHXypbJoS+bgclkS4jqr2hBxETBDLWYYIji+OGj+MwtOv8Oy8yZMBP
         EwnNzBbVSCtdQB1KAkilv/JtWYTlWLKN7bPKfYG+05fgDD+FPn07E/fD6sdHsOAvTW+Q
         eS7pV0LpZigoas+LNSbF3hO+sup+75Ju15Mhg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=KoGOTUdKXcpnfR0vI9ctBLbNalwMWLRfT516vTqHo0FBDu2xZCPezv9OjLrWEIc0bg
         XGDbWgMQ57IUszRr9jAa0vh8+wU4OKDxsUbrJ+2KAFL8TreI9fyFxYe8yinwTIaYNsj9
         LTNjGgRL3ff/8Hco+XVr+OnAaboBn1GV9YTwo=
Received: by 10.223.1.137 with SMTP id 9mr437401faf.93.1250201939706; Thu, 13 
	Aug 2009 15:18:59 -0700 (PDT)
In-Reply-To: <20090804085125.GB27452@lux.e.vtech>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125888>

2009/8/4 Karl Wiberg <kha@virtutech.com>:
> On 2009-07-31 12:27:53 +0100, Catalin Marinas wrote:
>
>> But can this not lead to a deadlock if the __indata is big? The
>> stdout of the created process is only processed once the whole
>> __indata is written. I thought communicate() was created to avoid
>> this issue.
>
> I don't think there's a problem. write() isn't supposed to have a
> limit on the amount of data it will accept in one call, as far as I'm
> aware. Plus, it works just fine with Erik's test case---which in my
> case was about 7 MB. If it can handle 7 MB, I doubt there's a limit
> we'll hit anytime soon.

write() itself doesn't have a limit, it's mainly what the application
receiving the data can handle. In the Git case, I think it takes all
the input as it isn't a filtering tool (things may be different with
tools like sed etc.).

> Oh, and we still call communicate()---we just don't pass it any
> additional bytes to write to stdin.

Yes, but if write() is blocked, communicate() won't be called.

Since we are only using Git, I'll merge this patch (and maybe add a comment).

-- 
Catalin
