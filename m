From: Phil Hord <phil.hord@gmail.com>
Subject: Re: Location-agnostic submodules
Date: Mon, 30 Apr 2012 16:39:49 -0400
Message-ID: <CABURp0qA9hK1fBd3rmLG61ErpbbzrcxO=AAmFOsoxjt=ozu09Q@mail.gmail.com>
References: <20120427143710.GA13953@pape.arcanes.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Pierre Thierry <pierre@nothos.net>
X-From: git-owner@vger.kernel.org Mon Apr 30 22:40:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SOxOL-0002bb-D1
	for gcvg-git-2@plane.gmane.org; Mon, 30 Apr 2012 22:40:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756901Ab2D3UkL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Apr 2012 16:40:11 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:39312 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756820Ab2D3UkK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Apr 2012 16:40:10 -0400
Received: by yhmm54 with SMTP id m54so1697210yhm.19
        for <git@vger.kernel.org>; Mon, 30 Apr 2012 13:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=g15uXRbZYyLaPtKguLI608ISuSnIAewEQVWIBoZSXIw=;
        b=qYRBIjdU2bcfFMvDgSCwIe+IziX9fx9IKfP0Kdh4oq+c+IgYXHrDWJXtWoo9TEoSo/
         EkiA977kYheClUZrIcBOXZMNrppPZghQn48YxQdQzN95hNQviMKTtpWPmemkR7vKUXYh
         WJgoCe91j4D13O6XVnNzBkUHGQVsggReyaHWV3L0EbmduT9X2493NyUkMwmoC61kLD2V
         oeIve3qDeGFHrdd5U7ncWEAocSbs3u2K+WJYMk4qg2RzJHAmRuBE+GqiElPM7VnJzv/T
         8ZKEvSuhvjcqWd5RytT/zpE3UJQPENQndx419QLbFxrwF1HJ81qGabGB94gRYaYyWgeb
         EkwQ==
Received: by 10.236.125.168 with SMTP id z28mr19020064yhh.120.1335818409591;
 Mon, 30 Apr 2012 13:40:09 -0700 (PDT)
Received: by 10.146.122.15 with HTTP; Mon, 30 Apr 2012 13:39:49 -0700 (PDT)
In-Reply-To: <20120427143710.GA13953@pape.arcanes.fr.eu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196606>

On Fri, Apr 27, 2012 at 10:37 AM, Pierre Thierry <pierre@nothos.net> wrote:
> I just discovered the workings of the submodule command, and as I have
> grown to like the fact that a repository is not unique with Git, and
> specifically that it has no unique or central location, I'm bothered
> by how submodule works.
>
> Would there be any major issue in having (1) submodule to be able to
> clone the submodules from the super repository when they are available
> there and (2) having zero, one or many addresses for each submodule,
> used as hints (obviously not used when (1) is satisfied)?

Maybe something like this:
    [submodule "foo"]
        path = foo-mod
        url = ../foo ../foo-alternate
https://someplace.com/git/foo.git  https://kernel.org/git/foo


I think the problem now will be that you have an indeterminate source
URL for your submodule.  So far as all of your alternate locations are
the same it is probably not a problem.  But if one of them lags behind
the others by a day or even an hour, then you may have gitlinks in
your superproject which have not made it into the lagging mirror yet.
And this will cause problems.

Moreover, each time you clone the repository you may get different
results.  This would be confusing.

But aside from these administrative issues, I think this could work.

> When the repository is not bare, the submodules would be found at
> their place in the tree, nothing difficult here. When the repository
> is bare, there could be a tree with the bare repositories of the
> submodules.

I think this could work even if the repository were bare; these days,
submodule repositories are stored in .git/modules/* anyway.  So if it
were possible to craft a bare repository with this structure in place,
then even "bare" repos could support embedded submodules like this.

I think this amplifies the relative URL problem.  That problem exists
anyway, but this maybe gives it more ways to fail.

> This could be done by a new subcommand, that would take a remote as an
> optional argument, its default being origin, as usual:
>
> $ git submodule clone origin
>
> As I see it, adding this 'clone' subcommand for the case where the
> repository is not bare couldn't add any compatibility issue, so if I'm
> right on this point, I'd like to try and implement this soon.

I don't think there is any need for a new 'clone' command since the
clone porcelain already understands submodules.  Maybe a new switch is
needed to control the remote to use, but this switch is needed for
more cases than just clone.

   git remote add shared http://elsewhere.com/project.git
   git submodule init --remote=shared foo

This could also solve some existing ambiguities with relative paths
and with 'git-submodule sync', for example.

At first you worried me, but now I am starting to like this idea more and more.

Phil
