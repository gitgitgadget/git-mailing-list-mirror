From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH 3/3] fetch-pack: use smaller handshake window for initial request
Date: Sun, 20 Mar 2011 16:12:43 -0700
Message-ID: <AANLkTinpv-kvzoPiFrge95JKHSFAOWvcE11MAjVywwwq@mail.gmail.com>
References: <7vsjukrrmc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <junio@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 21 00:13:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1Ro6-00013p-Sh
	for gcvg-git-2@lo.gmane.org; Mon, 21 Mar 2011 00:13:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751632Ab1CTXNF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 Mar 2011 19:13:05 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:61983 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751385Ab1CTXNE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 Mar 2011 19:13:04 -0400
Received: by vws1 with SMTP id 1so4897864vws.19
        for <git@vger.kernel.org>; Sun, 20 Mar 2011 16:13:03 -0700 (PDT)
Received: by 10.52.165.134 with SMTP id yy6mr4613599vdb.312.1300662783196;
 Sun, 20 Mar 2011 16:13:03 -0700 (PDT)
Received: by 10.52.164.105 with HTTP; Sun, 20 Mar 2011 16:12:43 -0700 (PDT)
In-Reply-To: <7vsjukrrmc.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169533>

On Fri, Mar 18, 2011 at 15:27, Junio C Hamano <junio@pobox.com> wrote:
> Start the initial request small by halving the INITIAL_FLUSH (we will=
 try
> to stay one window ahead of the server, so we would end up giving twi=
ce as
> many "have" in flight at the very beginning). =A0We may want to tweak=
 these
> values even more, taking MTU into account.

Thanks Junio, this patch series looks good to me.

I keep thinking about trying to maximize to the MTU, but this is
difficult. If we only consider the anonymous git:// over TCP case,
clients start the conversation with their "want" list, which includes
the capability list after the first want line. Because the want list
isn't regular in size (clients request different branches based on
what the server has offered, and what it is behind on, and what the
user may have asked for on the command line) and the capability list
isn't either (clients request a lot of capabilities these days) sizing
the initial "have" list to round out to fill an MTU is difficult to do
with a static constant. The best way to size the initial transfer to
an MTU boundary is to keep a running counter of bytes written thus
far, write *at least* 16 (or whatever our INITIAL_FLUSH is), and then
write additional "have" lines until we cannot fit another one in the
current MTU.

=46or subsequent rounds, yes, we can statically size to an MTU, but
there isn't much benefit to doing a static size here if we have the
code to dynamically size the first batch based on the capability list
and the wants.

=46or smart HTTP however, sizing to an MTU is much more difficult. The
HTTP headers sent by libcurl are difficult to predict, and go in front
of the want list. And subsequent rounds include not just the HTTP
headers, but also the prior want list and any prior have lines that
received back ACK %s common from the remote peer. So we probably have
to use a dynamic size for the subsequent rounds too. To make things
more difficult, smart HTTP usually gzips the POST body before
transmission, which compresses the want/have list somewhat and makes
it even harder to predict where an MTU would be full.

Long story short, I'm not sure its worth trying to optimize to fill an
MTU. But if I'm right, doubling the size of the window on each round
will reduce the number of round-trips involved. Over git:// this might
not be very noticeable since the server is already sending you TCP ACK
messages, and the Git-level ACK/NAKs can be piggy-backed into the TCP
ACKs. But over http:// I think its a big win because the Git-level
ACK/NAKs cannot be used until the entire HTTP request has been
processed. It might not seem like a lot, but if your HTTP client is
behind 2 HTTP proxies (e.g. your local LAN proxy, and then the remote
server is actually a reverse proxy), the HTTP processing can really
start to dominate the round-trip time.

--=20
Shawn.
