From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCHv2 2/2] receive-pack: Add receive.objectCountLimit to
 refuse push with too many objects
Date: Fri, 13 May 2011 19:30:30 -0700
Message-ID: <BANLkTik_taBK+=nh+0WEUjp3AV_fC7e_dg@mail.gmail.com>
References: <201105131854.31540.johan@herland.net> <7vpqnm7cim.fsf@alter.siamese.dyndns.org>
 <201105140343.48741.johan@herland.net> <201105140403.09981.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Sat May 14 04:40:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QL4m1-0006QD-J0
	for gcvg-git-2@lo.gmane.org; Sat, 14 May 2011 04:40:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757253Ab1ENCav convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 May 2011 22:30:51 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:40117 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756066Ab1ENCav convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 May 2011 22:30:51 -0400
Received: by vws1 with SMTP id 1so2211685vws.19
        for <git@vger.kernel.org>; Fri, 13 May 2011 19:30:50 -0700 (PDT)
Received: by 10.52.180.8 with SMTP id dk8mr2952405vdc.73.1305340250095; Fri,
 13 May 2011 19:30:50 -0700 (PDT)
Received: by 10.52.157.73 with HTTP; Fri, 13 May 2011 19:30:30 -0700 (PDT)
In-Reply-To: <201105140403.09981.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173572>

On Fri, May 13, 2011 at 19:03, Johan Herland <johan@herland.net> wrote:
> The new receive.objectCountLimit config variable defines an upper lim=
it
> on the number of objects to accept in a single push. If the number of
> objects in a push exceeds this limit, the entire push is discarded
> without storing the pushed objects on the server at all.
=2E..
> + =A0 =A0 =A0 =A0 =A0 ntohl(hdr.hdr_entries) > receive_object_count_l=
imit) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 char buf[1024];
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (xread(0, buf, 1024) > 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ; /* nothing */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return "received pack exceeds configure=
d receive.objectCountLimit";

Discarding in core is painful. We are still consuming bandwidth to
toss away the data.

I wonder... should we instead export the objectCountLimit as part of
the advertisement to the client, and teach send-pack to look at this
and pass it down to pack-objects? If pack-objects winds up with more
than this limit, it aborts and the client doesn't even transmit data.
Newer clients would abort cleanly with a nice error.

I don't see it as a problem to advertise to a client "This server will
only accept X objects from you, sending X + 1 is an error and will be
rejected." If we are worried about an evil client using this
advertisement to try and DoS a server... he can easily do that with a
single giant blob. Or a very long delta chain of a single blob and
many, many tiny deltas applied onto it. Knowing what the remote's
objectCountLimit is doesn't increase the risk of a DoS attack.

=46or older clients that don't know this new advertised capability, the=
y
should fail hard and not transfer all of this data. In my experience
when a user gets these strange errors from his Git client, he contacts
his server administrator with the screen output. At which point the
administrator can see the Counting objects line, check the repository
configuration, and tell the user what the problem is... and encourage
them to upgrade their client to a newer version.

If we are going to put limits in, does it make sense to try and push
these limits back to pack-objects in a more detailed way? You talked
about depth of history, or size of pack. pack-objects could
approximate both. If its depth of history, it might even be able to
cut off before it enumerates too many commits. :-)

The remote side obviously cannot abort early with number of commits or
pack size limits, but if those were soft limits suggested to a client,
while the object count was a hard limit, you might get a better
approximation for what you want. A server administrator might
configure a soft limit of 10 commits, but a hard limit of 5,000
objects. For most users, a bad push would abort very early on the soft
limit of 10 commits if they did an incorrect rebase. Meanwhile a user
who made 1 commit but changed every GPL header in the linux-2.6
repository (26,000+ files) would also be stopped for exceeding the
(hard) 5000 object limit.

--=20
Shawn.
