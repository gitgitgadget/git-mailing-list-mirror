From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/6] convert some config callbacks to match_config_key
Date: Mon, 14 Jan 2013 09:06:10 -0800
Message-ID: <20130114170610.GB22098@sigill.intra.peff.net>
References: <20130114145845.GA16497@sigill.intra.peff.net>
 <20130114150322.GC16828@sigill.intra.peff.net>
 <20130114165527.GB3121@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Joachim Schmitz <jojo@schmitz-digital.de>,
	=?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 14 18:06:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TunUe-0001pC-Oe
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jan 2013 18:06:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757602Ab3ANRGS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2013 12:06:18 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:33041 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757601Ab3ANRGO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2013 12:06:14 -0500
Received: (qmail 21312 invoked by uid 107); 14 Jan 2013 17:07:30 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (12.144.179.211)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 14 Jan 2013 12:07:30 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 14 Jan 2013 09:06:10 -0800
Content-Disposition: inline
In-Reply-To: <20130114165527.GB3121@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213501>

On Mon, Jan 14, 2013 at 08:55:28AM -0800, Jonathan Nieder wrote:

> Jeff King wrote:
> 
> > --- a/convert.c
> > +++ b/convert.c
> > @@ -465,10 +465,8 @@ static int read_convert_config(const char *var, const char *value, void *cb)
> >  	 * External conversion drivers are configured using
> >  	 * "filter.<name>.variable".
> >  	 */
> > -	if (prefixcmp(var, "filter.") || (ep = strrchr(var, '.')) == var + 6)
> > +	if (match_config_key(var, "filter", &name, &namelen, &ep) < 0 || !name)
> >  		return 0;
> 
> Hm, I actually find the preimage more readable here.

The big thing to me is getting rid of the manual "6" there, which is bad
for maintainability (it must match the length of "filter", and there is
no compile-time verification).

> Rename match_config_key() to something like parse_config_key()?
> match_ makes it sound like its main purpose is to match it against a
> pattern, but really it is more about decomposing into constituent
> parts.

There is already a git_config_parse_key, but it does something else. I
wanted to avoid confusion there. And I was trying to indicate that this
was not just about parsing, but also about matching the section.
Basically I was trying to encapsulate the current technique and have as
little code change as possible. But maybe:

  struct config_key k;
  parse_config_key(&k, var);
  if (strcmp(k.section, "filter") || k.subsection))
          return 0;

would be a better start (or having git_config do the first two lines
itself before triggering the callback).

> Rename ep to something like 'key' or 'filtertype'?  Without the
> explicit string processing, it is not obvious what ep is the end of.

Ah, so that is what "ep" stands for. I was thinking it is a terrible
variable name, but I was trying to keep the patch minimal.

> > -	if (prefixcmp(var, "diff."))
> > -		return NULL;
> > -	dot = strrchr(var, '.');
> > -	if (dot == var + 4)
> > -		return NULL;
> > -	if (strcmp(type, dot+1))
> > +	if (match_config_key(var, "diff", &name, &namelen, &key) < 0 ||
> > +	    strcmp(type, key))
> >  		return NULL;
> >  
> > -	name = var + 5;
> > -	namelen = dot - name;
> >  	drv = userdiff_find_by_namelen(name, namelen);
> 
> What happens in the !name case?  (Honest question --- I haven't checked.)

Segfault, I expect. Thanks for catching.

I actually wrote this correctly once, coupled with patch 4, but screwed
it up when teasing it apart into two patches. It should be:

  if (match_config_key(var, "diff", &name, &namelen, &key) < 0 ||
      !name ||
      strcmp(type, key))
          return NULL;

Patch 4 replaces this with correct code (as it moves it into
userdiff_config).

-Peff
