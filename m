From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH] don't use mmap() to hash files
Date: Sun, 14 Feb 2010 22:06:39 +0300
Message-ID: <37fcd2781002141106v761ce6e0kc5c5bdd5001f72a9@mail.gmail.com>
References: <20100211234753.22574.48799.reportbug@gibbs.hungrycats.org>
	 <20100213133951.GA14352@Knoppix>
	 <201002131539.54142.trast@student.ethz.ch>
	 <20100213162924.GA14623@Knoppix>
	 <37fcd2781002131409r4166e496h9d12d961a2330914@mail.gmail.com>
	 <20100213223733.GP24809@gibbs.hungrycats.org>
	 <20100214011812.GA2175@dpotapov.dyndns.org>
	 <alpine.DEB.1.00.1002140249410.20986@pacific.mpi-cbg.de>
	 <20100214024259.GB9704@dpotapov.dyndns.org>
	 <alpine.DEB.1.00.1002141908150.20986@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Zygo Blaxell <zblaxell@esightcorp.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Thomas Rast <trast@student.ethz.ch>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Feb 14 20:06:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ngjnw-0007oo-F1
	for gcvg-git-2@lo.gmane.org; Sun, 14 Feb 2010 20:06:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752813Ab0BNTGm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Feb 2010 14:06:42 -0500
Received: from mail-fx0-f227.google.com ([209.85.220.227]:55404 "EHLO
	mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752413Ab0BNTGl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Feb 2010 14:06:41 -0500
Received: by mail-fx0-f227.google.com with SMTP id 27so485990fxm.25
        for <git@vger.kernel.org>; Sun, 14 Feb 2010 11:06:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=ouUgVSlqpwiumw/UGU1vpMLRraNxL+QbBPQkCWf8q3s=;
        b=PuG81qDeXKYw5iHlIv/vMbXSj+LgM1WzI/Y48S5c3CDQboohvO69vhje8UPjXh2Vtl
         mtCmpiiq6vQGWwxHVe+iAsq4IfJT/Kj7Bw19AXxFLaDJxkwoI4hAm373kbWgxPtn2lgE
         +cDI/RbXx1XeT5f99Qka92T8LBVpUmN6bYShc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=gBWlCYLhFLlufjeAO+zmE0I30zHgkisWLUgO1Dh/FSQouKSPUGl7Zr2WavZ036hc8v
         rBDsjGRhfrEQcEzW1MY4CTLjTFYCkCrg+dQK63YJ0znu4XLEhcaSODvJ+AUKzetqvrWR
         eAguo98ShgOOpImH6tOUHKZ8+KLhoS6DuUzJs=
Received: by 10.239.187.195 with SMTP id m3mr397163hbh.130.1266174399778; Sun, 
	14 Feb 2010 11:06:39 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.1002141908150.20986@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139930>

On Sun, Feb 14, 2010 at 9:10 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> On Sun, 14 Feb 2010, Dmitry Potapov wrote:
>
>> On Sun, Feb 14, 2010 at 02:53:58AM +0100, Johannes Schindelin wrote:
>> > On Sun, 14 Feb 2010, Dmitry Potapov wrote:
>> >
>> > > + if (strbuf_read(&sbuf, fd, 4096) >= 0)
>> >
>> > How certain are you at this point that all of fd's contents fit into
>> > your memory?
>>
>> You can't be sure... In fact, we know mmap() also may fail for huge
>> files, so can strbuf_read().
>
> That's comparing oranges to apples. In one case, the address space runs
> out, in the other the available memory. The latter is much more likely.

"much more likely" is not a very qualitative characteristic... I would
prefer to see numbers. My gut feeling is that it is not a problem in
real use cases where Git is used as VCS and not storage for huge media
files.  In fact, we do not use mmap() on Windows or MacOS at all, and
I have not heard that users of those platforms suffered much more from
inability to store huge files than those who use Linux.  I do not want
to say that there is no difference, but it may not as large as you try
to portray. In any case, my patch was to let people to test it and to
see what impact it has and come up with some numbers.

BTW, probably, it is not difficult to stream a large file in chunks (and
it may be even much faster, because we work on CPU cache), but I suspect
it will not resolve all issues with huge files, because eventually we
need to store them in a pack file. So we need to develop some strategy
how to deal with them.

One way to deal with them is to stream directly into a separate pack.
Still, it does not resolve all problems, because each pack file should
be mapped into a memory, and this may be a problem for 32-bit system
(or even 64-bit systems where a sysadmin set limit on amount virtual
memory available a single program).

The other way to handle huge files is to split them into chunks.
http://article.gmane.org/gmane.comp.version-control.git/120112

Maybe there are other approaches. I heard some people tried to do
something about it, but i have never interested in big files to look
at this issue closely.

>
>> > And even if you could be certain, a hint is missing that
>> > strbuf_read(), its name notwithstanding, does not read NUL-terminated
>> > strings. Oh, and the size is just a hint for the initial size, and it
>> > reads until EOF. That has to be said in the commit message.
>>
>> I did not add _any_ new code, including the above line. It was there
>> before my patch.
>
> But that explanation does not answer my question, does it?

I believe it did, or I did not understand your question.

Dmitry
