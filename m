From: Jeff King <peff@peff.net>
Subject: Re: [GSOC] Git Configuration API improvements
Date: Fri, 14 Mar 2014 00:31:41 -0400
Message-ID: <20140314043141.GC31906@sigill.intra.peff.net>
References: <CAOLa=ZSKDg9DKxTRMy4yWW7=ZHcudGmK4guYmaP2okxH8Q044Q@mail.gmail.com>
 <vpqsiqovleu.fsf@anie.imag.fr>
 <CAOLa=ZQwrtvoBWEra-p9wwFmYBZqcz75a9R0qm7bv2g7UCJn4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: karthik nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 14 05:31:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WOJme-0003F4-97
	for gcvg-git-2@plane.gmane.org; Fri, 14 Mar 2014 05:31:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751493AbaCNEbo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2014 00:31:44 -0400
Received: from cloud.peff.net ([50.56.180.127]:39231 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750786AbaCNEbn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2014 00:31:43 -0400
Received: (qmail 1142 invoked by uid 102); 14 Mar 2014 04:31:43 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 13 Mar 2014 23:31:43 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 14 Mar 2014 00:31:41 -0400
Content-Disposition: inline
In-Reply-To: <CAOLa=ZQwrtvoBWEra-p9wwFmYBZqcz75a9R0qm7bv2g7UCJn4A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244074>

On Tue, Mar 11, 2014 at 09:49:33PM +0530, karthik nayak wrote:

> On Tue, Mar 11, 2014 at 8:21 PM, Matthieu Moy
> <Matthieu.Moy@grenoble-inp.fr> wrote:
> > karthik nayak <karthik.188@gmail.com> writes:
> >
> >> Currently we have multiple invocation of git_config() in an
> >> individual invocation of git() which is not efficient. Also, it is
> >> hard to implement new features,
> >
> > I think efficiency is not a real concern here. Config files are small
> > and easy to parse, so parsing them multiple times isn't really
> > noticeable from the performance point of view.
> >
> > OTOH, the extensibility is a real concern, and that should be the main
> > motivation for the project.
>
> Thanks. I understand what you mean. extensibility is the main motivation of the
> project, i think that by implementing the cache system we can fix the
> small problems
> (reappearing of headers while setting and unsetting configs) and also
> implement new features
> like to unset a config easily.

I think the most interesting part of the config idea is turning the
fetching of config variables "inside out".

That is, right now we turn control over to the config code, which
invokes our callbacks. So we see all variables in sequence, and pick out
the ones that are interesting.  We implement precedence with a "last one
wins" technique where we keep overwriting a variable with subsequent
config options.

This can lead to difficult ordering situations, such as when a config
option _might_ be respected based on another factor (e.g., the presence
of a command line option, as in the status.branch option).

It also means that it's impossible to tell after the fact whether a
value was set explicitly on the command line, by config, or if we are
using a system default. Most of the time this doesn't matter, but there
are a few cases where we care, and we end up having to manually manage
a separate flag in each case.

By the phrase "inside out" above, I mean that we could read all config,
and then fetch individual values as we need them. We do need to care
about efficiency here, but only insofar as we don't cause any
regressions (that is, the current system is fine speed-wise, we just
need to make sure that we do not create new problems by calling a slow
lookup in a tight loop or anything like that).

-Peff
