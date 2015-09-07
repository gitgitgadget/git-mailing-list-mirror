From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 4/5] clone: allow --local from a linked checkout
Date: Mon, 07 Sep 2015 09:25:49 -0700
Message-ID: <xmqqd1xu9oxe.fsf@gitster.mtv.corp.google.com>
References: <20150715132552.GA28574@lanh>
	<1440204002-7638-1-git-send-email-pclouds@gmail.com>
	<1440204002-7638-5-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, bjornar@snoksrud.no
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 07 18:26:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZYzF1-0007FO-V2
	for gcvg-git-2@plane.gmane.org; Mon, 07 Sep 2015 18:26:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753352AbbIGQZz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Sep 2015 12:25:55 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:36205 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751463AbbIGQZu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Sep 2015 12:25:50 -0400
Received: by padhk3 with SMTP id hk3so15600512pad.3
        for <git@vger.kernel.org>; Mon, 07 Sep 2015 09:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=jDQNkHLPuWdnU1Ix3z7W6TWzyvTeOxo32BAkOA1KxGQ=;
        b=JGw49qokEuIl8+mm3U5DOHCjwV7LIjhYw3GRkxPW650+gbLpMJJvh62LG5m7Bt+v23
         2B8jKgvi6S4Hv7p34keLMvBvXMnn16NZG25Vz3P2ttUKj+6fkjkKqHgaGI737sOMAuBx
         TaRQiHXtU3AbUnd0LsYBmKaWWe7NP3C+2XyjTK5IfJotRVSsIsBZraBlcVVnmu69NGQp
         NGi+vT9Lf1QDOr5b1aF3bYbfIoXtOimKxsARqMVgIvjOaOsix+pkNVNGRs5YmANrkI6K
         ttdaZ8QEuoP6ejLxIT+6kxuyBru+dK+4tIQAXKRPUdCunG7zVZdHi7ATrq2uDeJGbyS1
         EtTQ==
X-Received: by 10.68.98.5 with SMTP id ee5mr47208536pbb.95.1441643150556;
        Mon, 07 Sep 2015 09:25:50 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:751a:a433:a60b:dba1])
        by smtp.gmail.com with ESMTPSA id ql5sm275626pac.46.2015.09.07.09.25.49
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Mon, 07 Sep 2015 09:25:49 -0700 (PDT)
In-Reply-To: <1440204002-7638-5-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sat, 22
 Aug 2015 07:40:01 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277468>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Noticed-by: Bj=C3=B8rnar Snoksrud <snoksrud@gmail.com>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  builtin/clone.c         | 6 ++++--
>  t/t2025-worktree-add.sh | 5 +++++
>  2 files changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/clone.c b/builtin/clone.c
> index 578da85..836fb64 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -424,8 +424,10 @@ static void clone_local(const char *src_repo, co=
nst char *dest_repo)
>  	} else {
>  		struct strbuf src =3D STRBUF_INIT;
>  		struct strbuf dest =3D STRBUF_INIT;
> -		strbuf_addf(&src, "%s/objects", src_repo);
> -		strbuf_addf(&dest, "%s/objects", dest_repo);
> +		get_common_dir(&src, src_repo);
> +		get_common_dir(&dest, dest_repo);
> +		strbuf_addstr(&src, "/objects");
> +		strbuf_addf(&dest, "/objects");

Why addstr vs addf?  Shouldn't both be addstr?

>  		copy_or_link_directory(&src, &dest, src_repo, src.len);
>  		strbuf_release(&src);
>  		strbuf_release(&dest);
> diff --git a/t/t2025-worktree-add.sh b/t/t2025-worktree-add.sh
> index 8267411..3694174 100755
> --- a/t/t2025-worktree-add.sh
> +++ b/t/t2025-worktree-add.sh
> @@ -193,4 +193,9 @@ test_expect_success '"add" -B/--detach mutually e=
xclusive' '
>  	test_must_fail git worktree add -B poodle --detach bamboo master
>  '
> =20
> +test_expect_success 'local clone from linked checkout' '
> +	git clone --local here here-clone &&
> +	( cd here-clone && git fsck )
> +'
> +
>  test_done
