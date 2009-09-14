From: Jeff King <peff@peff.net>
Subject: Re: could not detach HEAD error didn't identify the cause of the
 issue
Date: Mon, 14 Sep 2009 07:22:11 -0400
Message-ID: <20090914112211.GC9216@sigill.intra.peff.net>
References: <4AAD8AE0.9070305@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Ben Bradshaw <ben@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Mon Sep 14 13:22:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mn9da-0007qS-SA
	for gcvg-git-2@lo.gmane.org; Mon, 14 Sep 2009 13:22:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755355AbZINLWL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Sep 2009 07:22:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755345AbZINLWK
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Sep 2009 07:22:10 -0400
Received: from peff.net ([208.65.91.99]:60254 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755349AbZINLWJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Sep 2009 07:22:09 -0400
Received: (qmail 24033 invoked by uid 107); 14 Sep 2009 11:22:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Mon, 14 Sep 2009 07:22:31 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 14 Sep 2009 07:22:11 -0400
Content-Disposition: inline
In-Reply-To: <4AAD8AE0.9070305@catalyst.net.nz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128446>

On Mon, Sep 14, 2009 at 12:14:24PM +1200, Ben Bradshaw wrote:

> I was asked to post this issue to the list, I've just had git tell me it
> can't detach HEAD which left me scratching mine as to the cause and fix.
> Turns out if I have local untracked files that the remote branch also
> has then this error will trigger. I have included my shell backlog
> (client data removed). In this example the site_map folder was present
> on master and I had a local, untracked copy.
> 
> git can obviosly detect this issue and stop my local copy getting in a
> bad state, but an error message such as "sites/all/modules/site_map/ is
> present in HEAD but is untracked locally, unable to apply changes" (or
> something to point the finger) would be much appreciated.

I couldn't reproduce it here; I get such a message.

  # set up forked repo, "another" exists only on master
  $ mkdir repo && cd repo
  $ git init
  $ echo content >file && git add file && git commit -m base
  $ echo content >another && git add another && git commit -m another
  $ git checkout -b other HEAD^
  $ echo changes >file && git commit -a -m changes

  # add untracked "another" here
  $ echo untracked >another

  # try rebase
  $ git rebase master
  First, rewinding head to replay your work on top of it...
  error: Untracked working tree file 'another' would be overwritten by merge.
  could not detach HEAD

  # try git pull --rebase, in case it hides the message
  $ git config branch.other.remote .
  $ git config branch.other.merge refs/heads/master
  $ git pull --rebase
  From .
   * branch            master     -> FETCH_HEAD
  First, rewinding head to replay your work on top of it...
  error: Untracked working tree file 'another' would be overwritten by merge.
  could not detach HEAD

I'll admit the "could not detach HEAD" message would probably be better as:

  rebase: unable to move HEAD to 'master', aborting rebase

or something similar.

What version of git are you using? What does my test case above produce
for you?

-Peff
