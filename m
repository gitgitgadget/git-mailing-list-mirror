From: Jeff King <peff@peff.net>
Subject: Re: git submodule should honor "-c credential.helper" command line
 argument
Date: Thu, 18 Feb 2016 23:30:20 -0500
Message-ID: <20160219043019.GA14764@sigill.intra.peff.net>
References: <56B0E3AA.30804@syntevo.com>
 <20160203042554.GA21179@sigill.intra.peff.net>
 <CA+P7+xpGTvbyLOKQ=DHFBLOuVNN8WocraaZQhFD36oDiFrY+sA@mail.gmail.com>
 <CA+P7+xr4gQFPsUiuqSzMsUJP6_W8FnXBwX1Xes=XjksuTs=+hQ@mail.gmail.com>
 <56B74B17.4040304@syntevo.com>
 <CA+P7+xpFmZBUwq1h9Xhi7xKYfAyvcouBiV5ujHxuGJQJTMHXZw@mail.gmail.com>
 <CA+P7+xpHNHVSJnVg3HwiBjWxRdSpLXCsm3GpWst=BNyhLMVd5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Marc Strapetz <marc.strapetz@syntevo.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Git mailing list <git@vger.kernel.org>
To: Jacob Keller <jacob.keller@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 19 05:30:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWciG-0003Zm-Ex
	for gcvg-git-2@plane.gmane.org; Fri, 19 Feb 2016 05:30:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424701AbcBSEad (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2016 23:30:33 -0500
Received: from cloud.peff.net ([50.56.180.127]:45065 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1424612AbcBSEaZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2016 23:30:25 -0500
Received: (qmail 2187 invoked by uid 102); 19 Feb 2016 04:30:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 18 Feb 2016 23:30:24 -0500
Received: (qmail 23764 invoked by uid 107); 19 Feb 2016 04:30:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 18 Feb 2016 23:30:30 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 18 Feb 2016 23:30:20 -0500
Content-Disposition: inline
In-Reply-To: <CA+P7+xpHNHVSJnVg3HwiBjWxRdSpLXCsm3GpWst=BNyhLMVd5A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286658>

On Thu, Feb 18, 2016 at 05:15:54PM -0800, Jacob Keller wrote:

> I am looking at this more and I am stuck as to how best to provide a
> test case.
> 
> I think the problem as stated above is pretty straight forward, we
> just want to stop clearing GIT_CONFIG_PARAMETERS but I can't find an
> easy way to test that we've done the right thing. There are no current
> tests for using a credential helper with submodule update right now.

If you just want to test that GIT_CONFIG_PARAMETERS is left untouched in
the submodule, you can tweak any config setting that would impact the
newly-cloned repo. E.g. this:

  unset GIT_COMMITTER_NAME
  git config --global user.name='Global Name'
  git -c user.name='Command-Line Name' clone repo-with-module foo
  head -1 foo/.git/logs/HEAD
  head -1 foo/.git/modules/sub/logs/HEAD

shows that the parent-level clone uses the "-c" name, but the submodule
does not.

That being said, I am not sure this is the right solution. In the thread
I linked earlier[1], Jens indicated he would prefer not to blindly share
config with the submodules, and I think I agree. Or are you proposing to
pick and choose the keys in GIT_CONFIG_PARAMETERS, and whitelist
credential.*?

In that case, obviously my test example would not work, though I think
that it might be fine to put "user.name" onto the whitelist (the things
we really would worry about is stuff like "core.worktree" that clearly
does not make sense to carry over into the submodule).

-Peff

[1] http://thread.gmane.org/gmane.comp.version-control.git/264840
