From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] cherry-pick: don't forget -s on failure
Date: Wed, 12 Sep 2012 15:45:10 -0700
Message-ID: <7v8vcec13d.fsf@alter.siamese.dyndns.org>
References: <20120912195732.GB4722@suse.cz>
 <7vd31qc1p3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Robin Stocker <robin@nibor.org>
To: Miklos Vajna <vmiklos@suse.cz>
X-From: git-owner@vger.kernel.org Thu Sep 13 00:45:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBvgS-000826-3I
	for gcvg-git-2@plane.gmane.org; Thu, 13 Sep 2012 00:45:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751449Ab2ILWpO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Sep 2012 18:45:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58563 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751055Ab2ILWpN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Sep 2012 18:45:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 919BC8C83;
	Wed, 12 Sep 2012 18:45:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=epZyn/KcAuNLiKcVYeIvfYTSKnw=; b=OjON8s
	vvvFixMPRMTqvZVdEDWim8wRdl8iNYyVOPnZAEL22RGePsw3ijL6bMORLRn11tCC
	MlOyM7TsCrhcFZgKDvoCYbdmkoTvSFV29wG7F2QA1hc1OLwdmJPiBc9u0sv6qRea
	K+mqeZiRanS2PfM6bKDt8qLP85HuiL551ikFM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KUaFTHCCcNpqrfnw8eeL2zjqZteyk9C9
	3eIQZa0bTX2THllAdtcIWL/eTKrjOMpqOtOgK5iwl0djaOOpwEqnr75xkO8vW3p4
	8HfQkDyFWdmLKc4Vc0Kvr8sWMW5GSdEpW5dfEBpCvnL0Pd+PGurf5ykSdQfmxIB4
	MB160z573C8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7FE3D8C82;
	Wed, 12 Sep 2012 18:45:12 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D34298C80; Wed, 12 Sep 2012
 18:45:11 -0400 (EDT)
In-Reply-To: <7vd31qc1p3.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 12 Sep 2012 15:32:08 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 82DC60F2-FD2B-11E1-B193-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205349>

Junio C Hamano <gitster@pobox.com> writes:

> I think we had a separate topic around cherry-pick that needs the
> footer thing accessible from cherry-pick recently ($gmane/204755).
>
> I think the code movement in this patch is a good one.
>
> Thanks.

Having said that, the behaviour after this patch is applied is not
quite right.

A typical .git/MERGE_MSG that is left after "cherry-pick" gives the
control back to you asking for help, with your patch that adds the
sign-off at the end, would look like this:


    cherry-pick: don't forget -s on failure

    In case 'git cherry-pick -s <commit>' failed, the user had to use 'git
    commit -s' (i.e. state the -s option again), which is easy to forget
    about.  Instead, write the signed-off-by line early, so plain 'git
    commit' will have the same result.

    Signed-off-by: Miklos Vajna <vmiklos@suse.cz>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

    Conflicts:
            builtin/commit.c

    Signed-off-by: Junio C Hamano <gitster@pobox.com>


Notice two issues?

 - The additional S-o-b should come immediately after the existing
   block of footers.

 - And the last entry in the existing footer block is already mine,
   so there shouldn't have been a new and duplicated one added.


I am not sure how reusable the moved function is without
enhancements for your purpose.  The logic to identify the footer
needs to be enhanced so that an "end" pointer to point at the byte
before the caller added "Conflicts: " can be given, and pretend as
if it is the end of the buffer, unlike in the fresh commit case
where it can consider the real end of the buffer as such.

Or something like that.
