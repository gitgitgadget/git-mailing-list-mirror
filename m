From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Give better 'pull' advice when pushing non-ff updates to current branch
Date: Mon, 23 Apr 2012 19:29:54 -0700
Message-ID: <xmqqr4vdhnfh.fsf@junio.mtv.corp.google.com>
References: <1335221121-36664-1-git-send-email-christiwald@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Matthieu.Moy@grenoble-inp.fr, peff@peff.net
To: Christopher Tiwald <christiwald@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 24 04:30:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMVW1-00024r-15
	for gcvg-git-2@plane.gmane.org; Tue, 24 Apr 2012 04:30:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756446Ab2DXC36 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Apr 2012 22:29:58 -0400
Received: from mail-gy0-f202.google.com ([209.85.160.202]:64312 "EHLO
	mail-gy0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756240Ab2DXC35 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2012 22:29:57 -0400
Received: by ghbz15 with SMTP id z15so26118ghb.1
        for <git@vger.kernel.org>; Mon, 23 Apr 2012 19:29:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:x-gm-message-state;
        bh=eBhMAUaLyQp+yzc5qVnY+FXv90DBoQOJN2xjHvwWIzc=;
        b=DnwDwTHcnaWkAL4dEeOnlp7h0DnDKDWwJB9h5RC/5Gd8QwFAonYdUVvSrZg+I89Elz
         Fo6ghRv5QIENfvEXLjGvtTwRaEsW2pBNpX7QZynoowQ4YP/RCMbc5A/oPuKiOPS/8MKe
         nVXKatMuE+4ZixhKqu3Tpc4Fv5ihByuhIvR7gzC1SJXsPJG2jYn30iFC2WExq8PuXmE6
         LDxLKdItFm8JvDc+uTstxTiMs0obR5oeFYLsYMS/Uu1pkRNmNzz6G6wkraZnuoGQ8ve9
         bqKwhlsnSiw/ZN0kdKvcMbd7RdNsNdVyH1seTqHrZNL6ST9QShzfpK6KEwDylrFp/Q6b
         fxLA==
Received: by 10.100.243.25 with SMTP id q25mr6765709anh.8.1335234596858;
        Mon, 23 Apr 2012 19:29:56 -0700 (PDT)
Received: by 10.100.243.25 with SMTP id q25mr6765665anh.8.1335234596460;
        Mon, 23 Apr 2012 19:29:56 -0700 (PDT)
Received: from wpzn3.hot.corp.google.com (216-239-44-65.google.com [216.239.44.65])
        by gmr-mx.google.com with ESMTPS id j51si16740509yhi.1.2012.04.23.19.29.55
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Mon, 23 Apr 2012 19:29:55 -0700 (PDT)
Received: from junio.mtv.corp.google.com (junio.mtv.corp.google.com [172.27.69.24])
	by wpzn3.hot.corp.google.com (Postfix) with ESMTP id 5426F10004D;
	Mon, 23 Apr 2012 19:29:55 -0700 (PDT)
Received: by junio.mtv.corp.google.com (Postfix, from userid 110493)
	id F3C7AE120A; Mon, 23 Apr 2012 19:29:54 -0700 (PDT)
In-Reply-To: <1335221121-36664-1-git-send-email-christiwald@gmail.com>
	(Christopher Tiwald's message of "Mon, 23 Apr 2012 18:45:21 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-Gm-Message-State: ALoCoQk7wjpMk+HEwTbV4hG3kyVwmzcM8oYQJYFWuXl2umY09Q8lRre172zedUu0Fve0fyQ/J57pa7MNnauQIdkKDgCdtohWEaADX6N3glsKdKrh89a/FCTmuCBi1iwpd7lh87RFRkDnh7mmjbdDG6UxHUBM35zk5gC8DHl9GO2xy9iGOhlSr/M=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196181>

Christopher Tiwald <christiwald@gmail.com> writes:

> @@ -177,6 +192,16 @@ static int push_with_options(struct transport *transport, int flags)
>  {
>  	int err;
>  	int nonfastforward;
> +	struct branch *branch;
> +	struct strbuf buf = STRBUF_INIT;
> +
> +	branch = branch_get(NULL);
> +
> +	if (branch) {
> +		strbuf_addstr(&buf, transport->remote->name);
> +		strbuf_addstr(&buf, "/");
> +		strbuf_addstr(&buf, branch->name);
> +	}

The "buf" is a horrible name for a variable that is used to hold states
in a long haul that has to span multiple hunks in a patch.  Please name
it after what the value means.

> @@ -201,7 +226,18 @@ static int push_with_options(struct transport *transport, int flags)
>  	default:
>  		break;
>  	case NON_FF_HEAD:
> -		advise_pull_before_push();
> +		/* Branches configured for octopus merges should advise
> +		 * just 'git pull' */
> +		if (branch->remote_name &&
> +		    branch->merge &&
> +		    branch->merge_nr == 1 &&
> +		    !strcmp(transport->remote->name, branch->remote_name) &&
> +		    !strcmp(strbuf_detach(&buf, NULL),
> +			    prettify_refname(branch->merge[0]->dst))) {

Why detach?  buf_to_be_renamed_more_sanely.buf, perhaps?

Is comparison between whatever buf has and the result of prettify safe
and sane?  After all, prettify is a random abbreviation that is meant
for human consumption, assuming that the reader is intelligent enough to
guess "Ah, it must be a tag" when she sees "v1.0" which is the result of
stripping the leading "refs/tags/" out.

This part should be using straight strcmp against branch->merge[0]->dst,
which means buf_to_be_renamed_more_sanely in the earlier hunk needs to
be computing what's tracked and merged correctly using the configured
refspec mapping, perhaps?
