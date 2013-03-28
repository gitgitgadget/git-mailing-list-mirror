From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Composing git repositories
Date: Thu, 28 Mar 2013 15:31:46 +0530
Message-ID: <CALkWK0nreJZX4msFET0a7cuUMWNbQhhqy+ezrkqYGqL4_a2duA@mail.gmail.com>
References: <CALkWK0=CsuAWQwk5Guf0pbC4_ZEoZiwQpamcRvBGz5LJ0QGKHg@mail.gmail.com>
 <7vmwtqt8rs.fsf@alter.siamese.dyndns.org> <CALkWK0kNH2A4eLML22RTofarR3MB++OECiNXMi-bWLLMWK1GAg@mail.gmail.com>
 <7vvc8comj5.fsf@alter.siamese.dyndns.org> <CALkWK0nARWAtC-D3UiNLccuaSwjR6meJb+Cu590N=8Ti8O7OMg@mail.gmail.com>
 <20130327192630.GF28148@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 28 11:02:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UL9fJ-0007dY-VL
	for gcvg-git-2@plane.gmane.org; Thu, 28 Mar 2013 11:02:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755922Ab3C1KCJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Mar 2013 06:02:09 -0400
Received: from mail-bk0-f51.google.com ([209.85.214.51]:36986 "EHLO
	mail-bk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752588Ab3C1KCI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Mar 2013 06:02:08 -0400
Received: by mail-bk0-f51.google.com with SMTP id y8so1956970bkt.24
        for <git@vger.kernel.org>; Thu, 28 Mar 2013 03:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=jvWVpDHTK5kenuXkDFCc3Y27Wlvb1Sg3XNT8lqnKVco=;
        b=vrvbVxbZ9JXhMX36Ky3bRdm8XLEX+AdOdmHJ6202/DVFXiqD2RXUn87KGulThAMccg
         6aTj6SNcQp60HmbKolhA97GHYKtS6zkrJoz/yUqksOWZ06OTzMj8PSVOJEIV9egCx3nC
         XW5kQsuuehCzN4lO4nYsDON159KNU8xyF5nGkHw2EGq8453VHhIyvju0bicnBIp/KQqg
         IVJMSbxFh+R33cc3q8L/lcbT2hFTJfssuDtwBnypqK0UH6OW4cCB6v5BIC7yyLM6Kphe
         9v3wdDyujTddwQwh5cGroT0vZU8VoJPEu64yxrWEV9TVDei61aRAd+Ogpbt1QPLleuQq
         f+6w==
X-Received: by 10.205.139.71 with SMTP id iv7mr11787989bkc.86.1364464926519;
 Thu, 28 Mar 2013 03:02:06 -0700 (PDT)
Received: by 10.204.36.10 with HTTP; Thu, 28 Mar 2013 03:01:46 -0700 (PDT)
In-Reply-To: <20130327192630.GF28148@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219379>

Jonathan Nieder wrote:
> Do you mean that you wish you could ignore subrepository boundaries
> and use commands like
>
>         git clone --recurse-submodules http://git.zx2c4.com/cgit
>         cd cgit
>         vi git/cache.h
>         ... edit edit edit ...
>         git add --recurse-submodules git/cache.h
>         git commit --recurse-submodules
>         git push --recurse-submodules
>
> , possibly with configuration to allow the --recurse-submodules to be
> implied, and have everything work out well?

Do you realize how difficult this is to implement?  We'll need to
patch all the git commands to essentially do what we'd get for free if
the submodule were a tree object instead of a commit object (although
I'm not saying that's the Right thing to do).  Some caveats:

- If we maintain one global index, and try to emulate git-subtree
using submodules, we've lost.  It's going to take freakin' ages to
stat billions of files across hundreds of nested sumodules.  One major
advantage of having repository boundaries is separate object stores,
indexes, worktrees: little ones that git is designed to work with.

- Auto-splitting commits that touch multiple submodules/ superproject
at once.  Although git-subtree does this, I think it's horribly ugly.

- Auto-propagating commits upwards to the superproject is another big
challenge.  I think the current design of anchoring to a specific
commit SHA-1 has its usecases, but is unwieldy when things become big.
 We have to fix that first.
