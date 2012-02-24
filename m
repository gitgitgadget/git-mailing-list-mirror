From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [FYI] very large text files and their problems.
Date: Fri, 24 Feb 2012 18:14:46 +0700
Message-ID: <CACsJy8Aq=ofaHo3RkOBWTYP3eehZAU0E=HeDoUpR0nh+seKxzA@mail.gmail.com>
References: <20120222154926.GC11202@pomac.netswarm.net> <CACsJy8Bdbegs7QdztvsFnKPcpAX5UL7s7uc37wF3_nF4kJQjrQ@mail.gmail.com>
 <20120224101121.GA9526@pomac.netswarm.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Ian Kumlien <pomac@vapor.com>
X-From: git-owner@vger.kernel.org Fri Feb 24 12:15:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0t7W-0008RZ-3S
	for gcvg-git-2@plane.gmane.org; Fri, 24 Feb 2012 12:15:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753037Ab2BXLPS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Feb 2012 06:15:18 -0500
Received: from mail-ww0-f42.google.com ([74.125.82.42]:49566 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752609Ab2BXLPR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Feb 2012 06:15:17 -0500
Received: by wgbgn7 with SMTP id gn7so346593wgb.1
        for <git@vger.kernel.org>; Fri, 24 Feb 2012 03:15:16 -0800 (PST)
Received-SPF: pass (google.com: domain of pclouds@gmail.com designates 10.180.8.226 as permitted sender) client-ip=10.180.8.226;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of pclouds@gmail.com designates 10.180.8.226 as permitted sender) smtp.mail=pclouds@gmail.com; dkim=pass header.i=pclouds@gmail.com
Received: from mr.google.com ([10.180.8.226])
        by 10.180.8.226 with SMTP id u2mr3954001wia.16.1330082116294 (num_hops = 1);
        Fri, 24 Feb 2012 03:15:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=dt14fS6MZNn1OpJLF6XBobGn78wdR4b4A7q/ejJTB74=;
        b=x8gqdTeboHRm5H3s1wdTLz/R3znY+TdSi0ZjJ3hCmrzYhMzYs6XL9cC8enS4Zd7tE/
         LzDTbkvNEKPVMdO1VMDs39lj77MBkdZhyYZs2P55I4uo9E8hyd73drErAWL3YgzlOd8C
         iUOiSPCQN7LQbRLaDAEL9dIGZGNP3GXmnrxRs=
Received: by 10.180.8.226 with SMTP id u2mr3171976wia.16.1330082116255; Fri,
 24 Feb 2012 03:15:16 -0800 (PST)
Received: by 10.223.13.5 with HTTP; Fri, 24 Feb 2012 03:14:46 -0800 (PST)
In-Reply-To: <20120224101121.GA9526@pomac.netswarm.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191429>

On Fri, Feb 24, 2012 at 5:11 PM, Ian Kumlien <pomac@vapor.com> wrote:
> I'm uncertain if you got my reply since i did it out of bounds - so i'll
> repeat myself - sorry... =)

yes I received it, just too busy this week.

>> > git needs to have atleast the same ammount of memory as the largest
>> > file free... Couldn't this be worked around?
>> >
>> > On a (32 bit) machine with 4GB memory - results in:
>> > fatal: Out of memory, malloc failed (tried to allocate 3310214313 bytes)
>> >
>> > (and i see how this could be a problem, but couldn't it be mitigated? or
>> > is it bydesign and intended behaviour?)
>>
>> I think that it's delta resolving that hogs all your memory. If your
>> files are smaller than 512M, try lower core.bigFileThreshold. The
>> topic jc/split-blob, which stores a big file are several smaller
>> pieces, might solve your problem. Unfortunately the topic is not
>> complete yet.
>
> Well, in this case it's just stream unpacking gzip data to disk, i
> understand if delta would be a problem... But wouldn't delta be a
> problem in the sence of <size_of_change>+<size_of_subdata>+<result> ?
>
> Ie, if the file is mmapped - it shouldn't have to be allocated, right?

We should not delta large files. I was worried that the large file
check could go wrong, But I guess your blob's not deltified in this
case.

When you receive a pack during a clone, the pack is streamed to
index-pack, not mmapped, and index-pack checks every object in there
in uncompressed form. I think I have found a way to avoid allocating
that much. Need some more check, then send out.
-- 
Duy
