From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] Speedup recursive by flushing index only once for all entries
Date: Fri, 5 Jan 2007 12:22:39 +0100
Message-ID: <81b0412b0701050322u67131900xea969b2da9981a94@mail.gmail.com>
References: <81b0412b0701040247k47e398e6q34dd5233bb5706f6@mail.gmail.com>
	 <Pine.LNX.4.63.0701041327490.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <81b0412b0701040447u329dcf9bvcd7adb9e9d199f18@mail.gmail.com>
	 <7v8xgileza.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 05 12:22:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2n9p-0004XJ-EO
	for gcvg-git@gmane.org; Fri, 05 Jan 2007 12:22:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161046AbXAELWm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 Jan 2007 06:22:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161065AbXAELWm
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jan 2007 06:22:42 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:48612 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161046AbXAELWl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jan 2007 06:22:41 -0500
Received: by ug-out-1314.google.com with SMTP id 44so5676262uga
        for <git@vger.kernel.org>; Fri, 05 Jan 2007 03:22:40 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=imkBSN3fqh1wSnn7AmBixxm6VwBujnSSjWeGnEY629YgaKw9f/V0uTPgWb7v0lbVlLl8O84rSaCAervk4/fYUxN82v4BRIFa21Mzitpmpz/4/GJcxW4ODAHB9Zi86n/Wv2tpQYDO81JuQm9b4RaRgEdYZmuSumHf/6Gb9ViTfGY=
Received: by 10.78.123.4 with SMTP id v4mr2902835huc.1167996160047;
        Fri, 05 Jan 2007 03:22:40 -0800 (PST)
Received: by 10.78.135.3 with HTTP; Fri, 5 Jan 2007 03:22:39 -0800 (PST)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7v8xgileza.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35997>

On 1/4/07, Junio C Hamano <junkio@cox.net> wrote:
> >> However, I was wondering if the index has to be written at all.
> >> I expect the written index (except the last one, of course) to have no
> >> user...
> >
> > Good question...
>
> That's most likely because you played safe, and started from the
> Python version whose only way to manipulate the index and write
> out a tree was to actually write the index out.

Yes, it was because of that. Just didn't thought about when to
update index at all (never really had a time).

> So let's step back a bit.

Excellent analysis, thanks! I suspect heavily it will work as is.
Now, if only someone could find time to code it up...

> By the way, Alex, you seem to heavily work on Cygwin, and I am
> interested in your experience with Shawn's sliding mmap() on
> real projects, as I suspect Cygwin would be more heavily
> impacted with any mmap() related changes.  You already said
> performance is "bearable".  Does that mean it was better and
> got worse but still bearable, or it was unusably slow but now it
> is bearably usable?

It is usably slow: ~30 sec for a commit (I stopped using normal
commit, using update-index and simplified index commit now),
around minute for the recursive merges (if they are simple),
~10 sec for a hot-cache hard reset. Avoiding gitk whenever
possible.

Compared to my only linux system here:

2-3 times slower in diff-tree for 44K files, around 9k differences
(0.2 sec against 0.6 sec, it quickly adds up if you do it often,
like when merging (it's slower for really big merges, constrained
by CPU and memory), commiting, gitk).

The windows machine is a corporate Lenovo 2.66MHz/1Gb,SATA laptop.
The linux machine is 1.2MHz/384Mb, IDE noname notebook.

I somehow adapted myself to it though (reading mails, drinking coffee).
