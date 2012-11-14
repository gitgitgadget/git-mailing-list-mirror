From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/6] var: accept multiple variables on the command line
Date: Wed, 14 Nov 2012 11:26:02 -0800
Message-ID: <20121114192602.GC3860@sigill.intra.peff.net>
References: <20121113164845.GD20361@sigill.intra.peff.net>
 <20121113165247.GC12626@sigill.intra.peff.net>
 <20121114170148.GB6858@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Thomas Rast <trast@student.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 14 20:26:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYibQ-0001dn-Bp
	for gcvg-git-2@plane.gmane.org; Wed, 14 Nov 2012 20:26:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423358Ab2KNT0H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2012 14:26:07 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:48569 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423233Ab2KNT0F (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2012 14:26:05 -0500
Received: (qmail 5759 invoked by uid 107); 14 Nov 2012 19:26:53 -0000
Received: from 204-16-157-26-static.ipnetworksinc.net (HELO sigill.intra.peff.net) (204.16.157.26)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 14 Nov 2012 14:26:53 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Nov 2012 11:26:02 -0800
Content-Disposition: inline
In-Reply-To: <20121114170148.GB6858@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209742>

On Wed, Nov 14, 2012 at 09:01:48AM -0800, Jonathan Nieder wrote:

> >  DESCRIPTION
> >  -----------
> > -Prints a git logical variable.
> > +Prints one or more git logical variables, separated by newlines.
> > +
> > +Note that some variables may contain newlines themselves
> 
> Maybe a -z option to NUL-terminate values would be useful some day.

Yeah, I thought about that but stopped short. The intended caller in my
series is Git.pm, whose command() splits on newlines. Although it is
perl...I suspect doing:

  local $/ = "\0";
  my @entries = command(...);

would work. For ident variables, we know they don't contain a newline,
though.

> > --- a/builtin/var.c
> > +++ b/builtin/var.c
> > @@ -73,8 +73,7 @@ static int show_config(const char *var, const char *value, void *cb)
> >  
> >  int cmd_var(int argc, const char **argv, const char *prefix)
> >  {
> > -	const char *val = NULL;
> > -	if (argc != 2)
> > +	if (argc < 2)
> >  		usage(var_usage);
> >  
> >  	if (strcmp(argv[1], "-l") == 0) {
> 
> What should happen if I pass "-l" followed by other arguments?

Good catch. Probably we should just call usage() once we see "-l"
and (argc > 2), which matches the previous behavior. I don't see much
point in listing specific variables after having listed them all.

I was also tempted to convert to parse_options, but I don't think that
really buys us anything (we could detect the option in "git var foo -l
bar", but since we are not going to do anything useful in such a case,
there is not much point).

> > +	test_tick &&
> > +	echo "A U Thor <author@example.com> 1112911993 -0700" >expect &&
> 
> Do we need to hardcode the timestamp?  Something like
> 
> 	test_cmp_filtered () {
> 		expect=$1 actual=$2 &&
> 		sed -e 's/[0-9][0-9]* [-+][0-9][0-9][0-9][0-9]/TIMESTAMP" \
> 			<"$actual" >"$actual.filtered" &&
> 		test_cmp "$expect" "$actual.filtered"
> 	}

No, we don't have to. I was just hoping to keep the tests simple by not
doing any parsing trickery. The test_tick keeps it stable, but as you
note, it is not robust to reordering. I think it would be sufficient to
just put $GIT_COMMITTER_DATE into the expected output.

I'll fix both in a re-roll.

Thanks.

-Peff
