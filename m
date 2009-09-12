From: Jeff King <peff@peff.net>
Subject: Re: git push --confirm ?
Date: Sat, 12 Sep 2009 14:43:42 -0400
Message-ID: <20090912184342.GB20561@coredump.intra.peff.net>
References: <1252777897.2974.24.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Colin Walters <walters@verbum.org>
To: Owen Taylor <otaylor@redhat.com>
X-From: git-owner@vger.kernel.org Sat Sep 12 20:43:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmXZg-0003MA-70
	for gcvg-git-2@lo.gmane.org; Sat, 12 Sep 2009 20:43:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754876AbZILSno (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Sep 2009 14:43:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754865AbZILSnn
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Sep 2009 14:43:43 -0400
Received: from peff.net ([208.65.91.99]:51839 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754828AbZILSnn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Sep 2009 14:43:43 -0400
Received: (qmail 13645 invoked by uid 107); 12 Sep 2009 18:44:03 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 12 Sep 2009 14:44:03 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 12 Sep 2009 14:43:42 -0400
Content-Disposition: inline
In-Reply-To: <1252777897.2974.24.camel@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128282>

On Sat, Sep 12, 2009 at 01:51:37PM -0400, Owen Taylor wrote:

>  * An initial --dry-run pass is done but with more verbosity -
>    for updates of existing references, it would show what commits
>    were being added or removed in a one-line format.
> 
>  * The user is prompted if they want to proceed
>  
>  * If the user agrees, then the push is run without --dry-run
>
> [...]
>
> I think this wouldn't be too hard to add to 'git push', though
> I haven't tried to code it. Yes, it's not atomic without protocol
> changes - I think that's OK:

I have never wanted such a feature, so maybe I am a bad person to
comment, but I don't see much advantage from a UI standpoint over what
we have now. Which is "git push --dry-run", check to see if you like it,
and then re-run without --dry-run. If you just want to see more output
in the first --dry-run, then that is easy to do with an alternate
format.

But what _would_ be useful is doing it atomically. You can certainly do
all three of those steps from within one "git push" invocation, and I
think that is enough without any protocol changes. The protocol already
sends for each ref a line like:

  <old-sha1> <new-sha1> <ref>

and receive-pack will not proceed with the update unless the <old-sha1>
matches what is about to be changed.

>  - If the push isn't being forced intermediate ref updates will
>    be caught as a non-fast-forward in the second pass.
> 
>  - If the push is being forced, you might overwrite someone else's
>    push anyways even without --confirm.

Yeah, "--force" is not very fine-grained. I wonder if rather than a
complete --confirm you would rather have something iterative like:

  $ git push --interactive
  Pushing to server:/path/to/repo.git
    * [new branch]      topic -> topic
  Push this branch [Yn]?
      5ad9dce..cfc497a  topic -> topic
  Push this branch [Yn]?
      5ad9dce...cfc497a topic -> topic (non-fast forward)
  Force this branch [yN]?

where of course the actual output text and y/n defaults are subject to
debate. You could even have a 'v' option at each prompt to visualize the
differences in gitk so you can easily get more information on what you
might be overwriting in a non-fast-forward scenario.

-Peff
