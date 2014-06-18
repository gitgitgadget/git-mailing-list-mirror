From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] alloc.c: remove alloc_raw_commit_node() function
Date: Wed, 18 Jun 2014 16:08:55 -0400
Message-ID: <20140618200854.GA23098@sigill.intra.peff.net>
References: <53A1EE0E.6040000@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Wed Jun 18 22:09:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxMAH-00013l-JF
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jun 2014 22:09:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754943AbaFRUI5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2014 16:08:57 -0400
Received: from cloud.peff.net ([50.56.180.127]:46985 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754564AbaFRUI4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2014 16:08:56 -0400
Received: (qmail 31687 invoked by uid 102); 18 Jun 2014 20:08:56 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 18 Jun 2014 15:08:56 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Jun 2014 16:08:55 -0400
Content-Disposition: inline
In-Reply-To: <53A1EE0E.6040000@ramsay1.demon.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252053>

On Wed, Jun 18, 2014 at 08:52:46PM +0100, Ramsay Jones wrote:

> In order to encapsulate the setting of the unique commit index, commit
> 969eba63 ("commit: push commit_index update into alloc_commit_node",
> 10-06-2014) introduced a (logically private) intermediary allocator
> function. However, this function (alloc_raw_commit_node()) was declared
> as a public function, which undermines its entire purpose.
> 
> Remove the alloc_raw_commit_node() function and inline its code into
> the (public) alloc_commit_node() function.
> 
> Noticed by sparse ("symbol 'alloc_raw_commit_node' was not declared.
> Should it be static?").
> 
> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
> ---
> 
> Hi Jeff,
> 
> I noticed this while it was still in 'pu', but got distracted and
> didn't send this in time ... sorry about that! :(

Yeah, I noticed it while writing the patch but decided it wasn't worth
the trouble to deal with (since after all, it's not advertised to any
callers, the very thing that sparse is complaining about. :) ).

I don't mind fixing it, though I really don't like repeating the
contents of DEFINE_ALLOCATOR. I know it hasn't changed in a while, but
it just feels wrong.

> My first attempt at fixing this involved changing the DEFINE_ALLOCATOR
> macro to include a 'scope' parameter so that I could declare the
> raw_commit allocator 'static'. Unfortunately, I could not pass the
> extern keyword as the scope parameter to all the other allocators,
> because that made sparse even more upset - you can't use extern on
> a function _definition_. That meant passing an empty argument (or a
> comment token) to the scope parameter. This worked for gcc 4.8.2 and
> clang 3.4, but I was a little concerned about portability.

Yeah, passing an empty argument was my first thought, but I don't know
offhand if there are portability concerns.

You could also have DEFINE_ALLOCATOR just fill in the body, and do:

  struct blob *alloc_blob_node(void)
  {
	DEFINE_ALLOCATOR(struct blob);
  }

or similar.

-Peff
