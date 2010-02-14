From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH] don't use mmap() to hash files
Date: Sun, 14 Feb 2010 22:56:46 +0300
Message-ID: <37fcd2781002141156n7e2b9673s1eb6c12869facdb2@mail.gmail.com>
References: <20100211234753.22574.48799.reportbug@gibbs.hungrycats.org>
	 <37fcd2781002131409r4166e496h9d12d961a2330914@mail.gmail.com>
	 <20100213223733.GP24809@gibbs.hungrycats.org>
	 <20100214011812.GA2175@dpotapov.dyndns.org>
	 <alpine.DEB.1.00.1002140249410.20986@pacific.mpi-cbg.de>
	 <20100214024259.GB9704@dpotapov.dyndns.org>
	 <alpine.DEB.1.00.1002141908150.20986@pacific.mpi-cbg.de>
	 <37fcd2781002141106v761ce6e0kc5c5bdd5001f72a9@mail.gmail.com>
	 <alpine.DEB.1.00.1002142021100.20986@pacific.mpi-cbg.de>
	 <alpine.DEB.1.00.1002142025160.20986@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Zygo Blaxell <zblaxell@esightcorp.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Thomas Rast <trast@student.ethz.ch>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Feb 14 20:56:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgkaM-0004Vu-Bd
	for gcvg-git-2@lo.gmane.org; Sun, 14 Feb 2010 20:56:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753190Ab0BNT4u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Feb 2010 14:56:50 -0500
Received: from mail-fx0-f227.google.com ([209.85.220.227]:45467 "EHLO
	mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753169Ab0BNT4s (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Feb 2010 14:56:48 -0500
Received: by fxm27 with SMTP id 27so520934fxm.25
        for <git@vger.kernel.org>; Sun, 14 Feb 2010 11:56:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=cBUZrFF2i51RiCDc5iT0tajUoTKtO3emaIQgsLVO7ZU=;
        b=Jn86PzfcYphiETFBEMCaMisaF2N+ceHuYczJ+yYxBo4CRv2Z0nVh4dAq4jwmeCtkKu
         ScEVsgfA8gzNvTzSUQcqhNLHL8X8HmlsgAP4ppgvFEwhnyzfwySkgFdAXjbfNxtofZwn
         hm/ut0VJePkREDOE+lIZ1Vr8XXx9rg8uLD3Qo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=IL6qiHYZ6puZZG4sPN4bVOpe3366XksqrZ5ZqrJIFdpMPvyYfQG/k1nRrlsva2Z54G
         2ipRkIyJKTgu6MBiMUlgabRbJx/3pI1asE/f9wdh5g8KG6Hw0aPZVhpHvKlWpRmu2prI
         iI7X/nrHgncG2H2lS8cUssk1lBxUh4uwiQLPw=
Received: by 10.239.184.80 with SMTP id x16mr454482hbg.198.1266177406718; Sun, 
	14 Feb 2010 11:56:46 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.1002142025160.20986@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139935>

On Sun, Feb 14, 2010 at 10:28 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>>
>> Concrete example: in one of my repositories, the average file size is
>> well over 2 gigabytes.
>
> Just to make extremely sure that you undertand the issue: adding these
> files on a computer with 512 megabyte RAM works at the moment. Can you
> guarantee that there is no regression in that respect _with_ your patch?

It may not work without enough swap space, and it will not pretty anyway
due to swapping. So, I see the following options:

1. to introduce a configuration parameter that will define whether to use
mmap() to hash files or not. It is a trivial change, but the real question
is what default value for this option (should we do some heuristic based
on filesize vs available memory?)

2. to stream files in chunks. It is better because it is faster, especially on
large files, as you calculate SHA-1 and zip data while they are in CPU
cache. However, it may be more difficult to implement, because we have
filters that should be apply to files that are put to the repository.

3. to improve Git to support huge files on computers with low memory.

I think #3 is a noble goal, but I do not have time for that. I can try to take
on #2, but it may take more time than I have now. As to #1, I am ready to
send the patch if we agree that is the right way to go...

I am open to any your suggestion. Maybe there are some options here..


Dmitry
