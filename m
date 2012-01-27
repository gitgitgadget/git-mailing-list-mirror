From: Hallvard Breien Furuseth <h.b.furuseth@usit.uio.no>
Subject: Re: make install rewrites source files
Date: Fri, 27 Jan 2012 14:11:46 +0100 (CET)
Message-ID: <hbf.20120127mhkz@bombur.uio.no>
References: <hbf.20120123bz2f@bombur.uio.no>
    <7vhazm89bo.fsf@alter.siamese.dyndns.org>
    <hbf.20120123j61g@bombur.uio.no>
    <20120126225231.GA14753@ecki>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Fri Jan 27 14:12:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rqlau-0001l4-Qk
	for gcvg-git-2@lo.gmane.org; Fri, 27 Jan 2012 14:12:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754938Ab2A0NLv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jan 2012 08:11:51 -0500
Received: from mail-out2.uio.no ([129.240.10.58]:53198 "EHLO mail-out2.uio.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754927Ab2A0NLu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jan 2012 08:11:50 -0500
Received: from mail-mx4.uio.no ([129.240.10.45])
	by mail-out2.uio.no with esmtp (Exim 4.75)
	(envelope-from <hbf@ulrik.uio.no>)
	id 1Rqlal-00082z-HS; Fri, 27 Jan 2012 14:11:47 +0100
Received: from bombur.uio.no ([129.240.6.233])
	by mail-mx4.uio.no with esmtp  (Exim 4.76)
	(envelope-from <hbf@ulrik.uio.no>)
	id 1Rqlal-0001Ei-3z; Fri, 27 Jan 2012 14:11:47 +0100
Received: by bombur.uio.no (Postfix, from userid 2112)
	id B3110D86; Fri, 27 Jan 2012 14:11:46 +0100 (CET)
In-Reply-To: <20120126225231.GA14753@ecki>
X-UiO-Ratelimit-Test: rcpts/h 3 msgs/h 1 sum rcpts/h 4 sum msgs/h 1 total rcpts 2115 max rcpts/h 17 ratelimit 0
X-UiO-Spam-info: not spam, SpamAssassin (score=-5.0, required=5.0, autolearn=disabled, T_RP_MATCHES_RCVD=-0.01,UIO_MAIL_IS_INTERNAL=-5, uiobl=NO, uiouri=NO)
X-UiO-Scanned: 969E1FAB9127BE139BA54DF85059A2846B0BFA68
X-UiO-SPAM-Test: remote_host: 129.240.6.233 spam_score: -49 maxlevel 80 minaction 2 bait 0 mail/h: 1 total 934 max/h 5 blacklist 0 greylist 0 ratelimit 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189217>

On Thu, 26 Jan 2012 23:52:31 +0100, Clemens Buchacher <drizzd@aon.at> wrote:
> How about removing the profile-all target and making it a build option
> instead? To enable it, do the usual:
> (...)
> ifdef PROFILE_BUILD
>  all:
> 	$(MAKE) CFLAGS=... -fprofile-generate ... all-one
> 	$(MAKE) CFLAGS=... -fprofile-use ... all-one
> else
>  all: all-one
> endif
> 
> and each previous instance of 'all' replaced with 'all-one'.

Not quite.  test: and install: should depend on 'all', otherwise making
them without doing 'make all' first will test/install an unprofiled Git.

So 'all' with profiling should be today's profile-all, which should not
throw away the build and start over.  It can create some files to mark
how far it has gotten instead.  And profile-generate currently uses
'test' which would recurse, it needs another internal test target.

Not sure if it is worth it.  Something like this, perhaps.  Except I
have not thought about how this interacts with the coverage targets.

# Final targets

ifdef PROFILE_BUILD
all::		profile-all
test:		profile-test
install:	profile-install
else
all::		all-one
test:		test-one
install:	install-one
endif

# Profiling
#
# Note: If profiling (the test phase) failed halfway through but you
# still want to use the partial profile results to build Git, you can
#	touch p-gen.stamp
# and then 'make all' again.

profile-all: p-use.stamp

profile-gen p-gen.stamp:
	$(MAKE) CFLAGS="$(PROFILE_GEN_CFLAGS)" all-one
	$(MAKE) CFLAGS="$(PROFILE_GEN_CFLAGS)" -j1 test-one
	touch p-gen.stamp

profile-use p-use.stamp: p-gen.stamp
	$(MAKE) CFLAGS="$(PROFILE_USE_CFLAGS)" all-one
	touch p-use.stamp

profile-test: p-use.stamp
	$(MAKE) CFLAGS="$(PROFILE_USE_CFLAGS)" test-one

profile-install: p-use.stamp
	$(MAKE) CFLAGS="$(PROFILE_USE_CFLAGS)" install-one

.PHONY: all-one test test-one install install-one
.PHONY: profile-all profile-gen profile-test profile-install profile-clean


Also let 'clean' depend on 'profile-clean' which does
	$(RM) p-gen.stamp p-use.stamp.

-- 
Hallvard
