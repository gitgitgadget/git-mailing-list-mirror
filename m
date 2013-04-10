From: Jeff King <peff@peff.net>
Subject: Re: git-http-backend: anonymous read, authenticated write
Date: Wed, 10 Apr 2013 17:53:46 -0400
Message-ID: <20130410215346.GB6215@sigill.intra.peff.net>
References: <20130409054553.GA1537@mteis.lan>
 <20130409171247.GD21972@sigill.intra.peff.net>
 <20130410204544.GA2472@mteis.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Magnus Therning <magnus@therning.org>
X-From: git-owner@vger.kernel.org Wed Apr 10 23:53:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQ2xp-0002zE-DB
	for gcvg-git-2@plane.gmane.org; Wed, 10 Apr 2013 23:53:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936993Ab3DJVxx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Apr 2013 17:53:53 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:39316 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752735Ab3DJVxx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Apr 2013 17:53:53 -0400
Received: (qmail 8412 invoked by uid 107); 10 Apr 2013 21:55:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 10 Apr 2013 17:55:45 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Apr 2013 17:53:46 -0400
Content-Disposition: inline
In-Reply-To: <20130410204544.GA2472@mteis.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220782>

On Wed, Apr 10, 2013 at 10:45:44PM +0200, Magnus Therning wrote:

> I was putting together a *long* response, with my different
> configurations when it suddenly hit me how to make it work.
> 
> So, this is the accesslog for a successful `git push`:
> 
> 192.168.1.84 tracsrv.local - [10/Apr/2013:22:24:59 +0200] "GET /git/foo.git/info/refs?service=git-receive-pack HTTP/1.1" 401 351 "-" "git/1.8.2.1"
> 192.168.1.84 tracsrv.local - [10/Apr/2013:22:24:59 +0200] "GET /git/foo.git/info/refs?service=git-receive-pack HTTP/1.1" 401 351 "-" "git/1.8.2.1"
> 192.168.1.84 tracsrv.local magnus [10/Apr/2013:22:25:04 +0200] "GET /git/foo.git/info/refs?service=git-receive-pack HTTP/1.1" 200 202 "-" "git/1.8.2.1"
> 192.168.1.84 tracsrv.local magnus [10/Apr/2013:22:25:09 +0200] "POST /git/foo.git/git-receive-pack HTTP/1.1" 200 73 "-" "git/1.8.2.1"
> 
> That is, *both* the GET and POST queries require a valid username
> (trying to push without a valid user will fail with a 403 already on
> the GET query).  Maybe Apache 2.x simply behaves *very* differently
> from lighttpd, but I still can't see how a rule to require a valid
> user only on the POST can ever work.

Right. But that is not configured at all by the apache config shown in
the manpage:

               <LocationMatch "^/git/.*/git-receive-pack$">
                       AuthType Basic
                       AuthName "Git Access"
                       Require group committers
                       ...
               </LocationMatch>

which should not match on the info/refs request at all. That is why I
suspect there is something else wrong in your lighttpd config, or
something wrong in the conversion of the apache config to lighttpd.

Anyway, it sounds like you found a working config.

-Peff
