From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH 2/2] daemon: report permission denied error to clients
Date: Mon, 17 Oct 2011 21:48:21 +0200
Message-ID: <20111017194821.GA29479@ecki>
References: <20111014211921.GB16429@sigill.intra.peff.net>
 <1318803076-4229-1-git-send-email-drizzd@aon.at>
 <1318803076-4229-2-git-send-email-drizzd@aon.at>
 <20111017020912.GB18536@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Oct 17 21:47:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFtAD-0001XH-Ha
	for gcvg-git-2@lo.gmane.org; Mon, 17 Oct 2011 21:47:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753847Ab1JQTrx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Oct 2011 15:47:53 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:1176 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753802Ab1JQTrw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Oct 2011 15:47:52 -0400
Received: from localhost (p5B22F233.dip.t-dialin.net [91.34.242.51])
	by bsmtp.bon.at (Postfix) with ESMTP id A9C87130053;
	Mon, 17 Oct 2011 21:47:42 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20111017020912.GB18536@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183813>

On Sun, Oct 16, 2011 at 10:09:12PM -0400, Jeff King wrote:
> On Mon, Oct 17, 2011 at 12:11:16AM +0200, Clemens Buchacher wrote:
> 
> > If passed an inaccessible url, git daemon returns the
> > following error:
> > 
> >  $ git clone git://host/repo
> >  fatal: remote error: no such repository: /repo
> > 
> > In case of a permission denied error, return the following
> > instead:
> > 
> >  fatal: remote error: permission denied: /repo
> > 
> > Signed-off-by: Clemens Buchacher <drizzd@aon.at>
> > ---
> 
> I like the intent. This actually does leak a little more information
> than the existing --informative-errors, as before you couldn't tell the
> difference between "not found" and "not exported".

I think you mean that before, you couldn't tell the difference
between "not found" and "permission denied".

> > -static char *path_ok(char *directory)
> > +static int path_ok(char *directory, const char **return_path)
> >  {
> >  	static char rpath[PATH_MAX];
> >  	static char interp_path[PATH_MAX];
> > @@ -120,13 +120,13 @@ static char *path_ok(char *directory)
> >  
> >  	if (daemon_avoid_alias(dir)) {
> >  		logerror("'%s': aliased", dir);
> > -		return NULL;
> > +		return -1;
> >  	}
> >  
> >  	if (*dir == '~') {
> >  		if (!user_path) {
> >  			logerror("'%s': User-path not allowed", dir);
> > -			return NULL;
> > +			return EACCES;
> 
> The new calling conventions for this function seem a little weird.  I
> would expect either "return negative, and set errno" for usual library
> code, or possibly "return negative error value". But "return -1, or a
> positive error code" seems unusual to me.

Yes indeed, will fix.

Clemens
