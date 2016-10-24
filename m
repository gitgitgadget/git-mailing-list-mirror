Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B85F620193
	for <e@80x24.org>; Mon, 24 Oct 2016 19:53:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S941054AbcJXTxP (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Oct 2016 15:53:15 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57650 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753826AbcJXTxO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Oct 2016 15:53:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4974547359;
        Mon, 24 Oct 2016 15:53:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=cAzTHG4Pi9mG3dMIH7WkxKP29gM=; b=L60edF
        vrwjlQygVBX+LmXaepYd75aU3ePBMpUM++bFEGTSxzvaPzjJKaytAJSnqdwva3RC
        iIH8zk3XQe2/Bz3v77kxa00vKfdi8hAv/DvrEW4HfzXiOFZOrUx+We5Vj9WJC716
        DeWWjhePhGC8giJHChrXztYhcRv8qkYBLVaHE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=dnBroCW1qSC+Q811rDRbwLghQ3O4jCBm
        6wB+1aFwLTORSYAs3m/cEKksz59EBZvRceeDcDvIaKl81H3KRYP6omLU4nq2Cny9
        bktKEXsDOGcCcSuFEAB9OWf3XDn72DeyT23/tbv2/I+5uc9h4VE4lwH7/zOxyy8b
        H3Nt3W30C1A=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 40E9547358;
        Mon, 24 Oct 2016 15:53:13 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AE3B447357;
        Mon, 24 Oct 2016 15:53:12 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Wong <e@80x24.org>
Cc:     larsxschneider@gmail.com, git@vger.kernel.org,
        Johannes.Schindelin@gmx.de, jnareb@gmail.com
Subject: Re: [PATCH v2 2/2] read-cache: make sure file handles are not inherited by child processes
References: <20161024180300.52359-1-larsxschneider@gmail.com>
        <20161024180300.52359-3-larsxschneider@gmail.com>
        <20161024183900.GA12769@starla>
Date:   Mon, 24 Oct 2016 12:53:10 -0700
In-Reply-To: <20161024183900.GA12769@starla> (Eric Wong's message of "Mon, 24
        Oct 2016 18:39:00 +0000")
Message-ID: <xmqqwpgx4j89.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7F0ABED0-9A23-11E6-A435-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Wong <e@80x24.org> writes:

> larsxschneider@gmail.com wrote:
>> +++ b/read-cache.c
>> @@ -156,7 +156,11 @@ void fill_stat_cache_info(struct cache_entry *ce, struct stat *st)
>>  static int ce_compare_data(const struct cache_entry *ce, struct stat *st)
>>  {
>>  	int match = -1;
>> -	int fd = open(ce->name, O_RDONLY);
>> +	int fd = open(ce->name, O_RDONLY | O_CLOEXEC);
>> +
>> +	if (O_CLOEXEC && fd < 0 && errno == EINVAL)
>> +		/* Try again w/o O_CLOEXEC: the kernel might not support it */
>> +		fd = open(ce->name, O_RDONLY);
>
> In the case of O_CLOEXEC != 0 and repeated EINVALs,
> it'd be good to use something like sha1_file_open_flag as in 1/2
> so we don't repeatedly hit EINVAL.  Thanks.

Sounds sane.  

It's just only once, so perhaps we do not mind a recursion like
this?

 read-cache.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index b594865d89..a6978b9321 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -156,11 +156,14 @@ void fill_stat_cache_info(struct cache_entry *ce, struct stat *st)
 static int ce_compare_data(const struct cache_entry *ce, struct stat *st)
 {
 	int match = -1;
-	int fd = open(ce->name, O_RDONLY | O_CLOEXEC);
+	static int cloexec = O_CLOEXEC;
+	int fd = open(ce->name, O_RDONLY | cloexec);
 
-	if (O_CLOEXEC && fd < 0 && errno == EINVAL)
+	if ((cloexec & O_CLOEXEC) && fd < 0 && errno == EINVAL) {
 		/* Try again w/o O_CLOEXEC: the kernel might not support it */
-		fd = open(ce->name, O_RDONLY);
+		cloexec &= ~O_CLOEXEC;
+		return ce_compare_data(ce, st);
+	}
 
 	if (fd >= 0) {
 		unsigned char sha1[20];
