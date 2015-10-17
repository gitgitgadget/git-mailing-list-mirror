From: Tobias Klauser <tklauser@distanz.ch>
Subject: Re: [PATCH v2 2/4] stripspace: Use parse-options for command-line
 parsing
Date: Sat, 17 Oct 2015 12:30:32 +0200
Message-ID: <20151017103032.GC2468@distanz.ch>
References: <1445008605-16534-1-git-send-email-tklauser@distanz.ch>
 <1445008605-16534-3-git-send-email-tklauser@distanz.ch>
 <xmqqoafyg2sp.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 17 12:30:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZnOl8-0008Hq-U1
	for gcvg-git-2@plane.gmane.org; Sat, 17 Oct 2015 12:30:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751538AbbJQKah (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Oct 2015 06:30:37 -0400
Received: from sym2.noone.org ([178.63.92.236]:54704 "EHLO sym2.noone.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751086AbbJQKag (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Oct 2015 06:30:36 -0400
Received: by sym2.noone.org (Postfix, from userid 1002)
	id 3ndLGL5pDPzQWhr; Sat, 17 Oct 2015 12:30:34 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <xmqqoafyg2sp.fsf@gitster.mtv.corp.google.com>
X-Editor: Vi IMproved 7.3
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279783>

On 2015-10-16 at 19:07:34 +0200, Junio C Hamano <gitster@pobox.com> wrote:
> Tobias Klauser <tklauser@distanz.ch> writes:
> 
> > Use parse-options to parse command-line options instead of a
> > hand-crafted implementation.
> >
> > This is a preparatory patch to simplify the introduction of the
> > --count-lines option in a follow-up patch.
> 
> The second paragraph is probably of much lessor importance than one
> thing you forgot to mention: the users can now use a unique prefix
> of the option and say "stripspace --comment".

I didn't even know about that feature, but now that you've mentioned it
I will certainly make use of it more in the future :) And of course,
I'll adjust the commit message accordingly for v3.

> > +enum stripspace_mode {
> > +	STRIP_DEFAULT = 0,
> > +	STRIP_COMMENTS,
> > +	COMMENT_LINES
> > +};
> >  
> >  int cmd_stripspace(int argc, const char **argv, const char *prefix)
> >  {
> >  	struct strbuf buf = STRBUF_INIT;
> > -	int strip_comments = 0;
> > -	enum { INVAL = 0, STRIP_SPACE = 1, COMMENT_LINES = 2 } mode = STRIP_SPACE;
> > -
> > -	if (argc == 2) {
> > -		if (!strcmp(argv[1], "-s") ||
> > -		    !strcmp(argv[1], "--strip-comments")) {
> > -			strip_comments = 1;
> > -		} else if (!strcmp(argv[1], "-c") ||
> > -			   !strcmp(argv[1], "--comment-lines")) {
> > -			mode = COMMENT_LINES;
> > -		} else {
> > -			mode = INVAL;
> > -		}
> > -	} else if (argc > 1) {
> > -		mode = INVAL;
> > -	}
> > -
> > -	if (mode == INVAL)
> > -		usage(usage_msg);
> 
> When given "git stripspace -s blorg", we used to set mode to INVAL
> and then showed the correct usage.  But we no longer have a check
> that corresponds to the old INVAL thing, do we?  Perhaps check argc
> to detect presence of an otherwise ignored non-option argument
> immediately after parse_options() returns?

Agreed, we should check it. I'll go with the implementation you
suggested in the follow-up message.

> > -	if (strip_comments || mode == COMMENT_LINES)
> > +	enum stripspace_mode mode = STRIP_DEFAULT;
> > +
> > +	const struct option options[] = {
> > +		OPT_CMDMODE('s', "strip-comments", &mode,
> > +			    N_("skip and remove all lines starting with comment character"),
> > +			    STRIP_COMMENTS),
> > +		OPT_CMDMODE('c', "comment-lines", &mode,
> > +			    N_("prepend comment character and blank to each line"),
> > +			    COMMENT_LINES),
> > +		OPT_END()
> > +	};
> > +
> > +	argc = parse_options(argc, argv, prefix, options, stripspace_usage,
> > +			     PARSE_OPT_KEEP_DASHDASH);
> 
> What is the point of keep-dashdash here?

Likewise, it shouldn't be there as in your follow-up patch.
