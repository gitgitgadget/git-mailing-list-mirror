From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 5/8] revert: Catch incompatible command-line options early
Date: Wed, 11 May 2011 07:06:54 -0500
Message-ID: <20110511120654.GF2676@elie>
References: <1305100822-20470-1-git-send-email-artagnon@gmail.com>
 <1305100822-20470-6-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 11 17:56:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKBlj-0002RP-CL
	for gcvg-git-2@lo.gmane.org; Wed, 11 May 2011 17:56:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756164Ab1EKP4F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2011 11:56:05 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:39299 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755436Ab1EKP4D (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2011 11:56:03 -0400
Received: by iyb14 with SMTP id 14so445743iyb.19
        for <git@vger.kernel.org>; Wed, 11 May 2011 08:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=+xOKUvFZVqK8g7BQHhWT/8ssggJFakcEsLqNsKqZbuU=;
        b=L2rvI0jxO2AQnqdpmGoxeGZtznxlhAkgGi2Fca4PAtT4CGQtjxZ10OL7jUEeri27PC
         CnZgxwVaOx2NcrlH+O1XpYbeezDLoOjZh8y78wfTfBnLKB8w2q5OU3lsoDFJV4ubR3TN
         NLvvGK9qMg6x0r8L4fWJZXnoQOhIKnyBYE7Aw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=XZijLDSYAJ7EUO5B6gNvbfbcAe7vJbltHqGUzLb+JNBuCpRFkrdjrGRJ2GcpmNMoUn
         pl/wT//Zuyt9cU2yr+IDcARNosTESNJon/fg/BOqop15HMkgCtjQOVgLNvF3IQkmHtFc
         MrhVErqK+Vp3sp48JBMFEQHzLfacPSKG/Z5y8=
Received: by 10.42.134.196 with SMTP id m4mr9809873ict.491.1305115618311;
        Wed, 11 May 2011 05:06:58 -0700 (PDT)
Received: from elie (adsl-69-209-56-134.dsl.chcgil.ameritech.net [69.209.56.134])
        by mx.google.com with ESMTPS id i3sm34979iby.6.2011.05.11.05.06.56
        (version=SSLv3 cipher=OTHER);
        Wed, 11 May 2011 05:06:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1305100822-20470-6-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173396>

Ramkumar Ramachandra wrote:

> Earlier, incompatible command-line options used to be caught in
> pick_commits after parse_args has parsed the options and populated the
> options structure; a lot of unncessary work has already been done, and
> significant amount of cleanup is required to die at this stage.
> Instead, hand over this responsibility to parse_args so that the
> program can die early.

Looking at the patch, this seems like a bugfix (error messages
currently say "cherry-pick: " when they should sometimes say
"revert: ") and cleanup (dealing with options incompatible with "--ff"
in a loop instead of one by one) in addition to the "check and die
early" improvement you explain above.

> --- a/builtin/revert.c
> +++ b/builtin/revert.c
> @@ -80,10 +80,29 @@ static int option_parse_x(const struct option *opt,
>  	return 0;
>  }
>  
> +static void die_opt_incompatible(const char *me, const char *base_opt, ...)
> +{
> +	const char *this_opt;
> +	int this_opt_set;
> +	va_list ap;
> +
> +	va_start(ap, base_opt);
> +	while (1) {
> +		if (!(this_opt = va_arg(ap, const char *)))
> +			break;
> +		if ((this_opt_set = va_arg(ap, int)))
> +			die(_("%s: %s cannot be used with %s"),
> +				me, this_opt, base_opt);
> +	}
> +	va_end(ap);
> +}

Wait a second --- this doesn't always die!  Why is it called
die_opt_incompatible rather than verify_opt_compatible_or_die or
something?

I think I would have written the loop something like

	va_start(ap, opt1);
	while ((opt2 = va_arg(ap, const char *))) {
		int set = va_arg(ap, int);
		if (set)
			die(opt1 cannot be used with opt2);
	}
	va_end(ap);

Thanks.  The refactoring into a loop is nice.
