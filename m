From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFCv2 05/16] remote.h: Change get_remote_heads return to void
Date: Tue, 02 Jun 2015 14:17:53 -0700
Message-ID: <xmqqlhg124ji.fsf@gitster.dls.corp.google.com>
References: <1433203338-27493-1-git-send-email-sbeller@google.com>
	<1433203338-27493-6-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, pclouds@gmail.com, peff@peff.net
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Jun 02 23:18:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YztZZ-0000rX-5S
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jun 2015 23:18:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752461AbbFBVSB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2015 17:18:01 -0400
Received: from mail-ie0-f170.google.com ([209.85.223.170]:35482 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751605AbbFBVRz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2015 17:17:55 -0400
Received: by iesa3 with SMTP id a3so143211342ies.2
        for <git@vger.kernel.org>; Tue, 02 Jun 2015 14:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=2kWvQWcmhwK5Dex82VwMflcfEBTUwBCEq3LCFP7GiQs=;
        b=UI/TUxOW4nENSUgxvvhWeXstP9xfmJiY4uuPR8NrxHB9qbmAu0tdCKopFPA3ZH2PhP
         UO6oDWxPuHO7b0Hi4I/tM2dzIgh/DKDAEJ2AWOPG7qNQTkVf5b5j/yySJdLNTNovhvgY
         fhxvlxFq8qP2XBRlRBjzeczhEg0VoeNtGVvUviPzqYbmZhz0e0/uybaK+mPEc72tTgqL
         uDcDO+SZdn1tIV9+jYSg+JiThmb1skuvMjj8hdrVLIsvy/2IfUM8snkQoVb7IfLUXSHA
         YwCP4uGTGe5Fgr/T99mAC5ZyXdljCKzEmUMsDEFdIjE/reJNKrOnb7Qh2TA0kDVclhpk
         Ie4Q==
X-Received: by 10.42.43.199 with SMTP id y7mr36689444ice.12.1433279875035;
        Tue, 02 Jun 2015 14:17:55 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:3140:53f3:e8c0:89b0])
        by mx.google.com with ESMTPSA id fm3sm10837662igb.1.2015.06.02.14.17.54
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 02 Jun 2015 14:17:54 -0700 (PDT)
In-Reply-To: <1433203338-27493-6-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Mon, 1 Jun 2015 17:02:07 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270601>

Stefan Beller <sbeller@google.com> writes:

> No function uses the return value of get_remote_heads, so we don't want
> to confuse readers by it.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---

This is somewhat a sad change, as the returned value is designed to
be useful if caller wants to continue appending to the list.

Now such a caller has to tangle the list (the variable it gave the
function as the fourth argument) itself to find its tail.

Does it really "confuse" readers enough that it hurts to have a
return value?

>  connect.c | 10 ++++------
>  remote.h  |  8 ++++----
>  2 files changed, 8 insertions(+), 10 deletions(-)
>
> diff --git a/connect.c b/connect.c
> index 4295ba1..a2c777e 100644
> --- a/connect.c
> +++ b/connect.c
> @@ -108,10 +108,10 @@ static void annotate_refs_with_symref_info(struct ref *ref)
>  /*
>   * Read all the refs from the other end
>   */
> -struct ref **get_remote_heads(int in, char *src_buf, size_t src_len,
> -			      struct ref **list, unsigned int flags,
> -			      struct sha1_array *extra_have,
> -			      struct sha1_array *shallow_points)
> +void get_remote_heads(int in, char *src_buf, size_t src_len,
> +		      struct ref **list, unsigned int flags,
> +		      struct sha1_array *extra_have,
> +		      struct sha1_array *shallow_points)
>  {
>  	struct ref **orig_list = list;
>  	int got_at_least_one_head = 0;
> @@ -172,8 +172,6 @@ struct ref **get_remote_heads(int in, char *src_buf, size_t src_len,
>  	}
>  
>  	annotate_refs_with_symref_info(*orig_list);
> -
> -	return list;
>  }
>  
>  static const char *parse_feature_value(struct string_list *feature_list, const char *feature, int *lenp)
> diff --git a/remote.h b/remote.h
> index 02d66ce..d5242b0 100644
> --- a/remote.h
> +++ b/remote.h
> @@ -144,10 +144,10 @@ int check_ref_type(const struct ref *ref, int flags);
>  void free_refs(struct ref *ref);
>  
>  struct sha1_array;
> -extern struct ref **get_remote_heads(int in, char *src_buf, size_t src_len,
> -				     struct ref **list, unsigned int flags,
> -				     struct sha1_array *extra_have,
> -				     struct sha1_array *shallow);
> +extern void get_remote_heads(int in, char *src_buf, size_t src_len,
> +			     struct ref **list, unsigned int flags,
> +			     struct sha1_array *extra_have,
> +			     struct sha1_array *shallow);
>  
>  int resolve_remote_symref(struct ref *ref, struct ref *list);
>  int ref_newer(const unsigned char *new_sha1, const unsigned char *old_sha1);
