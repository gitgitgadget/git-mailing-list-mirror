From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/4] make pathless 'add [-u|-A]' warning less noisy
Date: Tue, 19 Mar 2013 00:25:14 -0400
Message-ID: <20130319042514.GA4807@sigill.intra.peff.net>
References: <20130313040845.GA5057@sigill.intra.peff.net>
 <20130313041037.GB5378@sigill.intra.peff.net>
 <20130319034415.GI5062@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 19 05:25:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHo7P-00085H-El
	for gcvg-git-2@plane.gmane.org; Tue, 19 Mar 2013 05:25:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755088Ab3CSEZU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Mar 2013 00:25:20 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:56878 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755074Ab3CSEZT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Mar 2013 00:25:19 -0400
Received: (qmail 23502 invoked by uid 107); 19 Mar 2013 04:27:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 19 Mar 2013 00:27:02 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 19 Mar 2013 00:25:14 -0400
Content-Disposition: inline
In-Reply-To: <20130319034415.GI5062@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218479>

On Mon, Mar 18, 2013 at 08:44:15PM -0700, Jonathan Nieder wrote:

> >                                                          The
> > config option added by this patch gives them such an option.
> 
> I suspect the need for this config option is a sign that the warning
> is too eager.  After all, the whole idea of the change being safe is
> that it shouldn't make a difference the way people usually use git,
> no?
> 
> In other words, how about the following patches?  With them applied,
> hopefully no one would mind even if the warning becomes a fatal error.

Clever. I think it would help in my case. I sometimes follow the
workflow you describe in patch 3 (i.e., just working in a subdir), and
sometimes do something more like:

  $ vi foo.c
  $ cd t
  $ vi tXXXX-foo.sh
  $ ./tXXXX-foo.sh
  $ git add -u

With your patches, we would continue to warn about the second case, but
I think that is a good thing; git is not doing what I want. But by
reducing the false positives from the first case, I would start to
actually pay attention to the warning more.

> Jonathan Nieder (4):
>   add: make pathless 'add [-u|-A]' warning a file-global function
>   add: make warn_pathless_add() a no-op after first call
>   add -u: only show pathless 'add -u' warning when changes exist outside cwd
>   add -A: only show pathless 'add -A' warning when changes exist outside cwd

I don't see anything obviously wrong with the patches themselves. I
wonder if we would want to change the warning to be more explicit that
yes, there really were files that were impacted by this. And possibly
even list them.

I suspect I would not even mind that becoming the final behavior.  I.e.,
going to:

  $ cd subdir && git add -u
  warning: Using 'git add -u' without a pathspec operates only on the
  current subdirectory. Updates from the following files were NOT
  staged:

    file1
    file2
    other-subdir/file3

now, and then eventually converting the warning into a fatal error (and
demanding that the user use ":/" or "." as appropriate).

But in the long run, I guess defaulting to ":/" will be more convenient,
so there is no point in complaining about the ambiguity forever. And in
that case, since the warning is just a placeholder, I don't know that
it's worth much effort to make it fancier.

-Peff
