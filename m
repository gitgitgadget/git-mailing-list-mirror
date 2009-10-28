From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Add '--bisect' revision machinery argument
Date: Wed, 28 Oct 2009 16:07:34 -0700
Message-ID: <7viqdzgls9.fsf@alter.siamese.dyndns.org>
References: <alpine.LFD.2.01.0910271124110.31845@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Oct 29 00:08:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3Hcp-0007qQ-SP
	for gcvg-git-2@lo.gmane.org; Thu, 29 Oct 2009 00:08:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754026AbZJ1XIJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2009 19:08:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753511AbZJ1XIJ
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Oct 2009 19:08:09 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:44697 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751877AbZJ1XII (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2009 19:08:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 98FA76A284;
	Wed, 28 Oct 2009 19:08:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cA3YECKZEKc+4L0A7BpInkahcpo=; b=EGwAT/
	eXtW1iuBK5k/W4kY/1+Dj2e44CG8qZolG67otGAGIZ304n51oZecrDOHvTbKTaww
	WJE61HGTuHHzCSIp4F3gyLcXXwxH+ZtzGYCLdfbGDZqU8UN9E7hDy/LonNEWptpK
	wGwGKmP9GcQGAo82p3ghH7DNEHKDN+93BWWws=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Kd9i0WOtGmsNg6SbzTNifyq/dbSilQff
	2gu3HMK7lDkn1uFRycte2DB2qrFj+Ak2bSUbci8HnbF8j/pQsV09sgaVpmKJLsWI
	TRQBmFQkOt7K4It13DwNIPJVmRIbSn4Zj1ZA4MzgbkZCb6FRcTjt2sAzEwncJeFE
	ZWhNR4UWxyw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6B9C96A281;
	Wed, 28 Oct 2009 19:08:07 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BE8216A27F; Wed, 28 Oct
 2009 19:07:55 -0400 (EDT)
In-Reply-To: <alpine.LFD.2.01.0910271124110.31845@localhost.localdomain>
 (Linus Torvalds's message of "Tue\, 27 Oct 2009 11\:28\:07 -0700 \(PDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C10134A8-C416-11DE-9B97-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131509>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> So this adds "--bisect" as a revision parsing argument, and as a result it 
> just works with all the normal logging tools. So now I can just do
>
> 	gitk --bisect --simplify-by-decoration filename-here

This shows a very nice direction to evolve, but your patch as-is breaks
"rev-list --bisect", I think. Call to your setup_revisions() eats the
command line "--bisect" option but cmd_rev_list() wants to see it to go
into the "bisection" mode of traversal.

Also, the helper of "git bisect" can and probably should be taught to just
ask this new behaviour from the revision machinery, instead of collecting
good and bad refs itself using bisect.c::read_bisect_refs().

Here is a short-term fix that can be squashed in, in order to allow t6022
to pass again.

 builtin-rev-list.c |    2 ++
 revision.c         |    1 +
 revision.h         |    1 +
 3 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index 4ba1c12..32bf033 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -319,6 +319,8 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 
 	memset(&info, 0, sizeof(info));
 	info.revs = &revs;
+	if (revs.bisect)
+		bisect_list = 1;
 
 	quiet = DIFF_OPT_TST(&revs.diffopt, QUIET);
 	for (i = 1 ; i < argc; i++) {
diff --git a/revision.c b/revision.c
index 80a0528..a36c0d9 100644
--- a/revision.c
+++ b/revision.c
@@ -1273,6 +1273,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 			if (!strcmp(arg, "--bisect")) {
 				handle_refs(revs, flags, for_each_bad_bisect_ref);
 				handle_refs(revs, flags ^ UNINTERESTING, for_each_good_bisect_ref);
+				revs->bisect = 1;
 				continue;
 			}
 			if (!strcmp(arg, "--tags")) {
diff --git a/revision.h b/revision.h
index b6421a6..921656a 100644
--- a/revision.h
+++ b/revision.h
@@ -63,6 +63,7 @@ struct rev_info {
 			reverse:1,
 			reverse_output_stage:1,
 			cherry_pick:1,
+			bisect:1,
 			first_parent_only:1;
 
 	/* Diff flags */
