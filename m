From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] Clear fd after closing to avoid double-close error
Date: Tue, 22 Oct 2013 19:39:08 +0700
Message-ID: <CACsJy8DtvaojrrQr4=uYCRse7N+SXb+WdjY+C_0FRSjYsNC6zg@mail.gmail.com>
References: <1382443823-31317-1-git-send-email-jl@opera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?UTF-8?Q?Jens_Lindstr=C3=B6m?= <jl@opera.com>
X-From: git-owner@vger.kernel.org Tue Oct 22 14:39:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VYbFR-00007N-1l
	for gcvg-git-2@plane.gmane.org; Tue, 22 Oct 2013 14:39:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752823Ab3JVMjk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Oct 2013 08:39:40 -0400
Received: from mail-qe0-f53.google.com ([209.85.128.53]:59274 "EHLO
	mail-qe0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752351Ab3JVMjj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Oct 2013 08:39:39 -0400
Received: by mail-qe0-f53.google.com with SMTP id cy11so4701037qeb.12
        for <git@vger.kernel.org>; Tue, 22 Oct 2013 05:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=Cs6fhgbh5qtyQOm71vLmVoTrRMsKE799Q3w5aALzZts=;
        b=VwXA6NeS72kNdnfTwp22lPIgcYJvBDzS/TTsi2ulvKzYAmDKWZuS4b8qE17mm7Ai4h
         OYWVA+Tfg9AyzPORek9XEs4yoeBdsoOqpGcwkCG33NOAgvPTYrebyYB0ZRNSw/QZPLFB
         VqNmYSlUuPdngwplmipfkgS25K+pYr0if5mW1ztLZK/+BVSxYsimjKWvDlskANICVHGJ
         +p4fyRv1J4c3CHbi0VT1HLq4QDpYAKdEdeqdpsyb/7CGmkD336k4Q6NB04D+JZNxiKfk
         0vPMJlbQQMNysU7DH2hdRa39GHxDYzIaFokX0ai23NM3P/Jo4i/W4GtsVgcku47d36o6
         9aYQ==
X-Received: by 10.229.110.8 with SMTP id l8mr1864013qcp.24.1382445578866; Tue,
 22 Oct 2013 05:39:38 -0700 (PDT)
Received: by 10.96.27.202 with HTTP; Tue, 22 Oct 2013 05:39:08 -0700 (PDT)
In-Reply-To: <1382443823-31317-1-git-send-email-jl@opera.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236465>

On Tue, Oct 22, 2013 at 7:10 PM, Jens Lindstr=C3=B6m <jl@opera.com> wro=
te:
> From: Jens Lindstrom <jl@opera.com>
>
> In send_pack(), clear the fd passed to pack_objects() by setting
> it to -1, since pack_objects() closes the fd (via a call to
> run_command()).
>
> Not doing so risks having git_transport_push(), caller of
> send_pack(), closing the fd again, possibly incorrectly closing
> some other open file.

Not your itch. But if you have time you may want to fix fetch-pack
too. It has the same problem. fetch-pack.c:get_pack() with
use_sideband =3D=3D 0 passes fd[0] to start_command(), then later its
caller transport.c:fetch_refs_via_pack() closes the handle again.

> Signed-off-by: Jens Lindstr=C3=B6m <jl@opera.com>
> ---
>  send-pack.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/send-pack.c b/send-pack.c
> index 7d172ef..7def2af 100644
> --- a/send-pack.c
> +++ b/send-pack.c
> @@ -302,6 +302,9 @@ int send_pack(struct send_pack_args *args,
>                                 finish_async(&demux);
>                         return -1;

In this code block, there is "close(out);", we may need to set fd[1] =3D=
 -1 too.

>                 }
> +               if (!args->stateless_rpc)
> +                       /* Closed by pack_objects() via start_command=
() */
> +                       fd[1] =3D -1;
>         }
>         if (args->stateless_rpc && cmds_sent)
>                 packet_flush(out);

I was puzzled by this packet_flush(out) for a while because I thought
"out" was already closed. Turns out when stateless_rpc is true, a new
pipe is created in pack_objects() and "out" is not closed. So
everything is still good (and messy).

Life would have been simpler if fd[1] was _always_ closed by
send_pack(), like in c20181e (start_command(), if .in/.out > 0, closes
file descriptors, not the callers - 2008-02-21).
--=20
Duy
