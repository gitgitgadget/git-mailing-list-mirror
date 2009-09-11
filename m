From: Junio C Hamano <gitster@pobox.com>
Subject: Re: bash_completion outside repo
Date: Fri, 11 Sep 2009 13:43:24 -0700
Message-ID: <7viqfpw6tv.fsf@alter.siamese.dyndns.org>
References: <a3b675320909100813i3e70ab3at66408aebb9952c7d@mail.gmail.com>
 <20090911133313.GF2582@inocybe.localdomain>
 <a3b675320909110700k7eb7286qc8cb5691aae214c7@mail.gmail.com>
 <20090911141730.GA384@coredump.intra.peff.net>
 <20090911143651.GE1033@spearce.org>
 <20090911150934.GB977@coredump.intra.peff.net>
 <20090911164730.GA21536@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	james bardin <jbardin@bu.edu>, Todd Zullinger <tmz@pobox.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Sep 11 22:43:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmCyF-000655-Ma
	for gcvg-git-2@lo.gmane.org; Fri, 11 Sep 2009 22:43:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754699AbZIKUni (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Sep 2009 16:43:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752455AbZIKUnh
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Sep 2009 16:43:37 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:45893 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752393AbZIKUnh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Sep 2009 16:43:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 20FC62F35C;
	Fri, 11 Sep 2009 16:43:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=H+FHO9btAmIeIOi+nafrQodhkrw=; b=OdtASBhG8GNelsteZwyuaps
	jMb3eyLkljhI0bF2w4iosR7jACW0ZIrJgc/VoA1guzlp8vzkbssdEW2wRp69dJ+F
	iCwD3CJTrD48BoxlDa3Hjw50XarddVvKHOsqt73nOoycMin/GKBCP2BNHfsks9D1
	0CYv4y8tOnW+FY59UUjU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=ahdN2x6twH3IQUDmAqXPxyRD5fKQiIQIVm6KwKG0YKqjKQb96
	H8sZU1QCvOK5wP6zKLjFhImr1GSQB28EpC1mNP02Q2eclz296XMeQpJkD73OXSs1
	QoZ6D5I1pzf1cR2LwS8HI/1erJXqoq1nl7yyzwGwA3ia8RC+htg4HWO4ro=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id CC2682F35B;
	Fri, 11 Sep 2009 16:43:32 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8B77D2F35A; Fri, 11 Sep
 2009 16:43:25 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C51FDE5E-9F13-11DE-8893-A13518FFA523-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128217>

Jeff King <peff@peff.net> writes:

> This is actually a bit overengineered. Of the hundreds of calls to
> git_config, there are exactly _two_ which check the return value. And
> neither of them cares whether we parsed files or not; they really only
> care if there was an error. So we could simply return 0 as long as there
> is no error.
>
> This also makes me wonder, though. Git can do wildly different things
> (including hard-to-reverse things) based on config (e.g., just consider
> gc.pruneExpire). Yet we call git_config() without ever checking for
> errors. In the actual parsing routines, we die() if there is an error.
> But if we fail to open the file due to some transient error, we will
> silently ignore the situation.
>
> Granted, such transient errors are unlikely. The biggest reasons for
> failing to open a file are that it doesn't exist, or that we have no
> permission to read it, both of which are treated explicitly in
> git_config as "silently ok". But I wonder if we should simply be dying
> on such an error, and git_config() should just have a void return.

Thanks.

ENOENT should be the same as having an empty file, which is the main point
of the patch and at the same time why you feel this is overengineered.  I
agree with you on both counts.

While I also agree that EACCESS and other failures should be treated as
fatal in principle for safety, e.g. when running prune without being able
to read gc.pruneExpire as you mentioned, we would need a tradeoff between
safety and convenience.  When asked to help looking at a complex merge in
a colleages' repository, do you want your "git diff" to refuse to run only
because her .git/config cannot be read by you?  Of course, you _can_ work
this particular one around by various means (e.g. prefixing GIT_CONFIG=...
to force ignoring the file; telling the colleage that she'd better make
her .git/config readable to you if she wants your help), if either one of
the owner of the .git/config file or the party that wants to access the
repository is a non-person such a workaround would be harder to arrange.

Also there was a move going in the opposite direction to allow a config
file that is syntactically broken to be handled without the parser dying,
primarily to help "git config -e".  In the longer term, our direction
shouldn't be adding more die() in the git_config() callchain, but instead
allowing it to report different kind of failures to let the caller act
based on what it does and what the nature of failure is.

For example, "gc" may say "I won't prune because I had to skip some of the
lines in your .git/config because you have syntax errors in them, and I
may have missed the definition of gc.pruneExpire you may wanted to place
on them", while "diff" may ignore that kind of errors.

Having said all that, my preference *for now* would be to ignore "there is
no $HOME/.gitconfig (or /etc/gitconfig) file", but catch all other errors
and die().

There are some other glitches in the current git_config() callchain.

 - No config file anywhere gives an error.  I agree with you that this is
   a bug.

 - Having GIT_CONFIG=/no/such/file in the environment gives an error,
   which is good.

 - config.c::git_parse_file() [*1*] dies when it detects certain file
   format errors itself.  This is not good for "git config -e", as it
   needs to learn core.editor before it can be used to fix such an error.

   This function then calls config.c::get_value() and it dies when
   config.c::get_value() reports any error.

 - config.c::get_value() is called by config.c::git_parse_file() to finish
   parsing out the <name, value> pair, and stores the "value" in a form
   usable in the code, e.g. a variable defined in environment.c.  The
   function returns an error on some file format errors (e.g. a variable
   name is too long, string quoting unterminated) that signals the calling
   config.c::git_parse_file() to die().  These error returns are good (the
   caller however may need to be fixed for "config -e" issue not to die).

   It then calls the parse callbacck routines.  They return error when
   they detect semantic errors (e.g. "branch.autosetupmerge = alwys" is
   not one of the valid values).

The last one is not the topic of this patch, but it is quite problematic.
When you are interested in finding out what value gc.pruneExpire is set,
you do not care (as long as the configuration file was syntactically
correct and you did not have to skip any file you were supposed to read
due to EACCESS) if "branch.autosetupmerge" has an invalid value.

A possible longer term solution would be to:

 - Change the signature of callbacks (e.g. git_default_branch_config()) so
   that they return void.  They are not allowed to report any semantic
   errors while parsing.

 - Instead, they use special "INVALID" value and store that when they see
   a semantically incorrect value.  They may also want to store what the
   actual string the config file gave them for later reporting, together
   with the name of and the line number in the config file for diagnostic
   purposes.

 - The user of the internalized value (i.e. "git grep git_branch_track"
   shows there are only two, cmd_branch() and cmd_checkout()) must check
   for the above INVALID value before they use the variable, and die at
   the point of the use.

I'll send an illustration patch separately.

[Footnote]

*1* What a horrible name for this function!  It is static so git_ prefix
is unneeded, and if it anticipates it might get someday exported, parse_file
is too generic and should be named git_parse_config_file().
