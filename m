Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92BDD2036B
	for <e@80x24.org>; Fri,  6 Oct 2017 07:26:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750970AbdJFH0G (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Oct 2017 03:26:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59760 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750714AbdJFH0F (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2017 03:26:05 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3DA4A285C1;
        Fri,  6 Oct 2017 07:26:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mx1.redhat.com 3DA4A285C1
Authentication-Results: ext-mx06.extmail.prod.ext.phx2.redhat.com; dmarc=none (p=none dis=none) header.from=redhat.com
Authentication-Results: ext-mx06.extmail.prod.ext.phx2.redhat.com; spf=fail smtp.mailfrom=pbonzini@redhat.com
Received: from [10.36.117.66] (ovpn-117-66.ams2.redhat.com [10.36.117.66])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CDC4562508;
        Fri,  6 Oct 2017 07:26:03 +0000 (UTC)
Subject: Re: [RFC PATCH 0/4] interpret-trailers: introduce "move" action
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <20171005132243.27058-1-pbonzini@redhat.com>
 <xmqq8tgowzaa.fsf@gitster.mtv.corp.google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6ba01966-682a-6515-b1c2-3048da6158e0@redhat.com>
Date:   Fri, 6 Oct 2017 09:26:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <xmqq8tgowzaa.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Fri, 06 Oct 2017 07:26:05 +0000 (UTC)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/10/2017 08:44, Junio C Hamano wrote:
> Paolo Bonzini <pbonzini@redhat.com> writes:
>> The purpose of this action is for scripts to be able to keep the
>> user's Signed-off-by at the end.
>>
>>     #! /bin/sh
>>     me=$(git var GIT_COMMITTER_IDENT | sed 's,>.*,>,')
>>     them=$(git log -i -1 --pretty='format:%an <%ae>' --author="$*")
>>     trailer="Reviewed-by: $them"
>>     sob="Signed-off-by: $me"
>>     git log -1 --pretty=format:%B | \
>>       git interpret-trailers --where end --if-exists doNothing --trailer "$trailer" \
>>                              --where end --if-exists move --if-missing doNothing --trailer "$sob" | \
>>       git commit --amend -F-
>>
>> which lets me keep the SoB line at the end, as it should be.
>> Posting as RFC because it's possible that I'm missing a simpler
>> way to achieve this...
>
> If anything, the above (assuming that you wrote a patch, sent out
> for a review with or without signing it off, and then after getting
> a review, you are adding reviewed-by to the commit) does not
> demonstrate the need for "move".  The use of "move" in the example
> looks like a mere workaround that reviewed-by was added at the wrong
> place (i.e. --where end) in the first place.

Yes, I agree.  Though I also tried implementing "--where beforeLastSOB", 
and in the end decided against it because there were more corner cases.
I include the patch for reference at the end of this message, to be
applied on top of these four.

> But that is not the primary reason why I find the example using
> S-o-b convincing.  If the patch in your example originally did not
> have just one S-o-b by you, but yours was at the end of the chain of
> patch passing, use of "move" may become even more problematic.  Your
> friend may write an original, sign it off and pass it to you, who
> then signs it off and sends to the mailng list.  It gets picked up
> by somebody else, who tweaks and adds her sign off, then you pick it
> up and relay it to the final destination (i.e. the first sign-off is
> by your friend, then you have two sign-offs of yours, one sign off
> from somebody else in between, and the chain records how the patch
> "flowed").  And then Linus says "yeah, this is good, I throughly
> reviewed it."  Where would you place that reviewed-by?  Before your
> second (and last) sign-off?  What makes that last one special?

So:

   Signed-off-by: Me
   Signed-off-by: Friend
   Signed-off-by: Me       <<<
   Reviewed-by: Linus
   Signed-off-by: Me

I do think the SoB line marked with "<<<" is a bit "special".  SoB lines 
before it represent the path followed by the contribution, according to 
clause (c) of the Developer Certificate of Origin.  Multiple 
*consecutive* SoB lines from the same person do not add much, while 
multiple separate SoB lines from the same person must be kept.

Of course, using "--where start" for Reviewed/Tested/Acked-by lines *is* 
an option.  On the other hand, for "Cc: stable@vger.kernel.org" the 
placement hints at *who* decided the patch to be worth of inclusion in a 
stable version.  That person might be the right one to bug if the patch 
doesn't apply and needs a manual backport.  It's not science of course, 
but in practice I found the "always apply with -s, and use 'move' to 
keep my SoB at the end" workflow to be the least error-prone.

> Would it more faithfully reflect the order of events if you added
> Linus's reviewed-by and then your own sign-off to conclude the
> chain?

Possibly, but the DCO doesn't care and SoB lines are first and firemost 
about the DCO.

On the other hand, "move" does not provide exactly what we want in the 
case where the user's SoB is there, but is not the last.  So, the above 
script pretty much assumes that you apply the patch with "-s"; if you 
didn't, you'd need something more like "moveLast".  It is trivial to 
implement "moveLast" on top of the first three patches in this series, 
but things start getting a bit out of hand perhaps...

Paolo

> So I am not opposed to the idea of "move", but I am not sure in what
> situation it is useful and what use case it makes it easier to use.
> The example makes me suspect that what we want is not a new
> operation, but a way to specify "where" in a richer way.

----------- 8< ------------
From a238b973821586eaaf26d608172cdc72f19d6071 Mon Sep 17 00:00:00 2001
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 12 Jul 2017 18:11:44 +0200
Subject: [PATCH] trailer: add "beforeLastSOB" configuration for trailer.where

In some cases, people apply patches to a queue branch immediately
with "git am -3 -s", and later collect Reviewed-by or Acked-by
trailers as they come in from the mailing list.

In this case, "where=after" does not have the desired behavior,
because it will add the trailer in an unorthodox position, after the
committer's Signed-off-by line.  Introduce a "beforeLastSOB" value
for trailer.where; this of course makes the most sense if the
last Signed-off-by is from the committer itself.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Documentation/git-interpret-trailers.txt |  4 ++
 t/t7513-interpret-trailers.sh            | 86 +++++++++++++++++++++++++++++++-
 trailer.c                                | 41 ++++++++++++++-
 trailer.h                                |  3 +-
 4 files changed, 130 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
index 1cdde492c..e012f11c1 100644
--- a/Documentation/git-interpret-trailers.txt
+++ b/Documentation/git-interpret-trailers.txt
@@ -158,6 +158,10 @@ last trailer with the same <token>.
 +
 If it is `before`, then each new trailer will appear just before the
 first trailer with the same <token>.
++
+If it is `beforeLastSOB`, then each new trailer will appear just
+before the last Signed-off-by line.  If there is no such line, the
+trailer will appear at the end of the existing trailers.
 
 trailer.ifexists::
 	This option makes it possible to choose what action will be
diff --git a/t/t7513-interpret-trailers.sh b/t/t7513-interpret-trailers.sh
index a0f21fefd..06d6226cd 100755
--- a/t/t7513-interpret-trailers.sh
+++ b/t/t7513-interpret-trailers.sh
@@ -727,6 +727,25 @@ test_expect_success 'using "where = after"' '
 	test_cmp expected actual
 '
 
+test_expect_success 'using "where = beforeLastSOB"' '
+	git config trailer.review.key "Reviewed-by" &&
+	git config trailer.review.where "beforeLastSOB" &&
+	cat complex_message_body >expected &&
+	sed -e "s/ Z\$/ /" >>expected <<-\EOF &&
+		Fixes: Z
+		Acked-by= Z
+		Reviewed-by: Z
+		Signed-off-by: Z
+		Reviewed-by: Johannes
+		Signed-off-by: Junio
+	EOF
+	git interpret-trailers --trailer "Signed-off-by: Junio" \
+		--trailer "Reviewed-by: Johannes" \
+		complex_message >actual &&
+	git config trailer.ack.where "after" &&
+	test_cmp expected actual
+'
+
 test_expect_success 'using "where = end"' '
 	git config trailer.review.key "Reviewed-by" &&
 	git config trailer.review.where "end" &&
@@ -833,6 +852,26 @@ test_expect_success 'default "ifExists" is now "addIfDifferent"' '
 	test_cmp expected actual
 '
 
+test_expect_success 'using "ifExists = addIfDifferent" with "where = beforeLastSOB"' '
+	git config trailer.ack.ifExists "addIfDifferent" &&
+	git config trailer.ack.where "beforeLastSOB" &&
+	cat complex_message_body >expected &&
+	sed -e "s/ Z\$/ /" >>expected <<-\EOF &&
+		Fixes: Z
+		Acked-by= Z
+		Reviewed-by:
+		Signed-off-by: Z
+		Acked-by= Johannes
+		Acked-by= Peff
+		Signed-off-by: Junio
+	EOF
+	git interpret-trailers --trailer "Signed-off-by: Junio" \
+		--trailer "ack: Johannes" --trailer "ack: Johannes" \
+		--trailer "ack: Peff" --trailer "ack: Johannes" \
+		complex_message >actual &&
+	test_cmp expected actual
+'
+
 test_expect_success 'using "ifExists = addIfDifferent" with "where = end"' '
 	git config trailer.ack.ifExists "addIfDifferent" &&
 	git config trailer.ack.where "end" &&
@@ -892,6 +931,27 @@ test_expect_success 'using "ifExists = addIfDifferentNeighbor" with "where = end
 	test_cmp expected actual
 '
 
+test_expect_success 'using "ifExists = addIfDifferentNeighbor" with "where = beforeLastSOB"' '
+	git config trailer.ack.ifExists "addIfDifferentNeighbor" &&
+	git config trailer.ack.where "beforeLastSOB" &&
+	cat complex_message_body >expected &&
+	sed -e "s/ Z\$/ /" >>expected <<-\EOF &&
+		Fixes: Z
+		Acked-by= Z
+		Reviewed-by:
+		Signed-off-by: Z
+		Acked-by= Johannes
+		Acked-by= Peff
+		Acked-by= Johannes
+		Signed-off-by: Junio
+	EOF
+	git interpret-trailers --trailer "Signed-off-by: Junio" \
+		--trailer "ack: Johannes" --trailer "ack: Johannes" \
+		--trailer "ack: Peff" --trailer "ack: Johannes" \
+		complex_message >actual &&
+	test_cmp expected actual
+'
+
 test_expect_success 'using "ifExists = addIfDifferentNeighbor"  with "where = after"' '
 	git config trailer.ack.ifExists "addIfDifferentNeighbor" &&
 	git config trailer.ack.where "after" &&
@@ -1211,6 +1271,30 @@ test_expect_success 'using "ifMissing = doNothing"' '
 	test_cmp expected actual
 '
 
+test_expect_success 'using "where = beforeLastSOB" to add Signed-off-by' '
+	git config trailer.sign.key "Signed-off-by: " &&
+	git config trailer.sign.ifExists "addIfDifferentNeighbor" &&
+	git config trailer.sign.where "beforeLastSOB" &&
+	cat complex_message_body >expected &&
+	sed -e "s/ Z\$/ /" >>expected <<-\EOF &&
+		Fixes: Z
+		Acked-by= Z
+		Reviewed-by:
+		Signed-off-by: Junio
+		Signed-off-by: Johannes
+		Signed-off-by: Another
+		Signed-off-by: Junio
+		Signed-off-by: Z
+	EOF
+	git interpret-trailers --trailer "Signed-off-by: Junio" |
+	git interpret-trailers --trailer "Signed-off-by: Junio" \
+		--trailer "Signed-off-by: Johannes" \
+		--trailer "Signed-off-by: Another" \
+		--trailer "Signed-off-by: Junio" \
+		complex_message >actual &&
+	test_cmp expected actual
+'
+
 test_expect_success 'default "where" is now "after"' '
 	git config trailer.where "after" &&
 	git config --unset trailer.ack.where &&
@@ -1237,9 +1321,7 @@ test_expect_success 'default "where" is now "after"' '
 '
 
 test_expect_success 'with simple command' '
-	git config trailer.sign.key "Signed-off-by: " &&
 	git config trailer.sign.where "after" &&
-	git config trailer.sign.ifExists "addIfDifferentNeighbor" &&
 	git config trailer.sign.command "echo \"A U Thor <author@example.com>\"" &&
 	cat complex_message_body >expected &&
 	sed -e "s/ Z\$/ /" >>expected <<-\EOF &&
diff --git a/trailer.c b/trailer.c
index 4915bda8f..c1ab69e58 100644
--- a/trailer.c
+++ b/trailer.c
@@ -60,7 +60,12 @@ static const char *git_generated_prefixes[] = {
 
 static int scan_backwards(enum trailer_where where)
 {
-	return (where == WHERE_AFTER) || (where == WHERE_END);
+	/*
+	 * beforeLastSOB is almost like "end", only the placement of the new
+	 * trailer varies.
+	 */
+	return (where == WHERE_AFTER) || (where == WHERE_END) ||
+		(where == WHERE_BEFORE_LAST_SOB);
 }
 
 /*
@@ -100,6 +105,24 @@ static int same_trailer(struct trailer_item *a, struct arg_item *b)
 	return same_token(a, b) && same_value(a, b);
 }
 
+static int is_sob(struct trailer_item *in_tok)
+{
+	return !strncasecmp(in_tok->token, "Signed-off-by", 13);
+}
+
+static struct list_head *find_last_sob(struct list_head *head)
+{
+	struct list_head *pos;
+	struct trailer_item *in_tok;
+
+	list_for_each_prev(pos, head) {
+		in_tok = list_entry(pos, struct trailer_item, list);
+		if (is_sob(in_tok))
+			return pos;
+	}
+	return head;
+}
+
 static inline int is_blank_line(const char *str)
 {
 	const char *s = str;
@@ -297,6 +320,20 @@ static int apply_arg(struct trailer_item *in_tok,
 		add_after = 1;
 		place = head;
 		neighbor = NULL;
+	} else if (where == WHERE_BEFORE_LAST_SOB) {
+		add_after = 0;
+		place = find_last_sob(head);
+
+		/*
+		 * Trying to compare two trailers of the same kind provides the
+		 * most sensible results for addIfDifferentNeighbor (see testsuite).
+		 * So when *not* adding a SOB, beforeLastSOB compares to the element
+		 * before.
+		 */
+		if (strcasecmp(arg_tok->token, "Signed-off-by"))
+			neighbor = list_entry(place->prev, struct trailer_item, list);
+		else
+			neighbor = in_tok;
 	} else if (middle) {
 		add_after = (where == WHERE_AFTER);
 		place = &in_tok->list;
@@ -420,6 +457,8 @@ int trailer_set_where(enum trailer_where *item, const char *value)
 		*item = WHERE_END;
 	else if (!strcasecmp("start", value))
 		*item = WHERE_START;
+	else if (!strcasecmp("beforeLastSOB", value))
+		*item = WHERE_BEFORE_LAST_SOB;
 	else
 		return -1;
 	return 0;
diff --git a/trailer.h b/trailer.h
index 0fbdab38d..e30f59e47 100644
--- a/trailer.h
+++ b/trailer.h
@@ -8,7 +8,8 @@ enum trailer_where {
 	WHERE_END,
 	WHERE_AFTER,
 	WHERE_BEFORE,
-	WHERE_START
+	WHERE_START,
+	WHERE_BEFORE_LAST_SOB
 };
 enum trailer_if_exists {
 	EXISTS_DEFAULT,
-- 
2.14.2
