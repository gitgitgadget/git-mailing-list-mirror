From: Jeff King <peff@peff.net>
Subject: Re: Deleting the "current" branch in remote bare repositories
Date: Mon, 9 Feb 2009 13:28:43 -0500
Message-ID: <20090209182843.GA27109@coredump.intra.peff.net>
References: <20090207162754.5fb8b63f@perceptron> <94a0d4530902071405m33a0804er8030e14bea205898@mail.gmail.com> <20090208011802.2b7b9e74@perceptron> <7v1vu91d00.fsf@gitster.siamese.dyndns.org> <20090208111838.GD14359@coredump.intra.peff.net> <7v8wogzr3v.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jan =?utf-8?Q?Kr=C3=BCger?= <jk@jk.gs>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Git ML <git@vger.kernel.org>, obrien654j@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 09 19:30:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWata-0007Dk-9f
	for gcvg-git-2@gmane.org; Mon, 09 Feb 2009 19:30:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753619AbZBIS2r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2009 13:28:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751891AbZBIS2q
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Feb 2009 13:28:46 -0500
Received: from peff.net ([208.65.91.99]:46122 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752452AbZBIS2q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2009 13:28:46 -0500
Received: (qmail 4076 invoked by uid 107); 9 Feb 2009 18:29:01 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 09 Feb 2009 13:29:01 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 09 Feb 2009 13:28:43 -0500
Content-Disposition: inline
In-Reply-To: <7v8wogzr3v.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109098>

On Sun, Feb 08, 2009 at 11:05:40AM -0800, Junio C Hamano wrote:

> If you remove the current branch from a repository, the impact that
> operation causes the remote users of the repository would be the same
> whether the repository has or does not have a work tree.  And in that
> sense, I think it should apply equally.  The criteria is not "is it bare",
> but "is it used by people remotely".  IOW, you refuse deletion of the
> current branch if other people may fetch from it.

Here are two reasons why we might not want to conflate the two safety
valves:

 1. I'm concerned about it becoming more confusing for end users. Right
    now we don't even bother to look at denyCurrentBranch if we are in a
    bare repo. That is, it is easily explained as "this prevents a
    dangerous operation pushing into a non-bare repo, and if you have a
    bare repo, you don't have to care about or set this at all." But
    having it cover HEAD deletion, too, means that it is now "prevent
    some dangerous operations; some things are dangerous if your repo is
    non-bare, but safe otherwise.  But some of the operations are
    dangerous all the time".

    But maybe that is not really a concern. Most users should leave it
    set to the default unless they are clueful enough to know which
    operations are safe and which are not.

 2. It may not be fine-grained enough. If I am a clueful user with a
    post-receive hook, then I may want to set receive.denyCurrentBranch
    to "ignore". But that doesn't necessarily mean my hook gracefully
    handles _deletion_ of the branch. I may want to keep that set to
    "refuse", since it makes no sense for my workflow.

    Such a user is better served by a separate receive.denyDeleteHEAD
    option.

-Peff
