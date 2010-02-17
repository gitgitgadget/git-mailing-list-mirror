From: Junio C Hamano <gitster@pobox.com>
Subject: Re: 'git status' on NFS performance regression in 1.7.0
Date: Wed, 17 Feb 2010 12:23:31 -0800
Message-ID: <7vy6irligs.fsf@alter.siamese.dyndns.org>
References: <885649361002171208j41405b9exdfc34034c905e96c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git ML <git@vger.kernel.org>
To: James Pickens <jepicken@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 17 21:23:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhqRA-0006SK-HY
	for gcvg-git-2@lo.gmane.org; Wed, 17 Feb 2010 21:23:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755331Ab0BQUXi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Feb 2010 15:23:38 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:60052 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755064Ab0BQUXh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2010 15:23:37 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5B6199AA39;
	Wed, 17 Feb 2010 15:23:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:in-reply-to:date:message-id:mime-version
	:content-type; s=sasl; bh=BuNV0PuhsdPOsu9rqzjCEpSPZec=; b=ekPV73
	dSJ4+GxFLwjdpoLz8kAROaBjj93XQ5hLB/iM8B04sO4HEXCTt70LfYe7Ca6Hw9+Y
	+xBIbR/qBLhhn2fHCQ1KAsqPBNbj1trr9fFnN9uSc01w4sD5jWGCIDzshfV+lrYF
	9FWEvTaKbZfaYpKLfhSlTkpEoMjq5CnPM3koA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:in-reply-to:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qXC71kGfnS1kMKRIgj3m/fYsamq6b6EP
	CvkAqUdYoENpwS+eiHnNQ29kA4PkPYimMfvAhEkTy1XzzIq3DwrpxfZ+F+s7OOj/
	sJrj3CtXIfFPLllIkxeHc7lgt4lWyW4IMWz7C+EhhWzn1VDx6I0zqPBFCWGZLHXp
	y7arkzMamBQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 356C19AA35;
	Wed, 17 Feb 2010 15:23:35 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 80D4D9AA33; Wed, 17 Feb
 2010 15:23:32 -0500 (EST)
In-Reply-To: <885649361002171208j41405b9exdfc34034c905e96c@mail.gmail.com>
 (James Pickens's message of "Wed\, 17 Feb 2010 13\:08\:12 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 52F73E32-1C02-11DF-8055-D83AEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140260>

James Pickens <jepicken@gmail.com> writes:

> I noticed that 'git status' in version 1.7.0 is much slower than in 1.6.2.5
> on large work trees on NFS - averaging ~13 seconds runtime vs. ~2 seconds.
> I did a bit of debugging and found that 'git status' apparently doesn't use
> the multi-threaded preload_index any more, although some other commands
> like diff still use it.  Was it intentionally dropped from 'git status'?

There might be subtle breakage for doing this, but it would be worth a try
;-)

 builtin-commit.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index 55676fd..71f81c9 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -1046,7 +1046,7 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 	if (*argv)
 		s.pathspec = get_pathspec(prefix, argv);
 
-	read_cache();
+	read_cache_preload(NULL);
 	refresh_index(&the_index, REFRESH_QUIET|REFRESH_UNMERGED, s.pathspec, NULL, NULL);
 	s.is_initial = get_sha1(s.reference, sha1) ? 1 : 0;
 	s.in_merge = in_merge;
