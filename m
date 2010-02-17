From: Junio C Hamano <gitster@pobox.com>
Subject: Re: 'git status' on NFS performance regression in 1.7.0
Date: Wed, 17 Feb 2010 12:22:49 -0800
Message-ID: <7v3a0zmx2e.fsf@alter.siamese.dyndns.org>
References: <885649361002171208j41405b9exdfc34034c905e96c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git ML <git@vger.kernel.org>
To: James Pickens <jepicken@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 17 21:23:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhqQP-0005uU-Rz
	for gcvg-git-2@lo.gmane.org; Wed, 17 Feb 2010 21:23:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755218Ab0BQUW7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Feb 2010 15:22:59 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:59445 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755019Ab0BQUW5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2010 15:22:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 950D89AA25;
	Wed, 17 Feb 2010 15:22:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=R5Iey6inOm+ZPjatg44khRzgZcA=; b=H9n6uA
	WyQBajCblOaWA+HdGOFzJ2OYtDegFr1g5gFD1sVgomYoWBwQEg9DbT1ZzWR1yEj8
	LyAI8UeT0mrEuaZAAUGt9vvkbf+aeDZ3AcQaQf07yV3Gx+dcVHdIv5ftb+GPj4bM
	AWldN9vqE94YdT2gu0G309egPM/ycA4/xekf8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=N+shOq9sJtDQghyAXA9itqWE0r+Xa6M+
	07cHmeGAWYh8Mpx04nXAQHGekXocmNxePYontLJxrEn4+T3ZvJ0CFLZkCl+pIxwF
	7OPw5W67+0umALdHgjhNGCchLmZXBO2gOQNe7MWSH60Oua74N93qaKhi4PNrl1Eh
	V+OZklzKSSM=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 707749AA21;
	Wed, 17 Feb 2010 15:22:53 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CEC189AA1E; Wed, 17 Feb
 2010 15:22:50 -0500 (EST)
In-Reply-To: <885649361002171208j41405b9exdfc34034c905e96c@mail.gmail.com>
 (James Pickens's message of "Wed\, 17 Feb 2010 13\:08\:12 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3A104D46-1C02-11DF-A5C2-D83AEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140259>

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
+	read_cache_preload();
 	refresh_index(&the_index, REFRESH_QUIET|REFRESH_UNMERGED, s.pathspec, NULL, NULL);
 	s.is_initial = get_sha1(s.reference, sha1) ? 1 : 0;
 	s.in_merge = in_merge;
