From: Joshua Clayton <stillcompiling@gmail.com>
Subject: Re: [PATCH] Fix in Git.pm cat_blob crashes on large files
Date: Fri, 22 Feb 2013 07:11:54 -0800
Message-ID: <CAMB+bf+RyerXP3VP26KJM7wtVKOup15AeRpEewwKJx3=bL9+hQ@mail.gmail.com>
References: <CAMB+bfKYLjmDavcLaO7scBPfTLmzqAmH+k9uBj0WJ+dzj9vuyA@mail.gmail.com>
	<20130221224319.GA19021@sigill.intra.peff.net>
	<CAMB+bf+whVFD03neCh-gBORXOBoNjgaCbfP_mh8HgDy6UqGFZA@mail.gmail.com>
	<20130221232448.GA23736@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 22 16:12:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U8uIR-00059C-Ps
	for gcvg-git-2@plane.gmane.org; Fri, 22 Feb 2013 16:12:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757656Ab3BVPL5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Feb 2013 10:11:57 -0500
Received: from mail-lb0-f179.google.com ([209.85.217.179]:58994 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756818Ab3BVPL4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2013 10:11:56 -0500
Received: by mail-lb0-f179.google.com with SMTP id j14so642117lbo.38
        for <git@vger.kernel.org>; Fri, 22 Feb 2013 07:11:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=gJD/zTYjrQNINNhmq1Y6gDELyWSslEFhfPaRU7ZvOxQ=;
        b=mckNToDYyiLpJ8I6Z/thSNEpf3LgvGmfY3tkHnV8NCt+wp2T0XKpkyhtxuZ9tQFRZu
         scPqJ4en630wsOHQzH0kvgFfRtD6oX55hUGJ9WL1smbGrMu+tUwdN5bwbzUtaGKK+AKw
         x8RjdSqOHxShRP5XxkbHpaMypYbua1xt/MXVEQYIYsFdFEXHJCegMPdlPdxT9AYhGmHj
         9mmYtTt7mDT1cdBv2Mq4+gcLN+jyG12NZDX5RV9oxvBZmKc7VQv8ShfR4KBTrMORs6C6
         w73TwjsEysSBqU4lCcqFwRgp+kiLBoF3EidspslRC8As1mYCMofcbsY6YnqJspp5lPO+
         oK2Q==
X-Received: by 10.112.101.101 with SMTP id ff5mr1099745lbb.107.1361545915035;
 Fri, 22 Feb 2013 07:11:55 -0800 (PST)
Received: by 10.114.38.67 with HTTP; Fri, 22 Feb 2013 07:11:54 -0800 (PST)
In-Reply-To: <20130221232448.GA23736@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216834>

running git svn fetch on a remote repository (yes I know there are a
lot of possible outside variables, including network latency)
Code with 1024 reads and 64k writes:

real    75m19.906s
user    16m43.919s
sys     29m16.326s

Code with 1024 reads and 1024 writes:

real    71m21.006s
user    12m36.275s
sys     24m26.112s

...so the simpler code wins the trivial test.
I would say go with it.
Should I resubmit?

On Thu, Feb 21, 2013 at 3:24 PM, Jeff King <peff@peff.net> wrote:
> On Thu, Feb 21, 2013 at 03:18:40PM -0800, Joshua Clayton wrote:
>
>> > By having the read and flush size be the same, it's much simpler.
>>
>> My original bugfix did just read 1024, and write 1024. That works fine
>> and, yes, is simpler.
>> I changed it to be more similar to the original code in case there
>> were performance reasons for doing it that way.
>> That was the only reason I could think of for the design, and adding
>> the $flushSize variable means that
>> some motivated person could easily optimize it.
>>
>> So far I have been too lazy to profile the two versions....
>> I guess I'll try a trivial git svn init; git svn fetch and check back in.
>> Its running now.
>
> I doubt it will make much of a difference; we are already writing to a
> perl filehandle, so it will be buffered there (which I assume is 4K, but
> I haven't checked). And your version retains the 1024-byte read. I do
> think 1024 is quite low for this sort of descriptor-to-descriptor
> copying. I'd be tempted to just bump that 1024 to 64K.
>
>> In git svn fetch (which is how I discovered it) the file being passed
>> to cat_blob is a temporary file, which is checksummed before putting
>> it into place.
>
> Great. There may be other callers outside of our tree, of course, but I
> think it's pretty clear that the responsibility is on the caller to make
> sure the function succeeded. We are changing what gets put on the output
> stream for various error conditions, but ultimately that is an
> implementation detail that the caller should not be depending on.
>
> -Peff
