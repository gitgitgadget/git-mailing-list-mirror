Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,PLING_QUERY,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C242E20969
	for <e@80x24.org>; Fri, 31 Mar 2017 21:16:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933202AbdCaVQc (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Mar 2017 17:16:32 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53367 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753430AbdCaVQc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Mar 2017 17:16:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F030B7EFE1;
        Fri, 31 Mar 2017 17:16:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=IVz8JTKAnqo6S0ounH5fPwl+Cdo=; b=jiBlNb
        b3UU8qoqkOCnfH3BxhGJn6xnDBdomJYK+1bEShjzcj3bkIZ590FdO3+Oy9ii3V/J
        /1ajuH53DOSOgGb6Ft3M48AX5okGzca7l8I/PHXLT/cvnvI95PoVxizL/CnGP9no
        cbl4YLIZNW13YCNEmWgC3rbnzIVQvsEM3sccI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=uqE4tfhEigGE2mEAwnalGgOb2E4zuG52
        E6Oeh820+eCSa95kMlbLo1kyqXX55itQa4bPpg1dvK2WdkfrWGTMwEVNUm61oHuy
        eQuOB/UM+BzCl41ddrwap0OggzMyK0Iuc/mlNGNCz247xx5a7K5kG3cT0M/oy1+F
        8kqRgR97BeY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E85B57EFE0;
        Fri, 31 Mar 2017 17:16:30 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 61AD67EFDF;
        Fri, 31 Mar 2017 17:16:30 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: SHA1 collision in production repo?! (probably not)
References: <4D74C1D4-9EA7-4A17-AFC5-0B54B4A6DD0E@gmail.com>
        <xmqqh929z6wl.fsf@gitster.mtv.corp.google.com>
        <20170331174515.j2ruifuigskyvucc@sigill.intra.peff.net>
Date:   Fri, 31 Mar 2017 14:16:29 -0700
In-Reply-To: <20170331174515.j2ruifuigskyvucc@sigill.intra.peff.net> (Jeff
        King's message of "Fri, 31 Mar 2017 13:45:15 -0400")
Message-ID: <xmqq37dtxi36.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4F2898B2-1657-11E7-9084-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Before we forget...


-- >8 --
From: Jeff King <peff@peff.net>

When sha1_loose_object_info() finds that a loose object file cannot
be stat(2)ed or mmap(2)ed, it returns -1 to signal an error to the
caller.  However, if it found that the loose object file is corrupt
and the object data cannot be used from it, it forgets to return -1.

This can confuse the caller, who may be lead to mistakenly think
that there is a loose object and possibly gets an incorrect type and
size from the function.  The SHA-1 collision detection codepath, for
example, when it gets an object over the wire and tries to see the
data is the same as what is available as a loose object locally, can
get confused when the loose object is correupted due to this bug.

---
 sha1_file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sha1_file.c b/sha1_file.c
index 71063890ff..368c89b5c3 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2952,7 +2952,7 @@ static int sha1_loose_object_info(const unsigned char *sha1,
 	if (status && oi->typep)
 		*oi->typep = status;
 	strbuf_release(&hdrbuf);
-	return 0;
+	return (status < 0) ? status : 0;
 }
 
 int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi, unsigned flags)
