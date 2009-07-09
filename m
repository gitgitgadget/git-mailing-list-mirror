From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] Avoid doing extra 'lstat()'s for d_type if we have
 an up-to-date cache entry
Date: Thu, 09 Jul 2009 11:37:19 -0700
Message-ID: <7vab3d3dpc.fsf@alter.siamese.dyndns.org>
References: <20090707000500.GA5594@dpotapov.dyndns.org>
 <alpine.LFD.2.01.0907081902371.3352@localhost.localdomain>
 <alpine.LFD.2.01.0907081933530.3352@localhost.localdomain>
 <alpine.LFD.2.01.0907081936470.3352@localhost.localdomain>
 <alpine.LFD.2.01.0907081940220.3352@localhost.localdomain>
 <alpine.LFD.2.01.0907081942380.3352@localhost.localdomain>
 <7vskh646bw.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.01.0907090832200.3352@localhost.localdomain>
 <7vws6h3ji4.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.01.0907091011280.3352@localhost.localdomain>
 <alpine.LFD.2.01.0907091013540.3352@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dmitry Potapov <dpotapov@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jul 09 20:37:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOyUt-0007JX-Hh
	for gcvg-git-2@gmane.org; Thu, 09 Jul 2009 20:37:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753833AbZGISh0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2009 14:37:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753568AbZGIShZ
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jul 2009 14:37:25 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:60999 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753258AbZGIShY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jul 2009 14:37:24 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 4F3372680F;
	Thu,  9 Jul 2009 14:37:24 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 7CC802680A; Thu, 
 9 Jul 2009 14:37:20 -0400 (EDT)
In-Reply-To: <alpine.LFD.2.01.0907091013540.3352@localhost.localdomain>
 (Linus Torvalds's message of "Thu\, 9 Jul 2009 10\:18\:31 -0700 \(PDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8B818A0A-6CB7-11DE-AC25-DC021A496417-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123001>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> We don't really verify the whole path when we mark things ce_uptodate(). 
> Part of what read_directory() does is to find directory entries, and in 
> the process things like "git add" will notice if there's a conflict with 
> existing index entries.
>
> So if a directory has changed into a symlink to a directory, this 
> particular optimization will actually hide that, I suspect. I haven't 
> tested, though. But it might be worth-while to see what happens when you 
> had a directory structure, and then do
>
> 	mkdir dir
> 	touch dir/a
> 	touch dir/b
> 	git add dir
>
> 	mv dir new-dir
> 	ln -s new-dir dir
> 	git status

In existing codepaths, we have "has_symlink_leading_path()" checks to
notice that tracked dir/[ab] have disappeared.  "git diff" before or after
"git status" in the above sequence does notice what you did.

Would dir/a be marked as uptodate in the index, if somebody preloads the
index, after the above sequence?  I hope not.
