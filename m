From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [Btrfs-devel] btrfs and git-reflog
Date: Sun, 27 Jan 2008 00:08:59 -0800
Message-ID: <7vprvny9k4.fsf@gitster.siamese.dyndns.org>
References: <873asmcodd.fsf@burly.wgtn.ondioline.org>
	<200801251050.16697.chris.mason@oracle.com>
	<alpine.LFD.1.00.0801250905570.14161@hp.linux-foundation.org>
	<7vmyqt657t.fsf@gitster.siamese.dyndns.org>
	<7v7ihx2fdb.fsf@gitster.siamese.dyndns.org>
	<alpine.LFD.1.00.0801262314360.3222@www.l.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Chris Mason <chris.mason@oracle.com>, btrfs-devel@oss.oracle.com,
	Paul Collins <paul@burly.ondioline.org>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Jan 27 09:09:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJ2aP-0007Vi-8f
	for gcvg-git-2@gmane.org; Sun, 27 Jan 2008 09:09:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753395AbYA0IJQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2008 03:09:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752902AbYA0IJQ
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Jan 2008 03:09:16 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:37197 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752821AbYA0IJP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2008 03:09:15 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 3F2C648F6;
	Sun, 27 Jan 2008 03:09:13 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 9D80948F5;
	Sun, 27 Jan 2008 03:09:07 -0500 (EST)
In-Reply-To: <alpine.LFD.1.00.0801262314360.3222@www.l.google.com> (Linus
	Torvalds's message of "Sat, 26 Jan 2008 23:22:32 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71808>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> Yes, but the potential problem is actually very different:
>
>  - directory contains 'a', 'b' and 'c'
>
> 	* opendir()
> 	* readdir() returns 'a'
> 	  * unlink('a');
> 	* readdir() returns 'c', having skipped 'b'.
>
> This is something that could in theory happen if a directory is indexed 
> using the *position* of a filename in a directory. 'a' was position 1, 'b' 
> was position 2, and 'c' was position 3. After the first readdir(), the 
> file position was 2 (pointing at 'b'), but when we removed 'a', the other 
> entries positions moved down, and now 'b' is at position 1, and 'c' is at 
> position '2'. When we call readdir() the next time, it skips 'b' (because 
> it already returned position 1!), and returns 'c'.
>
> See?

Yes, I had that one in mind too, but that will cause us to miss
'b' and its only effect is to leave 'b' unpacked.  If we somehow
dropped 'b' and lost information that is a different story, but
I do not think this failure mode would cause our current code to
do so.  So I do not think is a big deal even if some filesystem
had a bug like that.
