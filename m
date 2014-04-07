From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 17/25] commit_lock_file(): make committing an unlocked
 lockfile a NOP
Date: Mon, 7 Apr 2014 15:31:31 -0400
Message-ID: <20140407193131.GC19342@sigill.intra.peff.net>
References: <1396827247-28465-1-git-send-email-mhagger@alum.mit.edu>
 <1396827247-28465-18-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Apr 07 21:31:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WXFGd-0004Gj-ME
	for gcvg-git-2@plane.gmane.org; Mon, 07 Apr 2014 21:31:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755766AbaDGTbf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Apr 2014 15:31:35 -0400
Received: from cloud.peff.net ([50.56.180.127]:55640 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755566AbaDGTbd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Apr 2014 15:31:33 -0400
Received: (qmail 15235 invoked by uid 102); 7 Apr 2014 19:31:33 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 07 Apr 2014 14:31:33 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 07 Apr 2014 15:31:31 -0400
Content-Disposition: inline
In-Reply-To: <1396827247-28465-18-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245893>

On Mon, Apr 07, 2014 at 01:33:59AM +0200, Michael Haggerty wrote:

> It was previously a bug to call commit_lock_file() with a lock_file
> object that was not active (an illegal access would happen within the
> function).  It was presumably never done, but this would be an easy
> programming error to overlook.  So guard the file-renaming code with
> an if statement to change committing an unlocked file into a NOP.
> 
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
> Alternatively, we could make it a fatal error (e.g., an assert() or
> if...die()) to call commit_lock_file() on an unlocked file, or omit a
> warning in this case.  But since it is so hard to test code related to
> locking failures, I have the feeling that such an error is most likely
> to occur in some error-handling path, maybe when some other lockfile
> acquisition has failed, and it would be better to let the code
> continue its attempted cleanup instead of dying.  But it would be easy
> to persuade me to change my opinion.

Yeah, I would have expected a die("BUG") here.

I think it is worth making it a fatal mistake and catching it. Rolling
back an uninitialized lockfile is probably OK; we are canceling an
operation that never started. But committing a lockfile that we didn't
actually fill out could be a sign of a serious error, and we may be
propagating a bogus success code. E.g., imagine that receive-pack claims
to have written your ref, but actually commit_lock_file was a silent
NOP. I'd much rather have it die loudly so we can track down the case.

-Peff
