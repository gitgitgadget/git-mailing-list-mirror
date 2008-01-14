From: Junio C Hamano <gitster@pobox.com>
Subject: Re: performance problem: "git commit filename"
Date: Mon, 14 Jan 2008 10:38:01 -0800
Message-ID: <7v63xwl0c6.fsf@gitster.siamese.dyndns.org>
References: <alpine.LFD.1.00.0801121426510.2806@woody.linux-foundation.org>
	<alpine.LFD.1.00.0801121735020.2806@woody.linux-foundation.org>
	<alpine.LFD.1.00.0801121949180.2806@woody.linux-foundation.org>
	<7vtzliqh3u.fsf@gitster.siamese.dyndns.org>
	<7vd4s6qal0.fsf@gitster.siamese.dyndns.org>
	<alpine.LFD.1.00.0801130922030.2806@woody.linux-foundation.org>
	<7vr6glnrvp.fsf@gitster.siamese.dyndns.org>
	<alpine.LFD.1.00.0801140902140.2806@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Kristian H?gsberg <krh@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Jan 14 19:38:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEUCl-0008PQ-LY
	for gcvg-git-2@gmane.org; Mon, 14 Jan 2008 19:38:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750870AbYANSiL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2008 13:38:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750824AbYANSiL
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jan 2008 13:38:11 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:36912 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750708AbYANSiK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2008 13:38:10 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id AD69B5AB2;
	Mon, 14 Jan 2008 13:38:08 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 04AFD5AAE;
	Mon, 14 Jan 2008 13:38:03 -0500 (EST)
In-Reply-To: <alpine.LFD.1.00.0801140902140.2806@woody.linux-foundation.org>
	(Linus Torvalds's message of "Mon, 14 Jan 2008 09:07:27 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70468>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> ... I think it would be even better if we 
> just bit the bullet and started looking at having a different in-memory 
> representation from the on-disk one. Possibly not *that* much different: 
> perhaps just keeping a pointer to the on-disk one along with a flags 
> value.

We have two things we currently do that are not about on-disk
index file ('-'), and this patch adds another ('+'):

 - Update the work tree file that corresponds to this entry
   (CE_UPDATE);

 - This entry is to be removed (ce_mode == 0);

 + The work tree file that corresponds to this entry is known to
   be unchanged (CE_UPTODATE).

We could introduce "struct in_core_cache_entry" that has these
information, indexed and sorted by name, and has a pointer to
what we read from the on-disk index.

	struct in_core_cache_entry {
		struct cache_entry *e;
                unsigned is_up_to_date : 1,
                	 to_be_updated : 1,
                         to_be_removed : 1;
	};

The code that iterate over active_cache[] will instead iterate
over this.  The number of the entries in this array will be the
new active_nr.

In the existing code, we reference "ce->name" and "ce->sha1"
everywhere. When we check and update flags we do bitops between
"ce->ce_flags" and "htons(CE_BLAH)" in many places.  Converting
them would adds another indirection and be quite painful.  But
the compiler can reliably spot the places we fail to find, so it
at least is not so risky.  It will just be a lot of work.
