From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 5/8] revert: Catch incompatible command-line options early
Date: Fri, 13 May 2011 15:37:16 +0530
Message-ID: <20110513100714.GG14272@ramkum.desktop.amazon.com>
References: <1305100822-20470-1-git-send-email-artagnon@gmail.com> <1305100822-20470-6-git-send-email-artagnon@gmail.com> <20110511120654.GF2676@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 13 12:07:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKpHP-0006Oi-CT
	for gcvg-git-2@lo.gmane.org; Fri, 13 May 2011 12:07:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757197Ab1EMKH0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 May 2011 06:07:26 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:2449 "EHLO
	smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753594Ab1EMKHZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2011 06:07:25 -0400
X-IronPort-AV: E=Sophos;i="4.64,363,1301875200"; 
   d="scan'208";a="79579466"
Received: from smtp-in-9002.sea19.amazon.com ([10.186.174.20])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 13 May 2011 10:07:24 +0000
Received: from ramkum.desktop.amazon.com (ramkum.desktop.amazon.com [172.25.205.64])
	by smtp-in-9002.sea19.amazon.com (8.13.8/8.13.8) with ESMTP id p4DA7MVX030919;
	Fri, 13 May 2011 10:07:22 GMT
Received: by ramkum.desktop.amazon.com (Postfix, from userid 272482)
	id 709DF75483F; Fri, 13 May 2011 15:37:16 +0530 (IST)
Content-Disposition: inline
In-Reply-To: <20110511120654.GF2676@elie>
User-Agent: Mutt/1.4.2.2i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173521>

Hi,

Jonathan Nieder writes:
> Ramkumar Ramachandra wrote:
> 
> > Earlier, incompatible command-line options used to be caught in
> > pick_commits after parse_args has parsed the options and populated the
> > options structure; a lot of unncessary work has already been done, and
> > significant amount of cleanup is required to die at this stage.
> > Instead, hand over this responsibility to parse_args so that the
> > program can die early.
> 
> Looking at the patch, this seems like a bugfix (error messages
> currently say "cherry-pick: " when they should sometimes say
> "revert: ") and cleanup (dealing with options incompatible with "--ff"
> in a loop instead of one by one) in addition to the "check and die
> early" improvement you explain above.

Ok, I'll reword.

> > --- a/builtin/revert.c
> > +++ b/builtin/revert.c
> > @@ -80,10 +80,29 @@ static int option_parse_x(const struct option *opt,
> >  	return 0;
> >  }
> >  
> > +static void die_opt_incompatible(const char *me, const char *base_opt, ...)
> > +{
> > +	const char *this_opt;
> > +	int this_opt_set;
> > +	va_list ap;
> > +
> > +	va_start(ap, base_opt);
> > +	while (1) {
> > +		if (!(this_opt = va_arg(ap, const char *)))
> > +			break;
> > +		if ((this_opt_set = va_arg(ap, int)))
> > +			die(_("%s: %s cannot be used with %s"),
> > +				me, this_opt, base_opt);
> > +	}
> > +	va_end(ap);
> > +}
> 
> Wait a second --- this doesn't always die!  Why is it called
> die_opt_incompatible rather than verify_opt_compatible_or_die or
> something?
> 
> I think I would have written the loop something like
> 
> 	va_start(ap, opt1);
> 	while ((opt2 = va_arg(ap, const char *))) {
> 		int set = va_arg(ap, int);
> 		if (set)
> 			die(opt1 cannot be used with opt2);
> 	}
> 	va_end(ap);
> 
> Thanks.  The refactoring into a loop is nice.

Thanks.  Looks like this patch is mostly right too :)

-- Ram
