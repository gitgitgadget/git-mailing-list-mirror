From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] log: add log.follow config option
Date: Tue, 07 Jul 2015 15:13:04 -0700
Message-ID: <xmqqsi8z1urz.fsf@gitster.dls.corp.google.com>
References: <1436294440-20273-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, David Turner <dturner@twitter.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Wed Jul 08 00:13:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCb72-0001zY-Fq
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jul 2015 00:13:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933120AbbGGWNI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2015 18:13:08 -0400
Received: from mail-ie0-f181.google.com ([209.85.223.181]:35754 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932886AbbGGWNG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2015 18:13:06 -0400
Received: by iecuq6 with SMTP id uq6so144070881iec.2
        for <git@vger.kernel.org>; Tue, 07 Jul 2015 15:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=21aajdxOvg/ShybIcGJSm/oDL+yo0Cy2HHz/9bjdvEM=;
        b=bDP/z2Y/SNCVd1y4de0YrpQjzEca5qZ8X6HZ0OHuK/p1PciyJl/QihXcvoW0Xy+rVn
         l/YjawTilqm+jkeYG2naHNL8ueoWQNGmifa2SCzbPl05yn9p3AjOItmW3DTIzfRNTdHT
         OzVtAtIWLwWUISbBgFuIL9togytPvoVAlZ1OB1y+TNyUKg9IXkRQdOICA3QR9G+/1EgM
         mHougSAkJvnOiBJqAQqUfH41C1tawG4LQNV/Af50NP1ImNxt5aU5IuOFHPNirb2f8rBw
         PPcfLUF4JRfVbtR/+KgMwGBKfnV8ZLWoMY70u3w1vM9TzdlBX5xbMnjPNGa0n2Iq6vZ3
         ArMA==
X-Received: by 10.107.151.75 with SMTP id z72mr10276330iod.46.1436307186104;
        Tue, 07 Jul 2015 15:13:06 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:7d74:6f43:1e30:fb1d])
        by smtp.gmail.com with ESMTPSA id q10sm12744770ige.16.2015.07.07.15.13.05
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 07 Jul 2015 15:13:05 -0700 (PDT)
In-Reply-To: <1436294440-20273-1-git-send-email-dturner@twopensource.com>
	(David Turner's message of "Tue, 7 Jul 2015 14:40:40 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273609>

David Turner <dturner@twopensource.com> writes:

> diff --git a/revision.c b/revision.c
> index 3ff8723..ae6d4c3 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -2322,12 +2322,21 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
>  
>  	if (revs->prune_data.nr) {
>  		copy_pathspec(&revs->pruning.pathspec, &revs->prune_data);
> -		/* Can't prune commits with rename following: the paths change.. */
> -		if (!DIFF_OPT_TST(&revs->diffopt, FOLLOW_RENAMES))
> -			revs->prune = 1;
> +
>  		if (!revs->full_diff)
>  			copy_pathspec(&revs->diffopt.pathspec,
>  				      &revs->prune_data);
> +
> +		if (DIFF_OPT_TST(&revs->diffopt, DEFAULT_FOLLOW_RENAMES) &&
> +		    revs->diffopt.pathspec.nr == 1)
> +			DIFF_OPT_SET(&revs->diffopt, FOLLOW_RENAMES);
> +
> +		/* Can't prune commits with rename following: the paths change.. */
> +		if (!DIFF_OPT_TST(&revs->diffopt, FOLLOW_RENAMES)) {
> +			revs->prune = 1;
> +		} else {
> +			revs->diff = 1;
> +		}
>  	}
>  	if (revs->combine_merges)
>  		revs->ignore_merges = 0;

It is unfortunate that we have to waste one DIFF_OPT bit and touch
revision.c for something that is "just a convenience".  Because
setup_revisions() does not have a way to let you flip the settings
depending on the number of pathspecs specified, I do not think of a
solution that does not have to touch a low level foundation part of
the codebase, which I'd really want to avoid.

But I wonder why your patch needs to touch so much.

Your changes to other files make sure that diffopt has the
DEFAULT_FOLLOW_RENAMES when (1) the configuration is set and (2) the
command line did not override it with --no-follow.  And these look
very sensible.

Isn't the only thing left to do in this codepath, after the DEFAULT_
is set up correctly, to set FOLLOW_RENAMES when (1) DEFAULT_ is set
and (2) you have only one path?

And once FOLLOW_RENAMES is set or unset according to the end-user
visible semantics, i.e. "just for a convenience, setting log.follow
adds --follow to the command line if and only if there is only one
pathspec", I do not see why existing code needs to be modified in
any other way.

IOW, I'd like to know why we need more than something like this
change to this file, instead of the above?  We didn't muck with
revs->diff in the original when FOLLOW_RENAMES was set, but now it
does, for example.

diff --git a/revision.c b/revision.c
index 3ff8723..f7bd229 100644
--- a/revision.c
+++ b/revision.c
@@ -2270,6 +2270,10 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 			got_rev_arg = 1;
 	}
 
+	if (DIFF_OPT_TST(&revs->diffopt, DEFAULT_FOLLOW_RENAMES) &&
+	    revs->diffopt.pathspec.nr == 1)
+		DIFF_OPT_SET(&revs->diffopt, FOLLOW_RENAMES);
+
 	if (prune_data.nr) {
 		/*
 		 * If we need to introduce the magic "a lone ':' means no
