From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] reset: support "--mixed --intent-to-add" mode
Date: Wed, 05 Feb 2014 10:25:33 -0800
Message-ID: <xmqqbnyl5sde.fsf@gitster.dls.corp.google.com>
References: <CACsJy8BXGZ+1Oqrpcky5JPCtZRwvxmxhXGfuEqY9Ct4Pt8FmJg@mail.gmail.com>
	<1391480409-25727-1-git-send-email-pclouds@gmail.com>
	<1391480409-25727-2-git-send-email-pclouds@gmail.com>
	<xmqqvbwu8zjx.fsf@gitster.dls.corp.google.com>
	<xmqqeh3i7bxm.fsf@gitster.dls.corp.google.com>
	<20140205002725.GA3858@lanh>
	<xmqqob2l5vl2.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 05 19:25:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WB7AP-0000a3-7Y
	for gcvg-git-2@plane.gmane.org; Wed, 05 Feb 2014 19:25:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753453AbaBESZl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Feb 2014 13:25:41 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45889 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753208AbaBESZk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Feb 2014 13:25:40 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 48BEC675C1;
	Wed,  5 Feb 2014 13:25:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=j7fa8LyYKxyB0VISkPa5Od9IL9I=; b=cO9rUE
	L6rYoDl0N/EzmcZ6uY3EsPXyu6OLIX+kyYYMvfyJq0rpjNRVAf9CHqw4elA0UdNk
	UhBofe7euQ1na5TEIerHSg/zKB9S92wF/wn3tfK2u1F6PykeAII8UMI7UaSDz4vx
	oDjf/zdJaWKEFa4zVPq54J2ezYn04b6N61IzY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=T7TYK79+PgQeH42PAspDY9XUyfM1wNXT
	cR+KiL07sXBeOwz01043+en16qGeDVLsm6NBWA49rRTxEVd3r659vvjrKCrFgTDi
	dNdiSqjBziLNvPojd63rG+PiA8Qc4dnHpqj210dSq9BLiaxPqSXDqe8IQp/4uoLQ
	6xMpgRzB7kg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DAAC7675BC;
	Wed,  5 Feb 2014 13:25:38 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 66F4E675BB;
	Wed,  5 Feb 2014 13:25:36 -0500 (EST)
In-Reply-To: <xmqqob2l5vl2.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 05 Feb 2014 09:16:09 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: E842E2F0-8E92-11E3-808C-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241633>

Junio C Hamano <gitster@pobox.com> writes:

> Duy Nguyen <pclouds@gmail.com> writes:
>
>> On Tue, Feb 04, 2014 at 02:25:25PM -0800, Junio C Hamano wrote:
>>> Junio C Hamano <gitster@pobox.com> writes:
>>> 
>>> > While I do not have any problem with adding an optional "keep lost
>>> > paths as intent-to-add entries" feature, I am not sure why this has
>>> > to be so different from the usual add-cache-entry codepath.  The
>>> > if/elseif chain you are touching inside this loop does:
>>> >
>>> >  - If the tree you are resetting to has something at the path
>>> >    (which is different from the current index, obviously), create
>>> >    a cache entry to represent that state from the tree and stuff
>>> >    it in the index;
>>> >
>>> >  - Otherwise, the tree you are resetting to does not have that
>>> >    path.  We used to say "remove it from the index", but now we have
>>> >    an option to instead add it as an intent-to-add entry.
>>> >
>>> > So, why doesn't the new codepath do exactly the same thing as the
>>> > first branch of the if/else chain and call add_cache_entry but with
>>> > a ce marked with CE_INTENT_TO_ADD?  That would parallel what happens
>>> > in "git add -N" better, I would think, no?
>>> 
>>> In other words, something along this line, perhaps?
>>
>> <snip>
>>
>> Yes. But you need something like this on top to actually set
>> CE_INTENT_TO_ADD
>
> Yes, indeed.  I wonder why your new test did not notice it, though
> ;-)

... and the answer turns out to be that it was not testing the right
thing.  On top of that faulty version, this will fix it.

Your suggestion to move CE_INTENT_TO_ADD to mark-intent-to-add makes
sense but a caller needs to be adjusted to drop the duplicated flag
manipulation.

 read-cache.c     | 3 +--
 t/t7102-reset.sh | 6 ++++++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 325d193..5b8102a 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -584,6 +584,7 @@ void mark_intent_to_add(struct cache_entry *ce)
 	unsigned char sha1[20];
 	if (write_sha1_file("", 0, blob_type, sha1))
 		die("cannot create an empty blob in the object database");
+	ce->ce_flags |= CE_INTENT_TO_ADD;
 	hashcpy(ce->sha1, sha1);
 }
 
@@ -613,8 +614,6 @@ int add_to_index(struct index_state *istate, const char *path, struct stat *st,
 	ce->ce_namelen = namelen;
 	if (!intent_only)
 		fill_stat_cache_info(ce, st);
-	else
-		ce->ce_flags |= CE_INTENT_TO_ADD;
 
 	if (trust_executable_bit && has_symlinks)
 		ce->ce_mode = create_ce_mode(st_mode);
diff --git a/t/t7102-reset.sh b/t/t7102-reset.sh
index 642920a..bc0846f 100755
--- a/t/t7102-reset.sh
+++ b/t/t7102-reset.sh
@@ -539,6 +539,12 @@ test_expect_success 'reset -N keeps removed files as intent-to-add' '
 	echo new-file >new-file &&
 	git add new-file &&
 	git reset -N HEAD &&
+
+	tree=$(git write-tree) &&
+	git ls-tree $tree new-file >actual &&
+	>expect &&
+	test_cmp expect actual &&
+
 	git diff --name-only >actual &&
 	echo new-file >expect &&
 	test_cmp expect actual
