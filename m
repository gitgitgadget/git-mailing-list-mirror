From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH] travis-ci: run previously failed tests first, then
 slowest to fastest
Date: Wed, 20 Jan 2016 09:26:06 +0900
Message-ID: <20160120002606.GA9359@glandium.org>
References: <1453195469-51696-1-git-send-email-larsxschneider@gmail.com>
 <20160119191234.GA17562@sigill.intra.peff.net>
 <xmqqegdd8997.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, larsxschneider@gmail.com,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 20 01:26:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLgbZ-0007Rq-UH
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jan 2016 01:26:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933302AbcATA0a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2016 19:26:30 -0500
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:44734 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932414AbcATA03 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2016 19:26:29 -0500
Received: from glandium by zenigata with local (Exim 4.86)
	(envelope-from <mh@glandium.org>)
	id 1aLgb8-0003J2-Hs; Wed, 20 Jan 2016 09:26:06 +0900
Content-Disposition: inline
In-Reply-To: <xmqqegdd8997.fsf@gitster.mtv.corp.google.com>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284403>

On Tue, Jan 19, 2016 at 03:00:52PM -0800, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
> > On Tue, Jan 19, 2016 at 10:24:29AM +0100, larsxschneider@gmail.com wrote:
> >
> >> From: Lars Schneider <larsxschneider@gmail.com>
> >> 
> >> Use the Travis-CI cache feature to store prove test results and make them
> >> available in subsequent builds. This allows to run previously failed tests
> >> first and run remaining tests in slowest to fastest order. As a result it
> >> is less likely that Travis-CI needs to wait for a single test at the end
> >> which speeds up the test suite execution by ~2 min.
> >
> > Thanks, this makes sense, and the patch looks good.
> >
> >> @@ -18,7 +22,7 @@ env:
> >>      - P4_VERSION="15.2"
> >>      - GIT_LFS_VERSION="1.1.0"
> >>      - DEFAULT_TEST_TARGET=prove
> >> -    - GIT_PROVE_OPTS="--timer --jobs 3"
> >> +    - GIT_PROVE_OPTS="--timer --jobs 3 --state=failed,slow,save"
> >
> > Have you tried bumping --jobs here? I usually use "16" on my local box.
> 
> I think 3 comes from this:
> 
>   http://thread.gmane.org/gmane.comp.version-control.git/279348/focus=279674

Having recently looked into this, the relevant travis-ci documentation
is:
https://docs.travis-ci.com/user/ci-environment/

which says all environments have 2 cores, so you won't get much from
anything higher than -j3.

The following document also says something slightly different:
https://docs.travis-ci.com/user/speeding-up-the-build#Parallelizing-your-build-on-one-VM

"Travis CI VMs run on 1.5 virtual cores."

> > I also looked into the Travis "container" thing. It's not clear to me
> > from their page:
> >
> >   https://docs.travis-ci.com/user/workers/container-based-infrastructure/
> >
> > whether we're using the new, faster container infrastructure or not.
> > ...
> > depends on when Travis "recognized" the repo, but I'm not quite sure
> > what that means. Should we be adding "sudo: false" to the top-level of
> > the yaml file?
> 
> In an earlier discussion
> 
>   http://thread.gmane.org/gmane.comp.version-control.git/279348/focus=279495
> 
> I found that we were not eligible for container-based sandbox as the
> version of travis-yaml back then used "sudo".  I do not seem to find
> the use of sudo in the recent one we have in my tree, so it would be
> beneficial if somebody interested in Travis CI look into this.

The https://docs.travis-ci.com/user/ci-environment/ document says the
default is "sudo: false" for repositories enabled in 2015 or later, which
I assume is the case for the git repository. "sudo: required" is the
default for repositories enabled before 2015.

Mike
