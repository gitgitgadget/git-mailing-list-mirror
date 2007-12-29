From: Junio C Hamano <gitster@pobox.com>
Subject: Re: On the many files problem
Date: Sat, 29 Dec 2007 11:27:31 -0800
Message-ID: <7vabntb8t8.fsf@gitster.siamese.dyndns.org>
References: <87y7bdweca.fsf@enceladus.ygingras.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Yannick Gingras <ygingras@ygingras.net>
X-From: git-owner@vger.kernel.org Sat Dec 29 20:29:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J8hLu-0008M0-GI
	for gcvg-git-2@gmane.org; Sat, 29 Dec 2007 20:28:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751170AbXL2T1q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Dec 2007 14:27:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750865AbXL2T1p
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Dec 2007 14:27:45 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:59084 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750935AbXL2T1p (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Dec 2007 14:27:45 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id CC06D444F;
	Sat, 29 Dec 2007 14:27:43 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 38941444C;
	Sat, 29 Dec 2007 14:27:40 -0500 (EST)
In-Reply-To: <87y7bdweca.fsf@enceladus.ygingras.net> (Yannick Gingras's
	message of "Sat, 29 Dec 2007 13:22:29 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69326>

Yannick Gingras <ygingras@ygingras.net> writes:

> Greetings Git hackers,
>
> No doubt, you guys must have discussed this problem before but I will
> pretend that I can't find the relevant threads in the archive because
> Marc's search is kind of crude.
>
> I'm coding an application that will potentially store quite a bunch of
> files in the same directory so I wondered how I should do it.  I tried
> a few different files systems and I tried path hashing, that is,
> storing the file that hashes to d3b07384d113 in d/d3/d3b07384d113.  As
> far as I can tell, that's what Git does.  It turned out to be slower
> than anything except ext3 without dir_index.

We hash like d3/b07384d113, but your understanding of we do is
more or less right.

If we never introduced packed object storage, this issue may
have mattered and we might have looked into it further to
improve the loose object access performance.  But in reality, no
sane git user would keep millions of loose objects unpacked.
And changing the layout would mean a backward incompatible
change for dumb transport clients.  There is practically no
upside and are downsides to change it now.

Traditionally, avoiding large directories when dealing with a
large number of files by path hashing was a tried and proven
wisdom in many applications (e.g. web proxies, news servers).
Newer filesystems do have tricks to let you quickly access a
large number of files in a single directory, and that lessens
the need for the applications to play path hashing games.

That is a good thing, but if that trick makes the traditional
way of dealing with a large number of files _too costly_, it may
be striking the balance at a wrong point.  That is favoring
newly written applications that assume that large directories
are Ok (or ones written by people who do not know the historical
behaviour of filesystems), by punishing existing practices too
heavily.

The person who is guilty of introducing the hashed loose object
store is intimately familiar with Linux.  I do not speak for
him, but if I have to guess, the reason he originally chose the
path hashing was because he just followed the tradition, and he
did not want to make the system too dependent on Linux or a
particular feature of underlying filesystems.
