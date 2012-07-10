From: Jeff King <peff@peff.net>
Subject: Re: git clone fails "with error: RPC failed; result=22, HTTP code =
 401
Date: Tue, 10 Jul 2012 16:51:28 -0400
Message-ID: <20120710205128.GD23798@sigill.intra.peff.net>
References: <CAEpEX_7xrGR+Uk5601iKKPr0uQDkT2sQ4ziPVmqCASYy51hBCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Ilya Ruprecht <ilya.ruprecht@googlemail.com>
X-From: git-owner@vger.kernel.org Tue Jul 10 22:51:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SohPD-0000E7-SK
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jul 2012 22:51:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753427Ab2GJUvb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jul 2012 16:51:31 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:56862
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753392Ab2GJUva (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jul 2012 16:51:30 -0400
Received: (qmail 2323 invoked by uid 107); 10 Jul 2012 20:51:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 10 Jul 2012 16:51:40 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 10 Jul 2012 16:51:28 -0400
Content-Disposition: inline
In-Reply-To: <CAEpEX_7xrGR+Uk5601iKKPr0uQDkT2sQ4ziPVmqCASYy51hBCQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201279>

On Fri, Jul 06, 2012 at 02:04:10PM +0200, Ilya Ruprecht wrote:

>         <Location "/git/repo1.git">
>                 # read access
>                 <Limit GET>
>                         require ldap-group repo.writers
>                         require ldap-group repo.readers
>                 </Limit>
> 
>                 # write access
>                 <Limit GET PUT POST DELETE PROPPATCH MKCOL COPY MOVE
> LOCK UNLOCK>
>                         require ldap-group repo.writers
>                 </Limit>

As you noticed, this will not do what you want. Git's smart-http
protocol uses POST requests to send the list of heads during ref
negotiation. So even a fetch request will require both GETs and POSTs.

The right way to restrict reading versus writing over smart-http is to
check which git service is being requested (confusingly, "git-upload-pack"
is for clones and fetches, and "git-receive-pack" is for pushes; the
names are based on what the _server_ is doing). There is an example in
the git-http-backend documentation, which uses a LocationMatch along
with a "require" directive.

-Peff
