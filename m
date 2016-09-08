Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C8D420705
	for <e@80x24.org>; Thu,  8 Sep 2016 16:42:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965747AbcIHQm1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Sep 2016 12:42:27 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61753 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S965628AbcIHQmX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2016 12:42:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 505CD3C173;
        Thu,  8 Sep 2016 12:42:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hxOR4ZSxDmy/TYNPBYV/U0HueKQ=; b=usWrjV
        rVa6Go3C4QOfJUoCm3R8BdxO+5qBk7J70lcqqG3TJyvuFDNqlnLjjn4qbMrpF6z9
        cZYA1dMP9Lu+7fUpm2dXPsmZozVIKo+lFNfi1r53bzIiym3INBLZxHVu7OCpSryw
        8kX9VRa01c33qK7w3bk/x3WgmraaaTHERp2NI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=TYF39GYrOaO3QdtyeI6jFFtQM601xeSQ
        abyBHq/R1guK1WfwVOllC7VqgXpovu26JA4WaPUM3BVH3dlSlwlJzoz6NXQZd2uS
        5NGqBxAq8isJ23ss69Ulv2PAPHryqdzUmrerZ/roac9V0q7122T+X1DgcSS3xaVu
        QYhIzcEslXk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 48B593C172;
        Thu,  8 Sep 2016 12:42:21 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B9F793C171;
        Thu,  8 Sep 2016 12:42:20 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        spearce@spearce.org, sbeller@google.com, peff@peff.net,
        Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: [PATCH] connect: tighten check for unexpected early hang up (Re: [PATCH v3 2/2] connect: advertized capability is not a ref)
References: <cover.1472836026.git.jonathantanmy@google.com>
        <cover.1473291819.git.jonathantanmy@google.com>
        <4b09bb7a5b7f4eb5fc31df3d98ce7ffc042eb367.1473291819.git.jonathantanmy@google.com>
        <20160908013431.GC25016@google.com>
        <20160908014555.GD25016@google.com>
        <20160908015040.GF25016@google.com>
Date:   Thu, 08 Sep 2016 09:42:18 -0700
In-Reply-To: <20160908015040.GF25016@google.com> (Jonathan Nieder's message of
        "Wed, 7 Sep 2016 18:50:40 -0700")
Message-ID: <xmqqinu6jqc5.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 362DE002-75E3-11E6-B1D0-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> Jonathan Nieder wrote:
>
>> Subject: connect: tighten check for unexpected early hang up
> [...]
>> @@ -131,7 +131,7 @@ struct ref **get_remote_heads(int in, char *src_buf, size_t src_len,
>>  				  PACKET_READ_GENTLE_ON_EOF |
>>  				  PACKET_READ_CHOMP_NEWLINE);
>>  		if (len < 0)
>> -			die_initial_contact(got_at_least_one_head);
>> +			die_initial_contact(first_line);
>
> This should say !first_line.
>
> I'll add tests if the patch seems like a good idea.

I tried to write one-paragraph comment for the die_initial_contact()
function, like so:

    +/*
    + * A remote end that is unwilling to talk to us would not give
    + * any response to us before hanging up.  After seeing some
    + * response, we know the hang-up is unexpected.
    + */
    +static void die_initial_contact(int saw_any_response)

but then I got stuck.

We may know that after seeing any response (not necessarily a ref,
but .have or shallow) the other end is willing to talk to us, but
the reverse is not necessarily true (it may be willing to talk to
us, but the network between us may have prevented it from doing so).
For that reason, the above comment is inappropriate for a function
that takes a bool and gives an "unexpected hung-up" or an
"unreachable, possible ACL or problems" message.

So my second attempt was to comment on the variable that keeps track
of the status of the conversation, which turned out to be better
(attached).

I think I fixed your "oops, the bool needs polarity flip".  A test
may be a good idea, but I am not sure how you plan to produce a
failure after sending some response.

-- >8 --
From: Jonathan Nieder <jrnieder@gmail.com>
Date: Wed, 7 Sep 2016 18:45:55 -0700
Subject: [PATCH] connect: tighten check for unexpected early hang up

A server hanging up immediately to mark access being denied does not
send any .have refs, shallow lines, or anything else before hanging
up.  If the server has sent anything, then the hangup is unexpected.

That is, if the server hangs up after a shallow line but before sending
any refs, then git should tell me so:

	fatal: The remote end hung up upon initial contact

instead of suggesting an access control problem:

	fatal: Could not read from remote repository.
	Please make sure you have the correct access rights
	and the repository exists.

Noticed while examining this code.  This case isn't likely to come up
in practice but tightening the check makes the code easier to read and
manipulate.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 connect.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/connect.c b/connect.c
index c53f3f1..067cf40 100644
--- a/connect.c
+++ b/connect.c
@@ -43,9 +43,9 @@ int check_ref_type(const struct ref *ref, int flags)
 	return check_ref(ref->name, flags);
 }
 
-static void die_initial_contact(int got_at_least_one_head)
+static void die_initial_contact(int unexpected)
 {
-	if (got_at_least_one_head)
+	if (unexpected)
 		die("The remote end hung up upon initial contact");
 	else
 		die("Could not read from remote repository.\n\n"
@@ -115,10 +115,17 @@ struct ref **get_remote_heads(int in, char *src_buf, size_t src_len,
 			      struct sha1_array *shallow_points)
 {
 	struct ref **orig_list = list;
-	int got_at_least_one_head = 0;
+
+	/*
+	 * A hang-up after seeing some response from the other end
+	 * means that it is unexpected, as we know the other end is
+	 * willing to talk to us.  A hang-up before seeing any
+	 * response does not necessarily mean an ACL problem, though.
+	 */
+	int saw_response;
 
 	*list = NULL;
-	for (;;) {
+	for (saw_response = 0; ; saw_response = 1) {
 		struct ref *ref;
 		struct object_id old_oid;
 		char *name;
@@ -131,7 +138,7 @@ struct ref **get_remote_heads(int in, char *src_buf, size_t src_len,
 				  PACKET_READ_GENTLE_ON_EOF |
 				  PACKET_READ_CHOMP_NEWLINE);
 		if (len < 0)
-			die_initial_contact(got_at_least_one_head);
+			die_initial_contact(saw_response);
 
 		if (!len)
 			break;
@@ -171,7 +178,6 @@ struct ref **get_remote_heads(int in, char *src_buf, size_t src_len,
 		oidcpy(&ref->old_oid, &old_oid);
 		*list = ref;
 		list = &ref->next;
-		got_at_least_one_head = 1;
 	}
 
 	annotate_refs_with_symref_info(*orig_list);
-- 
2.10.0-267-g7db2ae3

