From: Jeff King <peff@peff.net>
Subject: Re: More detailed error message for 403 forbidden.
Date: Thu, 28 Mar 2013 14:36:01 -0400
Message-ID: <20130328183601.GA11914@sigill.intra.peff.net>
References: <CAFT+Tg_PwAS__AYCwQQZjy4LVvAMZFJuJ+ediDJpRnxx73qMMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: "Yi, EungJun" <semtlenori@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 28 19:36:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULHgk-000221-5c
	for gcvg-git-2@plane.gmane.org; Thu, 28 Mar 2013 19:36:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753633Ab3C1SgJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Mar 2013 14:36:09 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:43844 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752039Ab3C1SgH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Mar 2013 14:36:07 -0400
Received: (qmail 27520 invoked by uid 107); 28 Mar 2013 18:37:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 28 Mar 2013 14:37:54 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 28 Mar 2013 14:36:01 -0400
Content-Disposition: inline
In-Reply-To: <CAFT+Tg_PwAS__AYCwQQZjy4LVvAMZFJuJ+ediDJpRnxx73qMMg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219439>

On Wed, Mar 27, 2013 at 12:29:57PM +0900, Yi, EungJun wrote:

> Currently, if user tried to access a git repository via HTTP and it
> fails because the user's permission is not enough to access the
> repository, git client tells that http request failed and the error
> was 403 forbidden.

The situations in which you'll get a 403 depend on how the server is
configured. For instance, on github.com, if you successfully
authenticate but are not authorized to access a repository, you get a
404 (we do this to avoid leaking information about which private
repositories exist). But we do provide a 403 if you try to access the
repository with a non-smart-http client.

So the "403 forbidden" there is not about your account, but about the
method; if git is going to give a more verbose message, it needs to be
careful not to mislead the user.

> It would be much better if git client shows response body which might
> include an explanation of the failure. For example,
> [...]
> $ git clone http://localhost/foo/bar
> error: The requested URL returned error: 403 while accessing
> http://localhost/foo/bar
> remote: User 'me' does not have enough permission to access the repository.
> fatal: HTTP request failed

I agree that is the best way forward, as that means the server is
telling us what is going on, and we are not guessing about the meaning
of the 403.

One problem is that the content body sent along with the error is not
necessarily appropriate for showing to the user (e.g., if it is HTML, it
is probably not a good idea to show it on the terminal). So I think we
would want to only show it when the server has indicated via the
content-type that the message is meant to be shown to the user. I'm
thinking the server would generate something like:

   HTTP/1.1 403 Forbidden
   Content-type: application/x-git-error-message

   User 'me' does not have enough permission to access the repository.

which would produce the example you showed above.

-Peff
