From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH 2/2] push -s: skeleton
Date: Wed, 7 Sep 2011 14:18:52 -0700
Message-ID: <CAJo=hJtz6fa4XfC-4ghryP_nfg3sbcrE2bKauj+F7w2Z_8Ckvw@mail.gmail.com>
References: <7vfwk82hrt.fsf@alter.siamese.dyndns.org> <7vbouw2hqg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 07 23:19:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1PWr-0005Ps-NU
	for gcvg-git-2@lo.gmane.org; Wed, 07 Sep 2011 23:19:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757058Ab1IGVTQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Sep 2011 17:19:16 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:52389 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757053Ab1IGVTN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Sep 2011 17:19:13 -0400
Received: by gxk21 with SMTP id 21so301042gxk.5
        for <git@vger.kernel.org>; Wed, 07 Sep 2011 14:19:12 -0700 (PDT)
Received: by 10.42.174.7 with SMTP id t7mr1049721icz.431.1315430352074; Wed,
 07 Sep 2011 14:19:12 -0700 (PDT)
Received: by 10.42.163.70 with HTTP; Wed, 7 Sep 2011 14:18:52 -0700 (PDT)
In-Reply-To: <7vbouw2hqg.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180912>

On Wed, Sep 7, 2011 at 13:57, Junio C Hamano <gitster@pobox.com> wrote:
> If a tag is GPG-signed, and if you trust the cryptographic robustness=
 of
> the SHA-1 and GPG, you can guarantee that all the history leading to =
the
> signed commit is not tampered with. However, it would be both cumbers=
ome
> and cluttering to sign each and every commit. Especially if you striv=
e to
> keep your history clean by tweaking, rewriting and polishing your com=
mits
> before pushing the resulting history out, many commits you will creat=
e
> locally end up not mattering at all, and it is a waste of time to sig=
n
> them.
>
> A better alternative could be to sign a "push certificate" (for the l=
ack
> of better name) every time you push, asserting that what commits you =
are
> pushing to update which refs. The basic workflow goes like this:
>
> =A01. You push out your work with "git push -s";

Yay!

> And here is a skeleton to implement it. It has all the necessary prot=
ocol
> extensions implemented (although I do not know if we need separate
> codepath for stateless RPC mode), but does not have subroutines to:

Yea, its broken for stateless RPC. See below.

> +static char *receive_push_certificate(void)
> +{
> + =A0 =A0 =A0 struct strbuf cert =3D STRBUF_INIT;
> + =A0 =A0 =A0 for (;;) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 char line[1000];

1000 isn't enough for some certificates. Imagine pushing a Gerrit Code
Review managed repository with 2M worth of advertisement data at once.
You can't sign that in 1000 bytes.

> @@ -326,6 +366,23 @@ int send_pack(struct send_pack_args *args,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0safe_write(out, req_buf.buf, req_buf.l=
en);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0packet_flush(out);
> =A0 =A0 =A0 =A0}
> +
> + =A0 =A0 =A0 if (signed_push) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 char *cp, *ep;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sign_push_certificate(&push_cert);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 strbuf_reset(&req_buf);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (cp =3D push_cert.buf; *cp; cp =3D =
ep) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ep =3D strchrnul(cp, '\=
n');
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (*ep =3D=3D '\n')
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ep++;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 packet_buf_write(&req_b=
uf, "%.*s",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0(int)(ep - cp), cp);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Do we need anything funky for statel=
ess rpc? */

Yes. Above we flushed the req_buf and send that in an HTTP request.
You need to hoist this block above the "if (args->stateless_rpc)"
segment.

--=20
Shawn.
