From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] remote: write correct fetch spec when renaming
 remote 'remote'
Date: Wed, 31 Aug 2011 22:42:11 -0400
Message-ID: <20110901024211.GC31838@sigill.intra.peff.net>
References: <1314841843-19868-1-git-send-email-martin.von.zweigbergk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 01 04:42:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QyxER-00061l-PF
	for gcvg-git-2@lo.gmane.org; Thu, 01 Sep 2011 04:42:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757473Ab1IACmO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Aug 2011 22:42:14 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:45593
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757444Ab1IACmN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Aug 2011 22:42:13 -0400
Received: (qmail 9697 invoked by uid 107); 1 Sep 2011 02:42:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 31 Aug 2011 22:42:59 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 31 Aug 2011 22:42:11 -0400
Content-Disposition: inline
In-Reply-To: <1314841843-19868-1-git-send-email-martin.von.zweigbergk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180517>

On Wed, Aug 31, 2011 at 09:50:42PM -0400, Martin von Zweigbergk wrote:

> When renaming a remote whose name is contained in a configured fetch
> refspec for that remote, we currently replace the first occurrence of
> the remote name in the refspec. This is correct in most cases, but
> breaks if the remote name occurs in the fetch refspec before the
> expected place. For example, we currently change
> 
> [remote "remote"]
> 	url = git://git.kernel.org/pub/scm/git/git.git
> 	fetch = +refs/heads/*:refs/remotes/remote/*
> 
> into
> 
> [remote "origin"]
> 	url = git://git.kernel.org/pub/scm/git/git.git
> 	fetch = +refs/heads/*:refs/origins/remote/*

Oops.

> Reduce the risk of changing incorrect sections of the refspec by
> requiring the string to be matched to have leading and trailing
> slashes, i.e. match "/<name>/" instead of just "<name>".

Doesn't this just mean that:

  git remote rename remotes foo

will break in the same way?

> We could have required even a leading ":refs/remotes/", but that would
> mean that we would limit the types of refspecs we could help the user
> update.

Actually, I think it's better to be more conservative, and rename only:

  refs/remotes/$OLD/

into

  refs/remotes/$NEW/

If we are tweaking the refspecs, it's because we assume that the refspec
follows a certain naming convention (i.e., the one we set up with "git
remote add"). If somebody has tweaked this to be:

  refs/heads/$OLD/*

or even:

  refs/heads/foo/$OLD/bar

then we are just guessing about what they want. And I suspect such a
person would not use "git remote rename", anyway, but would instead edit
the config themselves. I'd rather make it safe for people using the
default config, and people who want to stray from that can deal with
updating the config themselves (since they would have to have done so to
get into that state in the first place).

Maybe we should even print a warning in that case.

-Peff
