From: Junio C Hamano <gitster@pobox.com>
Subject: Re: 1.5.6.5 fails to clone git.kernel.org/[...]/rostedt/linux-2.6-rt
Date: Fri, 09 Jan 2009 00:58:55 -0800
Message-ID: <7vpriw26uo.fsf@gitster.siamese.dyndns.org>
References: <E1LLAn5-0001JM-00@alva.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Tim Shepard <shep@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Jan 09 10:00:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLDED-0004ho-Lo
	for gcvg-git-2@gmane.org; Fri, 09 Jan 2009 10:00:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753653AbZAII7G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jan 2009 03:59:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753459AbZAII7E
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jan 2009 03:59:04 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:53691 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753092AbZAII7E (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jan 2009 03:59:04 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 207CC8EAFB;
	Fri,  9 Jan 2009 03:59:02 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id DF5968EAFA; Fri,
  9 Jan 2009 03:58:56 -0500 (EST)
In-Reply-To: <E1LLAn5-0001JM-00@alva.home> (Tim Shepard's message of "Fri, 09
 Jan 2009 01:24:19 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C29FFF96-DE2B-11DD-B43A-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104989>

Tim Shepard <shep@alum.mit.edu> writes:

> I have git 1.5.6.5 installed from the Debian/lenny package.
>
> Poking around in http://git.kernel.org/ looking for a git repository
> that might have the latest -rt development happening, I found
>
>   http://git.kernel.org/?p=linux/kernel/git/rostedt/linux-2.6-rt.git
>
> which looked promising.
>
> But when I tried cloning it using:
>
>     git clone rsync://rsync.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-2.6-rt.git linux-2.6-rt
>
> it pulled several hundred megabytes through my (rather slow) DSL line
> and then printed out
>
>   error: Trying to write ref refs/tags/v2.6.11 with nonexistant object 5dc01c595e6c6ec9ccda4f6f69c131c0dd945f8c
>   fatal: Cannot update the ref 'refs/tags/v2.6.11'.
>
> and then removed everything it had just pulled.
>
> Looking at http://git.kernel.org/?p=linux/kernel/git/rostedt/linux-2.6-rt.git;a=tags
> I see that apparently v2.6.11 and v.2.6.11-tree both point at a tree
> object and not a commit.
>
> Is this a bug in git?

It is not a problem for the tag pointing to a tree, but linux-2.6-rt.git
tree uses (like everybody else) objects/alternates to borrow objects from
the repository of Linus.

I think we lost the alternate object store support when git-fetch was
rewritten from the original shell script (that did support fetching from
such a repository over rsync:// transport) to a reimplementation in C,
with commit b888d61 (Make fetch a builtin, 2007-09-10).  

Later, cd547b4 (fetch/push: readd rsync support, 2007-10-01) attempted to
resurrect some rsync support (b888d61 lost rsync support completely for
git-fetch), but introduced these lines in transport.c:

	/* NEEDSWORK: handle one level of alternates */
	result = run_command(&rsync);

These have not been touched ever since, and then finally commit 8434c2f
(Build in clone, 2008-04-27) killed support of cloning from a repository
that uses alternates for rsync transport for git-clone (before that, the
shell script version had a special case to still allow such operation over
rsync).

It appears practically nobody uses rsync:// transport anymore these days;
you are unfortunately the first one who noticed it.
