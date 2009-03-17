From: Junio C Hamano <gitster@pobox.com>
Subject: Re: undoing something
Date: Tue, 17 Mar 2009 00:09:23 -0700
Message-ID: <7vtz5ssk0s.fsf@gitster.siamese.dyndns.org>
References: <450196A1AAAE4B42A00A8B27A59278E70A2AEFA4@EXCHANGE.trad.tradestation.com>
 <7veiwxwa9z.fsf@gitster.siamese.dyndns.org>
 <450196A1AAAE4B42A00A8B27A59278E70A2AEFD7@EXCHANGE.trad.tradestation.com>
 <20090317064519.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Dlugosz <JDlugosz@TradeStation.com>, git@vger.kernel.org,
	Paolo Bonzini <bonzini@gnu.org>,
	Jay Soffian <jaysoffian@gmail.com>
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Tue Mar 17 08:11:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjTS6-0006ic-Uc
	for gcvg-git-2@gmane.org; Tue, 17 Mar 2009 08:11:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754132AbZCQHJi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2009 03:09:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754064AbZCQHJi
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Mar 2009 03:09:38 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:54889 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752493AbZCQHJh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2009 03:09:37 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 6AC74A2498;
	Tue, 17 Mar 2009 03:09:34 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 10C52A2497; Tue,
 17 Mar 2009 03:09:26 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 91A48F4E-12C2-11DE-A327-CFA5EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113427>

Nanako Shiraishi <nanako3@lavabit.com> writes:

> Quoting John Dlugosz <JDlugosz@TradeStation.com>:
>
>> === Re: ===
>>  (2) if you are not, you can obviously check out topic and do the above,
>>      or "git branch -f topic topic^".
>> === end ===
>>
>> As documented, this destroys the existing branch and makes a new one.
>> That would, by design, blow away the reflog for that branch.
>
> Does it?  If so I think you have an incorrect documentation.
>
> $ rm -fr /tmp/gomi && mkdir /tmp/gomi
> $ cd /tmp/gomi
> $ git init
> $ echo hello >world
> $ git add world
> $ git commit -m initial
> $ seq 1 100 | while read num; do echo $num >world; git commit -a -m $num; done
> $ git checkout -b side master~60
> $ git branch -f master master@{20}
> $ git log --oneline -g master | head -n 10
> 0acf8c1 master@{0}: branch: Reset from master@{20}
> 945c3ee master@{1}: commit: 100
> 54fcb36 master@{2}: commit: 99
> b314a1e master@{3}: commit: 98
> e91d999 master@{4}: commit: 97
> 0d88853 master@{5}: commit: 96
> 0124315 master@{6}: commit: 95
> 5df2cc5 master@{7}: commit: 94
> ...
> 0813a46 master@{9}: commit: 92

I didn't even notice there was another question buried.  Thanks.

Documentation/git-branch.txt says this:

        -f::
                Force the creation of a new branch even if it means deleting
                a branch that already exists with the same name.

which does imply that it first destroys the branch altogether and
recreates as if there was no such branch.

But that is actually not what the code does to reflog, and I think the
behaviour makes a lot more sense than "destroy and create" the
documentation implies.  branch.c::create_branch() has this:

	if (forcing)
		snprintf(msg, sizeof msg, "branch: Reset from %s",
			 start_name);
	else
		snprintf(msg, sizeof msg, "branch: Created from %s",
			 start_name);

The message for your master@{0} example came from the "forcing" codepath.

The documentation is indeed wrong.  It is more like "create a new branch,
or if the named branch already exists, reset the tip of it".  If we want
to sound alarmist, we could add "even if it means making the existing
history unreachable from the new tip of the branch", but I think "reset"
already means that and it would be redundant.

The create_branch() function does another thing, though.  It sets up the
tracking information _if asked_.  Because one branch cannot track more
than one "other things" at once, it inevitably overwrites the previous
tracking information if you say "branch --track -f dev origin/dev" if dev
were tracking something else.  But if you do not let it set up tracking,
the old tracking configuration is _not_ discarded.  I am not sure if that
was intended (the branch.<name>.remote nor branch.<name>.merge variables
are not something I use myself), but it makes sort of sense.  If you do
"git branch -f dev dev~2" to rewind its tip, you do not want to lose its
tracking information, so the current behaviour makes sense in that
respect.

I am not sure about how branch.autsetupmerge does interact with this in
the current code, nor how it should interact with it in the ideal world,
though.  That's for interested parties (I suspect Jay and Paolo?) to
figure out.
