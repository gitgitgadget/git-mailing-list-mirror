From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 06/12] prune_remote(): use delete_refs()
Date: Mon, 15 Jun 2015 11:35:28 -0700
Message-ID: <xmqq381sakgf.fsf@gitster.dls.corp.google.com>
References: <cover.1434206062.git.mhagger@alum.mit.edu>
	<aab9d191609b34fbfee0b68883a5b14fba2421ad.1434206062.git.mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Jun 15 20:35:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4ZEN-0006sb-K0
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jun 2015 20:35:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755928AbbFOSfc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jun 2015 14:35:32 -0400
Received: from mail-ig0-f176.google.com ([209.85.213.176]:34825 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755843AbbFOSfa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jun 2015 14:35:30 -0400
Received: by igbzc4 with SMTP id zc4so61376123igb.0
        for <git@vger.kernel.org>; Mon, 15 Jun 2015 11:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=hqs+8khqwcQQ6naxDhtDYnf2IewJs3DT33JOGcqmz/c=;
        b=Pju975ekaqNf6/JYF6Xo2/8+0i3Cua8Leu7Srftb4l7xUvtKPC7/hIgK7BImtLz9IT
         wiJEC6kKtIB94VCa6Tx/dRdviW10bZUtqvpBqCUpEBZEIoQaqqmnD5RMXxt40RYPLVOr
         jowFbbCIpn0FPVNrm4xlkqEx2+gf4j/0+kPh+BB5BBdg9EoGoyK+RktLpNJwlXmloaQN
         2Cd2IMICZgHT49MTarisWWmoCu0nNJiPVu2DpAbdFhPi4q4/C3dFWvMeNDTL4f+tVovl
         iXOocnbk2M890oLGnxWD562b9TR/pwZXKxgvA1x6G+6EljO+v001xBykF5UV2PnT5Xse
         0PCA==
X-Received: by 10.107.128.227 with SMTP id k96mr12314083ioi.7.1434393329939;
        Mon, 15 Jun 2015 11:35:29 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:16f:c4ab:c37f:75f8])
        by mx.google.com with ESMTPSA id 9sm9384871iok.20.2015.06.15.11.35.29
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 15 Jun 2015 11:35:29 -0700 (PDT)
In-Reply-To: <aab9d191609b34fbfee0b68883a5b14fba2421ad.1434206062.git.mhagger@alum.mit.edu>
	(Michael Haggerty's message of "Sat, 13 Jun 2015 16:42:09 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271702>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> This will result in errors being emitted for references that can't be
> deleted, but that is a good thing.
>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  builtin/remote.c | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)
>
> diff --git a/builtin/remote.c b/builtin/remote.c
> index c8dc724..cc3c741 100644
> --- a/builtin/remote.c
> +++ b/builtin/remote.c
> @@ -1314,19 +1314,12 @@ static int prune_remote(const char *remote, int dry_run)
>  		string_list_append(&refs_to_prune, item->util);
>  	string_list_sort(&refs_to_prune);
>  
> -	if (!dry_run) {
> -		struct strbuf err = STRBUF_INIT;
> -		if (repack_without_refs(&refs_to_prune, &err))
> -			result |= error("%s", err.buf);
> -		strbuf_release(&err);
> -	}
> +	if (!dry_run)
> +		result |= delete_refs(&refs_to_prune);
>  
>  	for_each_string_list_item(item, &states.stale) {
>  		const char *refname = item->util;
>  
> -		if (!dry_run)
> -			result |= delete_ref(refname, NULL, 0);
> -
>  		if (dry_run)
>  			printf_ln(_(" * [would prune] %s"),
>  			       abbrev_ref(refname, "refs/remotes/"));

The resulting code reads better by making the for-each-string-list-item
loop only about reporting and not actually doing anything.

But the log message puzzles me.  Didn't refs that cannot be deleted
cause the original to fail?  After repacking without these refs, it
called delete-ref, and a failure to delete or commit the deletion
would have hit the error() down there, no?
