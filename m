Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E9F220372
	for <e@80x24.org>; Thu, 12 Oct 2017 13:20:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753395AbdJLNUW (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Oct 2017 09:20:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41496 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751932AbdJLNUV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Oct 2017 09:20:21 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0B6162D0FCD;
        Thu, 12 Oct 2017 13:20:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mx1.redhat.com 0B6162D0FCD
Authentication-Results: ext-mx05.extmail.prod.ext.phx2.redhat.com; dmarc=none (p=none dis=none) header.from=redhat.com
Authentication-Results: ext-mx05.extmail.prod.ext.phx2.redhat.com; spf=fail smtp.mailfrom=fweimer@redhat.com
Received: from oldenburg.str.redhat.com (dhcp-192-212.str.redhat.com [10.33.192.212])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 61FDE6E717;
        Thu, 12 Oct 2017 13:20:20 +0000 (UTC)
Subject: Re: Is git am supposed to decode MIME?
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
References: <24940e12-3f72-1ef0-0983-58523d8dec51@redhat.com>
 <20171004092546.vnjddxqwvia5cfn6@sigill.intra.peff.net>
From:   Florian Weimer <fweimer@redhat.com>
Message-ID: <39aebcbd-7820-eafe-3c44-b96b057d0059@redhat.com>
Date:   Thu, 12 Oct 2017 15:20:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20171004092546.vnjddxqwvia5cfn6@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Thu, 12 Oct 2017 13:20:21 +0000 (UTC)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/04/2017 11:25 AM, Jeff King wrote:
> On Wed, Oct 04, 2017 at 10:44:31AM +0200, Florian Weimer wrote:
> 
>> The git am documentation talks about “mailboxes”.  I suppose these contain
>> messages in Internet Mail syntax.  Is git am supposed to decode MIME?
>>
>> I'm asking because I have a message whose body is encoded as
>> quoted-printable, but git am does not parse the patch contained in it.
>>
>> If git am is supposed to deal with this, I'll dig deeper and try to figure
>> out where things go wrong.
> 
> Yes, it should. I just double-checked with the toy patch patch below,
> and it correctly extracted the quoted-printable from the commit message
> and patch, as well as in the headers.

It took me a while, but I know think the message is simply corrupted. 
It's encoded with quoted-printable, and that looks correct, but it ends 
with:

@@ -5137,11 +5114,13 @@ __libc_mallopt (int param_number, int value)
    if (__malloc_initialized < 0)
      ptmalloc_init ();
    __libc_lock_lock (av->mutex);
-  /* Ensure initialization/consolidation */
-  malloc_consolidate (av);
=20
    LIBC_PROBE (memory_mallopt, 2, param_number, value);
=20
+  /* We must consolidate main arena before changing max_fast
+     (see definition of set_max_fast).  */
+  malloc_consolidate (av);
+
    switch (param_number)
      {
      case M_MXFAST:=

The “=” masks the final newline, and that doesn't decode into a valid 
diff hunk.  The file being patched continues after that, so it's not 
even the “\ No newline at end of file” case.

So in short, there is no Git bug here, and I just failed to interpret 
the “git am” diagnostics correctly:

Applying: Improve malloc initialization sequence
error: corrupt patch at line 342
Patch failed at 0001 Improve malloc initialization sequence
The copy of the patch that failed is found in: .git/rebase-apply/patch

Line 342 refers to the file in .git/rebase-apply/patch, not the original 
input, and it took me a while to figure that out.

Thanks,
Florian
