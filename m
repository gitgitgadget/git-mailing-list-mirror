From: Shawn Pearce <spearce@spearce.org>
Subject: Re: New Feature wanted: Is it possible to let git clone continue last
 break point?
Date: Fri, 4 Nov 2011 07:22:20 -0700
Message-ID: <CAJo=hJtsiEEHA33CQn1MCvb7vFv7uEF+U292YgBa7EWv7P8Jng@mail.gmail.com>
References: <CAEZo+gfKVY-YgMjd=bEYzRV4-460kqDik-yVcQ9Xs=DoCZOMDg@mail.gmail.com>
 <CAEZo+gcj5q2UYnak1+1UG7pPzoeaUr=QLsiCiNXbC_n+JQbKQQ@mail.gmail.com>
 <20111031090717.GA24978@elie.hsd1.il.comcast.net> <20111102220614.GB14108@sigill.intra.peff.net>
 <7vwrbigna7.fsf@alter.siamese.dyndns.org> <20111102232735.GA17466@sigill.intra.peff.net>
 <CAJo=hJtt8vjB5oU+tEabN2AS7c-24bMHNwQSoWtZYtjjrR3d7Q@mail.gmail.com>
 <20111103024248.GA9492@sigill.intra.peff.net> <CAJo=hJt2kU10r5rq23qgimtW8dmzu-N92vjO_hNBbVVsKSpDmg@mail.gmail.com>
 <20111104085633.GA13924@ecki> <4EB3B1E7.7080507@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Clemens Buchacher <drizzd@aon.at>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	netroby <hufeng1987@gmail.com>,
	Git Mail List <git@vger.kernel.org>,
	Tomas Carnecky <tom@dbservice.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Nov 04 15:22:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RMKfV-0006e6-5L
	for gcvg-git-2@lo.gmane.org; Fri, 04 Nov 2011 15:22:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932618Ab1KDOWo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Nov 2011 10:22:44 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:47145 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932551Ab1KDOWm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Nov 2011 10:22:42 -0400
Received: by gyc15 with SMTP id 15so1462937gyc.19
        for <git@vger.kernel.org>; Fri, 04 Nov 2011 07:22:42 -0700 (PDT)
Received: by 10.236.77.104 with SMTP id c68mr20533588yhe.69.1320416562138;
 Fri, 04 Nov 2011 07:22:42 -0700 (PDT)
Received: by 10.147.167.9 with HTTP; Fri, 4 Nov 2011 07:22:20 -0700 (PDT)
In-Reply-To: <4EB3B1E7.7080507@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184773>

On Fri, Nov 4, 2011 at 02:35, Johannes Sixt <j.sixt@viscovery.net> wrot=
e:
> Am 11/4/2011 9:56, schrieb Clemens Buchacher:
>> Cache ... not the pack but the information
>> =A0 =A0to re-create it...
>
> It has been discussed. It doesn't work. Because with threaded pack
> generation, the resulting pack is not deterministic.

The information to create a pack for a repository with 2M objects
(e.g. Linux kernel tree) is *at least* 152M of data. This is just a
first order approximation of what it takes to write out the 2M SHA-1s,
along with say a 4 byte length so you can find given an offset
provided by the client roughly where to resumse in the object stream.
This is like 25% of the pack size itself. Ouch.

This data is still insufficient to resume from. A correct solution
would allow you to resume in the middle of an object, which means we
also need to store some sort of indicator of which representation was
chosen from an existing pack file for object reuse. Which adds more
data to the stream. And then there is the not so simple problem of how
to resume in the middle of an object that was being recompressed on
the fly, such as a large loose object.

By the time you get done with all of that, your "ticket" might as well
be the name of a pack file. And your "resume information" is just a
pack file itself. Which would be very expensive to recreate.
