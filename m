From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 05/13] delete_refs(): improve error message
Date: Tue, 09 Jun 2015 11:47:56 -0700
Message-ID: <xmqq38207m77.fsf@gitster.dls.corp.google.com>
References: <cover.1433763494.git.mhagger@alum.mit.edu>
	<9f6f3432467c2b12329c16a46c52670f772993e5.1433763494.git.mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Jun 09 20:48:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2OZC-0007fv-No
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jun 2015 20:48:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932927AbbFISsC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2015 14:48:02 -0400
Received: from mail-ig0-f195.google.com ([209.85.213.195]:34453 "EHLO
	mail-ig0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753888AbbFISsB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jun 2015 14:48:01 -0400
Received: by igdh15 with SMTP id h15so2924841igd.1
        for <git@vger.kernel.org>; Tue, 09 Jun 2015 11:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version:content-type;
        bh=zM+hfyia32HP71GXvWc/AT3cXxAbfKKUPENY8m/M93Y=;
        b=G1ypRW1QGrkyzbaRQlhTZTwjPuAD4FxyBFNO0JdgvZBKFPc+NAFNsXISHZIQt87/iq
         eGP5n34MfzppGTA7DgCnP2w7MShTaAwj5pvL3LEFTSlTKCmSXF8NR2tUKypjykDAqiS3
         1k4M8H4GOsdqggvwCyh9NwOp+FXkj8D/Kqo0uuP/ksJzxdV60CQe40iDyofAsiu30wWt
         d91KAFFNU7iF4mlxiTdEZfxzCi7ScgOzJWxMYPULWT/wKbtJEgr6ElbPwlEGkZiEfZnf
         jhSOQAOogveLlc+YgS7pllRHRjSLf+mkQg9mxnsB2WK6ynzdOkH9+51JspVQBIcKlVjM
         BQzA==
X-Received: by 10.50.17.104 with SMTP id n8mr22072625igd.21.1433875679031;
        Tue, 09 Jun 2015 11:47:59 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:b116:bf29:c748:758b])
        by mx.google.com with ESMTPSA id ot6sm1678280igb.11.2015.06.09.11.47.56
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 09 Jun 2015 11:47:57 -0700 (PDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271224>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Change the error message from
>
>     Could not remove branch %s
>
> to
>
>     Could not remove reference %s
>
> This change makes sense even for the existing caller, which uses the
> function to delete remote-tracking branches.

I am 80% convinced ;-)

The existing caller never used this for removing tags, so 'could not
remove branch' was equally correct for it and was more specific than
'could not remove reference'.  If you change it to 'could not remove
that thing %s', it would still be correct for the existing caller;
it would be even less specific for them, though ;-)

The new callers you will add in later patch of course cannot live
with 'could not remove branch', so I think that this is an
acceptable compromise we can live with.  If somebody later wants to
make the message more specific, they can add code that switches on
the prefix of the ref when coming up with the error message (and use
that code consistently in other error messages e.g. 'could not add
reference').

>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  refs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/refs.c b/refs.c
> index c413282..2a2a06d 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -2827,7 +2827,7 @@ int delete_refs(struct string_list *refnames)
>  		const char *refname = refnames->items[i].string;
>  
>  		if (delete_ref(refname, NULL, 0))
> -			result |= error(_("Could not remove branch %s"), refname);
> +			result |= error(_("Could not remove reference %s"), refname);
>  	}
>  
>  	return result;
