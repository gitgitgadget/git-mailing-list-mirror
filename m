From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug: git log --numstat counts wrong
Date: Thu, 22 Sep 2011 10:51:30 -0700
Message-ID: <7vobycxy71.fsf@alter.siamese.dyndns.org>
References: <D3CF0A47-64DA-4EBB-9DCD-D2D714596C50@inf.fu-berlin.de>
 <7vr53a2icn.fsf@alter.siamese.dyndns.org>
 <3BF8BA51-4CAA-40A2-8B45-D39AAEE58E6F@inf.fu-berlin.de>
 <7vobyd1vmo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Tay Ray Chuan <rctay89@gmail.com>
To: Alexander Pepper <pepper@inf.fu-berlin.de>
X-From: git-owner@vger.kernel.org Thu Sep 22 19:51:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R6nQz-0001OO-CY
	for gcvg-git-2@lo.gmane.org; Thu, 22 Sep 2011 19:51:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753013Ab1IVRvg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Sep 2011 13:51:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40105 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751768Ab1IVRvf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Sep 2011 13:51:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B76516E22;
	Thu, 22 Sep 2011 13:51:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=A3ajsqzhAWtXTKj3umHAX3dxgbA=; b=JeGHsa
	jlAuchalhDfaGJHVI8V8Gq40rTDQLWz+4C+WIYhxcD3mFNuwxWJlzntkzJTuL/Ji
	hZnbN7rXYNfJsZlPAfjLRhpfAW1Vr1arj7SlAQkEhKp4l4INdHlm1pmbdr5OE+sZ
	qq6AOITq/l5xPURqbSRDc7A39IYan6JcdwQZU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=I7SV4liRV6Etthm9kEe46n5ZjJykQ6O8
	Jglh0Bxe9umfv7bJB6SQg9fyxbe6Kqmp1kt9vvOX+nthFBU0rJG5/m1vJgynIzj3
	GFRMhumFBcFcp0pDAX4i9lIcaHlCt1hkfj+d3N+wuXOoi7znmZiv2q4fmD/7G6ZF
	mN7+cE8Vm3Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ADB1B6E21;
	Thu, 22 Sep 2011 13:51:33 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1F16B6E20; Thu, 22 Sep 2011
 13:51:32 -0400 (EDT)
In-Reply-To: <7vobyd1vmo.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 21 Sep 2011 13:35:43 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8237E7EE-E543-11E0-927C-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181908>

Junio C Hamano <gitster@pobox.com> writes:

> Alexander Pepper <pepper@inf.fu-berlin.de> writes:
>
>> Am 21.09.2011 um 14:24 schrieb Junio C Hamano:
>>>> $ git log --numstat 48a07e7e533f507228e8d1c99d4d48e175e14260
>>>> [...]
>>>> 11      10      src/java/voldemort/server/storage/StorageService.java
>>> 
>>> Didn't we update it this already? I seem to get 10/9 here not 11/10.
>>
>> Current 'maint' (cd2b8ae9), 'master' (4b5eac7f)...
>
> That's a tad old master you seem to have.
>
> Strangely, bisection points at 27af01d5523, which was supposed to be only
> about performance and never about correctness. There is something fishy
> going on....

In any case, I think the real issue is that depending on how much context
you ask, the resulting diff is different (and both are valid diffs). If
you ask "log -p" (or "diff" or "show") to produce a patch, then we use the
default 3-line context. And then you feed that to an external diffstat to
count the number of deleted and added lines to get one set of numbers.

The --numstat (and --diffstat) code seems to be running the internal diff
machinery with 0-line context and counting the resulting diff internally.

And of course the results between the above two would be different because
diff can match lines differently when given different number of context
lines to include in the result.

So perhaps a good sanity-check for you to try (note: not checking your
sanity, but checking the sanity of the above analysis) would be to do:

  $ git show 48a07e7e53 -- $that_path | diffstat
  $ git show -U0 48a07e7e53 -- $that_path | diffstat
  $ git show --numstat 48a07e7e53 -- $that_path
  $ git show --stat 48a07e7e53 -- $that_path

and see how they compare (make sure to use the same version of git for
these experiments). The first one uses the default 3-lines context, the
second one forces 0-line context, and the last two uses 0-line context
hardwired in the code.

Applying the following patch should make the last two use the default
context or -U$num given from the command line to be consistent with the
codepath where we generate textual patches.

 diff.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/diff.c b/diff.c
index 9038f19..302ef33 100644
--- a/diff.c
+++ b/diff.c
@@ -2251,6 +2251,8 @@ static void builtin_diffstat(const char *name_a, const char *name_b,
 		memset(&xpp, 0, sizeof(xpp));
 		memset(&xecfg, 0, sizeof(xecfg));
 		xpp.flags = o->xdl_opts;
+		xecfg.ctxlen = o->context;
+		xecfg.interhunkctxlen = o->interhunkcontext;
 		xdi_diff_outf(&mf1, &mf2, diffstat_consume, diffstat,
 			      &xpp, &xecfg);
 	}
