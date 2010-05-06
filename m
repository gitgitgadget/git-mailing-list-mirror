From: Jeff King <peff@peff.net>
Subject: Re: 1.7.2 cycle will open soon
Date: Thu, 6 May 2010 01:52:36 -0400
Message-ID: <20100506055236.GA16151@coredump.intra.peff.net>
References: <7vaaselxe8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 06 07:52:47 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9u0s-0003dz-4L
	for gcvg-git-2@lo.gmane.org; Thu, 06 May 2010 07:52:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751613Ab0EFFwk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 May 2010 01:52:40 -0400
Received: from peff.net ([208.65.91.99]:34518 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750880Ab0EFFwk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 May 2010 01:52:40 -0400
Received: (qmail 2568 invoked by uid 107); 6 May 2010 05:52:53 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 06 May 2010 01:52:53 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 06 May 2010 01:52:36 -0400
Content-Disposition: inline
In-Reply-To: <7vaaselxe8.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146439>

On Tue, May 04, 2010 at 10:39:59PM -0700, Junio C Hamano wrote:

> It appears that the tip of 'maint' and 'next' (but curiously not 'master')
> do not pass test t1504 on at least FreeBSD right now, but I don't have
> enough energy to hunt things down tonight.

The culprit is Jonathan's 3bf7886 (test-lib: Let tests specify commands
to be run at end of test, 2010-05-02). FreeBSD's /bin/sh doesn't
propagate $? over an eval:

  $ /bin/sh
  $ false; echo $?
  1
  $ false; eval 'echo $?'
  0
  $ eval 'false; echo $?' ;# but it still works inside, of course
  1

Looking at that patch, I don't see any reason that eval_ret needs to be
set inside the eval. If we have multiple test_when_finished calls, we
keep setting and propagating eval_ret, which doesn't make much sense to
me.  Why not just:

  test_run_ () {
    test_cleanup=
    eval >&3 2>&4 "$1"
    eval_ret=$?
    eval >&3 2>&4 "$test_cleanup"
    return 0
  }

  test_when_finished () {
    test_cleanup="$*; $test_cleanup"
  }

Am I missing something?

-Peff
