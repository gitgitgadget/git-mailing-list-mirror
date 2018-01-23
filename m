Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E3301F404
	for <e@80x24.org>; Tue, 23 Jan 2018 18:41:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752467AbeAWSl0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Jan 2018 13:41:26 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53253 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752409AbeAWSlY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jan 2018 13:41:24 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2D1EAC5E67;
        Tue, 23 Jan 2018 13:41:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ajSEQvT4hcwROlPIjDGo2bI52r8=; b=WbYu2K
        58Rem/Ki5e3hJakSbhRGsLTYetNXQjjm3OZgiTfMdMj7qu9pQM+pFLWooAIJ5/Cp
        Ma03Q4fqiMMH734ieyHtpV1QMV7KueoSlNtHdn+wKNaFsq/CLV146MccA7RPcEUd
        NwpwL2SKAVgqearSNrI3SEiDqBrzZZQ5lA798=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DLUpRrsrArAyKUEJm3Oi6p9sAjvzmcvz
        wShrGDIVYa2nOoGMQ6mFLa/FxTxBjIw52dTt2psL7riddEez7JhjFDVhaoDalhAW
        bleGaZoIWkZl1wngLm2AddqypKu0omRKBCl9cBAggP37flTAjjvhjBJbnIrjE4en
        3Fea/y3D6UE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 23EEBC5E66;
        Tue, 23 Jan 2018 13:41:24 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8A434C5E65;
        Tue, 23 Jan 2018 13:41:23 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood@talktalk.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2 1/2] t7505: Add tests for cherry-pick and rebase -i/-p
References: <CAKdAkRSuNhEri+3eUbX8iVjr0JUyADSJBtgL==VjNwgKwe3Xqw@mail.gmail.com>
        <20180123102420.19911-1-phillip.wood@talktalk.net>
        <20180123102420.19911-2-phillip.wood@talktalk.net>
Date:   Tue, 23 Jan 2018 10:41:22 -0800
In-Reply-To: <20180123102420.19911-2-phillip.wood@talktalk.net> (Phillip
        Wood's message of "Tue, 23 Jan 2018 10:24:19 +0000")
Message-ID: <xmqq4lncifjh.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 02FD9F54-006D-11E8-AB63-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood@talktalk.net> writes:

> @@ -31,17 +63,40 @@ mkdir -p "$HOOKDIR"
>  echo "#!$SHELL_PATH" > "$HOOK"
>  cat >> "$HOOK" <<'EOF'
>  
> +GIT_DIR=$(git rev-parse --git-dir)
> +if test -d "$GIT_DIR/rebase-merge"
> +then
> +  rebasing=1
> +else
> +  rebasing=0
> +fi
> +
> +get_last_cmd () {
> +  tail -n1 "$GIT_DIR/rebase-merge/done" | {
> +    read cmd id _
> +    git log --pretty="[$cmd %s]" -n1 $id
> +  }
> +}
> +
>  if test "$2" = commit; then
> -  source=$(git rev-parse "$3")
> +  if test $rebasing = 1
> +  then
> +    source="$3"
> +  else
> +    source=$(git rev-parse "$3")
> +  fi
>  else
>    source=${2-default}
>  fi
> -if test "$GIT_EDITOR" = :; then
> -  sed -e "1s/.*/$source (no editor)/" "$1" > msg.tmp
> +test "$GIT_EDITOR" = : && source="$source (no editor)"
> +
> +if test $rebasing = 1
> +then
> +  echo "$source $(get_last_cmd)" >"$1"
>  else
>    sed -e "1s/.*/$source/" "$1" > msg.tmp
> +  mv msg.tmp "$1"
>  fi

It is somewhat irritating that indentation is screwed up in this
part of the file.  Can we not make it even worse?

