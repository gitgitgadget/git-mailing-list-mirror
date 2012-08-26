From: Jeff King <peff@peff.net>
Subject: Re: git no longer prompting for password
Date: Sun, 26 Aug 2012 06:13:41 -0400
Message-ID: <20120826101341.GA12566@sigill.intra.peff.net>
References: <5037E1D0.6030900@gmail.com>
 <20120824212501.GA16285@sigill.intra.peff.net>
 <5038E781.1090008@gmail.com>
 <20120825203904.GA10470@sigill.intra.peff.net>
 <5039F327.9010003@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Iain Paton <ipaton0@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 26 12:14:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T5ZrZ-0004MQ-EH
	for gcvg-git-2@plane.gmane.org; Sun, 26 Aug 2012 12:14:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753736Ab2HZKNt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Aug 2012 06:13:49 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:48732 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753652Ab2HZKNs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Aug 2012 06:13:48 -0400
Received: (qmail 18129 invoked by uid 107); 26 Aug 2012 10:14:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 26 Aug 2012 06:14:03 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 26 Aug 2012 06:13:41 -0400
Content-Disposition: inline
In-Reply-To: <5039F327.9010003@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204296>

On Sun, Aug 26, 2012 at 10:57:59AM +0100, Iain Paton wrote:

> > The odd URL is because we are probing to see if the server even supports
> > smart-http. But note that it does not match your regex above, which
> > requires "/git-receive-pack". It looks like that is pulled straight from
> > the git-http-backend manpage. I think the change in v1.7.8 broke people
> > using that configuration.
> 
> Yes, it was lifted straight out of the manpage, albeit a couple of years 
> ago now and there have been additions to the manpage since then. 
> I did check, and the basic config is identical in the current manpage.
> 
> I can't be the only one using a config that's based on the example in 
> the manpage surely ?  So I'm surprised this hasn't come up previously.

Yeah, I'm surprised it took this long to come up, too. Perhaps most
people just do anonymous http, and then rely on ssh for pushing to
achieve the same effect. Or maybe my analysis of the problem is wrong.
:)

I'm preparing some patches to the test suite that will demonstrate the
problem (we test dumb-http auth, but we don't do any smart-http auth at
all in the test suite), and then a fix on top to let us prompt for the
password in this instance. I think we should also update the
documentation, but the existing advice has been given long enough that
people are going to use it for some time, and I consider your issue to
be a regression in v1.7.8 that should be fixed.

> So after some head scratching trying to work out how to do the equivalent of 
> LocationMatch but on the query string I came up with the following:
> 
> ScriptAlias /git/ /usr/libexec/git-core/git-http-backend/
> 
> <Directory /usr/libexec/git-core>
>         Require ip 10.44.0.0/16
>         <If "%{THE_REQUEST} =~ /git-receive-pack/">
>                 AuthType Basic
>                 AuthUserFile /data/git/htpasswd
>                 AuthGroupfile /data/git/groups
>                 AuthName "Git Access"
> 
>                 Require group committers
>         </If>
> </Directory>
> 
> and I've removed the LocationMatch section completely.

Yeah, I think that will work. It feels a little weird and hacky. E.g.,
what if you had a repo named git-receive-pack? Unlikely, of course, but
I'd want the config we advertise in the manpage to be as robust as
possible.

I don't know enough about Apache to know off-hand if there is a cleaner
way. I'll investigate a bit more before doing my documentation patch.

> So for accesses to git-http-backend I require auth if anything in the request 
> includes git-receive-pack and that causes a prompt for the username/password 
> as required, while at the same time it still allows anonymous pull.
> 
> It appears that the clone operation uses
> 
> GET /git/test.git/info/refs?service=git-upload-pack HTTP/1.1
> 
> to probe for smart-http ?  So this would be ok ?

Right. Anything invoking receive-pack is always a push.

> I'm not sure this is ideal, I don't really know enough about the protocol to know 
> if I'll see git-receive-pack elsewhere. Possibly if someone includes it in the 
> name of a repo it'll blow up in my face.

Yep, exactly. That should be the only place, though, I think (branch
names, for example, are never part of the URL).

> I can always change it to match only on QUERY_STRING and put the LocationMatch 
> back in if that happens.

I think that would be cleaner. It would be even nicer if you could
really just match "service=" as a query parameter, but I don't know that
apache parses that at all. I also don't know if Apache does any
canonicalization of the QUERY_STRING. When matching, you'd want to make
sure there is no way of a client sneaking in a parameter that git would
understand to mean a push, but that your pattern would not notice (so,
e.g., just matching "git-receive-pack$" would not be sufficient, as I
could request "?service=git-receive-pack&fooled_you=true". I don't
recall whether git rejects nonsense like that itself.

> If that's all that's required, I'm fine with an easy change to httpd.conf
> 
> Thanks for the help Jeff.

No problem. I'll probably be a day or two on the patches, as the http
tests are in need of some refactoring before adding more tests. But in
the meantime, I think your config change is a sane work-around.

-Peff
