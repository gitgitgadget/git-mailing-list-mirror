From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [RFC] Add --create-cache to repack
Date: Fri, 28 Jan 2011 11:15:34 -0800
Message-ID: <AANLkTikPcp5CUTWfhy6FYbCEkNG6epGBAMNT5vTfSbvy@mail.gmail.com>
References: <1296201984-24426-1-git-send-email-spearce@spearce.org>
 <4D42878E.2020502@viscovery.net> <AANLkTim+AUY9SdeAFfkny2_a3qQ9SCDLUHR3s9Q3M98u@mail.gmail.com>
 <alpine.LFD.2.00.1101281304270.8580@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	John Hawley <warthog19@eaglescrag.net>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Fri Jan 28 20:16:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pitne-0003Iv-Rj
	for gcvg-git-2@lo.gmane.org; Fri, 28 Jan 2011 20:16:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754220Ab1A1TP5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 Jan 2011 14:15:57 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:48716 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753465Ab1A1TP5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Jan 2011 14:15:57 -0500
Received: by fxm20 with SMTP id 20so3690591fxm.19
        for <git@vger.kernel.org>; Fri, 28 Jan 2011 11:15:55 -0800 (PST)
Received: by 10.223.72.207 with SMTP id n15mr2735439faj.49.1296242155115; Fri,
 28 Jan 2011 11:15:55 -0800 (PST)
Received: by 10.223.70.205 with HTTP; Fri, 28 Jan 2011 11:15:34 -0800 (PST)
In-Reply-To: <alpine.LFD.2.00.1101281304270.8580@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165634>

On Fri, Jan 28, 2011 at 10:46, Nicolas Pitre <nico@fluxnic.net> wrote:
> On Fri, 28 Jan 2011, Shawn Pearce wrote:
>
>> This started because I was looking for a way to speed up clones comi=
ng
>> from a JGit server. =A0Cloning the linux-2.6 repository is painful,
=2E..
>> Later I realized, we can get rid of that cached list of objects and
>> just use the pack itself.
=2E..
> Playing my old record again... I know. =A0But pack v4 should solve a =
big
> part of this enumeration cost.

I've said the same thing for years myself.  As much as it would be
nice to fix some of the decompression costs with pack v2/v3, v2/v3 is
very common in the wild, and a new pack encoding is going to be a
fairly complex thing to get added to C Git.  And pack v4 doesn't
eliminate the enumeration, it just makes it faster.

> So that's the idea. =A0Keep the exact same functionality as we have n=
ow,
> without any need for cache management, but making the data structure =
in
> a form that should improve object enumeration by some magnitude.

That's what I also liked about my --create-cache flag.  Its keeping
the same data we already have, in the same format we already have it
in.  We're just making a more explicit statement that everything in
some pack is about as tightly compressed as it ever would be for a
client, and it isn't going to change anytime soon.  Thus we might as
well tag it with .keep to prevent repack of mucking with it, and we
can take advantage of this to serve the pack to clients very fast.

Over breakfast this morning I made the point to Junio that with the
cached pack and a slight network protocol change (enabled by a
capability of course) we could stop using pkt-line framing when
sending the cached pack part of the stream, and just send the pack
directly down the socket.  That changes the clone of a 400 MB project
like linux-2.6 from being a lot of user space stuff, to just being a
sendfile() call for the bulk of the content.  I think we can just hand
off the major streaming to the kernel.  (Part of the protocol change
is we would need to use multiple SHA-1 checksums in the stream, so we
don't have to re-checksum the existing cached pack.)


I love the idea of some of the concepts in pack v4.  I really do.  But
this sounds a lot simpler to implement, and it lets us completely
eliminate a massive amount of server processing (even under pack v4
you still have object enumeration), in exchange for what might be a
few extra MBs on the wire to the client due to slightly less good
deltas and the use of REF_DELTA in the thin pack used for the most
recent objects.  I don't envision this being used on projects smaller
than git.git itself, if you can gc --aggressive the whole thing in a
minute the cached pack is probably pointless.  But if you have 400+
MB, you want that to be network bound, and have almost no CPU impact
on the server.

Plus we can safely do byte range requests for resumable clone within
the cached pack part of the stream.  And when pack v4 comes along, we
can use this same strategy for an equally large pack v4 pack.

--=20
Shawn.
