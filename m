From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH 0/2] Let "git submodule add" fail when .git/modules/<name>
 already exists
Date: Sun, 30 Sep 2012 21:19:59 +0200
Message-ID: <50689B5F.3060308@web.de>
References: <BC634E06939C44239106E7A8DD229130@gmail.com> <50636C00.6080906@web.de> <50677E76.1050204@web.de> <7vtxugglqy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jonathan Johnson <me@jondavidjohn.com>,
	Git Mailing List <git@vger.kernel.org>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 30 21:20:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TIP3s-00080i-Mv
	for gcvg-git-2@plane.gmane.org; Sun, 30 Sep 2012 21:20:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751319Ab2I3TUI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Sep 2012 15:20:08 -0400
Received: from mout.web.de ([212.227.17.12]:52253 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751176Ab2I3TUH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Sep 2012 15:20:07 -0400
Received: from [192.168.178.41] ([91.3.153.206]) by smtp.web.de (mrweb001)
 with ESMTPA (Nemesis) id 0LjaR6-1TpFu622ZM-00btus; Sun, 30 Sep 2012 21:20:02
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:15.0) Gecko/20120907 Thunderbird/15.0.1
In-Reply-To: <7vtxugglqy.fsf@alter.siamese.dyndns.org>
X-Provags-ID: V02:K0:MCtoN5flp87HNdZqcqyYoa11uk69s3keTaBSGGMUW2C
 3XBQD0Qy9LgMewVsOgowgviHcOU/K6uujJ+M0cRL0Us/Ja4ooG
 K4weIwOt4bBHR3N1dUf4kwuRP0GF+W9UHbgiIZqu4qmnGxQbxc
 FtNsBPgCoVfA8AhLGL6x3mj1NDCddXpDcKLtcqAhJ2QSkH28Eg
 51hUztpqmqnJQ3NuIFPwQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206694>

Am 30.09.2012 06:47, schrieb Junio C Hamano:
> Jens Lehmann <Jens.Lehmann@web.de> writes:
> 
>>> The only long term solution I can think of is to use some kind of UUID for
>>> the name, so that the names of newly added submodules won't have a chance
>>> to clash anymore. For the short term aborting "git submodule add" when a
>>> submodule of that name already exists in .git/modules of the superproject
>>> together with the ability to provide a custom name might at least solve
>>> the local clashes.
> 
> That assumes that the addition of the submodule for the second time
> is to add a completely different submodule at the same location and
> is done on purpose, but is that a sensible assumption?
> 
> If a superproject that is about an embedded appliance used to have a
> submodule A bound at its path "kernel", but for some reason stopped
> shipping with "kernel" and then later reintroduced the directory
> "kernel" bound to some submodule B, my gut feeling is that it is
> just as likely (if not more likely) that A and B are indeed the same
> submodule (i.e. it shares the same history) as they are totally
> unrelated.
> 
> Could it be that it is a user error combined with the immaturity of
> "git submodule" tool that does not yet support "it used to be here,
> but it disappears for a while and then it reappears in the history
> of the superproject" very well that caused the user to manually add
> a "new" submodule which in fact is the same submodule at the same
> path?
> 
> I think failing with a better error message is a good idea. It
> should suggest to either resurrect the submodule that is stashed
> away in "$GIT_DIR/modules/$name" if it indeed is the same, or to
> give it a different name (perhaps "kernel" used to be pointing at
> the Linux kernel history, then the user is replacing it with a
> totally different implementation that is really from different
> origin and do not share any history, perhaps BSD).  In such a case,
> the user may want to pick bsd-kernel or something as its name, to
> differentiate it.

Good point! I will add a more detailed error message (including
the url of the default remote which is configured for the already
present submodule repo) and teach --force to skip the test and
resurrect that submodule repo.

>> Using some kind of UUID can easily be added in a subsequent patch,...
> 
> I would suggest thinking really long and hard before saying UUID.

Absolutely.

> It is an easy cop-out to ensure uniqueness, but risks to allow two
> people (or one person at two different time) to give two unrelated
> names to a single thing that actually is the same.

I'm not too worried about that (even though it would be good for
the disk footprint). And I couldn't come up with a better way to
solve the problem we currently have when the same name is used
for two different submodule repos.

> A better alternative might be to use the commit object name at the
> root of the history of the submodule, which would catch the simplest
> and most common case of the mistake, I would think.

This won't work well e.g. when one uses a fork of another repo,
that will contain different commits while still having the same
root commit. I was also thinking about hashing the URL, but that
will break when the user reconfigures the URL to somewhere else.
After playing with some ideas I couldn't find a way to let the
submodule's repo provide sufficient uniqueness.

I'd say for now we go with the detection of name clashes and let
the user choose if he wants to resurrect that submodule repo or
if he wants to choose another name. But if we notice further down
the road that collisions are a problem in real life, we can think
again if UUIDs - or something else - might be a solution.
