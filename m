From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] Fix potential local deadlock during fetch-pack
Date: Tue, 29 Mar 2011 10:22:58 -0700
Message-ID: <AANLkTikZ=POeQi5nnt8D9v4Z-_OaXNrXDjP2awWUtKzA@mail.gmail.com>
References: <7vtyelsvp0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 29 19:23:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4cdb-0000b0-1A
	for gcvg-git-2@lo.gmane.org; Tue, 29 Mar 2011 19:23:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752204Ab1C2RXW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Mar 2011 13:23:22 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:45067 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750991Ab1C2RXV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Mar 2011 13:23:21 -0400
Received: by qyk7 with SMTP id 7so2137722qyk.19
        for <git@vger.kernel.org>; Tue, 29 Mar 2011 10:23:21 -0700 (PDT)
Received: by 10.52.88.12 with SMTP id bc12mr24238vdb.243.1301419400757; Tue,
 29 Mar 2011 10:23:20 -0700 (PDT)
Received: by 10.52.166.133 with HTTP; Tue, 29 Mar 2011 10:22:58 -0700 (PDT)
In-Reply-To: <7vtyelsvp0.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170283>

On Tue, Mar 29, 2011 at 10:06, Junio C Hamano <gitster@pobox.com> wrote=
:
> The fetch-pack/upload-pack protocol relies on the underlying transpor=
t
> (local pipe or TCP socket) to have enough slack to allow one window w=
orth
> of data in flight without blocking the writer. =A0Traditionally we al=
ways
> relied on being able to have a batch of 32 "have"s in flight (roughly=
 1.5k

Its 64. Because the client "races ahead" one window before ever
reading. Which is closer to 3K of data in flight.

> The recent "progressive-stride" change allows "fetch-pack" to send up=
 to
> 1024 "have"s without reading any response from "upload-pack". =A0The
> outgoing pipe of "upload-pack" can be clogged with many ACK and NAK t=
hat
> are unread, while "fetch-pack" is still stuffing its outgoing pike wi=
th

s/pike/pipe/

> @@ -229,16 +229,17 @@ static void insert_alternate_refs(void)
> =A0}
>
> =A0#define INITIAL_FLUSH 16
> +#define PIPESAFE_FLUSH 32
> =A0#define LARGE_FLUSH 1024
>
> =A0static int next_flush(int count)
> =A0{
> - =A0 =A0 =A0 if (count < INITIAL_FLUSH * 2)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 count +=3D INITIAL_FLUSH;
> - =A0 =A0 =A0 else if (count < LARGE_FLUSH)
> + =A0 =A0 =A0 int flush_limit =3D args.stateless_rpc ? LARGE_FLUSH : =
PIPESAFE_FLUSH;
> +
> + =A0 =A0 =A0 if (count < flush_limit)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0count <<=3D 1;
> =A0 =A0 =A0 =A0else
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 count +=3D LARGE_FLUSH;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 count +=3D flush_limit;

Nak. You still deadlock because when count reaches PIPESAFE_FLUSH you
still double it to 2*PIPESAFE_FLUSH here. Instead I think you mean:

  if (args.stateless_rpc) {
    if (count < LARGE_FLUSH)
      count <<=3D 1;
    else
      count +=3D LARGE_FLUSH;
  } else {
    if (count * 2 < PIPESAFE_FLUSH)
      count <<=3D 1;
  }

--=20
Shawn.
