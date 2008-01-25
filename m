From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [Btrfs-devel] btrfs and git-reflog
Date: Fri, 25 Jan 2008 12:05:42 -0800
Message-ID: <7vmyqt657t.fsf@gitster.siamese.dyndns.org>
References: <873asmcodd.fsf@burly.wgtn.ondioline.org>
	<200801251050.16697.chris.mason@oracle.com>
	<alpine.LFD.1.00.0801250905570.14161@hp.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Chris Mason <chris.mason@oracle.com>, btrfs-devel@oss.oracle.com,
	Paul Collins <paul@burly.ondioline.org>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Jan 25 21:07:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JIUoq-00048c-EB
	for gcvg-git-2@gmane.org; Fri, 25 Jan 2008 21:06:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755582AbYAYUF6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2008 15:05:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755376AbYAYUF6
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jan 2008 15:05:58 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:35765 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752785AbYAYUF5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2008 15:05:57 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id D64A1605E;
	Fri, 25 Jan 2008 15:05:54 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 166D76059;
	Fri, 25 Jan 2008 15:05:48 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71734>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> Yes indeed. This is clearly git mis-using "readdir()", and should be 
> fixed. It could happen on other filesystems, and very much including ones 
> where there is no option of just "fixing" the filesystem (including 
> Linux: not everybody can upgrade their kernels just because git makes 
> some broken assumptions).

I agree that this is a broken assumption on git's part.  When we
have this loop:

	while (ent = readdir()) {
        	... do something in that directory ...
	}

we should expect readdir() may return new entries and cope with
it, as "If a file is removed from or added to the directory
after the most recent call to opendir() or rewinddir(), whether
a subsequent call to readdir() returns an entry for that file is
unspecified." [*1*]

The modification may not be done by us, but by "git push" from
elsewhere to update an existing ref, which can run while we are
inside this loop.

For this particular case, I think keeping track of what we have
already dealt with and skipping when we see duplicates is a good
enough solution.  Removal of a loose ref is protected by taking
a lock on the packed-refs file, so we shouldn't have to worry
about races between pack-refs and a push to delete a ref (IOW,
it won't be an issue that readdir(3) may report a file that is
removd by simultaneous git-push).

However, I am not sure if the way delete_ref() takes locks (one
for the ref itself and another for packed-refs file) is
deadlock-free.  That may need an independent fix if there is; I
haven't closely looked at this.

I suspect we might want to change the current ".lock" suffix to
something that would make the lock filenames an invalid ref
(e.g., "..lock", or "~"), so that people can use "foo.lock" as a
branch name.  That is also outside of the scope of readdir(3)
abuse fix, though.


[Reference]

*1* http://www.opengroup.org/onlinepubs/000095399/functions/readdir.html
