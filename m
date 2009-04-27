From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add core.trustlowlevelstat for diffs in dev,ino,uid and
 gid
Date: Sun, 26 Apr 2009 23:55:16 -0700
Message-ID: <7vab628u23.fsf@gitster.siamese.dyndns.org>
References: <1240743317-10117-1-git-send-email-robin.rosenberg@dewire.com>
 <200904261306.15448.robin.rosenberg.lists@dewire.com>
 <7vocujjm5r.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.2.00.0904261159190.7331@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	Git Mailing List <git@vger.kernel.org>, spearce@spearce.org
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Kjetil Barvik <barvik@broadpark.no>
X-From: git-owner@vger.kernel.org Mon Apr 27 09:40:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LyKm0-0008Lz-Bj
	for gcvg-git-2@gmane.org; Mon, 27 Apr 2009 08:57:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751648AbZD0Gza (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Apr 2009 02:55:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751536AbZD0Gza
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Apr 2009 02:55:30 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:54095 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751349AbZD0Gz3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Apr 2009 02:55:29 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 66A1A12969;
	Mon, 27 Apr 2009 02:55:26 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 6D99212968; Mon,
 27 Apr 2009 02:55:20 -0400 (EDT)
In-Reply-To: <alpine.LFD.2.00.0904261159190.7331@localhost.localdomain>
 (Linus Torvalds's message of "Sun, 26 Apr 2009 12:25:13 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 63215E62-32F8-11DE-BC73-D766E3C8547C-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117599>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> I started out wanting to check the stat information as much as possible, 
> but realistically, nobody probably really cares. We already effectively 
> removed st_dev checking and nsec checks.

Was ignoring st_dev checking primarily for a work tree over NFS?  I think
ignoring it makes sense.  If st_dev changes, it is likely that somebody
did a "mv" of a whole repository to some other filesystem, or the
filesystem is not giving stable st_dev to us for the whole tree---it is
not like we want to detect a change to a single path that changes its
st_dev and nothing else, as no such change is likely to be useful.

> IOW, maybe we should just do this, and remove over a hundred lines of dead 
> code or commentary/config. And never have to worry about these kinds of 
> issues with different environments again.

I like the end result.

But I am not sure about dropping the nanosecond resolution timestamps.
The area was extended recently in preparation for ext4; we can take
advantage of it to reduce the chance the racy-git avoidance codepath
triggers if we keep it.

    fba2f38 (make USE_NSEC work as expected, 2009-02-19)

    c06ff49 (Record ns-timestamps if possible, but do not use it without
    USE_NSEC, 2009-03-04)
