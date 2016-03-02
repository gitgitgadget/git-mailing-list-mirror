From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 06/10] setup: refactor repo format reading and
 verification
Date: Tue, 1 Mar 2016 21:51:44 -0500
Message-ID: <20160302025143.GB20625@sigill.intra.peff.net>
References: <20160301143546.GA30806@sigill.intra.peff.net>
 <20160301144206.GF12887@sigill.intra.peff.net>
 <1456867206.18017.94.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git mailing list <git@vger.kernel.org>, mhagger@alum.mit.edu,
	Duy Nguyen <pclouds@gmail.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Wed Mar 02 03:51:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aawtD-0006Xl-4q
	for gcvg-git-2@plane.gmane.org; Wed, 02 Mar 2016 03:51:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752443AbcCBCvr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2016 21:51:47 -0500
Received: from cloud.peff.net ([50.56.180.127]:52938 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752295AbcCBCvr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2016 21:51:47 -0500
Received: (qmail 28302 invoked by uid 102); 2 Mar 2016 02:51:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 01 Mar 2016 21:51:46 -0500
Received: (qmail 19397 invoked by uid 107); 2 Mar 2016 02:51:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 01 Mar 2016 21:51:57 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 01 Mar 2016 21:51:44 -0500
Content-Disposition: inline
In-Reply-To: <1456867206.18017.94.camel@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288093>

On Tue, Mar 01, 2016 at 04:20:06PM -0500, David Turner wrote:

> On Tue, 2016-03-01 at 09:42 -0500, Jeff King wrote:
> > +/*
> > + * Read the repository format characteristics from the config file
> > "path". If
> > + * the version cannot be extracted from the file for any reason, the
> > version
> > + * field will be set to -1, and all other fields are undefined.
> > + */
> > +void read_repository_format(struct repository_format *format, const
> > char *path);
> 
> Generally speaking, I don't care for this interface; I would prefer to
> return -1 and not change the struct.  But I see why it's maybe simpler
> in this one case.

Yeah, I waffled on it. The main reason was simply that the existing code
it's replacing generally wanted to have a stateful return, do some
cleanup, and then check "did we get a version?".

It would be easy to provide both (which matches the redundancy of
nongit_ok).

> > + * Internally, we need to swap out "fn" here, but we don't want to
> > expose
> > + * that to the world. Hence a wrapper around this internal function.
> > + */
> 
> I don't understand this comment.  fn is not being swapped out -- it's
> being passed on directly.

I meant that internally to setup.c, we need to call with different
variants of "fn", but that is an ugly interface we don't need to expose
outside the file. And further on in the series, we clean that up, and
can drop this internal interface. Maybe it's not even worth commenting
on (or commenting on in the commit message only).

> > +static void read_repository_format_1(struct repository_format
> > *format,
> > +				     config_fn_t fn, const char
> > *path)
> 
> The argument order here is different from git_config_from_file -- is
> that for a reason?

Only that I consider this to be a more object-oriented interface (akin
to strbuf, argv_array, etc), with "struct repository_format" as the
"this" object.  We usually put that argument first.

> > +	if (format->version >= 1 && format->unknown_extensions.nr) {
> > +		int i;
> > +
> > +		for (i = 0; i < format->unknown_extensions.nr; i++)
> > +			strbuf_addf(err, "unknown repository
> > extension: %s",
> > +				    format
> > ->unknown_extensions.items[i].string);
> 
> newline here or something?  Otherwise multiple unknown extensions will
> get jammed together.

Thanks, I blindly replaced warning(), which handles the newline. I'll
double-check the other conversions to sure we handle newlines there,
too.

-Peff
