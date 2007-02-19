From: Theodore Tso <tytso@mit.edu>
Subject: Re: [PATCH] Teach git-remote to update existing remotes by fetching from them
Date: Mon, 19 Feb 2007 07:52:19 -0500
Message-ID: <20070219125219.GD25490@thunk.org>
References: <E1HIzh2-0001Ph-T2@candygram.thunk.org> <7virdybu9a.fsf@assigned-by-dhcp.cox.net> <20070219073238.GA30030@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Feb 19 14:06:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJ8Do-0005bo-0V
	for gcvg-git@gmane.org; Mon, 19 Feb 2007 14:06:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932213AbXBSNGJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Feb 2007 08:06:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932217AbXBSNGJ
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Feb 2007 08:06:09 -0500
Received: from thunk.org ([69.25.196.29]:39452 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932213AbXBSNGH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Feb 2007 08:06:07 -0500
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtp   (Exim 4.50 #1 (Debian))
	id 1HJ8In-0005yG-7L; Mon, 19 Feb 2007 08:11:33 -0500
Received: from tytso by candygram.thunk.org with local (Exim 4.62)
	(envelope-from <tytso@thunk.org>)
	id 1HJ80B-0007OG-8a; Mon, 19 Feb 2007 07:52:19 -0500
Content-Disposition: inline
In-Reply-To: <20070219073238.GA30030@spearce.org>
User-Agent: Mutt/1.5.12-2006-07-14
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40123>

On Mon, Feb 19, 2007 at 02:32:38AM -0500, Shawn O. Pearce wrote:
> <personalwishlist>
> 
> It would be nice to define "gang remotes".  For example I want to
> be able to have:
> 
>   `git fetch cs`  ==  `git fetch cs-one; git fetch cs-two`
>   `git fetch jc`  ==  `git fetch origin; git fetch alt`
> 
> Why?  Well, I often have multiple remotes setup to the *same*
> repository depending on the SSH hostname I want to use to access
> that repository.  This has a lot to do with the way my firewalls
> are setup and where I'm physically connected at any given time.
> 
> Yes, I really do have multiple remotes setup to the access the
> same (remote) physical disk.  :)

Here are a couple of things that I'm thinking about doing with the
patch I submitted yesterday:

1) Change the configuration parameter from remote.fetch to
remotes.default.update, and let "git remote update" take a parameter,
"git remote update <name>", where it will look up the list of remotes
to fetch via remotes.<name>.update, and default <name> to "default" if
it is not specified.

2) In the case of <name> == default, if remotes.default.update does
not exist, it will update all remotes, skipping remotes where
remote.*.no_default_fetch is true.  (This allows people who want to
omit certain special case remotes that only work if their connection
to the intranet is up, etc., to be able to set up something
convenientl; but for people who have more complex setups, they will
have to use the method specified in (1) above.

I thought about doing this via git-fetch, but (1) git-fetch.sh is
already way too complicated as it is, and I see that JC is in the
process of rewriting portions of it to C; by implementing in
git-remote.perl I avoided potential patch conflicts, and (2) fetching
groups of remotes would be overloading concepts for git-fetch, which
makes not only the implementation hard, but also the potential
semantics.  i.e., what does this mean?

[remote "cs"]
	remote = cs-one
	remote = cs-two
	url = git://git.kernel.org/pub/scm/git/git.git
	fetch = +refs/heads/*:refs/remotes/origin/*

						- Ted
