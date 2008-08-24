From: Junio C Hamano <gitster@pobox.com>
Subject: [RFD] On deprecating "git-foo" for builtins
Date: Sat, 23 Aug 2008 20:33:10 -0700
Message-ID: <7vprnzt7d5.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org, users@kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 24 05:34:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KX6NP-0005z7-61
	for gcvg-git-2@gmane.org; Sun, 24 Aug 2008 05:34:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751807AbYHXDdT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Aug 2008 23:33:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751839AbYHXDdT
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Aug 2008 23:33:19 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:35114 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751750AbYHXDdS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Aug 2008 23:33:18 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 2214765D89;
	Sat, 23 Aug 2008 23:33:16 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 27AFB65D88; Sat, 23 Aug 2008 23:33:12 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 634B8D90-718D-11DD-B97A-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93511>

People seems to have quite strong negative feelings on the removal of
dashed form "git-foo" commands from their $PATH.

We have deprecated the dashed form in early 2006, and announced that 1.6.0
will remove them from $PATH in the 1.5.4 release notes, with instructions
on how to update their scripts before 1.6.0 happens.  Many people knew
about this transition, but they didn't do anything about it.  Since 2005,
git has matured enough that majority of people are using it without
building one themselves, without a chance to even read Release Notes.

The pain was exacerbated partly because we tried to be too nice during the
"deprecation" period, not to annoy people and not to break people's
scripts.

But that niceness backfired.  Many people seem to argue now that we should
have annoyed people by throwing loud deprecation notices to stderr when
they typed "git-foo", and we should have risked breaking their scripts iff
they relied on not seeing anything extra on the stderr.

I am 50% sympathetic to them, while the remainder of me think that they
can say that in retrospect only because they didn't actually got annoyed
with such extra messages and they did not have to fix their scripts before
the actual switch-over happened.  If we did go the "annoy them early"
route, I am sure they would have complained as loudly.

That's all history now anyway.  We should try to do better the next time,
which is much more important, and that is the topic of this message.

Now, we haven't set the timeframe yet, but the original plan, advocated by
Linus and others, was to eventually stop installing "git-foo" form on the
filesystem for builtin commands.  If we were to do this, we should plan
how the deprecation period for this change should look like.  I think the
sequence of events would look like this:

 (1) Declare that the dashed form are deprecated even in scripts that use
     "git --exec-path" the way 1.5.4 release notes suggested (it does not
     make sense to say "deprecated only for builtins", as the distinction
     between builtins and others are implementation details) and will be
     removed in 1.7.0;

 (2) Update git.c (the "git" wrapper) so that when the command is invoked
     in "git-foo" form for a builtin, issue messages to the standard error
     stream about the deprecation.  Also, when the wrapper invokes an
     external "git-foo" command, it exports an environment variable (say,
     "GIT_WRAPPER_IS_RUNNING_YOU");

     Update non-builtin commands and scripts to first check the
     environment variable, and otherwise issue the same deprecation
     message, and then unset the environment variable before continuing.

 (3) At 1.7.0, stop installing the hardlinks to builtin commands.

There is one alternative, and one augmentation:

 (A) We do not do anything.

 (B) In addition to the main transition plan, outside git, prepare an
     optional "git-old-style" package that installs many "git-foo"
     wrappers in $PATH (i.e. /usr/bin).  Each of them exec "git foo".
     People who like the dashed form can keep typing "git-foo", even
     though that will cost them two exec()s.

I personally do not mind seeing dozens of git-foo commands in /usr/bin,
did not have strong opinion on the transition we just did either way, but:

 * Alternative (A) does not logically make much sense.  Now with 1.6.0,
   people are strongly encouraged to use "git foo" form already.

 * Variant (B) feels quite backwards and I think it will have a negative
   effect on our userbase in the longer term. People who train their
   fingers to say "git-foo" on machines with the "git-old-style" package
   will have hard time adjusting to working on machines without it.
