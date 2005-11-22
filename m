From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: auto-packing on kernel.org? please?
Date: Tue, 22 Nov 2005 14:13:40 +0000
Message-ID: <b0943d9e0511220613h5978a600l@mail.gmail.com>
References: <Pine.LNX.4.64.0510131113490.15297@g5.osdl.org>
	 <20051121190151.GA2568@hpsvcnb.fc.hp.com>
	 <Pine.LNX.4.64.0511211110480.13959@g5.osdl.org>
	 <4382AC11.5090209@citi.umich.edu>
	 <Pine.LNX.4.64.0511212134330.13959@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Chuck Lever <cel@citi.umich.edu>, Carl Baldwin <cnb@fc.hp.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Nov 22 15:16:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EeYu1-0005Rb-4I
	for gcvg-git@gmane.org; Tue, 22 Nov 2005 15:13:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964943AbVKVONm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 Nov 2005 09:13:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964944AbVKVONm
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Nov 2005 09:13:42 -0500
Received: from xproxy.gmail.com ([66.249.82.192]:61489 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964943AbVKVONm convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Nov 2005 09:13:42 -0500
Received: by xproxy.gmail.com with SMTP id i30so893357wxd
        for <git@vger.kernel.org>; Tue, 22 Nov 2005 06:13:41 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UQ04lUaTvkDLJkHlyBfjvxYTY5KTZloiCoSR26Yxw1ewI5MXECqirMHJs0NKTSFk8of9byZkfiwZ3ISHv4nSy0KrSWFXV+VGBGD1j0oUZyH1YGfCby1yXA8roML+9UcTi0SLiEa1AIMfTy3qQMg9hZaRR4Jd4uZirQdL/c96+HY=
Received: by 10.70.103.10 with SMTP id a10mr3588115wxc;
        Tue, 22 Nov 2005 06:13:40 -0800 (PST)
Received: by 10.70.27.12 with HTTP; Tue, 22 Nov 2005 06:13:40 -0800 (PST)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0511212134330.13959@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12549>

On 22/11/05, Linus Torvalds <torvalds@osdl.org> wrote:
> On Tue, 22 Nov 2005, Chuck Lever wrote:
> > there are some things repacking does that breaks StGIT, though.
> >
> > git repack -d
> >
> > seems to remove old commits that StGIT was still depending on.
>
> If that is true, then "git-fsck-cache" probably also reports errors on a
> StGIT repository. No? Basically, it implies that the tool doesn't know how
> to find all the "heads".

Indeed, 'git repack -d'  or 'git prune' might remove the patches which
are not applied since there is no link to them from .git/refs/.

> Could somebody (Catalin?) perhaps tell how tools like git-fsck-cache and
> git-repack could figure out which objects are still in use by stgit?

They don't figure this out at the moment. I initially thought about
implementing these commands in StGIT so that they would pass the
proper references.

> Preferably with some generic mechanism that _other_ projects (not just
> stgit) might want to use?
>
> The preferred way would be to just list the references somewhere under
> .git/refs/stgit, in which case fsck and repack should pick them up
> automatically (so clearly stgit doesn't do that right now ;).

I thought about adding .git/refs/patches/<branch>/* files
corresponding to the every StGIT patch. Are the above git commands
looking at all depths in the .git/refs/ directory?

> > git repack -a -n
> >
> > seems to work fine with StGIT,
>
> Well, it "works", but not "fine". Since it doesn't know about the stgit
> objects, it won't ever pack them.
>
> But maybe that's what stgit wants (since they are "temporary"), but it
> does mean that if you see a big advantage from packing, you might be
> losing some of it.

The 'git repack -a' command would include the applied patches in the
newly created pack but leave out the unapplied ones. It would be even
better to leave all of them out since the StGIT patches are frequently
changed but an independent mechanism for this would complicate GIT -
'git repack' shouldn't pack any of the objects found in
.git/refs/patches/, even if they are reachable via .git/refs/heads/*
(and maybe call the patches directory something like
.git/refs/unpackable or volatile).

--
Catalin
