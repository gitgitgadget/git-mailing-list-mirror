Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0BD11F461
	for <e@80x24.org>; Thu, 27 Jun 2019 00:47:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727766AbfF0ArF (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Jun 2019 20:47:05 -0400
Received: from resqmta-ch2-02v.sys.comcast.net ([69.252.207.34]:34772 "EHLO
        resqmta-ch2-02v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727150AbfF0ArF (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 26 Jun 2019 20:47:05 -0400
Received: from resomta-ch2-03v.sys.comcast.net ([69.252.207.99])
        by resqmta-ch2-02v.sys.comcast.net with ESMTP
        id gIW8hMkDSXiWhgIZ6hhMWJ; Thu, 27 Jun 2019 00:47:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=20190202a; t=1561596424;
        bh=4o/WoU70yI6mPviG6Y1b//Hcj46OjyC9OTHKkpP8t6E=;
        h=Received:Received:Date:From:To:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=MP8yEMUxaeudBhpknlgCGVsy3ImpR/1UQ4D4jeocjEmYWDnaStxgEODVjw33iMmmM
         ZmVRbly0cwNRFdpP+tqAYeGKYkYkwdZsjn1WV3DjCfsb8l5JIK3uLbfTFuWkylqz/T
         oZhqvOxnFiHr3kz5Jt7p4UQSV5FKB9f36iIU+MPd5R72iMt2uSAohXZozYTUfyg+k6
         W3bLDQw1h/fy1yXxsdXnZc+TJgXHs79S5KVky5oxDYYt0sPKPea88NJuFs6ZwnFQ06
         GnoagkxizyVGII9yk6y7etbFx857OXZhJQT6EbCw0uF2MjhoreSa96knc2bdFqMGdx
         W3aPPpeXpw3hw==
Received: from comcast.net ([IPv6:2620:15c:2ce:200:ac3b:83cd:e5c7:24f4])
        by resomta-ch2-03v.sys.comcast.net with ESMTPSA
        id gIYdhb4ecOoCZgIYvhbpy6; Thu, 27 Jun 2019 00:47:02 +0000
X-Xfinity-VMeta: sc=0;st=legit
Date:   Wed, 26 Jun 2019 17:46:35 -0700
From:   Matthew DeVore <matvore@comcast.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     matvore@google.com, git@vger.kernel.org
Subject: Re: [PATCH v4 01/10] list-objects-filter: make API easier to use
Message-ID: <20190627004635.GA24081@comcast.net>
References: <70568c42ae6d59dacbb36ffb8e4a8828b6595158.1560558910.git.matvore@google.com>
 <20190621225838.226321-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190621225838.226321-1-jonathantanmy@google.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 21, 2019 at 03:58:38PM -0700, Jonathan Tan wrote:
> So what happens is that filter_fn, filter_free_fn, and filter_data are
> encapsulated into one opaque object, and users will now use filter_fn
> and filter_free_fn through other functions that we expose, allowing us
> to add some conveniences that currently have to be repeated at each call
> site.
> 
> I would prefer the following commit message:
> 
>   list-objects-filter: encapsulate filter components
> 
>   Encapsulate filter_fn, filter_free_fn, and filter_data into its own
>   opaque struct.
> 
>   Due to opaqueness, filter_fn and filter_free_fn can no longer be
>   accessed directly by users. Currently, all usages of filter_fn are
>   guarded by a necessary check:
> 
>     (obj->flags & NOT_USER_GIVEN) && filter_fn
> 
>   Take the opportunity to include this check into the new function
>   list_objects_filter__filter_object(), so that we no longer need to
>   write this check at every caller of the filter function.
> 
>   Also, the init functions in list-objects-filter.c no longer need to
>   confusingly return the filter constituents in various places
>   (filter_fn and filter_free_fn as out parameters, and filter_data as
>   the function's return value); they can just initialize the "struct
>   filter" passed in.
> 

Very nice, applied. I think your commit message is much more helpful than mine
and doesn't use the filter combination feature as an excuse for the change.

> > +	/*
> > +	 * No filter is active or user gave object explicitly. Choose default
> > +	 * behavior based on filter situation.
> > +	 */
> 
> This part is when we do not need to apply the filter (or none exists). I
> think the comment will be better if stated more explicitly:
> 
>   No filter is active or user gave object explicitly. In this case,
>   always show the object (except when LOFS_END_TREE, since this tree had
>   already been shown when LOFS_BEGIN_TREE).
> 

Agreed, this is a little better. Applied.
