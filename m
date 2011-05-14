From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCHv2 2/2] receive-pack: Add receive.objectCountLimit to
 refuse push with too many objects
Date: Sat, 14 May 2011 15:27:36 -0700
Message-ID: <BANLkTikGPhYYGF190XqWkyc=LuJ3PwA4Jg@mail.gmail.com>
References: <201105131854.31540.johan@herland.net> <7vpqnm7cim.fsf@alter.siamese.dyndns.org>
 <201105140343.48741.johan@herland.net> <201105140403.09981.johan@herland.net>
 <BANLkTik_taBK+=nh+0WEUjp3AV_fC7e_dg@mail.gmail.com> <7voc355fz9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 15 00:28:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLNJc-0002Sb-6C
	for gcvg-git-2@lo.gmane.org; Sun, 15 May 2011 00:28:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755351Ab1ENW15 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 May 2011 18:27:57 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:55590 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755297Ab1ENW15 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 May 2011 18:27:57 -0400
Received: by vws1 with SMTP id 1so2485121vws.19
        for <git@vger.kernel.org>; Sat, 14 May 2011 15:27:56 -0700 (PDT)
Received: by 10.52.181.98 with SMTP id dv2mr1965506vdc.33.1305412076088; Sat,
 14 May 2011 15:27:56 -0700 (PDT)
Received: by 10.52.157.73 with HTTP; Sat, 14 May 2011 15:27:36 -0700 (PDT)
In-Reply-To: <7voc355fz9.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173610>

On Sat, May 14, 2011 at 10:50, Junio C Hamano <gitster@pobox.com> wrote:
> Shawn Pearce <spearce@spearce.org> writes:
>
>> If we are going to put limits in, does it make sense to try and push
>> these limits back to pack-objects in a more detailed way? You talked
>> about depth of history, or size of pack. pack-objects could
>> approximate both.
>
> I think the receiving end switches between index-pack and unpack-objects
> based on the object count,

It does...

> but if we can add a protocol extension to carry
> these estimates from the sender, we would be much better off. A large push
> with a small number of objects would want to keep everything in a pack,
> for example, but currently there is no way to do so.

Yes, my thoughts exactly. A 600 MiB push of 3 objects (1 huge blob,
top level tree, commit) shouldn't be unpacked. Serving that huge blob
back out to clients that want to fetch it is more efficient when its
coming from a pack than from a loose object, due to the object reuse
that is available from a pack. Unfortunately we don't have the data
necessary to make that decision.

Probably the cleanest way to do this estimate transmission is to
modify the pack stream format. Introduce a new capability for
pack-stats. If advertised from receive-pack, send-pack can pass a
--pack-stats flag to pack-objects. That process then writes out a PACK
header with version code 4 (rather than 2), and includes additional
data beyond the object count in an extended PACK header. receive-pack
can then read the PACK header and handle version 2 as it does today,
and version 4 by also checking the additional stat fields and dumping
what is left over into either unpack-objects or index-pack like it
does now. We wouldn't even need to change index-pack or
unpack-objects, receive-pack could translate the PACK version 4 header
into a version 2 command line flag when it invokes the sub process to
handle the stream.

Hmm, or maybe this should be pack v5, just so nobody confuses it with
the mythical pack v4 we haven't implemented.

If we do add this stats header to the PACK stream, we need to be a bit
smarter about it. I would lay out the header with an additional 4 byte
field telling us the size of the stats block, and then use repeating
key-value pairs within the stats block to transmit the data. This way
clients can add additional stats to the stream and receive-pack can
ignore them if it doesn't understand them. We can start out with
number of commits and estimated size of the packed data (based on
summing up the reused object sizes) but could add more later like date
of oldest commit if we later decide it would help the remote handle
the pack stream, or reject it early.


As far as receive-pack rejecting the stream after seeing the header, I
would like to avoid an extra round-trip between the two peers. So we
probably need to modify send-pack like I suggest above to check the
stream for an error message after pack-objects terminates, even if
pack-objects terminates with a non-zero exit status. Even over a POSIX
pipe we should have room for 512 bytes of error data to be crammed
into the stream from receive-pack before we deadlock the two peers. If
we wanted to be really paranoid, we would run pack-objects in the
background and have send-pack constantly monitor the incoming half of
the pipe for a status result. Since pack-objects is already another
process this shouldn't be that difficult. (But it is harder for me in
JGit where its not a separate thread.)

-- 
Shawn.
