From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCHv2 2/2] receive-pack: Add receive.objectCountLimit to
 refuse push with too many objects
Date: Sat, 14 May 2011 15:17:24 -0700
Message-ID: <BANLkTimQD5JFeOeF48cbMjDL3+WMfsmPtA@mail.gmail.com>
References: <201105131854.31540.johan@herland.net> <201105140403.09981.johan@herland.net>
 <BANLkTik_taBK+=nh+0WEUjp3AV_fC7e_dg@mail.gmail.com> <201105141517.45324.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Sun May 15 00:17:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLN9i-00070A-DC
	for gcvg-git-2@lo.gmane.org; Sun, 15 May 2011 00:17:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755132Ab1ENWRp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 May 2011 18:17:45 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:41707 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754929Ab1ENWRp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 May 2011 18:17:45 -0400
Received: by vws1 with SMTP id 1so2483150vws.19
        for <git@vger.kernel.org>; Sat, 14 May 2011 15:17:44 -0700 (PDT)
Received: by 10.52.90.243 with SMTP id bz19mr1953594vdb.113.1305411464073;
 Sat, 14 May 2011 15:17:44 -0700 (PDT)
Received: by 10.52.157.73 with HTTP; Sat, 14 May 2011 15:17:24 -0700 (PDT)
In-Reply-To: <201105141517.45324.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173608>

On Sat, May 14, 2011 at 06:17, Johan Herland <johan@herland.net> wrote:
> I'm planning to add a new capability collection/namespace, called "li=
mit-*",
> where the server can communicate capabilities to the client, like so:
>
> =A0limit-object-count_100000
> =A0limit-commit-count_1000
> =A0limit-pack-size_500000000
>
> (I'd prefer to s/_/=3D/ or s/_/:/, but according to pack-protocol.txt=
, a
> capability may not contain "=3D" or ":")

I forget why =3D and : are forbidden here. I think its just because we
wanted the options to be "simple". I agree, I would prefer =3D here too=
,
and probably would have written the patch that way myself. There
shouldn't be a technical reason why =3D isn't allowed here. Its just
documented as being not a good idea because at one time someone wrote
that down.

> However, you say:
>
>> For older clients that don't know this new advertised capability, th=
ey
>> should fail hard and not transfer all of this data.
>
> AFAICS this is not the case. If a client does not understand a capabi=
lity,
> it simply ignores it, and carries on doing its usual thing.

By this I meant #2 below (the initial patch).

> IINM there are only two ways to prevent an older client from transfer=
ring
> all the data:
>
> 1. Change the pack protocol in an incompatible way, that causes older=
 client
> to abort with a pack format error prior to transmitting the pack.

This is not a good idea. We still want the client to be able to talk
to the server if it would be within the limits.

> 2. (as in initial patch) Abort receive-pack when the server detects a=
 limit
> violation, leaving the client with a broken pipe. I haven't read the =
pack
> protocol closely, but I wouldn't be surprised if this behavior is str=
ictly
> in violation of the protocol.

It is a violation of the protocol... sort of. Its allowed for the
server to up and die in the middle of a push. What happens if the
remote system loses power due to a grid failure while you are writing
to it? The remote system can't tell you "I'm going away now" first. It
just freezes and stops ACK'ing the TCP packets. Or if the remote
system gets overloaded and the Linux OOM killer kicks in... the remote
might get one of the processes elected for killing, and your TCP
connection breaks.

I don't think its as bad as it sounds. Its not a great user
experience, sure. And we maybe should also look at changing the
send-pack code to check the pipe for received data from the remote
peer if pack-objects dies (today it doesn't)... just in case the
reason pack-objects died is because an error message was written and
then the stream was closed.

--=20
Shawn.
