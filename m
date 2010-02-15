From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH] don't use mmap() to hash files
Date: Mon, 15 Feb 2010 15:23:59 +0300
Message-ID: <37fcd2781002150423n36378105t9bee9c0e5106ca4c@mail.gmail.com>
References: <20100211234753.22574.48799.reportbug@gibbs.hungrycats.org>
	 <20100214011812.GA2175@dpotapov.dyndns.org>
	 <alpine.DEB.1.00.1002140249410.20986@pacific.mpi-cbg.de>
	 <20100214024259.GB9704@dpotapov.dyndns.org>
	 <alpine.DEB.1.00.1002141908150.20986@pacific.mpi-cbg.de>
	 <37fcd2781002141106v761ce6e0kc5c5bdd5001f72a9@mail.gmail.com>
	 <alpine.DEB.1.00.1002142021100.20986@pacific.mpi-cbg.de>
	 <alpine.DEB.1.00.1002142025160.20986@pacific.mpi-cbg.de>
	 <37fcd2781002141156n7e2b9673s1eb6c12869facdb2@mail.gmail.com>
	 <alpine.LFD.2.00.1002142328310.1946@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Zygo Blaxell <zblaxell@esightcorp.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Thomas Rast <trast@student.ethz.ch>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Mon Feb 15 13:24:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ngzzo-0007Ha-JA
	for gcvg-git-2@lo.gmane.org; Mon, 15 Feb 2010 13:24:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755437Ab0BOMYG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Feb 2010 07:24:06 -0500
Received: from mail-fx0-f215.google.com ([209.85.220.215]:60169 "EHLO
	mail-fx0-f215.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754860Ab0BOMYB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Feb 2010 07:24:01 -0500
Received: by fxm7 with SMTP id 7so5628948fxm.28
        for <git@vger.kernel.org>; Mon, 15 Feb 2010 04:24:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=UxXTmvm3hEX47+XFvCL+GQqGF8/BwqigZMgdxSre4mI=;
        b=rc6BqgYqjwg+KfMFo4evUDUjYWTwB4OXe3VwCGSsDGbcJ/O/JiG2SBtNqPQkn8LbTL
         3DywUMlSYsDA7oGcMwGV9xkhoGJyAfqp6FUtAR9JMRDlCNSuuX1mq3P85V+Ipdxd09d9
         YgRpeKLxHIyJ9y+Ori7GUSoey/IqEZ9J6/OJE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=snNVapVT/NToJJO4Z6B13RExywvDi8WVIMrUJ+YvIgmlr1e9HjLtltTPuMAwwA4Hn/
         o4qm5Vlm3R3dH1h2IbGxrfvBON28DWfqXlD2HYfDyXa/ZImsRusPWpBMeMn0jqmLG0dp
         v+/CZnpeG2tSlVd+k2QZm6o4lWr42IwnJ2D24=
Received: by 10.239.193.74 with SMTP id h10mr524151hbi.163.1266236639895; Mon, 
	15 Feb 2010 04:23:59 -0800 (PST)
In-Reply-To: <alpine.LFD.2.00.1002142328310.1946@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140005>

On Mon, Feb 15, 2010 at 8:05 AM, Nicolas Pitre <nico@fluxnic.net> wrote=
:
> On Sun, 14 Feb 2010, Dmitry Potapov wrote:
>
>> 1. to introduce a configuration parameter that will define whether t=
o use
>> mmap() to hash files or not. It is a trivial change, but the real qu=
estion
>> is what default value for this option (should we do some heuristic b=
ased
>> on filesize vs available memory?)
>
> I don't like such kind of heuristic. =A0They're almost always wrong, =
and
> any issue is damn hard to reproduce. I tend to believe that mmap() wo=
rks
> better by letting the OS paging in and out memory as needed while
> reading data into allocated memory is only going to force the system
> into swap.

Probably, you are right. Heuristic is a bad idea. Still, we may want to
add an option to disable mmap() during hash calculation if we preserve
mmap() here. Though, I don't like keeping mmap() there if we go for #2.=
=2E
See below...

>
>> 2. to stream files in chunks. It is better because it is faster, esp=
ecially on
>> large files, as you calculate SHA-1 and zip data while they are in C=
PU
>> cache. However, it may be more difficult to implement, because we ha=
ve
>> filters that should be apply to files that are put to the repository=
=2E
>
> So? =A0"More difficult" when it is the right thing to do is no excuse=
 not
> to do it and satisfy ourselves with an half solution. =A0Barely repla=
cing
> mmap() with read() has drawbacks while the advantages aren't that man=
y.
> Gaining a few speed percentage while making it less robust when memor=
y
> is tight isn't such a great compromize to me. =A0BUT if you were to
> replace mmap() with read() and make the process chunked then you do
> improve both speed _and_ memory usage.

I have not had time to look closely at this, but there is one problem
that I noticed -- the header of any git object contains the blob length=
=2E
We know this length in advance (without reading all data) only for
regular files and only if they do not have any filter to be applied.
In all other cases, it seems we cannot do much better than we do now,
assuming that we do not want to change the storage format...

If so, the question remains what to do about regular files with some
filter. Currently, we use mmap() for the original data but store the
processed data in memory anyway. The question is whether want to keep
this use of mmap() here? Considering that it is a potential source of a
repository corruption and these filters should not be used for big file=
s
because they take a lot of memory anyway, I think we should get rid of
mmap() in hashing file completely, once we can process regular files
without filters in chunks.


Dmitry
