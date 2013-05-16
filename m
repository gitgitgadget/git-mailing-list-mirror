From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] strbuf_branchname(): do not double-expand @{-1}~22
Date: Wed, 15 May 2013 23:20:06 -0400
Message-ID: <20130516032006.GA13296@sigill.intra.peff.net>
References: <7vfvxnahs0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 16 05:20:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ucojm-00087b-Fb
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 05:20:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753379Ab3EPDUK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 May 2013 23:20:10 -0400
Received: from cloud.peff.net ([50.56.180.127]:44698 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753315Ab3EPDUI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 May 2013 23:20:08 -0400
Received: (qmail 19147 invoked by uid 102); 16 May 2013 03:20:36 -0000
Received: from c-71-62-74-146.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.62.74.146)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 15 May 2013 22:20:36 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 15 May 2013 23:20:06 -0400
Content-Disposition: inline
In-Reply-To: <7vfvxnahs0.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224466>

On Wed, May 15, 2013 at 05:29:51PM -0700, Junio C Hamano wrote:

> If you were on 'frotz' branch before you checked out your current
> branch, "git merge @{-1}~22" means the same as "git merge frotz~22".
> 
> The strbuf_branchname() function, when interpret_branch_name() gives
> up resolving "@{-1}~22" fully, returns "frotz" and tells the caller
> that it only resolved "@{-1}" part of the input, mistakes this as a
> total failure, and appends the whole thing to the result, yielding
> "frotz@{-1}~22", which does not make any sense.
> 
> Inspect the return valud from interpret_branch_name() a bit more
> carefully.  When it errored out without consuming anything, we will
> get -1 and we should return the whole thing.  Otherwise, we should
> append the remainder (i.e. "~22" in the earlier example) to the
> partially resolved name (i.e. "frotz").

Thanks, I think your patch looks like the right solution.

Also, s/valud/value/ in the commit message.

>  * The original code in a552de75eb01 (strbuf_branchname(): a wrapper
>    for branch name shorthands, 2009-03-21) did not have this problem
>    only because interpret_branch_name() did not return a partial
>    success, but in today's code after d46a8301930a (fix parsing of
>    @{-1}@{u} combination, 2010-01-28), it should pay attention to
>    the condition.

A quick grep shows substitute_branch_name does not distinguish these
cases, either, but I think that is OK. It is used by dwim_ref and
dwim_log to convert a string into a refname, and a partial parse of
something like "@{u}~22" should be a failure (it does not return a ref,
but rather a commit).

It does look like substitute_branch_name may leak "buf" in such a case,
though.

-Peff
