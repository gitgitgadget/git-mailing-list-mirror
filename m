From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/5] check-ignore: allow incremental streaming of queries
 via --stdin
Date: Thu, 11 Apr 2013 01:31:45 -0400
Message-ID: <20130411053145.GB28915@sigill.intra.peff.net>
References: <20130408181311.GA14903@pacific.linksys.moosehall>
 <1365645575-11428-1-git-send-email-git@adamspiers.org>
 <1365645575-11428-2-git-send-email-git@adamspiers.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git list <git@vger.kernel.org>
To: Adam Spiers <git@adamspiers.org>
X-From: git-owner@vger.kernel.org Thu Apr 11 07:32:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQA77-0006gJ-0r
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 07:32:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752062Ab3DKFbx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Apr 2013 01:31:53 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:39742 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750887Ab3DKFbw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Apr 2013 01:31:52 -0400
Received: (qmail 12012 invoked by uid 107); 11 Apr 2013 05:33:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 11 Apr 2013 01:33:44 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 11 Apr 2013 01:31:45 -0400
Content-Disposition: inline
In-Reply-To: <1365645575-11428-2-git-send-email-git@adamspiers.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220823>

On Thu, Apr 11, 2013 at 02:59:32AM +0100, Adam Spiers wrote:

> @@ -111,14 +110,11 @@ static int check_ignore_stdin_paths(struct path_exclude_check check, const char
>  				die("line is badly quoted");
>  			strbuf_swap(&buf, &nbuf);
>  		}
> -		ALLOC_GROW(pathspec, nr + 1, alloc);
> -		pathspec[nr] = xcalloc(strlen(buf.buf) + 1, sizeof(*buf.buf));
> -		strcpy(pathspec[nr++], buf.buf);
> +		pathspec[0] = xcalloc(strlen(buf.buf) + 1, sizeof(*buf.buf));
> +		strcpy(pathspec[0], buf.buf);
> +		num_ignored += check_ignore(check, prefix, (const char **)pathspec);
> +		maybe_flush_or_die(stdout, "check-ignore to stdout");

Now that you are not storing the whole pathspec at once, the pathspec
buffer only needs to be valid for the length of check_ignore, right?
That means you can drop this extra copy and just pass in buf.buf:

  pathspec[0] = buf.buf;
  num_ignored += check_ignore(check, prefix, pathspec);

> +test_expect_success 'setup: have stdbuf?' '
> +	if which stdbuf >/dev/null 2>&1
> +	then
> +		test_set_prereq STDBUF
> +	fi
> +'

Hmm. Today I learned about stdbuf. :)

-Peff
