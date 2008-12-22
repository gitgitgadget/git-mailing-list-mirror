From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Automagic patch merge ack emails
Date: Mon, 22 Dec 2008 12:29:03 -0800
Message-ID: <7v8wq8hs34.fsf@gitster.siamese.dyndns.org>
References: <2d460de70812220607j7f218ee3r7722bc8147a3dab4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Richard Hartmann" <richih.mailinglist@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 22 21:30:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LErQ7-00031i-38
	for gcvg-git-2@gmane.org; Mon, 22 Dec 2008 21:30:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754093AbYLVU3M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Dec 2008 15:29:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753825AbYLVU3M
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Dec 2008 15:29:12 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:47389 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753783AbYLVU3L (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Dec 2008 15:29:11 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id ECF641ADF1;
	Mon, 22 Dec 2008 15:29:09 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 8054C1ADDA; Mon,
 22 Dec 2008 15:29:06 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 302ECA2E-D067-11DD-80E7-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103764>

"Richard Hartmann" <richih.mailinglist@gmail.com> writes:

> I poked around the docs, but I could not find any option to have git
> send email to people who signed off a patch when it's merged.

The correcty way to say that "the changes from a patch get incorporated"
is "it's applied", not "merged".  There is no "post-am" hook you can use
to make an announcement.  Nor the sample post-commit hook that is called
after every commit mentions anything about e-mails.

And these are good things, and here is why.

It does not matter a whit to you if/when I applied your patch to a topic
branch in my private repository that I work in, preparing for eventual
pushout to the public tree.  Patches are reviewed in e-mail form, and
obvious typos and logic mistakes are corrected while still I am reading
your patch in my MUA, if they are trivial (otherwise you will get a reply
saying to which points I do not agree with your patch).  After your patch
passes this process, it may be applied somewhere, perhaps directly on
'master' or 'maint', or perhaps on a new topic branch to house your
changes.

But that is only the beginning of the story.  I'll apply many more changes
from other people, testing each step, rebasing and amending these changes
as necessary to fix breakages, and I may realize that some patches are not
quite ready to be in the public history during this process.  Your patches
may be part of these patches discarded that way.

When I decide not to apply your patch (iow, it hits my mailbox but I
reject it while it is in my MUA), git obviously would not know about it at
all [*1*].

Even after I apply your patch somewhere, I may decide not to include it in
in any of the public branches after testing and re-reviewing.  I may merge
the topic branch I created to host your patch to 'next', but after testing
and re-reviewing, I may decide it is not ready, and I'd rebuild 'next'
without the topic before pushing the results out.  And I'd delete such a
topic branch after I am done with it.

What this means is that the time a commit is made (either by patch
application or "git pull" from somebody else's tree) is too early to make
any announcement.  "git am" hook would not be useful for that purpose.

The only time that it may make a difference to you is when things are
pushed out to the public repository, and there is a mechanism for
automating tasks after new commits hits the public repository: the
post-receive hook.  contrib/hooks/post-receive-email may be a good example
to study if you are interested (I use it in my day job repository, but I
do not use the hook in git.git because the style of announcing I adopted
on this list is to send out "What's in/cooking" messages once or twice a
week).

> Does anyone else think this is useful? Does anyone else think it should
> make it into main so it can be enabled via config, not via a hook that
> needs to be imported into each and every repo?

If your "each and every" repository is used for the same uniform purpose
(namely, publishing to the public), then they can be initialized with the
same hook scripts using the templates mechanism, so in a sense, there
already is a mechanism for that.

But it is very unlikely your repositories are uniform, so I doubt that the
mechanism based on custom templates, or your built-in announcement
mechanism triggered by configuration, would be very useful.

Most of the freedom in a DVCS workflow comes from the separation between
making commits (including patch application and merges) and publishing the
result.  You do not want to fear committing crap, because you can
carefully check the result before making it public.

Because of that, private repositories where the real work takes place and
public repositories that serve as distribution points have very different
needs.  You do not want to have any announcement triggers in the former
(that's the whole point of separating "making commits" and "publishing the
result"), while some people like announcement triggers in the latter.

[Footnote]

*1* There are two kinds of patches that rejected that way.

 * One with good intention but wrong execution receives suggestion for
   improvements.

 * One with misguided intention or misleading description is requested to
   clarify why the change is needed, before receiving comments on the
   implementation.
