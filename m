From: Jeff King <peff@peff.net>
Subject: Re: [RFC] a tale of Git 2.5, ssh transport and GIT_* environment
 variables
Date: Fri, 4 Sep 2015 10:26:31 -0400
Message-ID: <20150904142630.GA11830@sigill.intra.peff.net>
References: <CAOxFTcx9E_FtYD_Jn3+S3j-rwGO+hJSVXUC2S5ZBB6der7dUuw@mail.gmail.com>
 <20150904125448.GA25501@sigill.intra.peff.net>
 <CAOxFTcwYJqFHrBkie19Fm3AqeYmSLRNBpBtOAkiYmfO9UgN-0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 04 16:26:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXrwr-0002K7-No
	for gcvg-git-2@plane.gmane.org; Fri, 04 Sep 2015 16:26:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932953AbbIDO0e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Sep 2015 10:26:34 -0400
Received: from cloud.peff.net ([50.56.180.127]:54978 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932767AbbIDO0d (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Sep 2015 10:26:33 -0400
Received: (qmail 23337 invoked by uid 102); 4 Sep 2015 14:26:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 04 Sep 2015 09:26:33 -0500
Received: (qmail 25331 invoked by uid 107); 4 Sep 2015 14:26:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 04 Sep 2015 10:26:38 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 04 Sep 2015 10:26:31 -0400
Content-Disposition: inline
In-Reply-To: <CAOxFTcwYJqFHrBkie19Fm3AqeYmSLRNBpBtOAkiYmfO9UgN-0g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277312>

On Fri, Sep 04, 2015 at 04:02:09PM +0200, Giuseppe Bilotta wrote:

> So, I've at least been able to circumscribe the problem to: server git
> 1.7.0.4, client git 2.5, GIT_WORK_TREE being sent over the ssh
> connection. I'll see if I can find some time to do some proper
> bisecting next week.

That sounds like progress. I was hoping I could replicate it with that
information, but I still can't:

  LOCAL_GIT=git.v2.5.0
  REMOTE_GIT=/home/peff/compile/git/bin-wrappers/git

  $ $LOCAL_GIT version
  git version 2.5.0

  $ ssh git.peff.net $REMOTE_GIT version
  git version 1.7.0.4

  $ ssh git.peff.net "rm -rf /tmp/foo.git; $REMOTE_GIT init --bare /tmp/foo.git"
  $ GIT_DIR=$PWD/.git GIT_WORK_TREE=$PWD $LOCAL_GIT push \
      --receive-pack="env | grep GIT >&2; $REMOTE_GIT receive-pack" \
      git.peff.net:/tmp/foo.git HEAD:branch

  GIT_DIR=/home/peff/tmp/.git
  GIT_WORK_TREE=/home/peff/tmp
  GIT_PREFIX=
  Counting objects: 3, done.
  Writing objects: 100% (3/3), 208 bytes | 0 bytes/s, done.
  Total 3 (delta 0), reused 0 (delta 0)
  To git.peff.net:/tmp/foo.git
   * [new branch]      HEAD -> branch

Interestingly, if I try pushing straight to master, the remote side
complains about trying to push the checked-out branch, even though it's
a bare repo (presumably it's getting confused by the GIT_WORK_TREE
setting; so that's _a_ bug, but not the one you are seeing).

So I'm not sure what is different about my setup and yours.

-Peff
