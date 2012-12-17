From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Pretty formats: skip color codes if !want_color()
Date: Mon, 17 Dec 2012 18:10:42 -0500
Message-ID: <20121217231042.GB1809@sigill.intra.peff.net>
References: <20121217225703.GC25103@orenhe-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Oren Held <oren@held.org.il>
X-From: git-owner@vger.kernel.org Tue Dec 18 00:11:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tkjpv-0004rI-2G
	for gcvg-git-2@plane.gmane.org; Tue, 18 Dec 2012 00:11:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752759Ab2LQXKp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2012 18:10:45 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:57125 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751192Ab2LQXKo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2012 18:10:44 -0500
Received: (qmail 11167 invoked by uid 107); 17 Dec 2012 23:11:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 17 Dec 2012 18:11:48 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 17 Dec 2012 18:10:42 -0500
Content-Disposition: inline
In-Reply-To: <20121217225703.GC25103@orenhe-laptop>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211719>

On Tue, Dec 18, 2012 at 12:57:03AM +0200, Oren Held wrote:

> Avoid color escape codes if colors are disabled, just like the
> behavior of other git commands.  This solves the case of color escape
> codes in stdout when piping or redirecting, e.g.: $ git log
> --format=%Cred%h > out

You may be interested in this thread from today, which is attacking the
same problem:

  http://thread.gmane.org/gmane.comp.version-control.git/211370/focus=211714

Two issues with your patch:

> @@ -956,6 +962,8 @@ static size_t format_commit_one(struct strbuf *sb, const char *placeholder,
>  	struct commit_list *p;
>  	int h1, h2;
>  
> +	int colors_enabled = want_color(GIT_COLOR_UNKNOWN);
> +

I think this would want to use the regular diff color variable to be
consistent with other coloring of "git log".

> @@ -967,20 +975,20 @@ static size_t format_commit_one(struct strbuf *sb, const char *placeholder,
>  			color_parse_mem(placeholder + 2,
>  					end - (placeholder + 2),
>  					"--pretty format", color);
> -			strbuf_addstr(sb, color);
> +			conditional_strbuf_addstr(colors_enabled, sb, color);
>  			return end - placeholder + 1;
>  		}

This breaks backwards compatibility for callers who expect the coloring
to be unconditional; adding new syntax would solve that.

The patch I linked to above solves both.

-Peff
