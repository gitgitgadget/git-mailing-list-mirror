From: Thomas Rast <tr@thomasrast.ch>
Subject: Re: [PATCH 12/13] Makefile: teach scripts to include make variables
Date: Sat, 08 Feb 2014 22:47:16 +0100
Message-ID: <87a9e1l1jv.fsf@thomasrast.ch>
References: <20140205174823.GA15070@sigill.intra.peff.net>
	<20140205180547.GL15218@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Feb 08 22:47:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WCFkM-0008R7-55
	for gcvg-git-2@plane.gmane.org; Sat, 08 Feb 2014 22:47:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751224AbaBHVr3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Feb 2014 16:47:29 -0500
Received: from ip1.thgersdorf.net ([148.251.9.194]:34556 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751048AbaBHVr3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Feb 2014 16:47:29 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id 435FA4D656A;
	Sat,  8 Feb 2014 22:47:27 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id ohYBEHefEjMK; Sat,  8 Feb 2014 22:47:17 +0100 (CET)
Received: from linux-1gf2.thomasrast.ch (46-126-8-85.dynamic.hispeed.ch [46.126.8.85])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id 307D84D64BD;
	Sat,  8 Feb 2014 22:47:17 +0100 (CET)
In-Reply-To: <20140205180547.GL15218@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 5 Feb 2014 13:05:47 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241864>

Jeff King <peff@peff.net> writes:

> The current scheme for getting build-time variables into a
> shell script is to munge the script with sed, and stick the
> munged variable into a special sentinel file so that "make"
> knows about the dependency.
>
> Instead, we can combine both functions by generating a shell
> snippet with our value, and then "building" shell scripts by
> concatenating their snippets. "make" then handles the
> dependency automatically, and it's easy to generate tighter
> dependencies.
>
> We demonstrate here by moving the "DIFF" substitution into
> its own snippet, which lets us rebuild only the single
> affected file when it changes.

I can't look right now *why* this happens, but this breaks
./t2300-cd-to-toplevel.sh --valgrind with messages like

  expecting success: 
                  (
                          cd 'repo' &&
                          . "$(git --exec-path)"/git-sh-setup &&
                          cd_to_toplevel &&
                          [ "$(pwd -P)" = "$TOPLEVEL" ]
                  )

  ./test-lib.sh: line 414: /home/thomas/g/t/valgrind/bin/git-sh-setup: No such file or directory
  not ok 1 - at physical root
  #
  #                       (
  #                               cd 'repo' &&
  #                               . "$(git --exec-path)"/git-sh-setup &&
  #                               cd_to_toplevel &&
  #                               [ "$(pwd -P)" = "$TOPLEVEL" ]
  #                       )
  #

I don't know why it only affects this test, or why it doesn't break when
within 'git bisect run' -- probably there's something funky going on in
the environment, quite possibly in my own configs.

-- 
Thomas Rast
tr@thomasrast.ch
