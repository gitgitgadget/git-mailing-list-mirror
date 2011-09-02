From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv2 1/2] remote: write correct fetch spec when renaming
 remote 'remote'
Date: Fri, 2 Sep 2011 12:03:33 -0400
Message-ID: <20110902160333.GB19690@sigill.intra.peff.net>
References: <1314924634-12235-1-git-send-email-martin.von.zweigbergk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 02 18:03:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QzWDV-0007mk-KN
	for gcvg-git-2@lo.gmane.org; Fri, 02 Sep 2011 18:03:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753260Ab1IBQDg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Sep 2011 12:03:36 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:52597
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753154Ab1IBQDf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Sep 2011 12:03:35 -0400
Received: (qmail 31570 invoked by uid 107); 2 Sep 2011 16:04:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 02 Sep 2011 12:04:22 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 02 Sep 2011 12:03:33 -0400
Content-Disposition: inline
In-Reply-To: <1314924634-12235-1-git-send-email-martin.von.zweigbergk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180617>

On Thu, Sep 01, 2011 at 08:50:33PM -0400, Martin von Zweigbergk wrote:

> +	strbuf_addf(&old_remote_context, ":refs/remotes/%s/", rename.old);
>  	for (i = 0; i < oldremote->fetch_refspec_nr; i++) {
>  		char *ptr;
>  
>  		strbuf_reset(&buf2);
>  		strbuf_addstr(&buf2, oldremote->fetch_refspec[i]);
> -		ptr = strstr(buf2.buf, rename.old);
> +		ptr = strstr(buf2.buf, old_remote_context.buf);
>  		if (ptr)
> -			strbuf_splice(&buf2, ptr-buf2.buf, strlen(rename.old),
> -					rename.new, strlen(rename.new));
> +			strbuf_splice(&buf2,
> +				      ptr-buf2.buf + strlen(":refs/remotes/"),
> +				      strlen(rename.old), rename.new,
> +				      strlen(rename.new));
>  		if (git_config_set_multivar(buf.buf, buf2.buf, "^$", 0))
>  			return error("Could not append '%s'", buf.buf);

If we find a refspec that does not match this pattern, what should we
do? This code silently ignores it.

At the very least, I'd like to see a warning indicating that one or more
fetch refspecs were not rewritten, and that the user should update the
config manually.

What should happen if there are multiple refspecs, and one doesn't
match? Should we rewrite the ones we can, or should we abort and not
rewrite anything at all? I think the latter is probably less confusing.

These are corner cases, obviously, and most people will just have the
stock refspecs or something that follows their pattern.

-Peff
