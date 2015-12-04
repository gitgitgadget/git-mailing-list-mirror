From: Jeff King <peff@peff.net>
Subject: Re: git-credential-cache--daemon quits on SIGHUP, can we change it
 to ignore instead?
Date: Fri, 4 Dec 2015 14:06:59 -0500
Message-ID: <20151204190658.GA16692@sigill.intra.peff.net>
References: <20151030001000.GA2123@sigill.intra.peff.net>
 <CAM-tV-_dc_YEE0Dh2T=8+_DcBiq_rvynOw2cFi+8QizkeGTusw@mail.gmail.com>
 <20151030005057.GA23251@sigill.intra.peff.net>
 <CAM-tV-8qSVJFOxLQt9SaYK_WqpxixzPArJnAK=3tHU9inM9Law@mail.gmail.com>
 <20151030210849.GA7149@sigill.intra.peff.net>
 <CAM-tV-9CNO_hqnweFpLaRHx4xEA32CPRdq56y6vYMWqURV9kgg@mail.gmail.com>
 <20151109155342.GB27224@sigill.intra.peff.net>
 <CAM-tV--hBSdCJckCnMtKgkQB2f_3eN8sXHdFWwg2hzb6s7ufxw@mail.gmail.com>
 <20151110122501.GA14418@sigill.intra.peff.net>
 <xmqqpoymrql7.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Noam Postavsky <npostavs@users.sourceforge.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 04 20:07:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a4vhG-0002Lp-3e
	for gcvg-git-2@plane.gmane.org; Fri, 04 Dec 2015 20:07:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754953AbbLDTHE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Dec 2015 14:07:04 -0500
Received: from cloud.peff.net ([50.56.180.127]:37439 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753472AbbLDTHD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Dec 2015 14:07:03 -0500
Received: (qmail 28332 invoked by uid 102); 4 Dec 2015 19:07:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 04 Dec 2015 13:07:02 -0600
Received: (qmail 26519 invoked by uid 107); 4 Dec 2015 19:07:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 04 Dec 2015 14:07:04 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 04 Dec 2015 14:06:59 -0500
Content-Disposition: inline
In-Reply-To: <xmqqpoymrql7.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281996>

On Fri, Dec 04, 2015 at 10:55:32AM -0800, Junio C Hamano wrote:

> >> +	int ignore_sighup = 0;
> >> +	git_config_get_bool("credentialcache.ignoresighup", &ignore_sighup);
> >> +
> >
> > Style-wise, I think the declaration should go above the options-list.
> 
> I was about to merge this to 'master', following your last issue of
> "What's cooking" report.
> 
> I was puzzled that git_config_get_bool() is used here without even
> checking if we are inside any Git repository and wondered if it was
> correct.  I'd imagine this is not a problem, as this process is
> spawned by "credential-cache" that was spawned by somebody (either
> push or fetch) who has read $GIT_DIR/config for credential.helper to
> determine that credential-cache needs to be used.

That does not have to be the case; I imagine most people would put
credential.helper in their ~/.gitconfig.

But I'm not sure I understand how that is relevant. The config subsystem
should work just fine whether we are in a repository or not (and if not,
return results only from system and user-wide config).

This probably _does_ trigger setup_git_env() when it was not otherwise
called, and it will back to looking at ".git/config" for the repo-level
config. That may fail to find the file if we are in a bare repository,
or a subdirectory of the working tree. IOW, I suspect this:

  git init --bare foo.git
  cd foo.git
  git config credential.helper cache
  git config credentialcache.ignoreSIGHUP true ;# goes into local config
  git fetch https://example.com/foo.git

may fail to respect the ignoreSIGHUP option.

I guess the solution would be to setup_git_director_gently() in the
daemon process.

-Peff
