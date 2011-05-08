From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 05/11] revert: Catch incompatible command-line options early
Date: Sun, 8 May 2011 17:17:51 +0530
Message-ID: <20110508114749.GA3114@ramkum.desktop.amazon.com>
References: <1302448317-32387-1-git-send-email-artagnon@gmail.com> <1302448317-32387-6-git-send-email-artagnon@gmail.com> <7vfwpotqdx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 08 13:48:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJ2TD-0007be-AB
	for gcvg-git-2@lo.gmane.org; Sun, 08 May 2011 13:48:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751187Ab1EHLr6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 May 2011 07:47:58 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:43615 "EHLO
	smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750949Ab1EHLr6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2011 07:47:58 -0400
X-IronPort-AV: E=Sophos;i="4.64,334,1301875200"; 
   d="scan'208";a="695338687"
Received: from smtp-in-0191.sea3.amazon.com ([10.224.12.28])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 08 May 2011 11:47:57 +0000
Received: from ramkum.desktop.amazon.com (ramkum.desktop.amazon.com [172.25.205.64])
	by smtp-in-0191.sea3.amazon.com (8.13.8/8.13.8) with ESMTP id p48BltpA024496;
	Sun, 8 May 2011 11:47:56 GMT
Received: by ramkum.desktop.amazon.com (Postfix, from userid 272482)
	id BA9C8754824; Sun,  8 May 2011 17:17:51 +0530 (IST)
Content-Disposition: inline
In-Reply-To: <7vfwpotqdx.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.4.2.2i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173094>

Hi Junio,

Junio C Hamano writes:
> Ramkumar Ramachandra <artagnon@gmail.com> writes:
> > @@ -112,6 +130,13 @@ static void parse_args(int argc, const char **argv)
> >  	if (cmd_opts.commit_argc < 2)
> >  		usage_with_options(usage_str, options);
> >  
> > +	if (cmd_opts.allow_ff) {
> > +		int opt_bitarray[] = {cmd_opts.signoff, cmd_opts.no_commit,
> > +				      cmd_opts.no_replay, cmd_opts.edit};
> > +		die_opt_incompatible(me, "--ff", 4, opt_bitarray, "--signoff",
> > +				"--no-commit", "-x", "--edit");
> > +	}
> 
> Why not do it like this instead?
> 
> 	struct incompatible {
>         	unsigned option_bit;
>                 const char *option_name;
> 	} incompatible[] = {
> 		{ opts->signoff, "--signoff" },
>                 { opts->no_commit, "--no-commit" },
>                 ...
> 	};
> 	verify_compatible("me", "--ff", incompatible, ARRAY_SIZE(incompatible));
> 
> Or if you are shooting for ease-of-use, it might make sense to do it like
> this:
> 
> 	verify_compatible("me", "--ff",
>         		"--signoff", opts->signoff,
>                         "--no-commit", opts->no_commit,
>                         ...
>                         NULL);
> 
> and make verify_compatible() a varargs function that takes two optional
> arguments at a time, i.e. const char *, followed by an int.  Then there is
> no need for extra "int opt_bitarray[]" or "struct incompatible".
> 
> That would justify use of varargs, I think.

Now that you point it out, my original approach was unnecessarily
cryptic and convoluted.  I've followed this approach in my new series,
and kept varargs -- the code looks much prettier now.  Thanks :)

I can't justify changing the name from "die_opt_incompatible" to
"verify_compatible" though; the name I've chosen seems to be more
appropriate/ descriptive.  Further, I think command-line parsing
should always be the toplevel caller, and "die" is therefore more
appropriate than "return error" here.

-- Ram
