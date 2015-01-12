From: Jeff King <peff@peff.net>
Subject: Re: profile-fast is failing in my Git 2.2.1 build from tar in a Git
 repo
Date: Mon, 12 Jan 2015 16:08:28 -0500
Message-ID: <20150112210827.GA10409@peff.net>
References: <1420408723.7095.207.camel@homebase>
 <xmqq1tn7o63p.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: paul@mad-scientist.net, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 12 22:08:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YAmDx-0003jk-Hj
	for gcvg-git-2@plane.gmane.org; Mon, 12 Jan 2015 22:08:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753093AbbALVI3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2015 16:08:29 -0500
Received: from cloud.peff.net ([50.56.180.127]:33432 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751598AbbALVI2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2015 16:08:28 -0500
Received: (qmail 7002 invoked by uid 102); 12 Jan 2015 21:08:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 12 Jan 2015 15:08:28 -0600
Received: (qmail 20476 invoked by uid 107); 12 Jan 2015 21:08:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 12 Jan 2015 16:08:49 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Jan 2015 16:08:28 -0500
Content-Disposition: inline
In-Reply-To: <xmqq1tn7o63p.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262294>

On Tue, Jan 06, 2015 at 03:13:30PM -0800, Junio C Hamano wrote:

> > The problem is in the t/perf/perf-lib.sh:test_perf_create_repo_from()
> > function, where we see this:
> >
> >   repo="$1"
> >   source="$2"
> >   source_git=$source/$(cd "$source" && git rev-parse --git-dir)
> >
> > The function is invoked as:
> >
> >   test_perf_create_repo_from '/home/psmith/src/git-2.2.1/t/perf/trash
> > directory.p5302-pack-index' /home/psmith/src/git-2.2.1/t/..
> >
> > but this doesn't work, because "$source" is not a Git repository; it's
> > the root of the unpacked tarball.
> 
> Yup, that is exactly why I said I am not surprised.
> 
> I do not think profile build is prepared to be run without having
> our history (after all, it is not test_perf_create_REPO_from, not
> test_perf_create_source_directory_of_git_from).  It wants to create
> a repository that hosts a reasonably sized but not too big a
> project, i.e. us.
> 
> The safest and cleanest fix would be to make sure that the said
> function checks if $source/.git is a repository, perhaps?

Hmph. We already dealt with this once in 93b5393 (Makefile: make perf
tests optional for profile build, 2014-08-19). That check explicitly
looks for ".git" (and not checking that we are in an outer git repo), so
I am not sure why it is kicking in at all. But probably the fix should
go there.

-Peff
