X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Colourise git-branch output
Date: Mon, 11 Dec 2006 23:58:09 -0800
Message-ID: <7vfybly29a.fsf@assigned-by-dhcp.cox.net>
References: <200612112210.08327.andyparkins@gmail.com>
	<BAYC1-PASMTP114CF00792AB16B95C1597AED70@CEZ.ICE>
	<7v7iwx2a0z.fsf@assigned-by-dhcp.cox.net>
	<BAYC1-PASMTP092A9E80667F373BF69AA6AED70@CEZ.ICE>
	<Pine.LNX.4.64.0612111936240.6452@woody.osdl.org>
	<7vejr5zoqe.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0612112135360.6452@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 12 Dec 2006 07:58:23 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.64.0612112135360.6452@woody.osdl.org> (Linus
	Torvalds's message of "Mon, 11 Dec 2006 21:41:57 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34065>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gu2Wp-0000Mp-CA for gcvg-git@gmane.org; Tue, 12 Dec
 2006 08:58:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1750955AbWLLH6Q (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 12 Dec 2006
 02:58:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750956AbWLLH6Q
 (ORCPT <rfc822;git-outgoing>); Tue, 12 Dec 2006 02:58:16 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:33466 "EHLO
 fed1rmmtao01.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1750949AbWLLH6P (ORCPT <rfc822;git@vger.kernel.org>); Tue, 12 Dec 2006
 02:58:15 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao01.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061212075814.CPUK9173.fed1rmmtao01.cox.net@fed1rmimpo02.cox.net>; Tue, 12
 Dec 2006 02:58:14 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id xjyR1V00Z1kojtg0000000; Tue, 12 Dec 2006
 02:58:26 -0500
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> I wish you'd learn to use the proper syntax ;)

Ok, ok, I'm an old timer.  But [color.diff] syntax is also
accepted and I have it in my ~/.gitconfig:

	$ cat ~/.gitconfig
	[diff.color]
        	old = red reverse
	$ git repo-config --global diff.color.old
        red reverse
        $ exit

> ... what's nice about it is that you can also do
>
> 	[color "diff"]
> 		auto
> 		old = red
> 		new = green
>
> and the config file rules for booleans are such that a config variable 
> without the "= val" part parses the same as "= true", so you can now do
>
> 	git repo-config --bool color.diff.auto
>
> and it will say "true".

I find that your version of "auto" above to be utterly
confusing.

The existing configuration variable diff.color as an extended
boolean takes true, false or "auto".

I do agree this is a nice way to say that I pretend to be color
blind to git repo-config:

	$ git repo-config --global --bool color.diff false
        $ cat ~/.gitconfig
        [color]
        	diff = false

and it is also nice to be able to say my preference is "auto"
with (you can have --bool with this example and still use
"auto", by the way, when setting):

	$ git repo-config --global color.diff auto
        $ cat ~/.gitconfig
        [color]
        	diff = auto

I also agree it is nice that the "boolean magic" kicks in when
we hand-craft it:

	$ cat ~/.gitconfig
        [color]
        	diff
	$ git repo-config --global --bool color.diff
        true

But your handcrafted

	[color "diff"]
        	auto

simply feels a very confusing syntax.  How would you even
express my preference is always-color (that is, "true")?

If we are changing color.diff to color.diff.usecolor which is
bool + auto, then I would understand it.

	[color "diff"]
        	usecolor
                # usecolor = auto
                # usecolor = no

but that would not let you query with --bool ("auto" would
barf).

I guess we should at least extend --bool so that scripts can
easily query extended bools; if the value looks like a bool (or
there is no value), it would return it normalized to "true" or
"false" so they do not have to say:

	case `repo-config --bool the.variable` in
        true | yes | on | 1)
        	echo ah you mean yes ;;
	esac

but if the value is not either boolean true or false, then
return the string as is (such as "auto").  I am inclined to just
extend --bool itself to do so (which means we would lose the
error checking form the script for truly boolean fields) rather
than adding a new --bool-or-string option.

In any case,

	[color]
        	diff
                # diff = auto
                # diff = no

would work already if we only talk about built-in accesses.  We
would need to extend repo-config --bool to make it easier for
scripts to work with this extended bool, but that is a minor
detail.

So it seems to me that the only reason to have
color.diff.usecolor is so that we can have "diff" related color
settings in one place.  Which is fine.

You could do the same thing with your "auto"

	[color "diff"]
        	auto
		# auto = always
                # auto = no

but what that means is that color.diff.auto _is_ the extended
boolean that tells us to:

	* use color on terminal when set to true
        * use color unconditionally when set to a non-bool 'always'
        * never use color when set to false

which sounds rather, eh, unusual.


	
