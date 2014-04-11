From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 6/9] branch: display publish branch
Date: Fri, 11 Apr 2014 07:17:51 -0400
Message-ID: <20140411111750.GA28858@sigill.intra.peff.net>
References: <1397156686-31349-1-git-send-email-felipe.contreras@gmail.com>
 <1397156686-31349-7-git-send-email-felipe.contreras@gmail.com>
 <CALkWK0mSfsUrSMPMmZ+PNtZ2WBUqN4Swk_e6S1fMGuUoocJSEg@mail.gmail.com>
 <53471d0b4c8dc_d696b12f08c@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	Matthieu Moy <matthieu.moy@imag.fr>,
	John Szakmeister <john@szakmeister.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 11 13:18:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WYZTd-000541-M9
	for gcvg-git-2@plane.gmane.org; Fri, 11 Apr 2014 13:18:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754290AbaDKLRy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Apr 2014 07:17:54 -0400
Received: from cloud.peff.net ([50.56.180.127]:57850 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754076AbaDKLRx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Apr 2014 07:17:53 -0400
Received: (qmail 20628 invoked by uid 102); 11 Apr 2014 11:17:53 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 11 Apr 2014 06:17:53 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 11 Apr 2014 07:17:51 -0400
Content-Disposition: inline
In-Reply-To: <53471d0b4c8dc_d696b12f08c@nysa.notmuch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246078>

On Thu, Apr 10, 2014 at 05:36:59PM -0500, Felipe Contreras wrote:

> > I noticed that this only picks up a publish-branch if
> > branch.*.pushremote is configured. What happened to the case when
> > remote.pushdefault is configured?
> 
> What happens when branch.*.remote is not configured for @{upstream}? The same
> thing.

I don't know if that is a good comparison.

In other threads, the discussed meaning of @{publish} was something like
"the tracking branch of the ref you would push to if you ran 'git push'
without arguments".

That is consistent with @{upstream} being "the tracking branch of the
ref you would pull from with 'git pull'". But "git pull" without a
branch.*.remote will do nothing, so "what pull would do" is the same as
"what you have configured in your branch.*.remote".

Whereas "git push" does not depend on having branch.*.pushremote
configured. Its behavior is based on push.default and push refspecs, so
"what push would do" must take that into account.

> It might be useful to visualize what would be the name of the branch when
> pushing it (without a refspec) even if the publish branch hasn't been
> configured, but I think the code would be much more coplicated, and it would
> break symetry with @{upstream}, besides, the user can just do 'git push -p
> branch', and from that moment on it will be visible.

It is more complicated (see the patches that Junio had at
jk/branch-at-publish), but I think it is more likely to do what the user
expects.

For instance, it looks like your @{publish} requires config like:

  [branch "master"]
  pushremote = foo
  push = refs/heads/bar

to operate. Setting "pushremote" affects what "git push" does; it will
go to the "foo" remote. But the branch.master.push setting does not do
anything to "git push". Only a push refspec (or push.default setting)
will change that. So the "branch.*.push" must be kept in sync manually
(perhaps by running "git push -p").

Whereas if @{publish} means "where you would push to", then
"branch.*.push" does not need to exist at all. The values can be taken
automatically from the other push settings.

-Peff

PS I first tried just setting "branch.master.pushremote" without setting
   "branch.master.push". This results in a segfault, as branch_get()
   assumes that push_name is always set and tries to xstrdup() it.
