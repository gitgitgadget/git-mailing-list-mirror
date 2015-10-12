From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] merge: fix cache_entry use-after-free
Date: Mon, 12 Oct 2015 15:28:07 -0700
Message-ID: <xmqqio6bbu2w.fsf@gitster.mtv.corp.google.com>
References: <1444687413-928-1-git-send-email-dturner@twitter.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Keith McGuigan <kmcguigan@twitter.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Tue Oct 13 00:28:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZllZn-0006WW-Hg
	for gcvg-git-2@plane.gmane.org; Tue, 13 Oct 2015 00:28:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752513AbbJLW2M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2015 18:28:12 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:36681 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752133AbbJLW2L (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2015 18:28:11 -0400
Received: by pacex6 with SMTP id ex6so2902pac.3
        for <git@vger.kernel.org>; Mon, 12 Oct 2015 15:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=pjPNNqzadbM0Om5+QeCA7WMcgpD5ehEe3tk7yZgR6lk=;
        b=oMICFLAwe6uWIL5dbDdldNftghYAJzSFWVxqM2+Eyk5dYABRWToucgG+kW50We3ERW
         J3ORpfs+jqqb33GpYBJJ9Li9nsqFM1BRWACLb3qM7QB64DOYXJfI54wXyDvarfj/hfRk
         SMjdI1KhkN2rM/JT/F0H5U5XN501ZdcZw9sNhcDkfHwUaopOClRuv3WN9UOZ1LoGlZ36
         2oVBPYZfYUyHdNKgRUKN3xWSWkaQgCqfTKaEC9v4TSM2uH/HfqymB9pjIcI7soV8HQn0
         InC7gwRFzeIDowytu9yY/U1Q18fZ8Zr3okoZx1pdRDiI3ZcfCSy6lcjX7j+FbIMSPZ4H
         1UHA==
X-Received: by 10.66.219.227 with SMTP id pr3mr37233009pac.33.1444688890498;
        Mon, 12 Oct 2015 15:28:10 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:495:58e7:6a27:bf4d])
        by smtp.gmail.com with ESMTPSA id xd10sm20343170pab.25.2015.10.12.15.28.09
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 12 Oct 2015 15:28:09 -0700 (PDT)
In-Reply-To: <1444687413-928-1-git-send-email-dturner@twitter.com> (David
	Turner's message of "Mon, 12 Oct 2015 18:03:33 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279469>

David Turner <dturner@twopensource.com> writes:

> From: Keith McGuigan <kmcguigan@twitter.com>
>
> During merges, we would previously free entries that we no longer need
> in the destination index.  But those entries might also be stored in
> the dir_entry cache, and when a later call to add_to_index found them,
> they would be used after being freed.
>
> To prevent this, add a ref count for struct cache_entry.  Whenever
> a cache entry is added to a data structure, the ref count is incremented;
> when it is removed from the data structure, it is decremented.  When
> it hits zero, the cache_entry is freed.
>
> Signed-off-by: Keith McGuigan <kmcguigan@twitter.com>
> ---

I'll forge your "messenger's sign-off" here ;-)

> diff --git a/unpack-trees.c b/unpack-trees.c
> index f932e80..1a0a637 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -606,8 +606,10 @@ static int unpack_nondirectories(int n, unsigned long mask,
>  					o);
>  		for (i = 0; i < n; i++) {
>  			struct cache_entry *ce = src[i + o->merge];
> -			if (ce != o->df_conflict_entry)
> -				free(ce);
> +			if (ce != o->df_conflict_entry) {
> +				drop_ce_ref(ce);
> +				src[i + o->merge] = NULL;
> +			}

This one smelled iffy.  I think it is safe because the caller does
not look at src[] other than src[0] after this function returns, and
this setting to NULL happens only when o->merge is set to 1, so I do
not think this is buggy, but at the same time I do not think setting
to NULL is necessary.

Other than that, looks nice.  Thanks.
