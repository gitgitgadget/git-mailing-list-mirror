From: James Pickens <jepicken@gmail.com>
Subject: Re: Why Git is so fast
Date: Thu, 30 Apr 2009 18:25:21 -0700
Message-ID: <885649360904301825i40b6b7b7o9874ee3df2809a21@mail.gmail.com>
References: <46a038f90904270155i6c802fceoffc73eb5ab57130e@mail.gmail.com>
	 <m3fxfqnxn5.fsf_-_@localhost.localdomain>
	 <b4087cc50904300556s359c91dfu444fa40ea85bd66e@mail.gmail.com>
	 <200904301728.06989.jnareb@gmail.com>
	 <20090430185244.GR23604@spearce.org> <86iqkllw0c.fsf@broadpark.no>
	 <20090430204033.GV23604@spearce.org> <8663gllt88.fsf@broadpark.no>
	 <f488382f0904301723i37ef03d9w4e93848e603ed28b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Kjetil Barvik <barvik@broadpark.no>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Steven Noonan <steven@uplinklabs.net>
X-From: git-owner@vger.kernel.org Fri May 01 03:25:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzhVM-00030V-M4
	for gcvg-git-2@gmane.org; Fri, 01 May 2009 03:25:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753560AbZEABZX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Apr 2009 21:25:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753323AbZEABZW
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Apr 2009 21:25:22 -0400
Received: from yw-out-2324.google.com ([74.125.46.31]:64253 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751054AbZEABZW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Apr 2009 21:25:22 -0400
Received: by yw-out-2324.google.com with SMTP id 5so1250327ywb.1
        for <git@vger.kernel.org>; Thu, 30 Apr 2009 18:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=4KgpImCi3I4ln+C9pRDrdJF7FX9Zz5wyXoSctW7c8aM=;
        b=p+SJDW1/eIVDZKcF1fxgchOhRxxRdZxrXPM5SYbN2ojwWE06qQPDSEoIYr76kBIGCi
         trkWHSnhNM5xYpwm1+ImGd8Zn0GtC0I6tMzd/LBf/av/AZEv8bxiFkBLslekOiS9nChT
         231nabPPA3kNRTili9GXVhETboFlsOFt7VFvo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=XjBPQBPkab4RZEnVgOYy+WYwnJMC9wrDwoDnla3ukoe3AwCKJ7xj/HCuZhowo6ys6s
         XfYD27GO4iRwkrYKWs9QnHg/qNX7wZS/dGvIw1LZgx3iKJf2dhhEhiWFh89oX996JBZw
         viuCaQ9TBnbf0Cd3ztTB7zcDPxy1SZfDWcJ9Y=
Received: by 10.151.134.5 with SMTP id l5mr4671786ybn.146.1241141121901; Thu, 
	30 Apr 2009 18:25:21 -0700 (PDT)
In-Reply-To: <f488382f0904301723i37ef03d9w4e93848e603ed28b@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118054>

On Thu, Apr 30, 2009, Steven Noonan <steven@uplinklabs.net> wrote:
> A bit off topic, but the results are rather interesting to me, and I
> think I see a weakness in how GCC is doing this on Intel. Someone
> please correct me if I'm wrong, but the PowerPC code seems much better
> because it can yield very high instruction-level parallelism. It does
> 5 loads and then 5 stores, using 4 registers for temporary storage and
> 2 registers for pointers.
>
> I realize the Intel x86 architecture is quite constrained in that it
> has so few general purpose registers, but there has to be better code
> than what GCC emitted above. It seems like the processor would stall
> because of the quantity of sequential inter-dependent instructions
> that can't be done in parallel (mov to memory that depends on a mov to
> eax, etc).

There aren't any unnecessary dependencies.  Take this sequence:

1:        movl    (%edx), %eax
2:        movl    %eax, (%ecx)
3:        movl    4(%edx), %eax
4:        movl    %eax, 4(%ecx)

There are two unavoidable dependencies - #2 depends on #1, and #4
depends on #3.  #3 does not depend on #2, even though they both
use %eax, because #3 is a write to %eax.  So whatever was in %eax
before #3 is irrelevant.  The processor knows this and will use
register renaming to execute #1 and #3 in parallel, and #2 and #4
in parallel.

James
