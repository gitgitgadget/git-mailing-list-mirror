From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Unresolved issues #2 (shallow clone again)
Date: Fri, 5 May 2006 08:59:44 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605050848230.3622@g5.osdl.org>
References: <7v64lcqz9j.fsf@assigned-by-dhcp.cox.net> <7v4q065hq0.fsf@assigned-by-dhcp.cox.net>
 <87mzdx7mh9.wl%cworth@cworth.org> <7v1wv92u7o.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0605050806370.3622@g5.osdl.org> <e3fqb9$hed$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 05 17:59:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fc2ic-0000ma-Bu
	for gcvg-git@gmane.org; Fri, 05 May 2006 17:59:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751156AbWEEP7r (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 May 2006 11:59:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751469AbWEEP7r
	(ORCPT <rfc822;git-outgoing>); Fri, 5 May 2006 11:59:47 -0400
Received: from smtp.osdl.org ([65.172.181.4]:53444 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751156AbWEEP7r (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 May 2006 11:59:47 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k45FxjtH005110
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 5 May 2006 08:59:45 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k45Fxi2V005773;
	Fri, 5 May 2006 08:59:44 -0700
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <e3fqb9$hed$1@sea.gmane.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19615>



On Fri, 5 May 2006, Jakub Narebski wrote:

> Linus Torvalds wrote:
> 
> > So what you'd get is a _really_ cut down history that doesn't contain any
> > commit history at all (just distinct "points in commit history time"), but
> > that _does_ contain all the objects that the commits point to.
> 
> So we would get 'skin-deep clone' rather than 'shallow' one?

Well, it's really shallow, but perhaps more importantly, I think it should 
be really easy, and have totally unambiguous semantics. Never any question 
of how far back to go, and I think we already really do have all the 
support logic for doing it.

Now, we don't actually expose the internal "no_walk" flag with a 
"--no-walk" command line argument parsing, but that's a one-liner.

There's another approach that might be a bit friendlier, which is again to 
walk only the objects of the WANT/HAVE things, but then _do_ walk the 
history for just commit objects. Something close to what I think the http 
fetch thing does if you pass it "-c -t". That too shouldn't require too 
much extra complexity, and it would mean that "git log" at least works.

Of course, that would require another slight difference to "rev-list.c", 
where we'd only recurse into trees of selected commit objects (ie we'd 
have to mark the HAVE/WANT commits specially, but it's not exactly 
complex either).

Of course, the complexity of _both_ of these approaches is really in the 
fsck stage, and all the crud you need to then do other things with these 
pared-down repos. For example, do you allow cloning? And do you just 
automatically notice that you're cloning a shallow repo, and only do a 
shallow clone. Etc etc..

		Linus
