From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] diff-lib.c: adjust position of i-t-a entries in diff
Date: Tue, 17 Mar 2015 10:57:06 -0700
Message-ID: <xmqq1tknpkwd.fsf@gitster.dls.corp.google.com>
References: <1425910445-27383-2-git-send-email-pclouds@gmail.com>
	<1426514206-30949-1-git-send-email-pclouds@gmail.com>
	<5506F3A9.1020704@drmicha.warpmail.net>
	<xmqqa8zdrkpy.fsf@gitster.dls.corp.google.com>
	<20150317140704.GA7248@lanh>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 17 18:57:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXvk2-0005h4-SL
	for gcvg-git-2@plane.gmane.org; Tue, 17 Mar 2015 18:57:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753453AbbCQR5S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2015 13:57:18 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:64181 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752965AbbCQR5Q (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2015 13:57:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C0FFA3DEF2;
	Tue, 17 Mar 2015 13:57:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zY7UncoefvfEVfxgFVfWA2GSbHY=; b=UZGA02
	1rQe0un0V0NGNTXux/3hjqPVxW+GyqHrKwyovnNg041s3SSu9UIlhBljtFV62Uvw
	AZbxSnCr8zswHYWrKu9VyJ9iRUC+f1vCjFacRT2rYDHGC1pqRX2Oqn12DUI00HQj
	OiK67txJaQwSVAOO7wc+OfwJB0ab4bDKOpAB8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NLoMkBdMekQTBLX5EG9+O3CO8j+anGjr
	4ro/wr13WTvVIvV85B8k4MBSt3hfmoqBRK0Kewh3dxI1lMVehYMyYH0O4zyqGfe1
	BjNwBgbzWqDkvghgYJ+yhwo4MPkJXg/8JUYG8s1jsNlfy+MGz3k27W6JRCyr+Vs/
	TKSwnwDGU98=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AD6123DEF1;
	Tue, 17 Mar 2015 13:57:09 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 27ABD3DEEE;
	Tue, 17 Mar 2015 13:57:09 -0400 (EDT)
In-Reply-To: <20150317140704.GA7248@lanh> (Duy Nguyen's message of "Tue, 17
	Mar 2015 21:07:04 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 07F5B282-CCCF-11E4-8034-A2259F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265648>

Duy Nguyen <pclouds@gmail.com> writes:

> On Mon, Mar 16, 2015 at 09:05:45AM -0700, Junio C Hamano wrote:
>> The offending one came from eec3e7e4 (cache-tree: invalidate i-t-a
>> paths after generating trees, 2012-12-16), which was a fix to an
>> earlier bug where a cache-tree written out of an index with i-t-a
>> entries had incorrect information and still claimed it is fully
>> valid after write-tree rebuilt it.  The test probably should add
>> another path without i-t-a bit, run the same "diff --cached" with
>> updated expectation before write-tre, and run the "diff --cached"
>> again to make sure it produces a result that match the updated
>> expectation.
>
> Would adding another non-i-t-a entry help? Before this patch
> "diff --cached" after write-tree shows the i-t-a entry only when
> eec3e7e4 is applied. But with this patch we don't show i-t-a entry any
> more, before or after write-tree, eec3e7e4 makes no visible difference.
>
> We could even revert eec3e7e4 and the outcome of "diff --cached" would
> be the same because we just sort of move the "invalidation" part from
> cache-tree to do_oneway_diff(). Not invalidating would speed up "diff
> --cached" when i-t-a entries are present. Still it may be a good idea
> to invalidate i-t-a paths to be on the safe side. Perhaps a patch like
> this to resurrect the test?

My unerstanding of what eec3e7e4 (cache-tree: invalidate i-t-a paths
after generating trees, 2012-12-16) fixed was that in this sequence:

    - You prepare an index.

    - You write-tree out of the index, which involves:

      - updating the cache-tree to match the shape of the resulting
        from writing the index out.

      - create tree objects matching all levels of the cache-tree as
        needed on disk.

      - report the top-level tree object name

   - run "diff-index --cached", which can and will take advantage of
     the fact that everything in a subtree below a known-to-be-valid
     cache-tree entry does not have to be checked one-by-one.  If a
     cache-tree says "everything under D/ in the index would hash to
     tree object T" and the HEAD has tree object T at D/, then the
     diff machinery will bypass the entire section in the index
     under D/, which is a valid optimization.

     However, when there is an i-t-a entry, we excluded that entry
     from the tree object computation, its presence did not
     contribute to the tree object name, but still marked the
     cache-tree entries that contain it as valid by mistake.  This
     old bug was what the commit fixed, so an invocation of "diff
     --cached" after a write-tree, even if the index contains an
     i-t-a entry, will not see cache-tree entries that are marked
     valid when they are not.  Instead, "diff --cached" will bypass
     the optimization and makes comparison one-by-one for the index
     entries.

So reverting the fix obviously is not the right thing to do.  If the
tests show different results from two invocations of "diff --cached"
with your patch applied, there is something that is broken by your
patch, because the index and the HEAD does not change across
write-tree in that test.

If on the other hand the tests show the same result from these two
"diff --cached" and the result is different from what the test
expects, that means your patch changed the world order, i.e. an
i-t-a entry used to be treated as if it were adding an empty blob to
the index but it is now treated as non-existent, then that is a good
thing and the only thing we need to update is what the test expects.
I am guessing that instead of expecting dir/bar to be shown, it now
should expect no output?

Does adding an non-i-t-a entry help?  It does not hurt, and it makes
the test uses a non-empty output, making its effect more visible,
which may or may not count as helping.


     
