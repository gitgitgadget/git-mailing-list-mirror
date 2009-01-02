From: Alexander Potashev <aspotashev@gmail.com>
Subject: Re: [RFC PATCH] builtin-apply: prevent non-explicit permission
	changes
Date: Fri, 2 Jan 2009 16:37:51 +0300
Message-ID: <20090102133751.GA31789@myhost>
References: <20081230235357.GA12747@myhost> <7vfxk3npuc.fsf@gitster.siamese.dyndns.org> <20090101221720.GA5603@myhost> <7v3ag2frv8.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 02 14:39:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LIkFA-0006Y0-8A
	for gcvg-git-2@gmane.org; Fri, 02 Jan 2009 14:39:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753958AbZABNh4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Jan 2009 08:37:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752553AbZABNhy
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Jan 2009 08:37:54 -0500
Received: from fg-out-1718.google.com ([72.14.220.155]:29183 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751550AbZABNhx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jan 2009 08:37:53 -0500
Received: by fg-out-1718.google.com with SMTP id 19so2269572fgg.17
        for <git@vger.kernel.org>; Fri, 02 Jan 2009 05:37:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=XROTEw36lI0iPl76vLyH7Pexw9QZceUUybS9Hkfg7vk=;
        b=UtxXNWOT9ShWqwuQU32FfbMjTcINbdWgIcp0cliU1+oGyNnl/gyWgixqBnn19rrXoF
         7SDk3kNwNjgfZy7cTR8kQF4mGkmXDYhtSLW+rvaD8Bfjbs1FZatGt1KE01EQE6Gfnl6b
         g3eX283oxQtDp8RAZHuruN8EiSDJeny/Pm88w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=CJ/ZMt3oS8cJpSlteTNegR7o65U1ERCpqYsSxnJUNiSg7wL0O2AeXcEO+Rl/mQWJcn
         da39PDHk8kdEUES1urJW7ly+ITt5L9mOkem4t91S37B9/4a8dadhqt8ittuKT2O0Q7we
         Fn848gqtc4PeL2VY9Mx6GZ/qO+ftBFa1troy4=
Received: by 10.86.84.5 with SMTP id h5mr10475312fgb.12.1230903470181;
        Fri, 02 Jan 2009 05:37:50 -0800 (PST)
Received: from smtp.gmail.com ([91.78.102.214])
        by mx.google.com with ESMTPS id d6sm18428970fga.10.2009.01.02.05.37.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 02 Jan 2009 05:37:49 -0800 (PST)
Received: by smtp.gmail.com (sSMTP sendmail emulation); Fri, 02 Jan 2009 16:37:51 +0300
Content-Disposition: inline
In-Reply-To: <7v3ag2frv8.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104381>

On 16:56 Thu 01 Jan     , Junio C Hamano wrote:
> Alexander Potashev <aspotashev@gmail.com> writes:
> 
> > On 05:00 Thu 01 Jan     , Junio C Hamano wrote:
> >> Alexander Potashev <aspotashev@gmail.com> writes:
> > ...
> >> > @@ -2447,6 +2447,7 @@ static int check_preimage(struct patch *patch, struct cache_entry **ce, struct s
> >> >  	if (st_mode != patch->old_mode)
> >> >  		fprintf(stderr, "warning: %s has type %o, expected %o\n",
> >> >  			old_name, st_mode, patch->old_mode);
> >> > +	patch->new_mode = st_mode;
> >> 
> >> Can you do this unconditionally, overwriting whatever we read from the
> >> patch header metainfo lines?
> >
> > Do you mean overwriting of 'patch->new_mode' right after patch parsing?
> 
> My question was if we should assign st_mode to new_mode _unconditionally_
> here, even when patch->new_mode has already been read from the explicit
> mode change line (i.e. "new mode ", line not "index "line) of the patch
> input.
> 
> The call-chain of the program looks like this:
> 
> -> apply_patch()
>    -> parse_chunk()
>       -> find_header()
>          * initialize new_mode and old_mode to 0
>          -> parse_git_header()
>             * set new_mode and old_mode from the patch metainfo, i.e.
>               "new mode", "old mode" and "index" lines.
>       -> parse_single_patch()
>    -> check_patch_list()
>       -> check_patch()
>          -> check_preimage()
>             * make sure there is no local mods
>             * warn if old_mode read from the patch (i.e. the preimage file
>               the patch submitter used to prepare the patch against) does not
>               match what we have
>          * warn about mode inconsistency (e.g. the patch submitter thinks
>            the mode should be 0644 but our tree has 0755).
>          -> apply_data()
>    -> write_out_results()
>       -> write_out_one_result(0)
>          * delete old
>       -> write_out_one_result(1)
>          * create new
> 
> Currently the mode 100644 on the "index" line in a patch is handled
> exactly in the same way as having "old mode 100644" and "new mode 100644"
> lines in the metainfo.  The patch submitter claims to have started from
> 100644 and he claims that he wants to have 100644 as the result.  That is
> why there is a warning in check_patch().
> 
> If we stop reading the new mode from the "index" line (but we still read
> "old_mode" there) without any other change you made in your patch, what
> breaks (i.e. without the patch->new_mode assignment hunk)?  I haven't
> followed the codepath too closely, and I suspect you found some cases
> where new_mode stays 0 as initialized, and that may be the reason you have
> this assignment.
> 
> But the assignment being unconditional bothered me a lot.
> 
> I tend to agree that the current "The final mode bits I want to have on
> this path is this" semantics we give to the "index" line is much less
> useful and less sane and it is a good idea to redefine it as "FYI, the
> copy I made this patch against had this mode bits.  I do not intend to
> change the mode bits of the path with this patch."
> 
>  builtin-apply.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
> 
> diff --git c/builtin-apply.c w/builtin-apply.c
> index 07244b0..a8f75ed 100644
> --- c/builtin-apply.c
> +++ w/builtin-apply.c
> @@ -630,7 +630,7 @@ static int gitdiff_index(const char *line, struct patch *patch)
>  	memcpy(patch->new_sha1_prefix, line, len);
>  	patch->new_sha1_prefix[len] = 0;
>  	if (*ptr == ' ')
> -		patch->new_mode = patch->old_mode = strtoul(ptr+1, NULL, 8);
> +		patch->old_mode = strtoul(ptr+1, NULL, 8);
>  	return 0;
>  }
>  
> @@ -2447,6 +2447,8 @@ static int check_preimage(struct patch *patch, struct cache_entry **ce, struct s
>  	if (st_mode != patch->old_mode)
>  		fprintf(stderr, "warning: %s has type %o, expected %o\n",
>  			old_name, st_mode, patch->old_mode);
> +	if (!patch->new_mode)
> +		patch->new_mode = st_mode;

This is a _major_ fix, with my patch it would never change any
permissions at all.

I couldn't fully understand that problem last night, sorry for the
noise.

>  	return 0;
>  
>   is_new:
