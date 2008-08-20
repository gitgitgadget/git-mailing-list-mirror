From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] bash-completion: fix getting strategy list
Date: Wed, 20 Aug 2008 14:13:42 -0700
Message-ID: <7vfxozpeyh.fsf@gitster.siamese.dyndns.org>
References: <fcaeb9bf0808190527q60869fd0uccbfd165431a752d@mail.gmail.com>
 <20080819132803.GA26201@laptop> <48AADDBB.1080203@viscovery.net>
 <fcaeb9bf0808200958u65ad8fa3oa118b88e16c9c50c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Johannes Sixt" <j.sixt@viscovery.net>,
	"Git Mailing List" <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Miklos Vajna <vmiklos@frugalware.org>
To: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 20 23:15:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVv18-0006nR-ON
	for gcvg-git-2@gmane.org; Wed, 20 Aug 2008 23:14:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751617AbYHTVNz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2008 17:13:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751522AbYHTVNz
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Aug 2008 17:13:55 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:39893 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751304AbYHTVNy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2008 17:13:54 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id EC96454FB2;
	Wed, 20 Aug 2008 17:13:52 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id E5F3E54FA3; Wed, 20 Aug 2008 17:13:46 -0400 (EDT)
In-Reply-To: <fcaeb9bf0808200958u65ad8fa3oa118b88e16c9c50c@mail.gmail.com>
 (Nguyen Thai Ngoc Duy's message of "Wed, 20 Aug 2008 23:58:14 +0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E426CC24-6EFC-11DD-BDDD-B29498D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93047>

"Nguyen Thai Ngoc Duy" <pclouds@gmail.com> writes:

> On 8/19/08, Johannes Sixt <j.sixt@viscovery.net> wrote:
>> Nguyen Thai Ngoc Duy schrieb:
>>
>> > +--show-strategies::
>>  > +     Show all available strategies. For internal use only.
>>  > +
>>
>>
>> IMO, you don't need to declare this option as internal; offering it for
>>  the public is fine...
>
> On second thought, I don't think the patch's worth it.

How about doing this instead?

-- >8 --
completion: find out supported merge strategies correctly

"git-merge" is a binary executable these days, and looking for assignment
to $all_strategies variable does not work well.

When asked for an unknown strategy, pre-1.6.0 and post-1.6.0 "git merge"
commands respectively say:

    $ $HOME/git-snap-v1.5.6.5/bin/git merge -s help
    available strategies are: recur recursive octopus resolve stupid ours subtree 
    $ $HOME/git-snap-v1.6.0/bin/git merge -s help
    Could not find merge strategy 'help'.
    Available strategies are: recursive octopus resolve ours subtree.

both on its standard error stream.  We can use this to learn what
strategies are supported.

The sed script is written in such a way that it catches both old and new
message styles ("Available" vs "available", and the full stop at the end).
It also allows future versions of "git merge" to line-wrap the list of
strategies, and add extra comments, like this:

    $ $HOME/git-snap-v1.6.1/bin/git merge -s help
    Could not find merge strategy 'help'.
    Available strategies are: blame recursive octopus resolve ours
    subtree.
    Also you have custom strategies: theirs

    Make sure you spell strategy names correctly.

---
diff --git c/contrib/completion/git-completion.bash w/contrib/completion/git-completion.bash
index 158b912..a310040 100755
--- c/contrib/completion/git-completion.bash
+++ w/contrib/completion/git-completion.bash
@@ -271,15 +271,17 @@ __git_merge_strategies ()
 		echo "$__git_merge_strategylist"
 		return
 	fi
-	sed -n "/^all_strategies='/{
-		s/^all_strategies='//
-		s/'//
+	git merge -s help 2>&1 |
+	sed -n -e '/[Aa]vailable strategies are: /,/^$/{
+		s/\.$//
+		s/.*://
+		s/^[ 	]*//
+		s/[ 	]*$//
 		p
-		q
-		}" "$(git --exec-path)/git-merge"
+	}'
 }
 __git_merge_strategylist=
-__git_merge_strategylist="$(__git_merge_strategies 2>/dev/null)"
+__git_merge_strategylist=$(__git_merge_strategies 2>/dev/null)
 
 __git_complete_file ()
 {
