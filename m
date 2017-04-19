Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B1271207BC
	for <e@80x24.org>; Wed, 19 Apr 2017 01:23:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758876AbdDSBXy (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Apr 2017 21:23:54 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52193 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1758793AbdDSBXw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2017 21:23:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 27E4C8158C;
        Tue, 18 Apr 2017 21:23:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wOTPq38o0nzXsT6nytQ/NYrcs+I=; b=m9gOZZ
        /65uMus15LYgKOe5HXJUR8SPz/gozoUbw3I2yRvpA/eY5XN8lYB3O3aXXj5gCzIk
        gP5gbYKLNwcx4mSNqt1xSyXbrCsi8etjTypRmws1oFReEWWUdFqQBqO6cBZERGQF
        IywUDISOhdOhbnPx/L1UiR0DGlLRG756XTMPs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fHUd7X6busbwcE7G9bEwQBsFzywIFRpc
        hz8TJ7jFMoHb3ASyQY13ddjHflYPuydHJjEUwOPK50VH001WPRmYT00zvANYO7uX
        Aut0CWiJXxDtnPdjuU73ZuYBR4Y6kDU4rYH8jLBnteB8hv7XrtCA2oWULjDG1yvk
        ifZeiUX0ENw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0C3A68158B;
        Tue, 18 Apr 2017 21:23:51 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5DCDB8158A;
        Tue, 18 Apr 2017 21:23:50 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Peart <peartben@gmail.com>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        benpeart@microsoft.com, christian.couder@gmail.com
Subject: Re: [PATCH v5 4/8] convert: Separate generic structures and variables from the filter specific ones
References: <20170407120354.17736-1-benpeart@microsoft.com>
        <20170407120354.17736-5-benpeart@microsoft.com>
        <48FA4601-0819-4DE2-943A-7A791BA7C583@gmail.com>
        <xmqqmvbfk8va.fsf@gitster.mtv.corp.google.com>
        <48448c2c-378d-0d87-2f99-32095326f323@gmail.com>
Date:   Tue, 18 Apr 2017 18:23:49 -0700
In-Reply-To: <48448c2c-378d-0d87-2f99-32095326f323@gmail.com> (Ben Peart's
        message of "Tue, 18 Apr 2017 12:38:37 -0400")
Message-ID: <xmqqa87ddwbe.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D7EAA06E-249E-11E7-B456-E680B56B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben Peart <peartben@gmail.com> writes:

> On 4/16/2017 11:31 PM, Junio C Hamano wrote:
>> Lars Schneider <larsxschneider@gmail.com> writes:
>>
>>> However, I think it eases code maintainability in the long run if a function is "as pure as
>>> possible" (IOW does rely on global state as less as possible).
>>
>> If the original relied on a global hashmap and this update kept the
>> code like so, I wouldn't mind the end result of this series
>> (i.e. rely on it being global).  But that is not the case.  It is
>> making the code worse by stopping passing the hashmap through the
>> callchain.
>
> ...  Since it was already a global, I didn't feel
> like this made it any worse.

The code before your series can easily lose the globals with the
attached patch, _exactly_ because it is prepared to be reusable by a
new caller that supplies its own hashmap by passing it through the
callchain.  The child-process machinery Lars made for his conversion
thing, which you are trying to split out to make it reusable, can be
used by somebody other than apply_multi_file_filter() if you do not
lose the hashmap; what the new caller needs to do is to supply its
own hashmap so that they do not interact with the set of processes
used by Lars's conversion machinery.

If we want to lose the global _after_ applying this patch 4/8, don't
we have to essentially _undo_ 4/8?  How can it not be seen as making
it worse?


 convert.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/convert.c b/convert.c
index 8d652bf27c..ff831e85b8 100644
--- a/convert.c
+++ b/convert.c
@@ -503,9 +503,6 @@ struct cmd2process {
 	struct child_process process;
 };
 
-static int cmd_process_map_initialized;
-static struct hashmap cmd_process_map;
-
 static int cmd2process_cmp(const struct cmd2process *e1,
 			   const struct cmd2process *e2,
 			   const void *unused)
@@ -682,6 +679,9 @@ static int apply_multi_file_filter(const char *path, const char *src, size_t len
 	struct strbuf filter_status = STRBUF_INIT;
 	const char *filter_type;
 
+static int cmd_process_map_initialized;
+static struct hashmap cmd_process_map;
+
 	if (!cmd_process_map_initialized) {
 		cmd_process_map_initialized = 1;
 		hashmap_init(&cmd_process_map, (hashmap_cmp_fn) cmd2process_cmp, 0);

