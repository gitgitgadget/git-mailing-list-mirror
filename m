From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/4] Turning Conflicts: hint into comment
Date: Tue, 28 Oct 2014 14:36:48 -0700
Message-ID: <1414532212-9016-1-git-send-email-gitster@pobox.com>
References: <xmqq1tpxgw6t.fsf@gitster.dls.corp.google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 28 22:56:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XjEl7-0007K9-Re
	for gcvg-git-2@plane.gmane.org; Tue, 28 Oct 2014 22:56:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755275AbaJ1V4w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Oct 2014 17:56:52 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:54431 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755252AbaJ1V4v (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Oct 2014 17:56:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BB35D1AFC1;
	Tue, 28 Oct 2014 17:56:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=RgZM
	SfMzHtx+AY1qjd522BAM66g=; b=UxnTJV0oPIcRCAFxHjtvpnM96sKvmu3RdUOH
	C2jG6QVlgDgqF07wUPJ99RFbgwMq0/PrSoiLLycmGFf1FSudhv/0Pj6ozhfPSYjE
	JB2gUp/uFf/hkK9yu949S0Q5g7l2AyhNMJGKluaaHzXrx7N2175BPfF/D5WW/WVx
	fqMPYo0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=UdOAdD
	HwMIgCcLILbHIstHoR8SZx4kTZVLpGRqkazJX0BFvbupnrsHfxAc/L4DrRr7NMBF
	F1gVMOcOpPrYdiDN7oK8sHvUdN4x+xf5K2//3J10Cwj90xXv9aebsqQxAQBcUMQc
	qVZtiyn+kgyZwcOsbRE7yo06lK+/0gebvvF+s=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B14061AFC0;
	Tue, 28 Oct 2014 17:56:50 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BAD6C1AAA4;
	Tue, 28 Oct 2014 17:36:55 -0400 (EDT)
X-Mailer: git-send-email 2.1.2-620-g33c52cb
In-reply-to: <xmqq1tpxgw6t.fsf@gitster.dls.corp.google.com>
X-Pobox-Relay-ID: 8A265DFE-5EEA-11E4-9FA7-527C6E758C04-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

So here is a reroll to hopefully bring this topic closer to
perfection.

The first two patches haven't changed, except that they are now part
of a numbered series.

The third patch is a refactoring that helps clarify what happens in
the last step, which is new.

The endgame is similar to what was posted before, except that we pay
attention to "Conflicts:" and HT indented pathnames in addition to
comments and blanks when determining the true end of the log
message.  This is so that running "git commit --amend -s" on a
commit that was created with older versions of Git by a careless
user who left the old conflicts hint around will insert the new
sign-off at the right place.

The series is designed to apply on v1.8.5.x series, even though I do
not anticpiate that we would need to backport this to maintenance
branches.  !prefixcmp() will need to turn into starts_with() when
merging to newer codebase, which I can let rerere take care of.

Junio C Hamano (4):
  builtin/merge.c: drop a parameter that is never used
  merge & sequencer: unify codepaths that write "Conflicts:" hint
  builtin/commit.c: extract ignore_non_trailer() helper function
  merge & sequencer: turn "Conflicts:" hint into a comment

 builtin/commit.c                | 74 ++++++++++++++++++++++++++---------------
 builtin/merge.c                 | 22 ++++--------
 sequencer.c                     | 34 ++++++++++---------
 sequencer.h                     |  1 +
 t/t3507-cherry-pick-conflict.sh | 42 ++++++++++++++++++-----
 5 files changed, 109 insertions(+), 64 deletions(-)

-- 
2.1.2-620-g33c52cb
