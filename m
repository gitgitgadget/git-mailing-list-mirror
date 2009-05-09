From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix segfault in merge-recursive
Date: Sat, 09 May 2009 09:54:30 -0700
Message-ID: <7vzldm6wu1.fsf@alter.siamese.dyndns.org>
References: <alpine.DEB.2.00.0905070102010.30999@narbuckle.genericorp.net>
	<alpine.DEB.1.00.0905071144370.18521@pacific.mpi-cbg.de>
	<alpine.DEB.2.00.0905072131470.30999@narbuckle.genericorp.net>
	<alpine.DEB.1.00.0905082229520.4601@intel-tinevez-2-302>
	<alpine.DEB.2.00.0905081436070.30999@narbuckle.genericorp.net>
	<alpine.DEB.1.00.0905090012410.4601@intel-tinevez-2-302>
	<alpine.DEB.2.00.0905081624230.30999@narbuckle.genericorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Dave O <cxreg@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 09 18:56:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2pqm-0001cP-0r
	for gcvg-git-2@gmane.org; Sat, 09 May 2009 18:56:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756644AbZEIQyc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 May 2009 12:54:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756596AbZEIQyb
	(ORCPT <rfc822;git-outgoing>); Sat, 9 May 2009 12:54:31 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:43017 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756664AbZEIQya (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 May 2009 12:54:30 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090509165431.MRNN20976.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Sat, 9 May 2009 12:54:31 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id pUuW1b0064aMwMQ03UuWGF; Sat, 09 May 2009 12:54:30 -0400
X-Authority-Analysis: v=1.0 c=1 a=8jqgv1hcQK4A:10 a=ybZZDoGAAAAA:8
 a=Vv0O3_QnCXIzwGc0r6gA:9 a=h45IlIjT7PKw63tWgxkA-Co-dwEA:4 a=qIVjreYYsbEA:10
X-CM-Score: 0.00
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118675>

Dave O <cxreg@pobox.com> writes:

> Once again, I don't really know what the implications of the index
> operations that are happening here are, but the update_stages() call
> in a recursive merge must be doing surprising.

When you are trying to come up with the final result (i.e. depth=0), you
want to record how the conflict arose by registering the state of the
common ancestor, your branch and the other branch in the index, hence you
want to do update_stages().

When you are merging with positive depth, that is because of a criss-cross
merge situation.  In such a case, you would need to record the tentative
result, with conflict markers and all as if the merge went cleanly, even
if there are conflicts, in order to write it out as a tree object later to
be used as a common ancestor tree.  update_file() calls update_file_flags()
with update_cache=1 to signal that the result needs to be written to the
index at stage #0 (i.e. merged), and the code should not clobber the index
further by calling update_stages().

Your patch looks correct.  Thanks.
