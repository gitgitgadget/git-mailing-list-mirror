From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] Fix premature call to git_config() causing t1020-subdirectory
 to fail
Date: Tue, 26 Feb 2008 19:53:57 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0802261933551.19665@iabervon.org>
References: <alpine.LNX.1.00.0802251604460.19024@iabervon.org> <200802260321.14038.johan@herland.net> <200802261640.48770.johan@herland.net> <alpine.LNX.1.00.0802261709180.19665@iabervon.org> <alpine.LSU.1.00.0802262239200.22527@racer.site>
 <alpine.LNX.1.00.0802261742260.19665@iabervon.org> <7vzltn2qsd.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	=?ISO-8859-15?Q?Kristian_H=F8gsberg?= <krh@redhat.com>,
	=?ISO-8859-15?Q?Santi_B=E9jar?= <sbejar@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 27 01:55:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUAZX-0006fS-9I
	for gcvg-git-2@gmane.org; Wed, 27 Feb 2008 01:54:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765647AbYB0AyA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Feb 2008 19:54:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765977AbYB0AyA
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Feb 2008 19:54:00 -0500
Received: from iabervon.org ([66.92.72.58]:58036 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751261AbYB0Ax7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Feb 2008 19:53:59 -0500
Received: (qmail 6743 invoked by uid 1000); 27 Feb 2008 00:53:57 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 27 Feb 2008 00:53:57 -0000
In-Reply-To: <7vzltn2qsd.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75196>

On Tue, 26 Feb 2008, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > On Tue, 26 Feb 2008, Johannes Schindelin wrote:
> >
> >> Hi,
> >> 
> >> On Tue, 26 Feb 2008, Daniel Barkalow wrote:
> >> 
> >> > Actually, I think I'll be leaving CONFIG_ENVIRONMENT alone entirely; I 
> >> > was only using it to override the setting that t5505 uses, but t5505 is 
> >> > just wrong to set it. So this is the right placement of git_config(), 
> >> > and the setenv and unsetenv aren't needed.
> >> 
> >> Well, existing git-clone.sh sets GIT_CONFIG.  So we have to unset any 
> >> existing GIT_CONFIG at least.
> >
> > As far as I can tell, that's a flaw in git-clone.sh; if the user has set 
> > GIT_CONFIG, it shouldn't be the case that every program other than 
> > git-clone obeys it while git-clone ignores it. (On the other hand, 
> > possibly every program other than git-config should ignore it, since it's 
> > only documented as affecting git-config.) git-clone.sh only sets it, I 
> > think, because it runs programs from the wrong context for them to do the 
> > right thing by default, not because it's specifically trying to override a 
> > user-provided setting.
> 
> When cloning locally, there are two repositories involved, and
> GIT_CONFIG if exists in the environment talks about the original
> one that gets cloned.

There's nothing in the documentation to suggest that you can use 
GIT_CONFIG to affect how the old repository is read, or that GIT_CONFIG 
doesn't affect the new repository. Actually, as far as I can tell, the 
configuration of a repository you're cloning (local or remote) doesn't 
matter at all. Note that GIT_DIR and GIT_WORK_TREE refer to the new repo, 
so it would be surprising for GIT_CONFIG to refer to the old one.

> Without setting GIT_CONFIG explicitly how would you set the 
> configuration that is about the new repository clone creates?

By setting GIT_DIR, which also makes everything else work right. (We may 
want to probe the old repository some by setting GIT_DIR to it 
temporarily, but we can just collect information that way, and then set it 
to the new one to configure it and set it up.)

My current design is to collect some initial information, create 
directories, and then set the work tree and git dir. Then we run fetch, 
configure things, etc., in the new context.

I'm not sure why git-clone.sh doesn't just set GIT_DIR to whatever it 
decides the git dir with be, and leave GIT_CONFIG alone (or unset it, if 
it's expected to mean something different).

	-Daniel
*This .sig left intentionally blank*
