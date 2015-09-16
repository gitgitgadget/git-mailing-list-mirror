From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 23/67] add_packed_git: convert strcpy into xsnprintf
Date: Wed, 16 Sep 2015 11:43:49 -0700
Message-ID: <xmqq8u86qk62.fsf@gitster.mtv.corp.google.com>
References: <20150915152125.GA27504@sigill.intra.peff.net>
	<20150915154143.GW29753@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 16 20:44:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZcHgS-00058X-14
	for gcvg-git-2@plane.gmane.org; Wed, 16 Sep 2015 20:43:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752560AbbIPSnw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2015 14:43:52 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:36122 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752392AbbIPSnv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2015 14:43:51 -0400
Received: by padhk3 with SMTP id hk3so216238068pad.3
        for <git@vger.kernel.org>; Wed, 16 Sep 2015 11:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=zzvzK23B5QrdwnTftv4l73FAsxkaVzGSSJ7bIoLFhsE=;
        b=WzwMcEfOfLKfwzMWsref9/iDib40soBrQZdeNM60mCwgDDV15aT3xZEWjcZojIcTUU
         P3hoHXJQhotSGw8Jj8D6vkBfbTgoH3at4Hbt0X27iNmdq43Ae+dfuSZiiHgikkVSZ9F7
         /p/gGA4pYps8mHIaMkAnTYpkDzks+lcQ8lpeCtiFxbqi0patdRL8DQJgIMRzdXd47May
         qwT04XQvi0ONstYxs8ZAdrRM2DcaBCUuoG1PamlCVHJeawxDjDmGBmRMfeY5wnqHjsKC
         QAEI4uq5ypo4jDwWd0Tsa3b0eYWVIijX9svgfG+0Lk9k9gpyTVRpq1EtHWCMW5qQVaXF
         5F2Q==
X-Received: by 10.66.144.99 with SMTP id sl3mr54640396pab.127.1442429031033;
        Wed, 16 Sep 2015 11:43:51 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:150c:7d53:9693:493e])
        by smtp.gmail.com with ESMTPSA id jo9sm3680662pbc.15.2015.09.16.11.43.49
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 16 Sep 2015 11:43:50 -0700 (PDT)
In-Reply-To: <20150915154143.GW29753@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 15 Sep 2015 11:41:43 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278047>

Jeff King <peff@peff.net> writes:

> +	alloc = path_len + strlen(".pack") + 1;
> +	p = alloc_packed_git(alloc);
> +	memcpy(p->pack_name, path, path_len); /* NUL from zero-ed struct */

This comment is confusing, isn't it?  Yes, there is a NUL, but you
will going to overwrite it with "." in ".keep" immediately and more
importantly, that overwriting does not depend on NUL being there.

What's more important to comment on would probably be the line that
computes the "alloc".  It uses ".pack" but that is because it knows
that is the longest suffix we care about, and that deserves mention
more than the NUL termination of intermediate result that does not
matter, no?

If ".bitmap" were in the set of suffixes we care about (it isn't),
we would be using that instead when measuring "alloc".

Thanks.

> +
> +	xsnprintf(p->pack_name + path_len, alloc - path_len, ".keep");
>  	if (!access(p->pack_name, F_OK))
>  		p->pack_keep = 1;
>  
> -	strcpy(p->pack_name + path_len, ".pack");
> +	xsnprintf(p->pack_name + path_len, alloc - path_len, ".pack");
>  	if (stat(p->pack_name, &st) || !S_ISREG(st.st_mode)) {
>  		free(p);
>  		return NULL;
