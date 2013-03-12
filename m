From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: [PATCH v2 1/4] config: factor out config file stack management
Date: Tue, 12 Mar 2013 16:44:35 +0100
Message-ID: <20130312154434.GB3021@sandbox-ub.fritz.box>
References: <20130310165642.GA1136@sandbox-ub.fritz.box>
 <20130310165752.GB1136@sandbox-ub.fritz.box>
 <20130312105200.GC11340@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jens Lehmann <jens.lehmann@web.de>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 12 16:45:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFRO3-0008Dy-KE
	for gcvg-git-2@plane.gmane.org; Tue, 12 Mar 2013 16:45:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932962Ab3CLPoo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Mar 2013 11:44:44 -0400
Received: from smtprelay04.ispgateway.de ([80.67.31.38]:47520 "EHLO
	smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932356Ab3CLPon (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Mar 2013 11:44:43 -0400
Received: from [77.21.76.82] (helo=localhost)
	by smtprelay04.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1UFRNT-000571-Oa; Tue, 12 Mar 2013 16:44:35 +0100
Content-Disposition: inline
In-Reply-To: <20130312105200.GC11340@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217968>

On Tue, Mar 12, 2013 at 06:52:00AM -0400, Jeff King wrote:
> On Sun, Mar 10, 2013 at 05:57:53PM +0100, Heiko Voigt wrote:
> 
> > Because a config callback may start parsing a new file, the
> > global context regarding the current config file is stored
> > as a stack. Currently we only need to manage that stack from
> > git_config_from_file. Let's factor it out to allow new
> > sources of config data.
> >
> > [...]
> >
> > +static int do_config_from(struct config_file *top, config_fn_t fn, void *data)
> > +{
> > +	int ret;
> > +
> > +	/* push config-file parsing state stack */
> > +	top->prev = cf;
> > +	top->linenr = 1;
> > +	top->eof = 0;
> > +	strbuf_init(&top->value, 1024);
> > +	strbuf_init(&top->var, 1024);
> > +	cf = top;
> > +
> > +	ret = git_parse_file(fn, data);
> > +
> > +	/* pop config-file parsing state stack */
> > +	strbuf_release(&top->value);
> > +	strbuf_release(&top->var);
> > +	cf = top->prev;
> > +
> > +	return ret;
> > +}
> 
> Can we throw in a comment at the top here with the expected usage? In
> particular, do_config_from is expecting the caller to have filled in
> certain fields (at this point, top->f and top->name), but there is
> nothing to make that clear.

Of course. Will do that in the next iteration. How about I squash this in:

diff --git a/config.c b/config.c
index b8c8640..b7632c9 100644
--- a/config.c
+++ b/config.c
@@ -948,6 +954,9 @@ int git_default_config(const char *var, const char *value, v
        return 0;
 }
 
+/* The fields data, name and the source specific callbacks of top need
+ * to be initialized before calling this function.
+ */
 static int do_config_from_source(struct config_source *top, config_fn_t fn, voi
 {
        int ret;


I would add that to the third patch:

	config: make parsing stack struct independent from actual data source

because that contains the final modification to config_file/config_source.

Cheers Heiko
