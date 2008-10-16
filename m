From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] reset --hard/read-tree --reset -u: remove unmerged new
 paths
Date: Thu, 16 Oct 2008 07:49:21 -0700
Message-ID: <7v8wsok32m.fsf@gitster.siamese.dyndns.org>
References: <20081015115654.fb34438f.akpm@linux-foundation.org>
 <alpine.DEB.1.10.0810151208100.7808@asgard.lang.hm>
 <alpine.DEB.1.10.0810151211580.7808@asgard.lang.hm>
 <alpine.LFD.2.00.0810151219120.3288@nehalem.linux-foundation.org>
 <20081015124949.b657a8db.akpm@linux-foundation.org>
 <alpine.LFD.2.00.0810151256410.3288@nehalem.linux-foundation.org>
 <alpine.LFD.2.00.0810151311210.3288@nehalem.linux-foundation.org>
 <7v3aixqzrn.fsf@gitster.siamese.dyndns.org>
 <7vy70ppiq1.fsf_-_@gitster.siamese.dyndns.org>
 <20081016072010.GA19188@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>, david@lang.hm,
	Git Mailing List <git@vger.kernel.org>
To: Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Thu Oct 16 16:51:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqUC5-0000zI-9Z
	for gcvg-git-2@gmane.org; Thu, 16 Oct 2008 16:51:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753855AbYJPOuC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Oct 2008 10:50:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753842AbYJPOuC
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Oct 2008 10:50:02 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:33846 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753719AbYJPOuA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Oct 2008 10:50:00 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 6A1248B910;
	Thu, 16 Oct 2008 10:49:59 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 416E58B90F; Thu, 16 Oct 2008 10:49:47 -0400 (EDT)
In-Reply-To: <20081016072010.GA19188@elte.hu> (Ingo Molnar's message of "Thu,
 16 Oct 2008 09:20:10 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B4A4C7BE-9B91-11DD-9D81-4F5276724C3F-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98386>

Ingo Molnar <mingo@elte.hu> writes:

> Does your fix mean that all i have to do in the future is a hard reset 
> back to HEAD, and that dangling files are not supposed to stay around?

As long as the index *somehow* knows about these new files, they are
removed.

The situation is:

 (0) you start from a HEAD that does not have path xyzzy;
 (1) you attempt to merge a rev that has path xyzzy;
 (2) the merge conflicts, leaving higher staged index entries for the
     path.
 (3) you decide not to conclude the merge by saying "reset --hard".

The old logic for "reset" was to remove paths that exist in the index at
stage #0 (i.e. cleanly merged) and not in HEAD.  The patch changes the
rule to remove paths that exist in the index at any stage (i.e. including
the ones that have conflicted and not resolved yet) and not in HEAD.
