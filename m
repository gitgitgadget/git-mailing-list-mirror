From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Teach "git add" and friends to be paranoid
Date: Thu, 18 Feb 2010 19:04:56 -0600
Message-ID: <20100219010456.GA1789@progeny.tock>
References: <20100211234753.22574.48799.reportbug@gibbs.hungrycats.org>
 <20100214011812.GA2175@dpotapov.dyndns.org>
 <7vljer1gyg.fsf_-_@alter.siamese.dyndns.org>
 <201002181114.19984.trast@student.ethz.ch>
 <7vtytee7ff.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1002181456230.1946@xanadu.home>
 <7v635ub8oa.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1002181604310.1946@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Zygo Blaxell <zblaxell@esightcorp.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Fri Feb 19 02:04:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NiHIf-0005XV-4u
	for gcvg-git-2@lo.gmane.org; Fri, 19 Feb 2010 02:04:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752624Ab0BSBEx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Feb 2010 20:04:53 -0500
Received: from mail-yx0-f200.google.com ([209.85.210.200]:48308 "EHLO
	mail-yx0-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752513Ab0BSBEw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2010 20:04:52 -0500
Received: by yxe38 with SMTP id 38so7020682yxe.4
        for <git@vger.kernel.org>; Thu, 18 Feb 2010 17:04:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=vD/pnVo0u5NuX56QGRV1UUW7Ns/VqNs5KcrULmYdByo=;
        b=v156ceAnDfx0PbmfkFd+NW5tPzH8BZA8AyxB710/It87pYOjprTDyQbu2XTEGArKHT
         iY8xL6wo2OR2qLreJWgjwbV0lWdCSy241smzSmjGpdZLdnsvcM+vSSILpTm7QG8oBmzw
         Fo+wiSL/G3bEetvzFdwJPo903hzx4bwTbngvg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=SMxRqW9LbyC2PxEk2MOHSPBvuB+py/byOmOyUYftn5lmaOoD9pvFWQudUeRPQQ6p8K
         w1goE6Sldtkk7NgHgqKCtjeXbrhwRAXD2Iv9ulkXVgI3v/ZUmu+nep1TgVbt+lQAfESK
         HkjvyTbRndjSPMV8F9AgZU+cwz5bcEuUN6+h0=
Received: by 10.150.127.38 with SMTP id z38mr626945ybc.22.1266541491270;
        Thu, 18 Feb 2010 17:04:51 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 6sm647019ywd.41.2010.02.18.17.04.49
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 18 Feb 2010 17:04:50 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1002181604310.1946@xanadu.home>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140400>

Nicolas Pitre wrote:
> On Thu, 18 Feb 2010, Junio C Hamano wrote:

>> I suspect that opening to mmap(2), hashing once to compute the objec=
t
>> name, and deflating it to write it out, will all happen within the s=
ame
>> second, unless you are talking about a really huge file, or you star=
ted at
>> very near a second boundary.
>
> How is the index dealing with this?  Surely if a file is added to the=
=20
> index and modified within the same second then 'git status' will fail=
 to=20
> notice the changes.  I'm not familiar enough with that part of Git.

See Documentation/technical/racy-git.txt and t/t0010-racy-git.sh.

Short version: in the awful case, the timestamp of the index is the
same as (or before) the timestamp of the file.  Git will notice this
and re-hash the tracked file.

> Alternatively, you could use the initial mtime sample to determine th=
e=20
> filesystem's time granularity by noticing how many LSBs are zero.

Yuck.

If such detection is going to happen, I would prefer to see it used
once to determine the initial value of a per-repository configuration
variable asking to speed up =E2=80=98git add=E2=80=99 and friends.

Note that we are currently not using the nsec timestamps to make any
important decisions, probably because in some filesystems they are
unreliable when inode cache entries are evicted (not sure about the
current status; does this work in NFS, for example?).  Within the
short runtime of =E2=80=98git add=E2=80=99, I guess this would not be a=
s much of a
problem.

Jonathan
