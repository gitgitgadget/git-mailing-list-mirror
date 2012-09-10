From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC] blame: respect "core.ignorecase"
Date: Mon, 10 Sep 2012 12:13:25 -0400
Message-ID: <20120910161325.GB9435@sigill.intra.peff.net>
References: <1347210113-27435-1-git-send-email-ralf.thielow@gmail.com>
 <7v7gs3q9rp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Ralf Thielow <ralf.thielow@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 10 18:13:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TB6cE-0003hc-GY
	for gcvg-git-2@plane.gmane.org; Mon, 10 Sep 2012 18:13:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932137Ab2IJQNa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Sep 2012 12:13:30 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:39706 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757984Ab2IJQN2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Sep 2012 12:13:28 -0400
Received: (qmail 29038 invoked by uid 107); 10 Sep 2012 16:13:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 10 Sep 2012 12:13:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Sep 2012 12:13:25 -0400
Content-Disposition: inline
In-Reply-To: <7v7gs3q9rp.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205132>

On Sun, Sep 09, 2012 at 12:24:58PM -0700, Junio C Hamano wrote:

> Having said all that, I am not sure if the "fixing" is really the
> right approach to begin with.  Contrast these two:
> 
>     $ git blame MakeFILE
>     $ git blame HEAD -- MakeFILE
> 
> The latter, regardless of core.ignorecase, should fail, with "No
> such path MakeFILE in HEAD".  The former is merely an extension to
> the latter, in the sense that the main traversal is exactly the same
> as the latter, but on top, local modifications are blamed to the
> working tree.
> 
> If we were to do anything, I would think the most sane thing to do
> is a smaller patch to fix fake_working_tree_commit() where it calls
> lstat() and _should_ die with "Cannot lstat MakeFILE" on a sane
> filesystem.  It does not currently make sure the path exists in the
> HEAD exactly as given by the user (i.e. without core.ignorecase
> matching), and die when it is not found.

Yes, I think that is the only sensible thing here. The rest of this
email is me essentially me agreeing with you and telling you things you
already know, but I had a slightly different line of reasoning, so I
thought I would share.

As far as the original patch, if you are going to change blame, then it
is only logical to change the whole revision parser so that "git log --
MAKEFILE" works. And I do not think that is a direction we want to go.

core.ignorecase has never been about "make git case-insensitive". Git
represents a case-sensitive tree, and will always do so because of the
sha1 we compute over the tree objects. core.ignorecase is really "make
case-sensitive git work around your case-insensitive filesystem"[1].

If the proposal were instead to add a certain type of pathspec that is
case-insensitive[2], that would make much more sense to me. It is not
violating git's case-sensitivity because it is purely a _query_ issue.
And it is a feature you might use whether or not your filesystem is case
sensitive.

-Peff

[1] I was going to submit a patch to Documentation/config.txt to make
    this more clear, but IMHO the current text is already pretty clear.

[2] I did not keep up with Duy's work on pathspec magic-prefixes (and I
    could not find anything relevant in the code or documentation), but
    it seems like this would be a logical feature to support there.
