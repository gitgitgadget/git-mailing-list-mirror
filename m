From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH 2/2] push -s: skeleton
Date: Wed, 7 Sep 2011 16:23:13 -0700
Message-ID: <CAJo=hJsLx1Q9ZDoxGn=dww5J-rO9GitH47rEme_1L8Lg0RmAqw@mail.gmail.com>
References: <7vfwk82hrt.fsf@alter.siamese.dyndns.org> <7vbouw2hqg.fsf@alter.siamese.dyndns.org>
 <CAJo=hJtz6fa4XfC-4ghryP_nfg3sbcrE2bKauj+F7w2Z_8Ckvw@mail.gmail.com> <7vpqjc0zaf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 08 01:23:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1RT2-0006dj-QQ
	for gcvg-git-2@lo.gmane.org; Thu, 08 Sep 2011 01:23:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756105Ab1IGXXf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Sep 2011 19:23:35 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:56848 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755892Ab1IGXXf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Sep 2011 19:23:35 -0400
Received: by ywf7 with SMTP id 7so162648ywf.19
        for <git@vger.kernel.org>; Wed, 07 Sep 2011 16:23:34 -0700 (PDT)
Received: by 10.42.162.74 with SMTP id w10mr1291icx.163.1315437814314; Wed, 07
 Sep 2011 16:23:34 -0700 (PDT)
Received: by 10.42.163.70 with HTTP; Wed, 7 Sep 2011 16:23:13 -0700 (PDT)
In-Reply-To: <7vpqjc0zaf.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180927>

On Wed, Sep 7, 2011 at 15:21, Junio C Hamano <gitster@pobox.com> wrote:
> Shawn Pearce <spearce@spearce.org> writes:
>
>> Yes. Above we flushed the req_buf and send that in an HTTP request.
>> You need to hoist this block above the "if (args->stateless_rpc)"
>> segment.
>
> What do you mean by "hoist"? For the req advertisement, it seems that=
 you
> are not hoisting anything but duplicating the code, turning safe_writ=
e()
> followed by flush into packet-buf-flush and sending the result over t=
he
> sideband. Shouldn't this new data be sent over the sideband-to-http t=
he
> same way?
>
> Unless you do not want signed push over http, that is...

We do.

> diff --git a/builtin/send-pack.c b/builtin/send-pack.c
> index 3193f34..37e0313 100644
> --- a/builtin/send-pack.c
> +++ b/builtin/send-pack.c
> @@ -379,9 +379,13 @@ int send_pack(struct send_pack_args *args,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0packet_buf_write(&req_=
buf, "%.*s",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 (int)(ep - cp), cp);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Do we need anything funky for statel=
ess rpc? */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 safe_write(out, req_buf.buf, req_buf.le=
n);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 packet_flush(out);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (args->stateless_rpc) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 packet_buf_flush(&req_b=
uf);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 send_sideband(out, -1, =
req_buf.buf, req_buf.len, LARGE_PACKET_MAX);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 safe_write(out, req_buf=
=2Ebuf, req_buf.len);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 packet_flush(out);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }

This sounds too late to me.  I think you just caused 2 HTTP POSTs, one
a partial one with the commands and no pack data, and another with the
push certificate and the pack. Neither is useful.

--=20
Shawn.
