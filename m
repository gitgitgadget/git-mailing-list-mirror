From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: Re: pack-object poor performance (with large number of objects?)
Date: Mon, 3 Oct 2011 19:17:19 +0200
Message-ID: <CAA01CsppPf_6Zp5UPYBsxa1JEwLGF-FqacRa7kBJ45Ges2ujrw@mail.gmail.com>
References: <CAA01CspZijOO_xbR=OcaRaesTeSy=6RM4DR01-07qimVzxvJZA@mail.gmail.com>
	<CAJo=hJtw+sYrP09zrDbZJNGHDYOeguQLkOe88FBYQDZrnaqsAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>,
	Ingo Molnar <mingo@elte.hu>, Junio C Hamano <gitster@pobox.com>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Oct 03 19:17:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RAm8r-0000JD-1C
	for gcvg-git-2@lo.gmane.org; Mon, 03 Oct 2011 19:17:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755693Ab1JCRRV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Oct 2011 13:17:21 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:51050 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754928Ab1JCRRU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Oct 2011 13:17:20 -0400
Received: by gyg10 with SMTP id 10so3614491gyg.19
        for <git@vger.kernel.org>; Mon, 03 Oct 2011 10:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=IM6F+H4yF/w+giFgH7hp7T7wMumV0npOOmePmKMRXHw=;
        b=d2Dw8fZ0pqj4JLSWw798BwCiq6kJeL8YtqjnuAf7sKxYGJrV3azm+vb8LiEFGpGe36
         3BN+ktNlGb/SUOcXfBvZ1lZ+768LtSn7HDMr7qM/aVKcBV8rWvDhg1JVlE9vrQJqoN3Y
         lEYxy6h8Yiqpx7+jPiLUB0nIvmXVdmEzKWxaI=
Received: by 10.150.207.19 with SMTP id e19mr369243ybg.287.1317662239323; Mon,
 03 Oct 2011 10:17:19 -0700 (PDT)
Received: by 10.150.196.1 with HTTP; Mon, 3 Oct 2011 10:17:19 -0700 (PDT)
In-Reply-To: <CAJo=hJtw+sYrP09zrDbZJNGHDYOeguQLkOe88FBYQDZrnaqsAw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182673>

On Mon, Oct 3, 2011 at 6:05 PM, Shawn Pearce <spearce@spearce.org> wrote:
> On Mon, Oct 3, 2011 at 07:43, Piotr Krukowiecki
> <piotr.krukowiecki@gmail.com> wrote:
>> I'm having poor git gc (pack-object) performance. Please read below
>> for details. What can I do to improve the performance/debug the reason
>> for the slowness? Should I leave the process running over night, or
>> should I stop it (for debugging)?
>> CCing people who posted some patches/benchmarks for pack-objects recently.
>>
>> git gc was first run automatically by git svn clone. It found 1544673
>> objects and worked for 50 minutes until I've killed it.
>>
>> Then I've run it by hand with --aggresive (because I've found on
>> Internet it helped in some cases). It found 1742200 objects this time.
>> At this moment it's been working for about 90 minutes.
>
> Packing time depends on a number of factors. One of them is the number
> of unpacked objects to process. With 1.7 million objects, yes, its
> going to take some time.

Any statistics how long it should take?


> Another factor is how much RAM you have on
> your system. Packing requires a lot of memory, especially with the
> --aggressive flag, as the packer tries up to 250 different
> combinations of two objects searching for a good delta compression
> format, and all 250 of those are typically in-memory at once. If you
> have insufficient physical RAM, the system will swap, unless you
> decrease the window size.

I have 4GB of RAM and not all was used so it certainly shouldn't be
swapping. The process was in 'D' state so I suppose the hard disk
might be the limiting factor.

I think I also disabled threading (I'll check tomorrow) - I suppose it
has impact on packing time too.

I'll re-run packing tomorrow with threading and check the memory
usage, is there anything else I can do?

>
>> The large number of unpacked objects is probably caused by me - I've
>> disabled auto gc when I was cloning from svn (I though it might speed
>> up things if it didn't repack several times during clone, only once
>> afterwards).
>
> Yes, this the reason `git svn` runs GC during its import. If you defer
> all of the repacking work until the end, with everything loose, it can
> take a very, very long time to repack. If you repack as you go, the
> incremental repacks are less expensive than a full repack, and the
> entire process will go faster overall.

I've learned the lesson :)

-- 
Piotr Krukowiecki
