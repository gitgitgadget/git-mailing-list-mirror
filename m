From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v8 1/4] cache-tree: Create/update cache-tree on checkou
Date: Tue, 02 Sep 2014 14:10:57 -0700
Message-ID: <xmqq8um1zq1q.fsf@gitster.dls.corp.google.com>
References: <1405140276-32162-1-git-send-email-dturner@twitter.com>
	<20140831120703.GA1240@serenity.lan>
	<xmqqfvg9zqw9.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Turner <dturner@twopensource.com>, git@vger.kernel.org,
	David Turner <dturner@twitter.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Tue Sep 02 23:11:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XOvM4-00079D-E3
	for gcvg-git-2@plane.gmane.org; Tue, 02 Sep 2014 23:11:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755266AbaIBVLD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Sep 2014 17:11:03 -0400
Received: from smtp.pobox.com ([208.72.237.35]:57673 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754274AbaIBVLB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2014 17:11:01 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D8CEE379AC;
	Tue,  2 Sep 2014 17:11:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iLPFpOJO1eRloLfraI4l8eUaqTI=; b=ZXaZtf
	hd6zrnV6RBddcBHVpmujuRwihZdvsHHCnBNvm7l6Pp6zO3riu8Z5i9mxPLREzxSV
	B0AKkuIOhys7TdRy1EoSgJ2MI2C5YvRRE8CcVJUY8N8ghrQor56iVwzHMHwP9UtQ
	Pr9eciYt4liazW/8FqeEPQwCzAN9lKOq7pyi0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AeIjbfg+0cuqu9FksoJARQb9Yze7vS6z
	Ay70mx+nDD5jDGS4uDPvgmKdUpVoYBhap7/1jCIOSHAIxcpe1nVBVWr9mqn/b6c0
	hcN3lqXOH8HmmeAD55mvjRQN7YNXJ37wgzAiVS0bQ6+RWMS1CWGXGyNiGb848alF
	2GVABG8UR+Y=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 79935379AB;
	Tue,  2 Sep 2014 17:11:00 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id B61E0379A8;
	Tue,  2 Sep 2014 17:10:58 -0400 (EDT)
In-Reply-To: <xmqqfvg9zqw9.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 02 Sep 2014 13:52:38 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: A2C36770-32E5-11E4-8EDB-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256368>

Junio C Hamano <gitster@pobox.com> writes:

> John Keeping <john@keeping.me.uk> writes:
>
>> On Fri, Jul 11, 2014 at 09:44:33PM -0700, David Turner wrote:
>>> When git checkout checks out a branch, create or update the
>>> cache-tree so that subsequent operations are faster.
>>> 
>>> update_main_cache_tree learned a new flag, WRITE_TREE_REPAIR.  When
>>> WRITE_TREE_REPAIR is set, portions of the cache-tree which do not
>>> correspond to existing tree objects are invalidated (and portions which
>>> do are marked as valid).  No new tree objects are created.
>>> 
>>> Signed-off-by: David Turner <dturner@twitter.com>
>>> ---
>>
>> This causes an incorrect error message to be printed when switching
>> branches with staged changes in a subdirectory.  The test case is pretty
>> simple:
>>
>> 	git init test &&
>> 	cd test &&
>> 	mkdir sub &&
>> 	echo one >sub/one &&
>> 	git add sub/one &&
>> 	git commit -m one &&
>> 	echo two >sub/two &&
>> 	git add sub/two &&
>> 	git checkout -b test
>>
>> After this commit the output is:
>>
>> 	error: invalid object 040000 0000000000000000000000000000000000000000 for 'bar'
>> 	A       bar/quux
>> 	Switched to branch 'test'
>>
>> but the "error:" line should not be there.
>
> Yeah, this seems to be broken and I am unhappy that I didn't notice
> it myself as I always use a version that is somewhat ahead of 'next'
> myself.

Perhaps like this, to make sure that we do not throw a garbage
object name into the cache tree when we avoid creating an unwanted
tree object?

All the tests added by the series seems to pass, so I am assuming
that this will not break the "repair" codepath when it should kick
in.

We may want to add your test to t0090 as well.

 cache-tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cache-tree.c b/cache-tree.c
index f951d7d..e3baf42 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -398,7 +398,7 @@ static int update_one(struct cache_tree *it,
 		it->entry_count, it->subtree_nr,
 		sha1_to_hex(it->sha1));
 #endif
-	return i;
+	return to_invalidate ? -1 : i;
 }
 
 int cache_tree_update(struct cache_tree *it,
