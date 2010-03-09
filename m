From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] builtin-add: fix exclude handling
Date: Tue, 9 Mar 2010 17:48:15 -0500
Message-ID: <20100309224815.GB25265@sigill.intra.peff.net>
References: <7vzl2s4fcy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 09 23:48:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Np8Dv-00082Y-PF
	for gcvg-git-2@lo.gmane.org; Tue, 09 Mar 2010 23:48:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753401Ab0CIWsT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Mar 2010 17:48:19 -0500
Received: from peff.net ([208.65.91.99]:36048 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751446Ab0CIWsR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Mar 2010 17:48:17 -0500
Received: (qmail 3499 invoked by uid 107); 9 Mar 2010 22:48:40 -0000
Received: from c-71-206-173-191.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.191)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 09 Mar 2010 17:48:40 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 09 Mar 2010 17:48:15 -0500
Content-Disposition: inline
In-Reply-To: <7vzl2s4fcy.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141852>

On Mon, Mar 01, 2010 at 12:26:37AM -0800, Junio C Hamano wrote:

>  - "git add ignored-pattern.o", i.e. the pathspec exactly matches but is
>    ignored by the traversal.
> 
> For the former, the function immediately errored out.  The latter were
> queued in the dir structure and later used to give an error message with
> "use -f if you really mean it" advice.
> 
> e96980e (builtin-add: simplify (and increase accuracy of) exclude
> handling, 2007-06-12) somehow lost the latter.  This adds the logic back,
> but with a bit of twist, as the code after e96980e uses collect_ignored
> option that does half the necessary work during the traversal.

I'm not sure that logic is accurate. The "increase accuracy" part of
e96980e was about the fact that COLLECT_IGNORED _knows_ something is
ignored, but builtin-add's prune_directory has to just _guess_ about it.

And I think your new code may have similar problems.  Look at the
failing test in t0050 (the one you tweaked in patch 1/3).  Before this
patch, it silently fails to add. Which is a bug, of course, but not this
one. But after this patch, we say "Oh, CamelCase was excluded, use -f,
etc". But that's not true. We are just making a guess after the fact
about why it wasn't included.

Now I am slightly hesitant to use that as an example, because it clearly
was also broken _before_ your patch. So it may be that the behavior it
exhibits (a pathspec not showing up as used, but the file exists and was
_not_ ignored) shouldn't ever happen for other cases.  I'm not sure,
which makes me a little nervous about the change. But I would be willing
to accept "it seems to work, so let's go with it for now and see if
anybody complains" if you want to try that.

But also:

> +		/* Existing file?  We must have ignored it */
> +		if (file_exists(match)) {
> +			int len = strlen(match);
> +			int i;
> +			for (i = 0; i < dir->ignored_nr; i++)
> +				if (dir->ignored[i]->len == len &&
> +				    !memcmp(dir->ignored[i]->name, match, len))
> +					break;
> +			if (dir->ignored_nr <= i)
> +				dir_add_ignored(dir, match, strlen(match));
> +			continue;
> +		}
> +		die("pathspec '%s' did not match any files", match);

Is that memcmp right? If I have something like:

  echo subdir >.gitignore
  git add 'sub*'

shouldn't it also say "Sorry, subdir [or sub*] was ignored"? But it
doesn't actually get added to the exclude list, and we get "pathspec did
not match any files", which is not quite true.

-Peff
