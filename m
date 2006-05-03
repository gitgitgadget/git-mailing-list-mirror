From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: gitk highlight feature
Date: Wed, 3 May 2006 09:57:51 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605030946260.4086@g5.osdl.org>
References: <17495.61142.677439.171773@cargo.ozlabs.ibm.com>
 <Pine.LNX.4.64.0605021659430.4086@g5.osdl.org> <Pine.LNX.4.64.0605021721540.4086@g5.osdl.org>
 <17496.7073.507895.484698@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 03 18:58:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FbKfn-0007Ei-9Q
	for gcvg-git@gmane.org; Wed, 03 May 2006 18:57:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030249AbWECQ54 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 May 2006 12:57:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030253AbWECQ5z
	(ORCPT <rfc822;git-outgoing>); Wed, 3 May 2006 12:57:55 -0400
Received: from smtp.osdl.org ([65.172.181.4]:58087 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030249AbWECQ5z (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 May 2006 12:57:55 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k43GvqtH007599
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 3 May 2006 09:57:52 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k43GvpTI007040;
	Wed, 3 May 2006 09:57:51 -0700
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17496.7073.507895.484698@cargo.ozlabs.ibm.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19501>



On Wed, 3 May 2006, Paul Mackerras wrote:
>
> Linus Torvalds writes:
> 
> > The obvious way to do it would be to just have two buttons per view: one 
> > exclusive one (for the main view - only one selected at a time), and the 
> > other one for the "highlight" one where you could allow multiple views to 
> > be selected for highlighting.
> 
> That's hard to do in a menu, but I could do it in a separate pane.
> Or, I could draw a series of tabs between the menu bar and the
> graph/headline/author/date panes.  Each tab would have the view name,
> a radiobutton to select it for highlighting, and a close button.

Actually, having used this thing (and thought about) some more, I'm afraid 
that I'll have to just admit that my whole "highlight" thing was 
misdesigned.

One is just an interface issue, and I think that it would be fixed by just 
removing the highlight entry from the "view" menu, and making it a menu of 
its own. That, I think, would fix the user interface to be more obvious 
and intuitive.

But the real thing I found is that when I decided I wanted to highlight, I 
didn't actually want to highlight by "git-rev-list" at all. At least not 
most of the time.

So far, what I've wanted to highlight by is:

 - "does it touch this file/directory/pathspec"

   This is _close_ to "git-rev-list", and you can (and do) actually 
   implement it as that, but it's stupid to do it that way. You just spend 
   extra time. It's literally much better to do

	cat commit-list | git-diff-tree -s --stdin -- <pathspec>

   which is a hell of a lot more efficient, since you already have the 
   commit-list you're interested in (and, in fact, this allows you to do 
   things efficiently only for the current _visible_ commits, if you want 
   to, which might be an important optimization for large views).

 - "Does the author/committer match xyz*"

   I ended up using the "search" button for this, and it worked, but the 
   highlight feature would just have done it much better. Especially if 
   there was a way to do "go to next highlight", instead of just "go to 
   next commit"

   Again, this is actually most easily done by just using the commit-list 
   you already _have_. Not with adding a new argument to "git-rev-list" 
   and trying to filter two views. Also, again, this can actually be done 
   for just the "visible" ones, not the whole view.

 - "highlight the commits [not] reachable from the selected commit"

   Now, this literally is "git-rev-list", but it's a variation on it: you 
   don't want a new view, you really want the _old_ view (exact same 
   git-rev-list arguments), but you add "^commit" to the list of 
   revisions. And then you (conditionally) invert the highlighting if you 
   wanted "reachable" rather than "not reachable".

And the current "create a new view, and overlay that on the old one" 
approach really isn't that good. My mistake, it was me who suggested it.

What do you think? 

		Linus
