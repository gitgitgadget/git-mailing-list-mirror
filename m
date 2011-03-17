From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH 1/2] fetch-pack: Finish negotation if remote replies "ACK
 %s ready"
Date: Thu, 17 Mar 2011 08:51:29 -0700
Message-ID: <AANLkTinKudDokLkZQhcMbzXuO8UeY9r74V_dqgyyV2YA@mail.gmail.com>
References: <1300146519-26508-1-git-send-email-spearce@spearce.org> <20110317071512.GF11931@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 17 16:52:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0FUc-0001Yv-I1
	for gcvg-git-2@lo.gmane.org; Thu, 17 Mar 2011 16:52:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754750Ab1CQPvv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Mar 2011 11:51:51 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:47357 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754734Ab1CQPvu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Mar 2011 11:51:50 -0400
Received: by qyg14 with SMTP id 14so2603911qyg.19
        for <git@vger.kernel.org>; Thu, 17 Mar 2011 08:51:49 -0700 (PDT)
Received: by 10.229.62.170 with SMTP id x42mr1156323qch.271.1300377109113;
 Thu, 17 Mar 2011 08:51:49 -0700 (PDT)
Received: by 10.229.77.205 with HTTP; Thu, 17 Mar 2011 08:51:29 -0700 (PDT)
In-Reply-To: <20110317071512.GF11931@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169248>

On Thu, Mar 17, 2011 at 00:15, Jeff King <peff@peff.net> wrote:
>> Over smart HTTP, the client must do an additional 10 HTTP POST
>> requests, each of which incurs round-trip latency, and must upload
>> the entire state vector of all known common objects. =A0On the final
>> POST request, this is 16 KiB worth of data.
>
> This optimization aside, I wonder if it is worth bumping up the numbe=
r
> of haves we send in a chunk from 32 to something higher.

I have been considering that myself. 32 isn't a good number here. Its
1604 bytes per round (32 have lines, and flush-pkt). Ethernet's
default MTU is 1500 bytes, so stopping at 32 causes us to need more
than one packet, and the last one isn't full. In native git:// or
ssh:// where its bi-directional the client does "race ahead" and send
another 1604 bytes, but now we're at 3208 bytes which still doesn't
fit well within the MTU. :-\

I've thought about increasing this to 64. On git:// or ssh:// that can
be wasteful as the remote should be able to stop us earlier,
especially if we are common very early (e.g. infrequent contributor
who is only 1 commit ahead). The same is true for smart HTTP, boosting
it to 64 would help the maintainer pull from a lieutenant with fewer
rounds, but it hurts the infrequent contributor as his only round is
larger for no good reason.

The better approach might be to automatically double the round size on
each successive round, until we reach an upper limit of say 1024. For
the infrequent contributor we might even consider cutting the initial
round to 16, as it would allow the entire initial round to fit into a
single Ethernet MTU over git://, and with the no-done capability, the
entire exchange is over in that single packet. :-)

=46or the maintainer, 16 is way too small, but they will then try 32,
64, 128, 256, 512... and should pick up the common point quickly.
Assuming the maintainer is already 600 commits ahead when he pulls,
we'll find the common point in 6 rounds, vs. the current approach that
requires 19 rounds.


But we should really cap the size at something sane like 1024 to
prevent HTTP POST payloads from being more than 64 KiB. But
practically this is <32 KiB because we gzip the POST body, and there
only content is hex digits and the word "have". It should be deflating
to smaller than 50% of the original size. For various selfish reasons
I wish I could keep this under 8192 bytes for the entire HTTP headers
and POST body, but this is under 64 "have" lines, and that's useless.

I'll try putting together this exponential round size patch today, I
have a few other git things to do today.

--=20
Shawn.
