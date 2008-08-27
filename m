From: Jeff King <peff@peff.net>
Subject: Re: git-shortlog hangs on bare repo without --bare option
Date: Wed, 27 Aug 2008 19:30:56 -0400
Message-ID: <20080827233056.GA25745@coredump.intra.peff.net>
References: <20080827195233.GA2477@garry-thinkpad.arpnetworks.com> <48B5C9E4.4030807@lsrfire.ath.cx> <7vvdxmm78o.fsf@gitster.siamese.dyndns.org> <7vod3em67d.fsf@gitster.siamese.dyndns.org> <7v8wuim4kv.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 28 01:32:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYUUd-00085m-9E
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 01:32:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752689AbYH0Xa7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 19:30:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752152AbYH0Xa7
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 19:30:59 -0400
Received: from peff.net ([208.65.91.99]:4860 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752146AbYH0Xa6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 19:30:58 -0400
Received: (qmail 22952 invoked by uid 111); 27 Aug 2008 23:30:58 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 27 Aug 2008 19:30:58 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 27 Aug 2008 19:30:56 -0400
Content-Disposition: inline
In-Reply-To: <7v8wuim4kv.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93985>

On Wed, Aug 27, 2008 at 04:16:32PM -0700, Junio C Hamano wrote:

> While this might help, I see there are more serious issues here.
> 
> If you start "git-shortlog" (or anything that has USE_PAGER but not
> RUN_SETUP in git.c) inside your project/.git directory (or a bare one, for
> that matter), the call sequence would become like this:
> 
> git.c::main()
>  -> handle_internal_command()
>    -> run_command()
>      -> commit_pager_choice()
>        -> setup_pager() (this is in pager.c)
>          -> git_config(git_default_config, NULL)
>            -> git_path("config")
>              -> get_git_dir()
>                -> setup_git_env()
>                  This sets git_dir to ".git"!!!!
> [...]
> This may be repeating what Jeff said earlier in another thread, but I
> think we should rethink the start-up sequence carefully.  Ideally (I am
> thinking aloud)...

Yep. This is the exact same problem I have been complaining about for a
while.

> [some implementation ideas]

Yes, this is roughly what I have been thinking of, as well. IOW,
unconditionally find everything right at the beginning, but let us
decide whether to barf later, when we know what command we are running.

A few complexities I found were:

  - some things really want no setup, like init and clone. I don't
    recall the exact issues, but trying obvious things caused breakage
    there.

  - the setup needs to not just be part of git.c, but factored out so
    non-builtin C programs can use it. I don't recall if there are
    issues related to git-sh-setup that need to be dealt with.

I think my approach was something like "let's just unconditionally call
setup_git_directory() in git.c, and wrap it with a static variable to
make sure we don't run it twice." but I ran into a host of issues. Sorry
I can't remember specifics.

-Peff
