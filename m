From: David Aguilar <davvid@gmail.com>
Subject: Re: Need some help on patching buildin-files // was: Looking for
 feedback and help with a git-mirror for local usage
Date: Sun, 14 Jun 2015 01:17:56 -0700
Message-ID: <20150614081754.GA15245@gmail.com>
References: <5579F318.7050503@kr217.de>
 <557AB9FC.30102@kr217.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Bernd Naumann <bernd@kr217.de>
X-From: git-owner@vger.kernel.org Sun Jun 14 10:18:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z437M-0004LM-AF
	for gcvg-git-2@plane.gmane.org; Sun, 14 Jun 2015 10:18:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751645AbbFNISH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Jun 2015 04:18:07 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:34737 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751417AbbFNISA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jun 2015 04:18:00 -0400
Received: by pacgb13 with SMTP id gb13so16317126pac.1
        for <git@vger.kernel.org>; Sun, 14 Jun 2015 01:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=xirMcxH0ULE8LjZQyCtHj/lc6kJwqSPdlD0oFXmswb0=;
        b=Lui0GmmgPFdJTcqGf2rHk7/lyN/b0yT35G3CCEAEtBM7q16A4/kc6V7dSwaenZHymR
         rFsXQ8DBkhjH1FiYalyrtnH6fqlHEgdd+HoHIu5pnM/vGMn7Y7aAFxMOT28d8T00HnMU
         7Sge5Uasx0RTCeypPltTvozxtHT9iAcUPgPFtPRm6duF7EPN5jDWLU0FdQJrbax/xZV7
         nROPZUzdDF5ulpOZ1UqBifNiO4sCmJ84iwOjJr44o9/jW/SQFks7f1igcVuIsVPEytIC
         3sBanRh3oLc9fyLcwmPmM3gpsYnhtjpCZQ+7n1W5m+qQ5riRbuBS+NiMsfZNUfE/mt2k
         5ncw==
X-Received: by 10.70.135.106 with SMTP id pr10mr37255644pdb.156.1434269879713;
        Sun, 14 Jun 2015 01:17:59 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPSA id po2sm8597131pbb.13.2015.06.14.01.17.58
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 14 Jun 2015 01:17:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <557AB9FC.30102@kr217.de>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271611>

On Fri, Jun 12, 2015 at 12:52:44PM +0200, Bernd Naumann wrote:
> Hello again,
> 
> After digging the code I may have got a clue where to start but I
> would  still appreciate some help from a developer, cause I have never
> learned to write C. (Some basics at school which happened over a
> decade ago.)
> 
> Currently I have questions on:
> 
> * How to patch clone: would cmd_clone() a good place? Or are there
> other calls which might be better. I think about to insert the check
> if a mirror will be setup or just updated, right after dest_exists.

If you'd still like to modify "git clone" itself, then the
"cmd_clone" entry point is certainly the place to start.
I would suggest exploring other alternatives, though.


Is it possible to use a caching HTTP proxy, so that "git clone"
goes through a local caching proxy?  I haven't tried this myself,
so maybe it's not even possible, but that seems like a natural
http-ish solution.


Another idea is to use Git's URL rewriting feature.  If your
clone URLs all follow a similar pattern then they can
automatically be rewritten to point to some other URL.

e.g. in ~/.gitconfig:

[url "file:///home/git/mirror/github.com/"]
	insteadOf = "https://github.com/"

This will make git clone from /home/git/mirror/github.com/
whenever it sees https://github.com/ URLs.

This is not perfect because it ends up cloning from your local
copies rather than setting up the references via --mirror, but
at least it avoids hitting the network.  You'll need to
periodically update your local mirrors, though.

If you prefer to keep ~/.gitconfig pristine then you could do it
in a wrapper script by injecting e.g. the "-c" config flags,

	git \
	-c url.file://foo/bar/.insteadOf=https://github.com/ \
	clone ...

> [...snip...]
> > 
> > I often build in example 'openwrt' with various build-scripts which
> > depends heavily on a fresh or clean environment and they omit many
> > sources via `git clone`, which results sometimes in over 100 MB of
> > traffic just for one build. /* Later needed .tar.gz source archives
> > are stored in a symlinked download directory which is supported by
> > 'openwrt/.config' since a few months... to reduce network traffic.
> > */

Why does a rebuild delete existing Git repositories?
That seems like a bad practice, and shouldn't be needed.
If possible, it would be worth improving the build scripts.

For example, a clone can be made pristine by doing
"git reset --hard && git clean -fdx".  Deleting a repository
just so that it can be re-cloned is very wasteful.

> > My connection to the internet is not the fastest in world and 
> > sometimes unstable, so I wanted to have some kind of local bare 
> > repository mirror, which is possible with `git clone --mirror`.
> > 
> > From these repositories I can later clone from, by calling `git 
> > clone --reference /path/to.git <url>`, but I do not wish to edit 
> > all the build-scripts and Makefiles.

Maybe it'd be possible to make just the "git clone" part of the
build scripts configurable?

That'd make it really easy to inject a wrapper script that scans
the arguments and injects the needed --mirror arguments, in the
case that the above options won't work.


> > So I wrote a git wrapper script (`$HOME/bin/git`), which checks if
> >  `git` was called with 'clone', and if so, then it will first 
> > clones the repository as a mirror and then clones from that local 
> > mirror. If the mirror already exists, then it will only be updated 
> > (`git remote update`). This works for now.
> > 
> > [...snip...]
> > 
> > Ok, so far, so good, but the implementation of the current 
> > shell-prototype looks way too hacky [0] and I have found some edge
> >  cases on which my script will fail: The script depends on the
> > fact that the last, or at least the second last argument is a
> > valid git-url, but the following is a valid call, too :
> > 
> > `git --no-pager \ clone git@github.com:openwrt/packages.git 
> > openwrt-packages --depth 1`
> > 
> > But this is not valid:
> > 
> > `git clone https://github.com/openwrt/packages.git --reference 
> > packages.git packages-2` or `git clone --verbose 
> > https://github.com/openwrt/packages.git packages-2 --reference 
> > packages.git`
> > 
> > 
> > I found out that git-clone actually also can only make a guess
> > what is the url and what not.

Another option is to rewrite the wrapper script in a better language.
For example, Python's argparse module can handle the above cases
with minimal fuss.

Anyways, as I said before, the root problem is really the build
scripts.  I bet modifying the build scripts to reuse existing
git repositories is easier than modifying "git clone".

cheers,
-- 
David
