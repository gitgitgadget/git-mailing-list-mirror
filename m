From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Documentation fixes in git-config
Date: Thu, 20 Jan 2011 19:27:16 -0500
Message-ID: <20110121002716.GC9442@sigill.intra.peff.net>
References: <20110108144644.GA11019@localhost.suse.cz>
 <20110111055922.GD10094@sigill.intra.peff.net>
 <20110119100105.GB8034@fm.suse.cz>
 <20110119141401.GE8034@fm.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Libor Pechacek <lpechacek@suse.cz>
X-From: git-owner@vger.kernel.org Fri Jan 21 01:27:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pg4qa-0004T5-Bv
	for gcvg-git-2@lo.gmane.org; Fri, 21 Jan 2011 01:27:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753529Ab1AUA1S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jan 2011 19:27:18 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:45301 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752617Ab1AUA1S (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Jan 2011 19:27:18 -0500
Received: (qmail 15404 invoked by uid 111); 21 Jan 2011 00:27:17 -0000
Received: from 99-189-169-83.lightspeed.snjsca.sbcglobal.net (HELO sigill.intra.peff.net) (99.189.169.83)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Fri, 21 Jan 2011 00:27:17 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Jan 2011 19:27:16 -0500
Content-Disposition: inline
In-Reply-To: <20110119141401.GE8034@fm.suse.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165351>

On Wed, Jan 19, 2011 at 03:14:01PM +0100, Libor Pechacek wrote:

> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index ff7c225..0f23bc7 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -12,8 +12,9 @@ The configuration variables are used by both the git plumbing
>  and the porcelains. The variables are divided into sections, wherein
>  the fully qualified variable name of the variable itself is the last
>  dot-separated segment and the section name is everything before the last
> -dot. The variable names are case-insensitive and only alphanumeric
> -characters are allowed. Some variables may appear multiple times.
> +dot. The variable names are case-insensitive, only alphanumeric
> +characters and '-' are allowed and must start with an alphabetic character.
> +Some variables may appear multiple times.

The intent of the change looks fine, but your sentence doesn't quite
parse to me (to be fair, the problem is in the one you are replacing,
but adding the third clause makes it even more confusing). How about:

  The variables names are case-insensitive, allow only alphanumeric
  characters and '-', and must start with an alphabetic character.

>  --get-regexp::
>  	Like --get-all, but interprets the name as a regular expression.
> -	Also outputs the key names.
> +	Regular expression matching is case sensitive in all parts of the key,
> +	therefore make sure your pattern matches lower case letters in section
> +	and variable names.  Also outputs the key names.

That is only true because of the breakage in your first patch. Without
your patch, both of these work:

  git config --get-regexp 'Foo.*'
  git config --get-regexp 'foo.*'

That being said, the downcasing is extremely naive for regexps, and you
should try to match the canonical name. The current downcasing behavior
should probably stay for historical reasons, but is not well thought-out
(it may even be accidental). Perhaps we should therefore explain it in
those terms:

  Regular expression matching is case-sensitive and done against a
  canonicalized version of the key in which section and variable names
  are lowercased, but subsection names are not. For historical reasons,
  some simple regular expressions are lower-cased before matching
  (everything before the first dot and after the last dot), which makes
  things like "Core.*' work.

I dunno. Maybe we should just declare "Core.*' to be broken, and anybody
who was relying on it is wrong.

-Peff
