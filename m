From: Junio C Hamano <gitster@pobox.com>
Subject: Re: commiting while the current version is in conflict
Date: Fri, 17 Oct 2008 02:36:28 -0700
Message-ID: <7vabd3mulf.fsf@gitster.siamese.dyndns.org>
References: <7vy70of6t2.fsf@arte.twinsun.com>
 <2d460de70810170021q5daa902er1e6e2fb6633400ec@mail.gmail.com>
 <m3d4hzk2du.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Richard Hartmann" <richih.mailinglist@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Miklos Vajna" <vmiklos@frugalware.org>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 17 11:38:07 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqlmV-000154-Sn
	for gcvg-git-2@gmane.org; Fri, 17 Oct 2008 11:38:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752945AbYJQJgw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Oct 2008 05:36:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752940AbYJQJgw
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Oct 2008 05:36:52 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:39970 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752663AbYJQJgv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Oct 2008 05:36:51 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 53E03707FE;
	Fri, 17 Oct 2008 05:36:50 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 57424707FD; Fri, 17 Oct 2008 05:36:39 -0400 (EDT)
In-Reply-To: <m3d4hzk2du.fsf@localhost.localdomain> (Jakub Narebski's message
 of "Fri, 17 Oct 2008 02:16:35 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 1FDFAD58-9C2F-11DD-AEBA-1E1F86D30F62-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98466>

Jakub Narebski <jnareb@gmail.com> writes:

> From time to time somebody proposes to add a command which is used
> only to say that given conflict got resolved, i.e. yet another
> porcelain "around" git-update-index plumbing (in addition to git-add,
> git-mv and git-rm).  One of problems is how to call it: git-resolve,
> git-resolved, git-mark-resolved?
>
> BTW. while I usually use "git commit -a", when comitting merge commit
> I usually use explicit "git add" together "git commit" (without '-a').

There are three things to keep in mind while thinking about this:

 * "git add" _always_ is to mark "this path now is in a good shape and is
   ready to be committed", whether you are doing a conflict resolution of
   a merge or making a normal commit.

 * you cannot partially commit a merge, as the resulting tree won't be a
   proper merge (i.e. the change from either parents do not describe what
   happened).

 * during a conflicted merge, cleanly merged paths are already staged in
   the index.

Which means that the only paths you would "git add" during a conflicted
merge are the paths you resolved (unless you are creating an evil merge),
and there is no point having a separate "git resolved" -- such a command
will be nothing but an alias to "git add" anyway.

We could add a training wheel mode to "git commit -a" (or "git add -u")
that warns about unmerged paths and asks confirmation, but I suspect that
it would really annoy people who used git for more than 2 weeks if we made
it the default, and on the other hand if it is not the default, it would
not help new people that much.  It is nice to try to help new people from
shooting themselves in the foot, but we need to draw a line somewhere so
that we do not hurt people by being obnoxious.  After all, even these new
people will graduate from the "new" status soon.  My gut feeling is that
helping "oh, I staged the file that I wasn't ready to commit" is on the
other side of that line, especially since the example pre-commit hook
safety is easily available.  If somebody wants to add a pre-add hook that
is run by "git add" Porcelain (but never by "update-index"), that would
add the safety net, too.
