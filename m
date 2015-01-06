From: Jeff King <peff@peff.net>
Subject: Re: git 2.2.x: Unexpected, overstrict file permissions after "git
 update-server-info"
Date: Mon, 5 Jan 2015 22:47:02 -0500
Message-ID: <20150106034702.GA11503@peff.net>
References: <20150105210724.032e9718@x230>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Paul Sokolovsky <paul.sokolovsky@linaro.org>
X-From: git-owner@vger.kernel.org Tue Jan 06 04:47:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y8L6v-0003T6-Lm
	for gcvg-git-2@plane.gmane.org; Tue, 06 Jan 2015 04:47:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753984AbbAFDrI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Jan 2015 22:47:08 -0500
Received: from cloud.peff.net ([50.56.180.127]:59301 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753312AbbAFDrG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Jan 2015 22:47:06 -0500
Received: (qmail 3592 invoked by uid 102); 6 Jan 2015 03:47:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 05 Jan 2015 21:47:05 -0600
Received: (qmail 6811 invoked by uid 107); 6 Jan 2015 03:47:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 05 Jan 2015 22:47:22 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 05 Jan 2015 22:47:02 -0500
Content-Disposition: inline
In-Reply-To: <20150105210724.032e9718@x230>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262043>

On Mon, Jan 05, 2015 at 09:07:24PM +0200, Paul Sokolovsky wrote:

> So, after the upgrade, users started to report that accessing
> info/refs file of a repo, as required for HTTP dump protocol, leads to
> 403 Forbidden HTTP error. We traced that to 0600 filesystem permissions
> for such files (for objects/info/packs too) (owner is gerrit user, to
> remind). After resetting permissions to 0644, they get back to 0600
> after some time (we have a cronjob in addition to a hook to run "git
> update-server-info"). umask is permissive when running cronjob (0002).
> 
> I traced the issue to:
> https://github.com/git/git/commit/d38379ece9216735ecc0ffd76c4c4e3da217daec

Yeah, I didn't consider the mode impact of using mkstemp. That is
definitely a regression that should be fixed. Though of course if you
really do want 0644, you should set your umask to 0022. :)

> It says: "Let's instead switch to using a unique tempfile via mkstemp."
> Reading man mkstemp: "The  file  is  created  with permissions 0600".
> So, that's it. The patch above contains call to adjust_shared_perm(),
> but apparently it doesn't promote restrictive msktemp permissions to
> something more accessible.

If you haven't set core.sharedrepository, then adjust_shared_perm is a
noop. But you shouldn't have to do that. Git should just respect your
umask in this case.

> Hope this issue can be addressed.

Patches to follow. Thanks for the report.

  [1/2]: t1301: set umask in reflog sharedrepository=group test
  [2/2]: update-server-info: create info/* with mode 0666

-Peff
