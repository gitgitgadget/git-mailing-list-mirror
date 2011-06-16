From: Jeff King <peff@github.com>
Subject: Re: [PATCH 2/7] archive: add user-configurable tar-filter
 infrastructure
Date: Wed, 15 Jun 2011 20:29:59 -0400
Message-ID: <20110616002959.GA20355@sigill.intra.peff.net>
References: <20110615223030.GA16110@sigill.intra.peff.net>
 <20110615223301.GB16807@sigill.intra.peff.net>
 <7vr56uisaa.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	"J.H." <warthog19@eaglescrag.net>, git@vger.kernel.org,
	git-dev@github.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 16 02:30:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QX0TL-0006Cl-L0
	for gcvg-git-2@lo.gmane.org; Thu, 16 Jun 2011 02:30:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754424Ab1FPAaE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jun 2011 20:30:04 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:48103
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752590Ab1FPAaD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jun 2011 20:30:03 -0400
Received: (qmail 8769 invoked by uid 107); 16 Jun 2011 00:30:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 15 Jun 2011 20:30:12 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 15 Jun 2011 20:29:59 -0400
Content-Disposition: inline
In-Reply-To: <7vr56uisaa.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175875>

On Wed, Jun 15, 2011 at 04:33:33PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Archive supports two output formats: tar and zip. The tar
> > ...
> > +static struct tar_filter *tar_filter_by_namelen(const char *name,
> > +						int len)
> > +{
> > +	struct tar_filter *p;
> > +	for (p = tar_filters; p; p = p->next)
> > +		if (!strncmp(p->name, name, len) && !p->name[len])
> > +			return p;
> > +	return NULL;
> > +}
> 
> Makes me wonder if we want to have a generic table that is keyed by name
> whose contents can be looked up by counted string. string_list is the
> closest thing we already have, but I do not think it has counted string
> interface (shouldn't be a rocket surgery to add it, though).

I don't know that it would actually make this code significantly clearer
or more efficient. If it were a sorted array, one could do a binary
search, but we are really talking about a handful of elements (if you
did want to refactor, this is almost identical to the matching code in
userdiff, too).

> > +static int tar_filter_config(const char *var, const char *value, void *data)
> > +{
> > ...
> > +	if (!strcmp(type, "command")) {
> > +		if (!value)
> > +			return config_error_nonbool(var);
> > +		tf->command = xstrdup(value);
> 
> Does this result in small leak if the same filter is multiply defined, say
> in /etc/gitconfig and then in ~/.gitconfig?

Yeah, it does. My original version had the builtin gzip statically
allocated, and it wasn't safe to free() anything. But I ended up having
to allocate it dynamically anyway because of the variable-sized list of
extensions, so it would be safe to free(tf->command) here. I'll do that
in my re-roll.

> > +struct tar_filter {
> > +	char *name;
> > +	char *command;
> > +	struct string_list extensions;
> > +	unsigned use_compression:1;
> 
> I suspect that you plan to pass sprintf("-%d", level) for the ones marked
> with this bit, but I wonder if we want to give a bit more control on how a
> compression level option is shaped for the particular command, and where
> on the command line the option comes.  As long as we are targetting gzip
> and nothing else it is fine, and I suspect newer compression commands
> would try to mimic the -[0-9] command line interface gzip has (e.g. xz),
> so this probably is not an issue in practice.

Yeah, I assumed everyone who would want this would support -[0-9]. After
all, all the flag is doing is passing -[0-9] that was supplied to
git-archive. We could allow something like:

  [tarfilter "gzip"]
    command = gzip %(compression)

but I don't see much point. Either you want it or you don't. If there is
a complex mapping of those numbers to some other options in your
command, then point git to a helper script which does the conversion
and then execs your command.

If somebody has a counterexample, I'd be curious to hear it.

-Peff
