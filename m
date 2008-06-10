From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git bugs
Date: Tue, 10 Jun 2008 16:38:56 -0700
Message-ID: <7v1w34dfn3.fsf@gitster.siamese.dyndns.org>
References: <832adb090806100141n69c086a2v2f59fe94b2f4ead3@mail.gmail.com>
 <alpine.LFD.1.10.0806101028040.3101@woody.linux-foundation.org>
 <832adb090806101145w55729676ya7bcfb41b0413f59@mail.gmail.com>
 <alpine.LFD.1.10.0806101249580.3101@woody.linux-foundation.org>
 <832adb090806101609q17a21948nb5814c3b22bd832d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	"Daniel Barkalow" <barkalow@iabervon.org>, git@vger.kernel.org
To: "Ben Lynn" <benlynn@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 11 01:40:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6DRf-0008GB-Ns
	for gcvg-git-2@gmane.org; Wed, 11 Jun 2008 01:40:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753563AbYFJXjO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2008 19:39:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753755AbYFJXjN
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jun 2008 19:39:13 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:51639 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753545AbYFJXjN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2008 19:39:13 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A5F6A53A3;
	Tue, 10 Jun 2008 19:39:10 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id AB3FE53A2; Tue, 10 Jun 2008 19:39:03 -0400 (EDT)
In-Reply-To: <832adb090806101609q17a21948nb5814c3b22bd832d@mail.gmail.com>
 (Ben Lynn's message of "Tue, 10 Jun 2008 16:09:23 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 6CFBF2FC-3746-11DD-B1F3-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84562>

"Ben Lynn" <benlynn@gmail.com> writes:

> I had thought about this. I hacked some code up where the index looks
> at the current system time when updating a cache entry to determine if
> the hash is racy. Is doing one time(NULL) call per file reasonable?
> I'm guessing it must be cheaper that a stat call.

Hmm, sorry, could you elaborate how you would plan to use the return value
from time(2) per file?

The "index file timestamp" trick assumes that once we start reading from
and writing to the filesystem (in order to hash the current contents,
check if there is any modification), nobody else touches the paths we are
interested in (e.g., after "read-tree -m -u" checks out the new contents,
grabs the stat information from the newly deposited file and stuffs that
in the index, you do not go in and edit it further until our process
returns the control to you).  We also assume that the files (both work
tree and the index) live in the same filesystem and the file timestamp,
which could be skewed compared to the system clock if the filesystem is
over the network, are consistent among them and monotonicly increasing.

        You have to have some assumption --- if you allow anybody to touch
        anything behind your back, or if you allow timestamps of some
        files come from different time sources than the one for some other
        files, I do not think any lstat(2) based change detection scheme
        would work.

We do our writeout first and then the index is updated after all our
writeout is done, so by definition (more precisely, "by that assumption"),
anything older than the timestamp of the index file are up to date, if
their filesystem timestamp match the timestamp recorded in the index, and
anything that is the same or newer than the index timestamp is suspect.

And that is the reason the current code gets by only with a single
timestamp.  I'd have to go back and study your breakage scenario a bit
better (I'm still at work today).
