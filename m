From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v1 1/3] Introduce config variable "diff.primer"
Date: Sun, 25 Jan 2009 22:12:07 -0500
Message-ID: <20090126031206.GB14277@sigill.intra.peff.net>
References: <1232904657-31831-1-git-send-email-keith@cs.ucla.edu> <1232904657-31831-2-git-send-email-keith@cs.ucla.edu> <7v1vurf7lq.fsf@gitster.siamese.dyndns.org> <alpine.GSO.2.00.0901251345240.12651@kiwi.cs.ucla.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Keith Cascio <keith@CS.UCLA.EDU>
X-From: git-owner@vger.kernel.org Mon Jan 26 04:13:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRHur-0005fC-D9
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 04:13:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751224AbZAZDMM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jan 2009 22:12:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751154AbZAZDMM
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jan 2009 22:12:12 -0500
Received: from peff.net ([208.65.91.99]:58603 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750970AbZAZDML (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jan 2009 22:12:11 -0500
Received: (qmail 31872 invoked by uid 107); 26 Jan 2009 03:12:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Sun, 25 Jan 2009 22:12:17 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 25 Jan 2009 22:12:07 -0500
Content-Disposition: inline
In-Reply-To: <alpine.GSO.2.00.0901251345240.12651@kiwi.cs.ucla.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107163>

On Sun, Jan 25, 2009 at 06:40:02PM -0800, Keith Cascio wrote:

> I agree opt-in is always better with new grammar/semantics.  However,
> the constraint I was trying to live inside is: if I call "git diff" on
> the command line with no options at all, then primer active.  Yet
> perhaps that's not possible, and the only way to do primer is to
> require opt-in spelled "--primer".  Then I can tell bash to alias
> 'gitdiff' as 'git diff --primer' and use that on the command line.

What's the point of aliasing something that isn't "git diff" to "git
diff --primer"? At that point, couldn't you just do away with --primer
entirely and alias "gitdiff" to "git diff --whatever --your --primer
--options --are"?

Anyway, I think that isn't necessary. We _do_ have a mechanism to handle
this already: some commands are plumbing, and must have stable
interfaces, and some commands are porcelain, and can do your magic
automatically. For example, gitk doesn't actually call "git diff"; it
calls "git diff-tree", "git diff-index", etc.

So if you just want this from the command line, then I think it is safe
to have "git diff" always respect "diff.primer", and scripts shouldn't
be impacted.

But this can break down in two ways:

  1. Sometimes we blur the line of plumbing and porcelain, where
     functionality is available only through plumbing. For example,
     gitweb until recently called "git diff" because there is no other
     way to diff two arbitrary blobs. But the solution there is, I
     think, to make that functionality available through plumbing. Not
     to disallow enhancements to porcelain.

  2. When you want a script to take advantage of porcelain-like options,
     the situation is much more difficult (and this is what Junio was
     talking about in his last mail).

     What I think is sane is:

       a. You grow new feature X.
       b. Porcelain takes advantage of any config that asks us to use X.
       c. Plumbing does _not_ respect such config, but will respect
          command line options.
       d. Scripts control which command line options they use; when the
          script writer decides feature X will not interfere (either
          because it is harmless to the script's use, or because the
          script is enhanced to handle the new behavior), then it can
          pass an "--allow-X" command line option.

     And of course that has two disadvantages (and I'm running out of
     numbering schemes):

       I. You have to wait for the script to be updated before you can
          start using X, even if _you_ know that it's harmless.

      II. Point (d) is not always true. Junio mentioned the fact that
          gitk passes command line parameters blindly to rev-list, which
          is potentially unsafe. Up until now, our attitude has been "if
          it hurts, don't do it". In other words, if you call "gitk
          --reverse" and it looks ugly, then it is your fault. :)

-Peff
