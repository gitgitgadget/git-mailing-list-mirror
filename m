From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v2] log: add log.follow config option
Date: Tue, 07 Jul 2015 21:28:59 -0400
Organization: Twitter
Message-ID: <1436318939.5521.32.camel@twopensource.com>
References: <1436294440-20273-1-git-send-email-dturner@twopensource.com>
	 <xmqqsi8z1urz.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, David Turner <dturner@twitter.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 08 03:29:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCeAf-0006a7-5e
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jul 2015 03:29:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757825AbbGHB3F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2015 21:29:05 -0400
Received: from mail-qk0-f172.google.com ([209.85.220.172]:35539 "EHLO
	mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754186AbbGHB3D (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2015 21:29:03 -0400
Received: by qkbp125 with SMTP id p125so153246223qkb.2
        for <git@vger.kernel.org>; Tue, 07 Jul 2015 18:29:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=GXjLf7VSbCBOF5AZXtgQq5j3CFHj56gNB+BkQcSHmqM=;
        b=anWF935Z3xamQslhnZUPKq7DLoW23CMx1PxMwOXl7kROj8zSzSDjAR0b1jqnhfypIl
         RotHZTvXFsETFCDFqXEkvoSdlZwR5Aa/99sRxRwvPF3LhByh+hrcvsCDN58a2u0o9LIU
         UN/QrV4psDvc1gMSCGUnd9X47/fP6n3KLopZothgd12QhZKtiRjP1NwhFayXGHP+TdwA
         dV6xP8jnNJumNeOyeAQiu8R0Gt/I+eJ6GqXlXhQhX5Ol+eag1BYhwqCnqe4cBWVLQzmj
         LgrFLfeDC5uN6u0AyUVuS/+uARkJ+WLIhkOA60RIoU2gWVt2jxwVXbG2WLQT/nJlqsDq
         e+vg==
X-Gm-Message-State: ALoCoQnI63hKh9//SMZmRDgua+H7COZJyJZZXYeKCAjq6IR/7gsawrUDJR8i50n3w83E8RnLOJO2
X-Received: by 10.55.48.11 with SMTP id w11mr11711074qkw.61.1436318942232;
        Tue, 07 Jul 2015 18:29:02 -0700 (PDT)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id w126sm95220qkw.32.2015.07.07.18.29.00
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Jul 2015 18:29:00 -0700 (PDT)
In-Reply-To: <xmqqsi8z1urz.fsf@gitster.dls.corp.google.com>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273630>

On Tue, 2015-07-07 at 15:13 -0700, Junio C Hamano wrote:
> David Turner <dturner@twopensource.com> writes:
> 
> > diff --git a/revision.c b/revision.c
> > index 3ff8723..ae6d4c3 100644
> > --- a/revision.c
> > +++ b/revision.c
> > @@ -2322,12 +2322,21 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
> >  
> >  	if (revs->prune_data.nr) {
> >  		copy_pathspec(&revs->pruning.pathspec, &revs->prune_data);
> > -		/* Can't prune commits with rename following: the paths change.. */
> > -		if (!DIFF_OPT_TST(&revs->diffopt, FOLLOW_RENAMES))
> > -			revs->prune = 1;
> > +
> >  		if (!revs->full_diff)
> >  			copy_pathspec(&revs->diffopt.pathspec,
> >  				      &revs->prune_data);
> > +
> > +		if (DIFF_OPT_TST(&revs->diffopt, DEFAULT_FOLLOW_RENAMES) &&
> > +		    revs->diffopt.pathspec.nr == 1)
> > +			DIFF_OPT_SET(&revs->diffopt, FOLLOW_RENAMES);
> > +
> > +		/* Can't prune commits with rename following: the paths change.. */
> > +		if (!DIFF_OPT_TST(&revs->diffopt, FOLLOW_RENAMES)) {
> > +			revs->prune = 1;
> > +		} else {
> > +			revs->diff = 1;
> > +		}
> >  	}
> >  	if (revs->combine_merges)
> >  		revs->ignore_merges = 0;
> 
> It is unfortunate that we have to waste one DIFF_OPT bit and touch
> revision.c for something that is "just a convenience".  Because
> setup_revisions() does not have a way to let you flip the settings
> depending on the number of pathspecs specified, I do not think of a
> solution that does not have to touch a low level foundation part of
> the codebase, which I'd really want to avoid.
> 
> But I wonder why your patch needs to touch so much.
> 
> Your changes to other files make sure that diffopt has the
> DEFAULT_FOLLOW_RENAMES when (1) the configuration is set and (2) the
> command line did not override it with --no-follow.  And these look
> very sensible.
> 
> Isn't the only thing left to do in this codepath, after the DEFAULT_
> is set up correctly, to set FOLLOW_RENAMES when (1) DEFAULT_ is set
> and (2) you have only one path?
>
> And once FOLLOW_RENAMES is set or unset according to the end-user
> visible semantics, i.e. "just for a convenience, setting log.follow
> adds --follow to the command line if and only if there is only one
> pathspec", I do not see why existing code needs to be modified in
> any other way.
> 
> IOW, I'd like to know why we need more than something like this
> change to this file, instead of the above?  We didn't muck with
> revs->diff in the original when FOLLOW_RENAMES was set, but now it
> does, for example.

We did, but we did it earlier.  But I can just rearrange the code.

> diff --git a/revision.c b/revision.c
> index 3ff8723..f7bd229 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -2270,6 +2270,10 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
>  			got_rev_arg = 1;
>  	}
>  
> +	if (DIFF_OPT_TST(&revs->diffopt, DEFAULT_FOLLOW_RENAMES) &&
> +	    revs->diffopt.pathspec.nr == 1)
> +		DIFF_OPT_SET(&revs->diffopt, FOLLOW_RENAMES);
> +
>  	if (prune_data.nr) {
>  		/*
>  		 * If we need to introduce the magic "a lone ':' means no

revs->diffopt.pathspec isn't set up yet then. But prune_data is, so I
can use that. 

Will send a v3.
