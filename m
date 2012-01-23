From: Hallvard Breien Furuseth <h.b.furuseth@usit.uio.no>
Subject: Re: make install rewrites source files
Date: Mon, 23 Jan 2012 21:57:51 +0100 (CET)
Message-ID: <hbf.20120123j61g@bombur.uio.no>
References: <hbf.20120123bz2f@bombur.uio.no>
	<7vhazm89bo.fsf@alter.siamese.dyndns.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 23 21:57:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RpQxi-0005l6-UY
	for gcvg-git-2@lo.gmane.org; Mon, 23 Jan 2012 21:57:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753903Ab2AWU5y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jan 2012 15:57:54 -0500
Received: from mail-out2.uio.no ([129.240.10.58]:36999 "EHLO mail-out2.uio.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753181Ab2AWU5x (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jan 2012 15:57:53 -0500
Received: from mail-mx3.uio.no ([129.240.10.44])
	by mail-out2.uio.no with esmtp (Exim 4.75)
	(envelope-from <hbf@ulrik.uio.no>)
	id 1RpQxc-0001tS-7R; Mon, 23 Jan 2012 21:57:52 +0100
Received: from bombur.uio.no ([129.240.6.233])
	by mail-mx3.uio.no with esmtp  (Exim 4.76)
	(envelope-from <hbf@ulrik.uio.no>)
	id 1RpQxb-0007BY-Ph; Mon, 23 Jan 2012 21:57:52 +0100
Received: by bombur.uio.no (Postfix, from userid 2112)
	id A910B1035; Mon, 23 Jan 2012 21:57:51 +0100 (CET)
In-Reply-To: <7vhazm89bo.fsf@alter.siamese.dyndns.org>
X-UiO-Ratelimit-Test: rcpts/h 2 msgs/h 1 sum rcpts/h 2 sum msgs/h 1 total rcpts 2103 max rcpts/h 17 ratelimit 0
X-UiO-Spam-info: not spam, SpamAssassin (score=-5.0, required=5.0, autolearn=disabled, T_RP_MATCHES_RCVD=-0.01,UIO_MAIL_IS_INTERNAL=-5, uiobl=NO, uiouri=NO)
X-UiO-Scanned: 64A6AC99919D7CF7448E486605C3D43F69C50AB9
X-UiO-SPAM-Test: remote_host: 129.240.6.233 spam_score: -49 maxlevel 80 minaction 2 bait 0 mail/h: 1 total 925 max/h 5 blacklist 0 greylist 0 ratelimit 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189013>

On Mon, 23 Jan 2012 12:15:07 -0800, Junio C Hamano <gitster@pobox.com> wrote:
> Hallvard Breien Furuseth <h.b.furuseth@usit.uio.no> writes:
> 
>> INSTALL says we can install a profiled Git with
>> 	   $ make profile-all
>> 	   # make install prefix=...
>> This does not work...
> 
> We should just drop prefix=... from that line, as the "prefix=value must
> be the same while building and installing" is not only about the "profile"
> build but applies to any other build.

Either add or remove a prefix so they match, yes.  Fine by me either way.

> I however wonder why you would need a separate profile-install target,
> though.  Shouldn't 
> 
>	$ make foo-build && make install
> 
> install a funky 'foo' variant of the build for any supported value of
> 'foo'?

'profile-all' makes 'all' with different CFLAGS from those in
Makefile.  'install' makes 'all' which notices CFLAGS has changed
since last build, so it rebuilds:
    $ make install
    * new build flags or prefix
    ...
That's also how the 2nd '$(MAKE) ... all' in profile-all can tell
that it should do anything.  Thus my new 'profile-install:' target
with the same flags as the final $(MAKE) in profile-all.

This looks way too clever to me.  'make' can detect that flags have
changed, but should then fail (optionally?) instead of rebuilding.
That'd likely solve my issue with other files rewritten as root too.
But I'm not volunteering to rewrite your build system.

BTW, it'd be useful to split up 'profile-all' so it is possible
to ignore 'make test' failure and compilete the build anyway:

.PHONY: profile-all profile-clean profile-gen profile-use profile-install
profile-all: profile-clean profile-gen profile-use
profile-gen:
	$(MAKE) CFLAGS="$(PROFILE_GEN_CFLAGS)" all
	$(MAKE) CFLAGS="$(PROFILE_GEN_CFLAGS)" -j1 test
profile-use:
	$(MAKE) CFLAGS="$(PROFILE_USE_CFLAGS)" all

-- 
Hallvard
