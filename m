From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Commit cce8d6fdb introduces file t/t5100/nul, git tree is now
 incompatible with Cygwin (and probably Windows)
Date: Wed, 28 May 2008 14:19:17 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0805281326520.19665@iabervon.org>
References: <483AC2CE.7090801@gmail.com> <7vy75vvtxo.fsf@gitster.siamese.dyndns.org> <32541b130805280933r573d59d0mf9cdc09f5e5a6a17@mail.gmail.com> <7vfxs2uytm.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 28 20:20:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1QFy-0008Jq-Lb
	for gcvg-git-2@gmane.org; Wed, 28 May 2008 20:20:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751919AbYE1STY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2008 14:19:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753820AbYE1STX
	(ORCPT <rfc822;git-outgoing>); Wed, 28 May 2008 14:19:23 -0400
Received: from iabervon.org ([66.92.72.58]:40221 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753904AbYE1STX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2008 14:19:23 -0400
Received: (qmail 30286 invoked by uid 1000); 28 May 2008 18:19:17 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 28 May 2008 18:19:17 -0000
In-Reply-To: <7vfxs2uytm.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83120>

On Wed, 28 May 2008, Junio C Hamano wrote:

> "Avery Pennarun" <apenwarr@gmail.com> writes:
> 
> > As an unhappy Windows user myself (sometimes), I think it might be
> > better to simply fix git to *survive* failing to create files like
> > 'nul' on Win32, rather than trying to *fix* such files in the repo.
> > It sounds (from the original post) like git has a *fatal* error
> > ("cannot be checked out on cygwin") when trying to create 'nul'.
> 
> Please learn to think before typing, let alone sending such a message to
> waste other people's time.
> 
> We give the user an error message, and signal error by exiting with
> non-zero.  You cannot have that path on the system, and we are being
> honest about it.  It is not like we are suddenly painting the screen in
> blue and refusing to get any more user input when you try to check out
> such a tree.  Which part of that is _not_ surviving?
> 
> The system with a *fatal* error is not git but the one that does not want
> an not-so-unreasonable name "NUL" on it.  Git survives on such a system
> and tells you what happened --- you cannot do certain things, such as
> checking out such a tree.  You live with it, or get a better system ;-)
> 
> What alternatives do you want to implement?  Certainly not silently
> creating "nul-garbage" file instead and pretend that nothing bad happened,
> as that would lead to madness.

Report a non-fatal error, mark in the index that that entry is not 
reflected in the working directory, and allow the user to manipulate it 
with commands that don't really need the working directory content.

$ git checkout origin/master
Warning: couldn't create 't/t5100/nul' in your working directory; ignoring 
working directory for this filename.
$ git mv t/t5100/nul t/t5100/nul-plain
$ ls t/t5100/nul-plain
t/t5100/nul-plain

The working directory doesn't really have to be absolutely vital to git's 
functioning (of course, the project you've checked out is going to have 
problems unless you fix things). In particular, it should be possible, on 
a machine with a broken filesystem, to modify a project that triggers the 
filesystem breakage to not trigger it, rather than having to rely on 
either read-tree/update-index --cachinfo/write-tree or a helpful user of a 
non-broken system to get things working again.

Git should, I think, even be able to figure out by itself when to not 
trust the filesystem; if open gives EEXIST, but readdir doesn't list it, 
it's a filesystem problem and we should work around it.

	-Daniel
*This .sig left intentionally blank*
