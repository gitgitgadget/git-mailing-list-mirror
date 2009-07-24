From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-add -p: be able to undo a given hunk
Date: Fri, 24 Jul 2009 09:06:16 -0700
Message-ID: <7v8wienk07.fsf@alter.siamese.dyndns.org>
References: <20090723074104.GI4750@laphroaig.corp>
 <7veis7yxwx.fsf@alter.siamese.dyndns.org>
 <20090724193207.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pierre Habouzit <madcoder@debian.org>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Fri Jul 24 18:06:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUNI5-00041g-M4
	for gcvg-git-2@gmane.org; Fri, 24 Jul 2009 18:06:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751921AbZGXQG2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jul 2009 12:06:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752349AbZGXQG2
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Jul 2009 12:06:28 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:40197 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752138AbZGXQG1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jul 2009 12:06:27 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9AB6610EFE;
	Fri, 24 Jul 2009 12:06:27 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id B804410EF8; Fri, 24 Jul 2009
 12:06:18 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F17CD0F2-786B-11DE-9402-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123924>

Nanako Shiraishi <nanako3@lavabit.com> writes:

> Quoting Junio C Hamano <gitster@pobox.com>
>
>> I fear tempting a new user who sees "undo" to say "yeah, I added the
>> change in this hunk to the index by mistake, please undo", which would
>> lose the work.  The confusion is easier to avoid if "add" only manipulates
>> the index without harming the work tree, and the user used a different
>> command, namely "checkout from the index", to get rid of the remaining
>> debug cruft, once s/he added all the necessary bits to the index perhaps
>> after a multi-stage commit session.
>
> I can see your argument that this might introduce more danger for
> newbies. As you said yourself number of times, nobody will stay being a
> newbie forever, and I don't think it is wise to reject a feature that is
> very handy for experts based solely on such a fear.

It is true that as new people learn they gain proficiency, and you are
also right to point out that I'd usually choose to optimize the interface
for making the life of experts easier rather than welding training wheels
to the system.

BUT

As new people gain proficiency in git, three things happen.

 (1) It becomes a lot less likely for them to make mistakes in choosing
     commands.  I mentioned that they may misunderstand what Pierre's
     "undo" would do, and that fear may be alleviated because of this.

 (2) It does _not_ become less likely for them to make typos when giving
     the command they chose.  The chance of saying 'u' when you mean 'y'
     does not decrease that much as you become more used to using git.
     Especially with interactive.singlekey, the consequence of such a typo
     is devastating.

 (3) They form a better mental model of how the world works.

     The high level view of the git workflow is for you to:

     (a) prepare good changes, together with some changes that are not
         quite ready, in your work tree; and

     (b) use "git add" to add only good changes suitable for the next
         commit to the index; and finally

     (c) make the next commit out of the index.  Repeat (b) and (c) as
         necessary to create multiple commits.

     If you botch the "git add" step during this process, because "git
     add" promises not to touch the work tree, you can safely reset the
     index entry to its previous state and redo the "git add" step,
     without having to fear that you may lose your work.

In your arsenal, you have "git add -p" to help you sift good pieces from
other parts in finer grained manner, instead of having to make an all or
nothing decision per file basis (i.e. "git add file").  But "git add -p"
(and "git add -i") is still about the "git add" step in the above high
level view.  You have a mixture of good and not so good changes in your
work tree, and you pick only good pieces to add to the index, _knowing_
that you can go back and redo this step safely exactly because your work
tree will stay the same even if you did make mistakes.

The proposed change breaks this expectation you would have naturally
gained during the course of becoming more and more proficient in using
git.

In other words, I do not think you can say that the change will not harm
the experts due to both the points 2 (experts can easily make typo) and 3
above (the change breaks the mental model of the world experts would have
formed).

Having said all that, it indeed would be useful to selectively revert
changes from the work tree files.

Even though you could add good bits interactively, making multiple
commits, and remove the remaining debugging cruft at the very end with
"git checkout $files" or "git reset --hard", if there are debugging crufts
for two or more phases of development, this alternative procedure would
not work well, compared to the workflow using Pierre's 'u', which allows
you to add necessary bits to commit one phase, remove the debugging bits
for that phase (but keeping other debugging bits for the remaining good
parts), then continue working and repeat committing and cleaning second
and subsequent phases.

It might be enough to change the command key to uppercase "U" to avoid
unintended mistakes, and document the fact prominently that this action is
an oddball exception to the principle of "git add", while describing why
it is an oddball, along the lines of the above discussion, if necessary.
