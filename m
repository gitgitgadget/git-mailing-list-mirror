From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Fix t3701 if core.filemode disabled
Date: Wed, 21 May 2008 10:36:07 -0400
Message-ID: <20080521143607.GA3575@sigill.intra.peff.net>
References: <20080518152337.GB3058@steel.home> <20080518190839.GC15506@sigill.intra.peff.net> <20080518200121.GA5789@steel.home> <20080519202342.GA9694@steel.home> <20080519205550.GA24246@sigill.intra.peff.net> <20080520215932.GB10437@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 21 16:45:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JypRC-0001iP-GS
	for gcvg-git-2@gmane.org; Wed, 21 May 2008 16:37:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757125AbYEUOgO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 May 2008 10:36:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757366AbYEUOgO
	(ORCPT <rfc822;git-outgoing>); Wed, 21 May 2008 10:36:14 -0400
Received: from peff.net ([208.65.91.99]:4533 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755643AbYEUOgN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 May 2008 10:36:13 -0400
Received: (qmail 4061 invoked by uid 111); 21 May 2008 14:36:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Wed, 21 May 2008 10:36:09 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 21 May 2008 10:36:07 -0400
Content-Disposition: inline
In-Reply-To: <20080520215932.GB10437@steel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82545>

On Tue, May 20, 2008 at 11:59:32PM +0200, Alex Riesen wrote:

> Sure. I have explicitely test for core.filemode=false, because
> some older setups (where git init did not set it) don't have
> the setting and git config core.filemode reports nothing.

I don't think that is relevant here; this is a test script, and as such
is testing the results of the current version of git-init (from when we
git-init the trash directory).

That being said, I think the test you have is perfectly fine, and the
patch is correct.

And I am OK with the patch as-is, though I have a few style nits:

> @@ -65,6 +65,7 @@ test_expect_success 'revert works (commit)' '
>  	git add -i </dev/null >output &&
>  	grep "unchanged *+3/-0 file" output
>  '
> +if test "$(git config core.filemode)" != false ; then
>  
>  test_expect_success 'patch does not affect mode' '
>  	git reset --hard &&
> @@ -84,5 +85,6 @@ test_expect_success 'stage mode but not hunk' '
>  	git diff          file | grep "+content"
>  '
>  
> +fi

1. It should be $(git config --bool core.filemode). As it happens,
git-init always uses the word "false" so this works OK, but it is
probably better to model good behavior and to be more robust.

2. It's a little hard to see which tests are affected. I would have done
   something more like:

  if test "$(git config --bool core.filemode)" = true
    test_filemode=
  else
    test_filemode=:
  fi

  $test_filemode test_expect_success ...

  But maybe that is just overengineering.

3. Usually when we skip tests we do something like

  say 'skipping filemode tests (filesystem does not properly support modes')

-Peff
