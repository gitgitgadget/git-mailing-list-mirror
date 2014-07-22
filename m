From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 6/6] notes-util.c: replace `git_config()` with
 `git_config_get_value()`
Date: Tue, 22 Jul 2014 07:23:11 -0400
Message-ID: <20140722112311.GB386@peff.net>
References: <1405941145-12120-1-git-send-email-tanayabh@gmail.com>
 <1405941145-12120-7-git-send-email-tanayabh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 22 13:23:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X9YAC-0002Ec-Mo
	for gcvg-git-2@plane.gmane.org; Tue, 22 Jul 2014 13:23:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753304AbaGVLXO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2014 07:23:14 -0400
Received: from cloud.peff.net ([50.56.180.127]:38155 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752986AbaGVLXO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2014 07:23:14 -0400
Received: (qmail 25198 invoked by uid 102); 22 Jul 2014 11:23:14 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 22 Jul 2014 06:23:14 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 22 Jul 2014 07:23:11 -0400
Content-Disposition: inline
In-Reply-To: <1405941145-12120-7-git-send-email-tanayabh@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254013>

On Mon, Jul 21, 2014 at 04:12:25AM -0700, Tanay Abhra wrote:

> -static int notes_rewrite_config(const char *k, const char *v, void *cb)
> +static void notes_rewrite_config(struct notes_rewrite_cfg *c)
>  {
> -	struct notes_rewrite_cfg *c = cb;
> -	if (starts_with(k, "notes.rewrite.") && !strcmp(k+14, c->cmd)) {
> -		c->enabled = git_config_bool(k, v);
> -		return 0;
> -	} else if (!c->mode_from_env && !strcmp(k, "notes.rewritemode")) {
> +	const char *v;
> +	struct strbuf key = STRBUF_INIT;
> +	strbuf_addf(&key, "notes.rewrite.%s", c->cmd);
> +	git_config_get_bool(key.buf, &c->enabled);
> +	strbuf_release(&key);

I wonder if it is worth teaching the accessors to form such strings
themselves, like:

  void git_config_get_bool(int *out, const char *fmt, ...);

so you could do:

  git_config_get_bool(&c->enabled, "notes.rewrite.%s", c->cmd);

The "normal" cases where we do not need any run-time modification could
be used as-is (I swapped the parameter order above, but you would not
have to do so). But I guess that would require us doing extra work in
the common "normal" case to print the string into a buffer, even though
it does not have any expansions (or to do a strchr, I guess, to look for
"%").  It's probably not worth it considering how few config keys have
computed values like this.

-Peff
