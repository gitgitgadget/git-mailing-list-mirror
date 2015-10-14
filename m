From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] merge: fix cache_entry use-after-free
Date: Wed, 14 Oct 2015 14:17:34 -0700
Message-ID: <xmqqk2qp6tg1.fsf@gitster.mtv.corp.google.com>
References: <1444687413-928-1-git-send-email-dturner@twitter.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Keith McGuigan <kmcguigan@twitter.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Wed Oct 14 23:17:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZmTQa-0007E4-Kc
	for gcvg-git-2@plane.gmane.org; Wed, 14 Oct 2015 23:17:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932305AbbJNVRg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2015 17:17:36 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:34731 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753811AbbJNVRf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2015 17:17:35 -0400
Received: by payp3 with SMTP id p3so16890139pay.1
        for <git@vger.kernel.org>; Wed, 14 Oct 2015 14:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=s2YU45eGExYDWEfqAyZYbP5mWJTCbzlwZ1oNSvNJ2QQ=;
        b=rsJW538vMjZNN6YSQ9PVeXjjeHIpc5Myz1qUlEf3Mf1GI407OgtMaBRY/pSdfe5wsa
         dWGbeT+y2L/SCiEIKwYeyXvLHKwlUsOy9Gmomqtz5MqxWFJbexTqpWnkYQFD0Wd5YdM2
         CssxBeGxsJiOdX+GQWJKtQcJgHaVfMJmmk1hCPZGtpqeAgf6yEROvSKYRXOKg+FPlotB
         nNO70a4FN/Bi7CkWb313h2w9gq3cP0VTQtbpm2lumWGKSfctdNM6HDDDkCtbz1jOPBRm
         ZFodqWKChFb4fenEO7eQ64FKowKDQXWlKkRFDELnnX6vbba8ctmY8Cocn3tj25lERWIz
         vMXw==
X-Received: by 10.68.69.45 with SMTP id b13mr5727815pbu.67.1444857455443;
        Wed, 14 Oct 2015 14:17:35 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:7964:41eb:7b4:cd77])
        by smtp.gmail.com with ESMTPSA id lo9sm11406105pab.19.2015.10.14.14.17.34
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 14 Oct 2015 14:17:34 -0700 (PDT)
In-Reply-To: <1444687413-928-1-git-send-email-dturner@twitter.com> (David
	Turner's message of "Mon, 12 Oct 2015 18:03:33 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279628>

David Turner <dturner@twopensource.com> writes:

> +	unsigned int ref_count; /* count the number of refs to this in dir_hash */

Me makes a mental note of the type used...

> @@ -213,6 +214,32 @@ struct cache_entry {
>  struct pathspec;
>  
>  /*
> + * Increment the cache_entry reference count.  Should be called
> + * whenever a pointer to a cache_entry is retained in a data structure,
> + * thus marking it as alive.
> + */
> +static inline void add_ce_ref(struct cache_entry *ce)
> +{
> +	assert(ce != NULL && ce->ref_count >= 0);

... and notices that ce->ref_count will always be non-negative here


> +	ce->ref_count++;
> +}
> +
> +/*
> + * Decrement the cache_entry reference count.  Should be called whenever
> + * a pointer to a cache_entry is dropped.  Once the counter drops to 0
> + * the cache_entry memory will be safely freed.
> + */
> +static inline void drop_ce_ref(struct cache_entry *ce)
> +{
> +	if (ce != NULL) {
> +		assert(ce->ref_count >= 0);

... and here.

By not checking integer overflow/wraparound, the code is assuming
that a ce entry will never referenced more than 4 billion times on
32-bit platform.  And that is a sensible assumption as there aren't
that many pointers in the address space to make that many reference
anyway.

Perhaps the code can assume the number won't be more than 2 billion
and use a signed type instead for the reference counting?
