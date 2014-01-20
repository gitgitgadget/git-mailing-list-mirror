From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] t/perf: time rev-list with UNINTERESTING commits
Date: Mon, 20 Jan 2014 17:39:36 -0500
Message-ID: <20140120223936.GA2350@sigill.intra.peff.net>
References: <20140120212845.GA11451@sigill.intra.peff.net>
 <20140120213101.GA16095@sigill.intra.peff.net>
 <20140120221142.GA24320@sigill.intra.peff.net>
 <87ppnmb7yr.fsf@thomasrast.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Thomas Rast <tr@thomasrast.ch>
X-From: git-owner@vger.kernel.org Mon Jan 20 23:39:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W5NVN-0003eA-RO
	for gcvg-git-2@plane.gmane.org; Mon, 20 Jan 2014 23:39:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752649AbaATWjj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jan 2014 17:39:39 -0500
Received: from cloud.peff.net ([50.56.180.127]:35890 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751760AbaATWjh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jan 2014 17:39:37 -0500
Received: (qmail 18389 invoked by uid 102); 20 Jan 2014 22:39:37 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 20 Jan 2014 16:39:37 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Jan 2014 17:39:36 -0500
Content-Disposition: inline
In-Reply-To: <87ppnmb7yr.fsf@thomasrast.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240734>

On Mon, Jan 20, 2014 at 11:32:12PM +0100, Thomas Rast wrote:

> > This is bad to be touching the repo and assuming it is non-bare. For
> > some reason I assumed that the perf suite made a copy of the repo, but
> > it doesn't. If you point to a bare repo via GIT_PERF_REPO, this part of
> > the test fails.
> 
> It does make a copy, but with cp -Rl.  I haven't actually ever tried
> what happens if you point it at a bare though.  It *should* fail because
> it tries to cd $repo/.git, but if that was itself bare...

Oh, hmph. I checked my linux repo, which I had used as GIT_PERF_REPO,
and noticed that it had the test commit in its reflog. But I forgot that
is because I did the test manually there right before writing up the
t/perf script!  So yes, it copies, and it's totally fine to be modifying
the repo.

Bare repos seem to work just fine for me. It looks like we use `git
rev-parse --git-dir` to get the source, and then copy that to `.git` in
the temporary directory. So that works fine either way, and we do have a
directory available as the working dir. But of course the config from
the bare repo says `core.bare = true`, so some commands will bail.

We could perhaps just set GIT_WORK_TREE in the perf scripts, which I
believe would override the bare setting in the .git/config. And then we
know the repos will be consistently non-bare.

Whether we do that or not, I think the update I posted is preferable, as
it reproduces the problem in a much simpler manner.

-Peff
