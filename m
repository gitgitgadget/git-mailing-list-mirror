From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] parse_commit_buffer: don't parse invalid commits
Date: Mon, 14 Jan 2008 13:42:29 -0800
Message-ID: <7vabn8jd8a.fsf@gitster.siamese.dyndns.org>
References: <12002478702664-git-send-email-mkoegler@auto.tuwien.ac.at>
	<7vk5mclvk3.fsf@gitster.siamese.dyndns.org>
	<20080114205826.GB5058@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: mkoegler@auto.tuwien.ac.at (Martin Koegler)
X-From: git-owner@vger.kernel.org Mon Jan 14 22:43:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEX5Q-0007rl-D3
	for gcvg-git-2@gmane.org; Mon, 14 Jan 2008 22:43:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751479AbYANVmm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2008 16:42:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752089AbYANVmm
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jan 2008 16:42:42 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:48853 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751479AbYANVmk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2008 16:42:40 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id EDC3E17DB;
	Mon, 14 Jan 2008 16:42:38 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 4FAE917D9;
	Mon, 14 Jan 2008 16:42:36 -0500 (EST)
In-Reply-To: <20080114205826.GB5058@auto.tuwien.ac.at> (Martin Koegler's
	message of "Mon, 14 Jan 2008 21:58:26 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70480>

mkoegler@auto.tuwien.ac.at (Martin Koegler) writes:

> You seem to have missed my reply to your last mail:
> http://marc.info/?l=git&m=119969163624138&w=2

Yeah, apparently I did.

> On the other hand, it is possible, that somebody pushed such a commit
> out, if he does not notice it. Then its difficult to get rid of the
> broken commit. [Hasn't happend a broken commit on pu recently?]

That's true, but I wonder if there is a reasonable middle
ground.  For example, we could keep the warning you added (by
calling error() to identify which commit object is suspicious)
without making the whole function return that error.  Then a
broken commit could have been catched while reviewing the series
before the commit gets pushed out.

>> I do not think the checks done by fsck and parse_commit should
>> share the same strictness.  They serve different purposes.
>
> Maybe I can improve fsck.

Thanks.  It should notice bogus commits but it should allow
checking objects referenced by them unless the particular
bogosity is severe enough to make "tree " and "parent " lines in
them invalid.

IOW, the information on the "author" line is not that important.
It has zero importance from the structural viewpoint, just like
the commit log message contents does not have any structural
importance (it does not even affect how the log output is sorted
at all, while the timestamp on the "committer" line has some say
in it).

Noticing a bogus "author" or "committer" line is like noticing
that your commit log message has garbage characters in it.
Maybe a future option to fsck might want to check that all log
messages are encoded in UTF-8, and you may catch some that are
in ISO-8859-1.  After flagging them as such, the program should
still continue digging the history down to check its ancestors,
as such a breakage does not affect the structural integrity of
the history.
