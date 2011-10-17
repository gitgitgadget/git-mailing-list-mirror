From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] daemon: report permission denied error to clients
Date: Sun, 16 Oct 2011 22:09:12 -0400
Message-ID: <20111017020912.GB18536@sigill.intra.peff.net>
References: <20111014211921.GB16429@sigill.intra.peff.net>
 <1318803076-4229-1-git-send-email-drizzd@aon.at>
 <1318803076-4229-2-git-send-email-drizzd@aon.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Mon Oct 17 04:09:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFcdj-0002LH-Mh
	for gcvg-git-2@lo.gmane.org; Mon, 17 Oct 2011 04:09:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753720Ab1JQCJP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Oct 2011 22:09:15 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:33598
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753636Ab1JQCJP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Oct 2011 22:09:15 -0400
Received: (qmail 1620 invoked by uid 107); 17 Oct 2011 02:09:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 16 Oct 2011 22:09:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 16 Oct 2011 22:09:12 -0400
Content-Disposition: inline
In-Reply-To: <1318803076-4229-2-git-send-email-drizzd@aon.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183751>

On Mon, Oct 17, 2011 at 12:11:16AM +0200, Clemens Buchacher wrote:

> If passed an inaccessible url, git daemon returns the
> following error:
> 
>  $ git clone git://host/repo
>  fatal: remote error: no such repository: /repo
> 
> In case of a permission denied error, return the following
> instead:
> 
>  fatal: remote error: permission denied: /repo
> 
> Signed-off-by: Clemens Buchacher <drizzd@aon.at>
> ---

I like the intent. This actually does leak a little more information
than the existing --informative-errors, as before you couldn't tell the
difference between "not found" and "not exported". But I think the
spirit of --informative-errors is to let that information leak, and this
is a good change.

> -static char *path_ok(char *directory)
> +static int path_ok(char *directory, const char **return_path)
>  {
>  	static char rpath[PATH_MAX];
>  	static char interp_path[PATH_MAX];
> @@ -120,13 +120,13 @@ static char *path_ok(char *directory)
>  
>  	if (daemon_avoid_alias(dir)) {
>  		logerror("'%s': aliased", dir);
> -		return NULL;
> +		return -1;
>  	}
>  
>  	if (*dir == '~') {
>  		if (!user_path) {
>  			logerror("'%s': User-path not allowed", dir);
> -			return NULL;
> +			return EACCES;

The new calling conventions for this function seem a little weird.  I
would expect either "return negative, and set errno" for usual library
code, or possibly "return negative error value". But "return -1, or a
positive error code" seems unusual to me.

One of:

  errno = EACCESS;
  return -1;

or

  return -EACCESS;

would be more idiomatic, I think.

-Peff
