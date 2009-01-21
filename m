From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [VALGRIND PATCH for nth_last patch series] Fix invalid memory
 access
Date: Wed, 21 Jan 2009 02:13:03 -0800
Message-ID: <7vr62xezm8.fsf@gitster.siamese.dyndns.org>
References: <7v8wpcs38c.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0901210113500.19014@racer>
 <7vwscpgi7t.fsf@gitster.siamese.dyndns.org>
 <200901211019.01493.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Johannes Sixt <johannes.sixt@telecom.at>,
	Johan Herland <johan@herland.net>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Jan 21 11:15:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPa70-0005iz-1d
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 11:15:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764102AbZAUKNS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2009 05:13:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764098AbZAUKNP
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jan 2009 05:13:15 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:64200 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764232AbZAUKNN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2009 05:13:13 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id F157E1CECC;
	Wed, 21 Jan 2009 05:13:11 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 71B811CEE4; Wed,
 21 Jan 2009 05:13:05 -0500 (EST)
In-Reply-To: <200901211019.01493.trast@student.ethz.ch> (Thomas Rast's
 message of "Wed, 21 Jan 2009 10:18:57 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 1BE6FD94-E7A4-11DD-82BE-BE78113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106587>

Thomas Rast <trast@student.ethz.ch> writes:

> Actually the point of that exercise was to ignore branch (non)switches
> of the form
>
>   checkout: moving from A to A

Ahhh, Ok, that is what I missed.

> I originally thought that this would be desirable behaviour, but now
> that it causes so much trouble, I'm not that sure any more.  I still
> think it would be more intuitive to not count them as switches (after
> all git-checkout says 'Already on "$branch"'), but OTOH 'cd .; cd -'
> also stays in the same directory.

An entry of the form "from A to A" is made only when you explicitly ask to
checkout the current branch by name (i.e. "git checkout" without any
parameter won't add such an entry to the reflog), so I tend to agree with
"cd" that the users may find it more natural if we counted them.

Having said all that, I think Dscho's one had an off-by-one (but it is
getting late and it may be I who has one).

When parsing "checkout: moving from master to side\n", match points at
"master to...", target points at "side\n", and len is 6 (length of
"master").  We want to see if target is "master\n" and ignore such an
entry, so we should be checking if target is one longer than len.

 sha1_name.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git c/sha1_name.c w/sha1_name.c
index 38c9f1b..9aed8ae 100644
--- c/sha1_name.c
+++ w/sha1_name.c
@@ -731,7 +731,10 @@ static int grab_nth_branch_switch(unsigned char *osha1, unsigned char *nsha1,
 		return 0;
 
 	len = target - match - 4;
-	if (target[len] == '\n' && !strncmp(match, target, len))
+	if (len + 1 == strlen(target) &&
+	    target[len] == '\n' &&
+	    !memcmp(target, match, len))
+		/* switching same branch "from A to A\n" */
 		return 0;
 
 	nth = cb->cnt++ % cb->alloc;
