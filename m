From: Junio C Hamano <junkio@cox.net>
Subject: Re: Implementing branch attributes in git config
Date: Mon, 08 May 2006 17:54:41 -0700
Message-ID: <7virogc90u.fsf@assigned-by-dhcp.cox.net>
References: <1147037659.25090.25.camel@dv>
	<Pine.LNX.4.64.0605071629080.3718@g5.osdl.org>
	<1147048587.17371.13.camel@dv>
	<Pine.LNX.4.64.0605071740550.3718@g5.osdl.org>
	<7vfyjli9vf.fsf@assigned-by-dhcp.cox.net>
	<BAYC1-PASMTP0334B471C6908E4E40BFD2AEA80@CEZ.ICE>
	<7vbqu9i6zl.fsf@assigned-by-dhcp.cox.net>
	<BAYC1-PASMTP110777A694DAF1D7623895AEA80@CEZ.ICE>
	<Pine.LNX.4.64.0605081905240.6713@iabervon.org>
	<BAYC1-PASMTP0453E2D70B10C6D116167EAEA80@CEZ.ICE>
	<Pine.LNX.4.63.0605090142280.5778@wbgn013.biozentrum.uni-wuerzburg.de>
	<BAYC1-PASMTP03ADC2F3E75E482ADC5CD3AEA90@CEZ.ICE>
	<Pine.LNX.4.64.0605081731440.3718@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 09 02:54:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FdGUw-0006ls-EB
	for gcvg-git@gmane.org; Tue, 09 May 2006 02:54:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751043AbWEIAyo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 May 2006 20:54:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751047AbWEIAyo
	(ORCPT <rfc822;git-outgoing>); Mon, 8 May 2006 20:54:44 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:8930 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1751039AbWEIAyn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 May 2006 20:54:43 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060509005442.LYGE27919.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 8 May 2006 20:54:42 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0605081731440.3718@g5.osdl.org> (Linus Torvalds's
	message of "Mon, 8 May 2006 17:37:29 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19793>

Linus Torvalds <torvalds@osdl.org> writes:

> On Mon, 8 May 2006, sean wrote:
>> 
>> One option, which I don't really like and comes with its own set of 
>> problems, would be to do something like:
>> 
>> [branch1]
>>     streetname = "p4/BrAnCH"
>> [branch2]
>>     streetname = "origin"
>
> You don't actually need that.
>
> We could easily do
>
> 	[branch]
> 		name = "p4/BrAnCH"
> 		url = git://git.kernel.org/...
> 		pull = master
>
> 	;
> 	; Repeating the "[branch]" section here isn't
> 	;  needed, but doesn't hurt either, and is
> 	; more readable
> 	;
> 	[branch]
> 		name = "origin"
> 		url = ...
> 		pull = ...
>
> because the config file is always parsed linearly, and just 
> trigger on "branch.name", and keep that around when parsing 
> anything else.
>
> The problem with _that_ is that "git repo-config" can't add this kind of 
> setup sanely: it doesn't understand that kind of statefulness.

Wait a minute...  Statefulness is not the issue, I think.

How would you tell your updated repo-config what to update and
what to look up?

	- I want the url for branch whose name is "origin"

	- I want to fetch their "for-linus" branch when fetching
          from the branch whose name is "jgarzik" from now on.

In these query and update, you _are_ naming the branch with
name="xxx"; you just made "name" a special attribute.

Now, how would that compare with:

        [branch.jgarzik]
                url = git://git.kernel.org/...
                fetch = for-linus

or
	[branch."JGarzik"]
                url = git://git.kernel.org/...
                fetch = for-linus

I would say if we are grouping things together, if we can give
name to each group, _and_ if we are going to refer to the group
with its name, we are better off making the groups into distinct
sections _and_ make the syntax obvious that what name refers to
the section.  I think [branch.jgarzik] syntax is more obvious
than your example where "name =" line is implicitly used as a
keyword to differenciate multiple occurrences of [branch]
sections.

Having said that, perhaps you have something more elaborate in mind,
e.g.

	repo-config --get branch.url where name = 'origin'
	repo-config --get branch.name where url like 'git://%'
	repo-config branch.url 'git://git.kernel.org/...' where name = foo

;-) ;-) ;-) ???  If that is what you are after, then I agree
your syntax is more generic and suitable.  But otherwise I fail
to see its point.

On a related topic, I have always been torn about the "for"
convention.  While I think it was a cute hack, it would break
quite badly once we start doing anything complex.

	[branch]
        	url = git://git.kernel.org/... for jgarzik
                fetch = for-linus for jgarzik
                proxy = none

        	url = git://git.kernel.org/... for torvalds
                fetch = master for torvalds
