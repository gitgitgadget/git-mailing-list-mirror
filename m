From: Junio C Hamano <gitster@pobox.com>
Subject: Re: On pathnames
Date: Thu, 24 Jan 2008 20:12:36 -0800
Message-ID: <7vy7ae7dcb.fsf@gitster.siamese.dyndns.org>
References: <34103945-2078-4983-B409-2D01EF071A8B@sb.org>
	<alpine.LFD.1.00.0801211846010.2957@woody.linux-foundation.org>
	<E3E4F5B3-1740-47E4-A432-C881830E2037@sb.org>
	<20080122133427.GB17804@mit.edu> <20080123000841.GA22704@mit.edu>
	<alpine.LFD.1.00.0801221625510.1741@woody.linux-foundation.org>
	<20080123013325.GB1320@mit.edu> <20080123064139.GC16297@glandium.org>
	<4697E0BA-7243-4C35-A384-0BD261EC21AF@sb.org>
	<20080123094052.GB6969@glandium.org> <20080123133802.GC7415@mit.edu>
	<alpine.LFD.1.00.0801230808440.1741@woody.linux-foundation.org>
	<98F90EB6-1930-4643-8C6C-CA11CB123BAA@sb.org>
	<alpine.LFD.1.00.0801230930390.1741@woody.linux-foundation.org>
	<7vprvr7x8h.fsf@gitster.siamese.dyndns.org>
	<alpine.LFD.1.00.0801241722130.22568@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Kevin Ballard <kevin@sb.org>, Theodore Tso <tytso@MIT.EDU>,
	Mike Hommey <mh@glandium.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Fri Jan 25 05:13:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JIFwd-0002HZ-HI
	for gcvg-git-2@gmane.org; Fri, 25 Jan 2008 05:13:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752897AbYAYENE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Jan 2008 23:13:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752868AbYAYEND
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jan 2008 23:13:03 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:45685 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752713AbYAYENA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Jan 2008 23:13:00 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 177676F90;
	Thu, 24 Jan 2008 23:12:59 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 146CB6F8A;
	Thu, 24 Jan 2008 23:12:48 -0500 (EST)
In-Reply-To: <alpine.LFD.1.00.0801241722130.22568@xanadu.home> (Nicolas
	Pitre's message of "Thu, 24 Jan 2008 17:31:27 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71678>

Nicolas Pitre <nico@cam.org> writes:

> On Thu, 24 Jan 2008, Junio C Hamano wrote:
>
>> If it is a new file, we won't find any name that is equivalent
>> to $A in the index, and we use the name $A obtained from
>> readdir(3).
>>=20
>> BUT with a twist.
>>=20
>> If the filesystem is known to be inconveniently case folding, we
>> are better off registering $B instead of $A (assuming we can
>> convert from $A to $B).
>
> Why?
>
> If you have no other representation for the file name than $A already=
,=20
> then I don't see why Git would have to play similar evil games and=20
> corru^H^H^Hnvert $A into $B.  Just store $A in the index and tree=20
> objects and be done with it.

Because this "conversion" is limited to the case where the
filesystem is known to be inconveniently case folding, I
personally do not care about this part of the outline that
deeply.  It would not bite _me_ or my friends either way.

But I would imagine that a person who has to work on HFS+ would
appreciate it if these two sequences behaved the same way:

    $ edit M=C3=A4rchen ;# assume this is a new file
    $ git add M=C3=A4rchen ;# we were told that IM gives $B (aka NFC)

vs

    $ edit M=C3=A4rchen ;# assume this is a new file
    $ git add M*en ;# now readdir(3) gives $A (aka NFD)

If we always convert $A (less interoperable form) to $B (more
interoperable form) on inconveniently case folding filesystems,
the new index entry will always be in form $B.  Without the
conversion, the former will give form $B while the latter will
give form $A.  It is, as you said, "similar evil game to
corrupt", but it is not even a corruption at that point, because
the inconveniently case folding filesystem already corrupted the
pathname before we get our hands on it, and it won't make a
difference for HFS+ only people anyway.

However, if the resulting tree that adds a new file is prepared
on an inconveniently case folding filesystem, the conversion
process, by definition, would make the resulting tree more
interoperable with other systems than without.

So I do not see any downside of doing the conversion on such a
filesystem but there is this "interoperability" upside.
