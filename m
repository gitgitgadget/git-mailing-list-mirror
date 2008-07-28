From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: theirs/ours was Re: [PATCH 6/6] Add a new test for using a custom merge strategy
Date: Mon, 28 Jul 2008 16:00:42 -0400
Message-ID: <32541b130807281300yb93884anf28f3ddb2cc507d@mail.gmail.com>
References: <bd6139dc0807280754x76b6ffedg6bf756dfce23f1e3@mail.gmail.com>
	 <20080728185604.GA26322@sigill.intra.peff.net>
	 <alpine.DEB.1.00.0807282008470.8986@racer>
	 <20080728192651.GA26677@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	sverre@rabbelier.nl, "Git Mailinglist" <git@vger.kernel.org>,
	"Miklos Vajna" <vmiklos@frugalware.org>
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jul 28 22:01:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNYuh-0004H3-9Q
	for gcvg-git-2@gmane.org; Mon, 28 Jul 2008 22:01:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752998AbYG1UAp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2008 16:00:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752602AbYG1UAp
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 16:00:45 -0400
Received: from qw-out-2122.google.com ([74.125.92.27]:36389 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752160AbYG1UAo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2008 16:00:44 -0400
Received: by qw-out-2122.google.com with SMTP id 3so300771qwe.37
        for <git@vger.kernel.org>; Mon, 28 Jul 2008 13:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=DqzqgIl/dIqnbryj1fyi0XAVEV025A5yt3fqd8lqIj8=;
        b=sh0FbiqnYy0/NxM6pcmEJ6YwOwEU4XdRo+TKkghdzFKgVy8Q/Uk9pAtP6zEHy7ShG9
         3bbF4NEJ9G7lb10rPMqacDhguY7mNFbRglX/XvEHu26qY5Wv8PMkcca5j2AXwKYUKnnA
         XWQIK/8euMvMgaKCvr1fwXWhBOlS0AJYRtaKc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=uqhRzZri2j6tHIrDhW6zo+Hrni/dI5JHk8N2dIuy0iHn0NChC6d9GImMUGxahP+oDC
         OgpXnNjr122COe4hBwUYi9xeY92TXHow9ARXoF75e+YLM93TEAk8ud5w5sHRMOMyipzi
         lZQFHDTK1wUPfAQwRnD+zK96GfVlB+sOBsx9c=
Received: by 10.214.80.15 with SMTP id d15mr340934qab.80.1217275242480;
        Mon, 28 Jul 2008 13:00:42 -0700 (PDT)
Received: by 10.150.96.5 with HTTP; Mon, 28 Jul 2008 13:00:42 -0700 (PDT)
In-Reply-To: <20080728192651.GA26677@sigill.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90496>

On 7/28/08, Jeff King <peff@peff.net> wrote:
> My situation was two long-running branches, "stable" and "devel",
>  both of which were worked on by many developers. One person was in
>  charge of integration and branch management. They wanted "stable" to
>  get the contents of "devel" (which were now ready for release), ignoring
>  any small fixes that had been done on "stable" (since they had all been
>  moved over to "devel" previously, but in subtly different ways that
>  would create conflicts). And "git reset" was not an option, because they
>  wanted to keep the history of "stable" in case those fixes needed to be
>  looked at later.
>
>  So the logical sequence was:
>
>   git checkout production
>   git merge -s theirs master

I have to say, this somehow feels wrong to me.  What you're saying is
essentially that "stable has already been merged into devel" followed
by "and now we want to catch stable up to devel."

It really is two separate thoughts, and merging devel directly into
stable - literally by *undoing* all the changes from stable - doesn't
sound like it should be considered a safe operation.

Personally, I've started enjoying the "--no-ff" option to git-merge.
That way I can do

   git checkout master
   git merge production
   git checkout production
   git merge --no-ff master

The latter merge isn't really a "merge" since it could have been just
fast forwarded.  But it avoids the aesthetic problems of commits like
"merge production into master" showing up in the master branch.  It
also means that "git reset --hard HEAD^" works whether or not a
fastforward would have been theoretically possible.

Of course, this whole discussion is really just about how to make your
log look cleaner, and we could debate forever about that.  It may make
sense to simply provide "theirs" as an exact mirror of "ours" if only
in the name of symmetry.

Have fun,

Avery
