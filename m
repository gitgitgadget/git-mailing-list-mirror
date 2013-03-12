From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: [PATCH v2 4/4] teach config parsing to read from strbuf
Date: Tue, 12 Mar 2013 17:42:54 +0100
Message-ID: <20130312164254.GB4752@sandbox-ub.fritz.box>
References: <20130310165642.GA1136@sandbox-ub.fritz.box>
 <20130310170052.GE1136@sandbox-ub.fritz.box>
 <20130312111806.GF11340@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jens Lehmann <jens.lehmann@web.de>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 12 17:43:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFSIW-0007y8-4h
	for gcvg-git-2@plane.gmane.org; Tue, 12 Mar 2013 17:43:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932643Ab3CLQnE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Mar 2013 12:43:04 -0400
Received: from smtprelay01.ispgateway.de ([80.67.31.28]:52193 "EHLO
	smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932065Ab3CLQnD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Mar 2013 12:43:03 -0400
Received: from [77.21.76.82] (helo=localhost)
	by smtprelay01.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1UFSHu-0007mS-Ow; Tue, 12 Mar 2013 17:42:54 +0100
Content-Disposition: inline
In-Reply-To: <20130312111806.GF11340@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217975>

On Tue, Mar 12, 2013 at 07:18:06AM -0400, Jeff King wrote:
> On Sun, Mar 10, 2013 at 06:00:52PM +0100, Heiko Voigt wrote:
> 
> > This can be used to read configuration values directly from gits
> > database.
> > 
> > Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
> 
> This is lacking motivation. IIRC, the rest of the story is something
> like "...so we can read .gitmodules directly from the repo" or something
> like that?

Will add some more here.

> > +struct config_strbuf {
> > +	struct strbuf *strbuf;
> > +	int pos;
> > +};
> >
> > +static int config_strbuf_fgetc(struct config_source *conf)
> > +{
> > +	struct config_strbuf *str = conf->data;
> 
> Yuck. If you used a union in the previous patch, then this could just go
> inline into the "struct config_source".
> 
> > +int git_config_from_strbuf(config_fn_t fn, const char *name, struct strbuf *strbuf, void *data)
> 
> Should this be a "const struct strbuf *strbuf"? For that matter, is
> there any reason not to take a bare pointer/len combination? It seems
> likely that callers would get the data from read_sha1_file, which means
> they have to stuff it into a strbuf for no good reason.

pointer/len should be fine too. I just used strbuf since when you find
out later that you need to modify the string its easier to handle. A
config parser should not need to do that so I will change that.

> > diff --git a/test-config.c b/test-config.c
> > new file mode 100644
> > index 0000000..c650837
> > --- /dev/null
> > +++ b/test-config.c
> > @@ -0,0 +1,40 @@
> 
> I'm slightly "meh" on this test-config program.  Having to add a C test
> harness like this is a good indication that we are short-changing users
> of the shell API in favor of builtin C code.

I mainly did this because I needed some test for the config part while
developing the "fetch renamed submodules" series.

> Your series does not actually add any callers of the new function. The
> obvious "patch 5/4" would be to plumb it into "git config --blob", and
> then we can just directly test it there (there could be other callers
> besides reading from a blob, of course, but I think the point of the
> series is to head in that direction).

Since this is a split of the series mentioned above there are no real
callers yet. The main reason for the split was that I wanted to reduce
the review burden of one big series into multiple reviews of smaller
chunks. If you think it is useful to add the --blob option I can also
test from there. It could actually be useful to look at certain
.gitmodules options from the submodule script.

Cheers Heiko
