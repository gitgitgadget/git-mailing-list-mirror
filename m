From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] use skip_prefix() to avoid more magic numbers
Date: Sun, 5 Oct 2014 21:18:28 -0400
Message-ID: <20141006011827.GA11027@peff.net>
References: <5430427A.5080800@web.de>
 <20141005224919.GA19998@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 06 03:18:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xawwd-0003uX-5y
	for gcvg-git-2@plane.gmane.org; Mon, 06 Oct 2014 03:18:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752181AbaJFBSb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Oct 2014 21:18:31 -0400
Received: from cloud.peff.net ([50.56.180.127]:55265 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751895AbaJFBSa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Oct 2014 21:18:30 -0400
Received: (qmail 4830 invoked by uid 102); 6 Oct 2014 01:18:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 05 Oct 2014 20:18:30 -0500
Received: (qmail 27923 invoked by uid 107); 6 Oct 2014 01:18:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 05 Oct 2014 21:18:30 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 05 Oct 2014 21:18:28 -0400
Content-Disposition: inline
In-Reply-To: <20141005224919.GA19998@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257905>

On Sun, Oct 05, 2014 at 03:49:19PM -0700, Jonathan Nieder wrote:

> > --- a/builtin/branch.c
> > +++ b/builtin/branch.c
> > @@ -81,14 +81,16 @@ static int parse_branch_color_slot(const char *var, int ofs)
> >  
> >  static int git_branch_config(const char *var, const char *value, void *cb)
> >  {
> > +	const char *slot_name;
> > +
> >  	if (starts_with(var, "column."))
> >  		return git_column_config(var, value, "branch", &colopts);
> >  	if (!strcmp(var, "color.branch")) {
> >  		branch_use_color = git_config_colorbool(var, value);
> >  		return 0;
> >  	}
> > -	if (starts_with(var, "color.branch.")) {
> > -		int slot = parse_branch_color_slot(var, 13);
> > +	if (skip_prefix(var, "color.branch.", &slot_name)) {
> > +		int slot = parse_branch_color_slot(var, slot_name - var);
> 
> I wonder why the separate var and offset parameters exist in the first
> place.  Wouldn't taking a single const char * so the old code could use
> 'var + 13' instead of 'var, 13' have worked?

I think this is in the same boat as parse_diff_color_slot, which I fixed
in 9e1a5eb (parse_diff_color_slot: drop ofs parameter, 2014-06-18). The
short of it is that the function used to want both the full name and the
slot name, but now needs only the latter.

The fix you proposed below is along the same line, and looks good to me
(and grepping for 'var *+ *ofs' shows only the two sites you found, so
hopefully that is the last of it).

> > @@ -809,18 +808,19 @@ static void parse_commit_header(struct format_commit_context *context)
> >  	int i;
> >  
> >  	for (i = 0; msg[i]; i++) {
> > +		const char *name;
> 
> ident instead of name, maybe? (since it's a 'name <email> timestamp'
> field)

Yeah, agreed.

-Peff
