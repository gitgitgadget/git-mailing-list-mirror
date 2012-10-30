From: Junio C Hamano <gitster@pobox.com>
Subject: Re: crash on git diff-tree -Ganything <tree> for new files with textconv filter
Date: Tue, 30 Oct 2012 21:46:01 +0900
Message-ID: <da24b6ea-ac9b-46dd-b591-25fd4e8e6504@email.android.com>
References: <508C29E4.5000801@arcor.de> <20121028120104.GE11434@sigill.intra.peff.net> <508D8DF7.7040007@arcor.de> <20121029060524.GB4457@sigill.intra.peff.net> <508EE4E4.1080407@arcor.de> <20121029223521.GJ20513@sigill.intra.peff.net> <20121029224705.GA32148@sigill.intra.peff.net> <20121030121747.GA4231@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>, Peter Oberndorfer <kumbayo84@arcor.de>
X-From: git-owner@vger.kernel.org Tue Oct 30 13:46:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTBD9-0002nm-Lm
	for gcvg-git-2@plane.gmane.org; Tue, 30 Oct 2012 13:46:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755572Ab2J3MqO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2012 08:46:14 -0400
Received: from mail-da0-f46.google.com ([209.85.210.46]:63603 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750881Ab2J3MqN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2012 08:46:13 -0400
Received: by mail-da0-f46.google.com with SMTP id n41so98505dak.19
        for <git@vger.kernel.org>; Tue, 30 Oct 2012 05:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:user-agent:in-reply-to:references:mime-version:content-type
         :content-transfer-encoding:subject:from:date:to:cc:message-id;
        bh=vwiOnCqtvA0eIOXmUVaVuox7My9i0MS2xyOvoVCbDlg=;
        b=UTZdESszZ18EthTLp2N0uf1rUlxy+AR543WBeDCnylbDPNR1B2+LgomSTxCKATc9An
         wXMyPu1/mgvAxKOARJGGU6um3ut10vbtEJVmeS0eOnU17Ky63+650yl62VXJpvcuWsek
         wvF0zfA2U7BwToQF09fat4g0aGAkuzNqc9SVu1iIvws5I0rqK9ni6l6N0FBy+gwpCHoH
         ajgJJNeKCApmXiT2VwXqm7+JkPB7+iVGMfDFG0CoMFMsBGZq44w0GmOf9BGLKsULENmD
         XQDP8UeT0IFF2igdCoMC3EB+mtX+Tjz0zF9pfqnNtpsCz0O/fMcR9LrikQx48kgzHbeX
         6I1g==
Received: by 10.66.88.133 with SMTP id bg5mr91982330pab.80.1351601173158;
        Tue, 30 Oct 2012 05:46:13 -0700 (PDT)
Received: from [192.168.0.4] (112.136.6.15.er.eaccess.ne.jp. [112.136.6.15])
        by mx.google.com with ESMTPS id vo8sm511903pbc.16.2012.10.30.05.46.11
        (version=SSLv3 cipher=OTHER);
        Tue, 30 Oct 2012 05:46:12 -0700 (PDT)
User-Agent: K-9 Mail for Android
In-Reply-To: <20121030121747.GA4231@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208700>

(1) sounds attractive for more than one reason. In addition to avoidance of this issue, it would bring bug-to-bug compatibility across platforms.

(4), if we can run grep on streaming data (tweak interface we have for checking out a large blob to the working tree), would let us work on dataset larger than fit in core. Even though it would be much more work, it might turn out to be a better option in the longer run.

Jeff King <peff@peff.net> wrote:

>On Mon, Oct 29, 2012 at 06:47:05PM -0400, Jeff King wrote:
>
>> On Mon, Oct 29, 2012 at 06:35:21PM -0400, Jeff King wrote:
>> 
>> > The patch below fixes it, but it's terribly inefficient (it just
>detects
>> > the situation and reallocates). It would be much better to disable
>the
>> > reuse_worktree_file mmap when we populate the filespec, but it is
>too
>> > late to pass an option; we may have already populated from an
>earlier
>> > diffcore stage.
>> > 
>> > I guess if we teach the whole diff code that "-G" (and
>--pickaxe-regex)
>> > is brittle, we can disable the optimization from the beginning
>based on
>> > the diff options. I'll take a look.
>> 
>> Hmm. That is problematic for two reasons.
>> 
>>   1. The whole diff call chain will have to be modified to pass the
>>      options around, so they can make it down to the
>>      diff_populate_filespec level. Alternatively, we could do some
>kind
>>      of global hack, which is ugly but would work OK in practice.
>> 
>>   2. Reusing a working tree file is only half of the reason a
>filespec
>>      might be mmap'd. It might also be because we are literally
>diffing
>>      the working tree. "-G" was meant to be used to limit log
>traversal,
>>      but it also works to reduce the diff output for something like
>"git
>>      diff HEAD^".
>> 
>> I really wish there were an alternate regexec interface we could use
>> that took a pointer/size pair. Bleh.
>
>Thinking on it more, my patch, hacky thought it seems, may not be the
>worst solution. Here are the options that I see:
>
>  1. Use a regex library that does not require NUL termination. If we
>     are bound by the regular regexec interface, this is not feasible.
>     But the GNU implementation works on arbitrary-length buffers (you
>     just have to use a slightly different interface), and we already
>    carry it in compat. It would mean platforms which provide a working
>     but non-GNU regexec would have to start defining NO_REGEX.
>
>  2. Figure out a way to get one extra zero byte via mmap. If the
>     requested size does not fall on a page boundary, you get extra
>     zero-ed bytes. Unfortunately, requesting an extra byte does not
>     do what we want; you get SIGBUS accessing it.
>
> 3. Copy mmap'd data at point-of-use into a NUL-terminated buffer. That
>     way we only incur the cost when we need it.
>
>  4. Avoid mmap-ing in the first place when we are using -G or
>     --pickaxe-regex (e.g., by doing a big read()). At first glance,
>     this sounds more efficient than loading the data one way and then
>     making another copy. But mmap+memcpy, aside from the momentary
>    doubled memory requirement, is probably just as fast or faster than
>     calling read() repeatedly.
>
>I am really tempted by (1).
>
>Given that (2) does not work, unless somebody comes up with something
>clever there, that would make (3) the next best choice.
>
>-Peff
