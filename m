From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Performance issue: initial git clone causes massive repack
Date: Mon, 6 Apr 2009 09:52:56 -0400
Message-ID: <9e4733910904060652t6c0f37d9t246b7394e3aad350@mail.gmail.com>
References: <20090404220743.GA869@curie-int>
	 <20090405T001239Z@curie.orbis-terrarum.net>
	 <20090405035453.GB12927@vidovic> <20090405070412.GB869@curie-int>
	 <20090405190213.GA12929@vidovic>
	 <alpine.DEB.1.10.0904051419490.6245@asgard.lang.hm>
	 <20090405225954.GA18730@vidovic>
	 <alpine.DEB.1.10.0904051613420.6245@asgard.lang.hm>
	 <alpine.LFD.2.00.0904052326090.6741@xanadu.home>
	 <7vab6ue520.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Pitre <nico@cam.org>, david@lang.hm,
	Nicolas Sebrecht <nicolas.s-dev@laposte.net>,
	"Robin H. Johnson" <robbat2@gentoo.org>,
	Git Mailing List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 06 15:55:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqpHa-0006dJ-Rr
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 15:54:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753863AbZDFNxH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Apr 2009 09:53:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753119AbZDFNxF
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Apr 2009 09:53:05 -0400
Received: from mail-qy0-f118.google.com ([209.85.221.118]:59140 "EHLO
	mail-qy0-f118.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752931AbZDFNxE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Apr 2009 09:53:04 -0400
Received: by qyk16 with SMTP id 16so3631730qyk.33
        for <git@vger.kernel.org>; Mon, 06 Apr 2009 06:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=S5ZD6aWWL1MfXMIxXVCupoNtm+iBoxHI0FRCJLFC+jg=;
        b=vil0KrkoSRmQTcNcCUlY7mr8TOxQYysOcRx7LpqsKOnptMXUyvarkXvV0sHvR3z2Rg
         oNeCEH8/CN4z4swuvsj1wTN6dDam6CmHXkCzRBCqloEHJcyLWkWTm+4UEEjObo1aR3B6
         wQOMSSjyGk6SDaj9El9IQlpRsoEac+eJrY4gM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=otPeIMaQyQ+oidiVve7DKwNvuFovCBBw3EX1avq/P+VoCsIt+uRQ5/n1DuNTaeZEo9
         XFyhFVTP6Lteqnkjwd/IV/wz/UsFdOTqJ8a2Z5j9JM4Dh6efYRSIufUza/b3pV/l5L1S
         UwpNlhwYFk63mupSWwr5SNlNAH0YsJYmZfpY0=
Received: by 10.220.99.6 with SMTP id s6mr3660444vcn.96.1239025977115; Mon, 06 
	Apr 2009 06:52:57 -0700 (PDT)
In-Reply-To: <7vab6ue520.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115831>

On Mon, Apr 6, 2009 at 1:15 AM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Nicolas Pitre <nico@cam.org> writes:
>
>> What git-pack-objects does in this case is not a full repack. =A0It
>> instead _reuse_ as much of the existing packs as possible, and only =
does
>> the heavy packing processing for loose objects and/or inter pack
>> boundaryes when gluing everything together for streaming over the ne=
t.
>> If for example you have a single pack because your repo is already f=
ully
>> packed, then the "packing operation" involved during a clone should
>> merely copy the existing pack over with no further attempt at delta
>> compression.
>
> One possibile scenario that you still need to spend memory and cycle =
is if
> the cloned repository was packed to an excessive depth to cause many =
of
> its objects to be in deltified form on insanely deep chains, while cl=
oning
> send-pack uses a depth that is more reasonable. =A0Then pack-objects =
invoked
> by send-pack is not allowed to reuse most of the objects and would en=
d up
> redoing the delta on them.

That seems broken. You went through all of the trouble to make the
pack file smaller to reduce transmission time, and then clone undoes
the work.

What about making a very simple special case for an initial clone?
=46irst thing an initial clone does is copy all of the pack files from
the server to the client without even looking at them. Some of these
packs will probably be marked 'keep' because they are old history and
have been densely packed. Once the packs are down, start over and do a
fetch taking these packs into account.

--=20
Jon Smirl
jonsmirl@gmail.com
