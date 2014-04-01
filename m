From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 12/22] delete_ref_loose(): don't muck around in the
 lock_file's filename
Date: Tue, 1 Apr 2014 16:21:18 -0400
Message-ID: <20140401202118.GG21715@sigill.intra.peff.net>
References: <1396367910-7299-1-git-send-email-mhagger@alum.mit.edu>
 <1396367910-7299-13-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Apr 01 22:21:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WV5BW-0002Mi-1w
	for gcvg-git-2@plane.gmane.org; Tue, 01 Apr 2014 22:21:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751439AbaDAUVV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Apr 2014 16:21:21 -0400
Received: from cloud.peff.net ([50.56.180.127]:52064 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751351AbaDAUVU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Apr 2014 16:21:20 -0400
Received: (qmail 22330 invoked by uid 102); 1 Apr 2014 20:21:20 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 01 Apr 2014 15:21:20 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 01 Apr 2014 16:21:18 -0400
Content-Disposition: inline
In-Reply-To: <1396367910-7299-13-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245654>

On Tue, Apr 01, 2014 at 05:58:20PM +0200, Michael Haggerty wrote:

> It's bad manners.  Especially since, if unlink_or_warn() failed, the
> memory wasn't restored to its original contents.
> 
> So make our own copy to work with.

Sounds good...

>  	if (!(flag & REF_ISPACKED) || flag & REF_ISSYMREF) {
> -		/* loose */
> -		int err, i = strlen(lock->lk->filename) - 5; /* .lock */
> -
> -		lock->lk->filename[i] = 0;
> -		err = unlink_or_warn(lock->lk->filename);
> -		lock->lk->filename[i] = '.';
> +		/*
> +		 * loose.  The loose file name is the same as the
> +		 * lockfile name, minus ".lock":
> +		 */
> +		char *loose_filename = xmemdupz(lock->lk->filename,
> +						strlen(lock->lk->filename) - 5);
> +		int err = unlink_or_warn(loose_filename);
> +		free(loose_filename);

Should we be using LOCK_SUFFIX_LEN from the previous commit here?

-Peff
