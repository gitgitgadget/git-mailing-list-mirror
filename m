Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70F22C433FE
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 08:16:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55D3B615E0
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 08:16:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349068AbhI3ISI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Sep 2021 04:18:08 -0400
Received: from cloud.peff.net ([104.130.231.41]:58166 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349087AbhI3ISG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Sep 2021 04:18:06 -0400
Received: (qmail 22697 invoked by uid 109); 30 Sep 2021 08:16:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 30 Sep 2021 08:16:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24579 invoked by uid 111); 30 Sep 2021 08:16:19 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 30 Sep 2021 04:16:19 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 30 Sep 2021 04:16:18 -0400
From:   Jeff King <peff@peff.net>
To:     Neeraj Singh <nksingh85@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: What's cooking in git.git (Sep 2021, #08; Mon, 27)
Message-ID: <YVVyUkwYNfkEqNfU@coredump.intra.peff.net>
References: <xmqq8rzhmsi7.fsf@gitster.g>
 <CABPp-BGuzd_TH57-1RvwJQD5r3S3ZkJcuiPnU8aWee8pgzUBEw@mail.gmail.com>
 <YVOn3hDsb5pnxR53@coredump.intra.peff.net>
 <20210929184339.GA19712@neerajsi-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210929184339.GA19712@neerajsi-x1.localdomain>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 29, 2021 at 11:43:39AM -0700, Neeraj Singh wrote:

> It seems to me that one problem is that the new "primary" objdir code doesn't
> disable ref updates since the GIT_QUARANTINE_ENVIRONMENT setting isn't set.
> If we fix that we should be forbidding ref updates.
> 
> I've included a path that fixes my test case. This is on top of:
> https://lore.kernel.org/git/CANQDOddqwVtWfC4eEP3fJB4sUiszGX8bLqoEVLcMf=v+jzx19g@mail.gmail.com/

Ah, right, I forgot we had that "forbid ref updates in quarantine" magic
(despite being the one who added it).

I do think this improves the safety, but things are still a bit more
dangerous because we're handling it all in a single process, which sees
both the quarantine and non-quarantine states. I wrote more details in
this reply a few minutes ago:

  https://lore.kernel.org/git/YVVmssXlaFM6yD5W@coredump.intra.peff.net/

(sorry, it's long; search for the paragraph starting with "Whereas doing
it in-process").

> When creating a subprocess with a temporary ODB, we set the
> GIT_QUARANTINE_ENVIRONMENT env var to tell child Git processes not
> to update refs, since the tmp-objdir may go away.
> 
> Introduce a similar mechanism for in-process temporary ODBs when
> we call tmp_objdir_replace_primary_odb.
> 
> Peff's test case was invoking ref updates via the cachetextconv
> setting. That particular code silently does nothing when a ref
> update is forbidden

Oh good. I was worried that it would generate ugly errors, rather than
silently skipping the update.

> @@ -2126,7 +2146,7 @@ int ref_transaction_prepare(struct ref_transaction *transaction,
>  		break;
>  	}
>  
> -	if (getenv(GIT_QUARANTINE_ENVIRONMENT)) {
> +	if (getenv(GIT_QUARANTINE_ENVIRONMENT) || !ref_updates_are_enabled()) {
>  		strbuf_addstr(err,
>  			      _("ref updates forbidden inside quarantine environment"));
>  		return -1;

I think the overall goal of this patch makes sense, but this
conditional, along with tmp-objdir reaching out to the refs code, feels
funny. Should we perhaps have a single:

  int tmp_objdir_is_primary(struct repository *r)
  {
	if (the_tmp_objdir &&
	    !strcmp(the_tmp_objdir->path.buf, r->objects->odb->path))
		return 1; /* our temporary is the primary */

	if (getenv(GIT_QUARANTINE_PATH))
		return 1; /* our caller put us in quarantine */

	return 0;
  }

Then it's all nicely abstracted and the ref code does not have to know
the details of GIT_QUARANTINE_PATH in the first place.

If you do got that route, the strcmp() might need to be a little more
careful about whether r->objects can be NULL (I didn't check).
Alternatively, I kind of wonder if "struct object_directory" should just
have a flag that says "is_temporary".

-Peff
