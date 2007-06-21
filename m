From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Introduce git version --list-features for porcelain use
Date: Thu, 21 Jun 2007 00:02:05 -0700
Message-ID: <7vr6o5zt76.fsf@assigned-by-dhcp.pobox.com>
References: <20070621045903.GA14047@spearce.org>
	<7v1wg55065.fsf@assigned-by-dhcp.pobox.com>
	<20070621061045.GG8477@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Jun 21 09:02:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1GgH-0004ay-4A
	for gcvg-git@gmane.org; Thu, 21 Jun 2007 09:02:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753310AbXFUHCK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Jun 2007 03:02:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752298AbXFUHCI
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jun 2007 03:02:08 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:34284 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751576AbXFUHCH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jun 2007 03:02:07 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070621070207.VIKR2558.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Thu, 21 Jun 2007 03:02:07 -0400
Received: from assigned-by-dhcp.pobox.com ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id E7261X0021kojtg0000000; Thu, 21 Jun 2007 03:02:06 -0400
In-Reply-To: <20070621061045.GG8477@spearce.org> (Shawn O. Pearce's message of
	"Thu, 21 Jun 2007 02:10:45 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50602>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> If you want to be less defensive, OK, it would also reduce the
> patch size a bit, but may allow someone to add an insane item to
> the list.

If we were to go this route (which I am not convinced is the
right direction yet---using "git version" to check the version
and say "1.5.3 has blame -w" might be easier to manage, and that
needs to be maintained only by the tools that care about the
particular feature, "blame -w"), we will potentially be talking
about hundreds of features in the long run.  I would rather want
to automate this even further, as keeping the feature list and
features together would become huge maintenance headache.

So, first of all, I would want the list of features in
supported_features[] to come from a separate file, whose sole
purpose is to have that list.  I would even suggest making it an
generated file, which depends on the source files (not
necessarily limited to C files), and built from within the build
procedure.

Whenever you add a new command line option, you would add a
greppable comment near it, something like...

 		else if (!strcmp("-s", arg))
 			output_option |= OUTPUT_NO_AUTHOR;
+		/* FEATURE[[[blame-ignore-whitespace]]] */
+		else if (!strcmp("-w", arg))
+			xdl_opts |= XDF_IGNORE_WHITESPACE;
 		else if (!strcmp("-S", arg) && ++i < argc)
 			revs_file = argv[i];

and have Makefile extract them, sort them and build the meat of
supported_features[] array automatically.

Unless we have something like that, I have to worry about merge
conflicts every time a new topic graduates to 'master'.

>> > +static int supports_feature(const char *the_feature)
>> 
>> And you can  perform a bsearch here. instead of linear.
>
> Sure.  But I'm actually expecting more for Porcelain that cares
> to run `git version --list-features` and store that output into
> its own internal table,

Ok, that is probably a sane assumption.

> ....  I figured the bsearch would take more
> code than the linear, and probably wasn't worth it in this dark
> little corner of Git.

Huh?  Don't you already have compar() function that bsearch(3)
can take?

>> I suspect that this patch is meant for my 'maint' (and
>> 1.5.2.3).  Or is it for my 'master'?  What's your plan to handle
>> transition?
>
> Eh, sorry, I should have mentioned that.  I meant for you to apply
> this to your master, where `git blame -w` is already present.
>
> Currently with next I get:
>
>   $ git version --list-features
>   git version 1.5.2.2.1050.g51a8b
>
> So what I was planning on doing in git-gui was running that, and if
> I just get one line with `git version` on it (which is an insane
> feature name btw) then I know --list-features is not supported,
> and neither is any other feature that I might be looking for from
> the --list-features command.
>
> On the other hand if --list-features is actually supported instead
> I'll get back at least a line with "list-features" on it, and I
> won't get a line with "git version" on it (as that is an insane
> feature name).

The explaination why "futureproofing" is unnecessary for 'maint'
is good, but that does not necessarily mean --list-featues would
need to list _all_ the features in the version that supports
that.  "blame -w" is in 'master' already, for example.  Is
"have-mergetool" a feature?  Yes, it is.  But you already know
the command exists if "git version" knows --list-features.

> Hmm.  So assuming that is true, under what rule do you propose we
> add new features to that array in the future?  And what name(s)
> do we give to them?

Assuming if this --list-features is a viable approach in the
long run, my gut feeling of relative order of things is:

 (1) We prepare rock-solid runtime with an _EMPTY_ feature array
     in 'master'.

 (2) We add automated feature array management in 'master', as
     outlined above.

 (3) Merge the above two to 'next'.

 (4) Update all existing topics, including the ones that are
     already in 'next', with the feature mark-up in comment
     (i.e. "FEATURE[[[feature-name]]]").

After (3) happens, any new topics that introduce a new feature
should be accompanied with the feature mark-up.

When an update appears on 'master' _after_ (1) and (2) happens
_but_ Porcelain writers like yourself do not realize that the
feature would be _very_ helpful for their Porcelains, and would
want to be able to tell if it exists via --list-features, long
after we start to support the feature, we might retroactively
have to add the feature mark-up.  There will be gap between the
commit that actually introduce and make the feature usable, and
the commit that teaches "git version" to talk about it in such a
case.  But I think that should be Ok.

I do not think we want to keep track of every little "features"
if no Porcelain cares about it.

Here is a list of potential "feature names", from the latest
"What's cooking" message.

 log-unlimited-message
 log-follow
 oneline-first-paragraph
 svn-merge-local
 work-tree-environ
 filter-branch
