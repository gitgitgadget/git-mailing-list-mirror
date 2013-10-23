From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2] Clear fd after closing to avoid double-close error
Date: Wed, 23 Oct 2013 20:00:01 +0700
Message-ID: <CACsJy8Dqjfnu856OCdBpnwNyeOeE5p8dKTFe_KNKy8O0t2vSYQ@mail.gmail.com>
References: <1382448962-31782-1-git-send-email-jl@opera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?UTF-8?Q?Jens_Lindstr=C3=B6m?= <jl@opera.com>
X-From: git-owner@vger.kernel.org Wed Oct 23 15:00:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VYy3A-0007Qn-QX
	for gcvg-git-2@plane.gmane.org; Wed, 23 Oct 2013 15:00:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754006Ab3JWNAd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Oct 2013 09:00:33 -0400
Received: from mail-qa0-f42.google.com ([209.85.216.42]:33639 "EHLO
	mail-qa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753688Ab3JWNAc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Oct 2013 09:00:32 -0400
Received: by mail-qa0-f42.google.com with SMTP id w8so4133427qac.8
        for <git@vger.kernel.org>; Wed, 23 Oct 2013 06:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=QLReNkGsD23fo/G2FPWqyvVcT1YhWnVNfoaB8NQB7B4=;
        b=XLmt082vR6q7h5BzOakKfAeXggKuCPJJXSgWgVjvOBdxz4PAohKSGkwoIQYTJIiZRQ
         il33OkTtn4RNwQk9DHxAZb8NeZNPQg5/KOjsrm2m+0GryEWkxmGSsxZAqZCcF6CMPmCU
         va7UmSTjnmlWi54wJTIA35cmycFzJQ50jbYhfTnzVra/+7lRSOephzW4yIKww+MLEUOo
         YSyMatOv1/gXLcglNPWjEvdBgfPfXAYvqtQB/JJ1Go5MZOQjWEuOBqHmtN9PDwXbiyqX
         zRIRTuEeCHqx8d0sZIyp3V+GJJXTMK+ku2AGReJCoNX6Ha3p0OOLxwB1mEJNewJIbqgo
         0/vQ==
X-Received: by 10.224.7.194 with SMTP id e2mr3844052qae.46.1382533231598; Wed,
 23 Oct 2013 06:00:31 -0700 (PDT)
Received: by 10.96.27.202 with HTTP; Wed, 23 Oct 2013 06:00:01 -0700 (PDT)
In-Reply-To: <1382448962-31782-1-git-send-email-jl@opera.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236509>

On Tue, Oct 22, 2013 at 8:36 PM, Jens Lindstr=C3=B6m <jl@opera.com> wro=
te:
> From: Jens Lindstrom <jl@opera.com>
>
> In send_pack(), clear the fd passed to pack_objects() by setting
> it to -1, since pack_objects() closes the fd (via a call to
> run_command()).  Likewise, in get_pack(), clear the fd passed to
> run_command().
>
> Not doing so risks having git_transport_push(), caller of
> send_pack(), closing the fd again, possibly incorrectly closing
> some other open file; or similarly with fetch_refs_from_pack(),
> indirect caller of get_pack().
>
> Signed-off-by: Jens Lindstr=C3=B6m <jl@opera.com>
> ---
>  fetch-pack.c | 4 ++++
>  send-pack.c  | 4 ++++
>  2 files changed, 8 insertions(+)
>
> diff --git a/fetch-pack.c b/fetch-pack.c
> index f5d99c1..29b711a 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -776,6 +776,10 @@ static int get_pack(struct fetch_pack_args *args=
,
>                 close(cmd.out);
>         }
>
> +       if (!use_sideband)
> +               /* Closed by start_command() */
> +               xd[0] =3D -1;
> +

=46urther up demux.out still holds this handle. But we don't actually
start_async when use_sideband is false so demux.out can't be used
anywhere else. So it's good.

Acked-by: me

>         ret =3D finish_command(&cmd);
>         if (!ret || (args->check_self_contained_and_connected && ret =
=3D=3D 1))
>                 args->self_contained_and_connected =3D
> diff --git a/send-pack.c b/send-pack.c
> index 7d172ef..edbfd07 100644
> --- a/send-pack.c
> +++ b/send-pack.c
> @@ -300,8 +300,12 @@ int send_pack(struct send_pack_args *args,
>                                 shutdown(fd[0], SHUT_WR);
>                         if (use_sideband)
>                                 finish_async(&demux);
> +                       fd[1] =3D -1;
>                         return -1;
>                 }
> +               if (!args->stateless_rpc)
> +                       /* Closed by pack_objects() via start_command=
() */
> +                       fd[1] =3D -1;
>         }
>         if (args->stateless_rpc && cmds_sent)
>                 packet_flush(out);
> --
> 1.8.1.2
>



--=20
Duy
