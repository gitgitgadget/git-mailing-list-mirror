From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-svn 1.5.3 does not understand grafts?
Date: Sat, 08 Sep 2007 12:53:57 -0700
Message-ID: <7vfy1pyluy.fsf@gitster.siamese.dyndns.org>
References: <20070908050146.GA28855@soma>
	<045501c7f23f$c359c450$5267a8c0@Jocke>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "'Eric Wong'" <normalperson@yhbt.net>,
	"'git'" <git@vger.kernel.org>
To: "Joakim Tjernlund" <joakim.tjernlund@transmode.se>
X-From: git-owner@vger.kernel.org Sat Sep 08 21:54:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IU6OC-00056M-NP
	for gcvg-git@gmane.org; Sat, 08 Sep 2007 21:54:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754705AbXIHTyI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 8 Sep 2007 15:54:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754688AbXIHTyH
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Sep 2007 15:54:07 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:59778 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754556AbXIHTyG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Sep 2007 15:54:06 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 65234130E62;
	Sat,  8 Sep 2007 15:54:22 -0400 (EDT)
In-Reply-To: <045501c7f23f$c359c450$5267a8c0@Jocke> (Joakim Tjernlund's
	message of "Sat, 8 Sep 2007 19:43:27 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58134>

"Joakim Tjernlund" <joakim.tjernlund@transmode.se> writes:

> hmm, I think git-cat-file is to blame.
> git-cat-file commit da783cce390ce013b19f1d308ea6813269c6a6b5 does
> not list list any parent...

The plumbing cat-file does not deal with grafts and this is
deliberate.  Otherwise you would not be able to find the true
set of parents when you'd want to.

So do not blame cat-file, but blame the Porcelain that uses
cat-file to read a commit object, without annotating what it
read with what is in grafts, in this case your command line
experiment ;-).

The log family of commands and rev-list plumbing while
traversing commit ancestry chain do take grafts into account.

One caveat is pretty=raw output format shows true parents
without grafts on "parent " header line, while the "commit "
fake header prepended in the output for each commit shows the
parents that takes into account.

To illustrate, if you forge the history and say the parent of
1ddea77 is 5da1606 (when the true parent is 820eca68) with
grafts mechanism, here is what happens:

    $ echo '1ddea77e449ef28d8a7c74521af21121ab01abc0 5da1606d0bf5b970fadfa0ca91618a1e871f6755' >.git/info/grafts
    $ git show -s --pretty=raw --parents 1ddea77
    commit 1ddea77e449ef28d8a7c74521af21121ab01abc0 5da1606d0bf5b970fadfa0ca91618a1e871f6755
    tree e9e61bc801438062978ff47b0963c536ed1e51a9
    parent 820eca68c2577d7499d203d7f4f7ae479b577683
    author Nick Hengeveld <nickh@reactrix.com> 1127757131 -0700
    committer Junio C Hamano <junkio@cox.net> 1127805558 -0700

        [PATCH] Return CURL error message when object transfer fails

        Return CURL error message when object transfer fails
        ...
    $ git-cat-file commit 1ddea77
    tree e9e61bc801438062978ff47b0963c536ed1e51a9
    parent 820eca68c2577d7499d203d7f4f7ae479b577683
    author Nick Hengeveld <nickh@reactrix.com> 1127757131 -0700
    committer Junio C Hamano <junkio@cox.net> 1127805558 -0700

    [PATCH] Return CURL error message when object transfer fails

    Return CURL error message when object transfer fails
    ...
