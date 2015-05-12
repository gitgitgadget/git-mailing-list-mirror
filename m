From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] upload-pack: Prepare to extend allow-tip-sha1-in-want
Date: Tue, 12 May 2015 14:39:01 -0700
Message-ID: <xmqqmw19earu.fsf@gitster.dls.corp.google.com>
References: <xmqqy4l1sblq.fsf@gitster.dls.corp.google.com>
	<1431465265-18486-1-git-send-email-fredrik.medley@gmail.com>
	<1431465265-18486-2-git-send-email-fredrik.medley@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Christian Halstrick <christian.halstrick@gmail.com>,
	Dan Johnson <computerdruid@gmail.com>,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>
To: Fredrik Medley <fredrik.medley@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 12 23:39:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsHtg-00056V-CN
	for gcvg-git-2@plane.gmane.org; Tue, 12 May 2015 23:39:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754182AbbELVjM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2015 17:39:12 -0400
Received: from mail-ig0-f171.google.com ([209.85.213.171]:36742 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754169AbbELVjD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2015 17:39:03 -0400
Received: by igbpi8 with SMTP id pi8so121686629igb.1
        for <git@vger.kernel.org>; Tue, 12 May 2015 14:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=SbYnoN2yPPm8iTcFtIeZaiHFxliAOEjNmGavkzvUqFM=;
        b=mUfUVvf9yzH9VhF/nQ61mhHBs9Ni+5LWUf3z+QDjd9Fove7KxwQGtANrZqpZj9kG6j
         CNsSLM1EAOQZWi1TFqcGTcRHtVvA29E00s4qVXRQLfseBjGkScmHFMlPp5SxQ/5rVXKi
         c+w+PqesR3cuu42kigJ6tFtySzMGpiz14Nq/VZhPLNmDumcwhoHD/2dfY/AkxsCDMn0/
         yGeFVGj2KPUbm6RY740D76LgR9Wck02aWamF13gFDdmw1Q5vM0oXfi0h7hKtmi8D2+EK
         qgvYdK+0DZh2dvwfZZNHTWnKIHqCN9Itvk9e/9ehidVsQhOSJKXuJE+d81csb3vwauhD
         ZjLw==
X-Received: by 10.50.4.67 with SMTP id i3mr6419394igi.47.1431466743043;
        Tue, 12 May 2015 14:39:03 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:1d41:fac7:b879:7542])
        by mx.google.com with ESMTPSA id m5sm12771283ioi.4.2015.05.12.14.39.02
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 12 May 2015 14:39:02 -0700 (PDT)
In-Reply-To: <1431465265-18486-2-git-send-email-fredrik.medley@gmail.com>
	(Fredrik Medley's message of "Tue, 12 May 2015 23:14:24 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268894>

Fredrik Medley <fredrik.medley@gmail.com> writes:

> Subject: Re: [PATCH 2/3] upload-pack: Prepare to extend allow-tip-sha1-in-want

s/: Prepare/: prepare/;

> Rename the allow_tip_sha1_in_want variable to
> allow_request_with_bare_object_name to allow for future extensions, e.g.
> allowing non-tip sha1.
> ---

Sign-off?

>  fetch-pack.c  |  9 ++++++---
>  upload-pack.c | 18 +++++++++++-------
>  2 files changed, 17 insertions(+), 10 deletions(-)
>
> diff --git a/fetch-pack.c b/fetch-pack.c
> index 48526aa..77174f9 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -43,7 +43,10 @@ static int marked;
>  #define MAX_IN_VAIN 256
>  
>  static struct prio_queue rev_list = { compare_commits_by_commit_date };
> -static int non_common_revs, multi_ack, use_sideband, allow_tip_sha1_in_want;
> +static int non_common_revs, multi_ack, use_sideband;
> +/* Allow specifying sha1 if it is a ref tip. */
> +#define ALLOW_TIP	01
> +static int allow_request_with_bare_object_name;

This side is OK, as "request" is by the end user giving the object
name from its command line.

> diff --git a/upload-pack.c b/upload-pack.c
> index aa84576..708a502 100644
> --- a/upload-pack.c
> +++ b/upload-pack.c
> @@ -35,7 +35,9 @@ static int multi_ack;
>  static int no_done;
>  static int use_thin_pack, use_ofs_delta, use_include_tag;
>  static int no_progress, daemon_mode;
> -static int allow_tip_sha1_in_want;
> +/* Allow specifying sha1 if it is a ref tip. */
> +#define ALLOW_TIP	01
> +static int allow_request_with_bare_object_name;

This side is not quite good, as the request coming over wire is
always 40-hex bare object name.  We are allowing requests against
what we did not advertise (either the tip of hidden refs, or
somewhere deep in the history from some tip that may or may not have
been advertised).

allow-unadvertised-object-request or something, perhaps?

>  static int shallow_nr;
>  static struct object_array have_obj;
>  static struct object_array want_obj;
> @@ -442,8 +444,8 @@ static int get_common_commits(void)
>  
>  static int is_our_ref(struct object *o)
>  {
> -	return o->flags &
> -		((allow_tip_sha1_in_want ? HIDDEN_REF : 0) | OUR_REF);
> +	int allow_hidden_ref = (allow_request_with_bare_object_name & ALLOW_TIP);
> +	return o->flags & ((allow_hidden_ref ? HIDDEN_REF : 0) | OUR_REF);
>  }
>  
>  static void check_non_tip(void)
> @@ -727,7 +729,8 @@ static int send_ref(const char *refname, const unsigned char *sha1, int flag, vo
>  		packet_write(1, "%s %s%c%s%s%s%s agent=%s\n",
>  			     sha1_to_hex(sha1), refname_nons,
>  			     0, capabilities,
> -			     allow_tip_sha1_in_want ? " allow-tip-sha1-in-want" : "",
> +			     (allow_request_with_bare_object_name & ALLOW_TIP) ?
> +				     " allow-tip-sha1-in-want" : "",
>  			     stateless_rpc ? " no-done" : "",
>  			     symref_info.buf,
>  			     git_user_agent_sanitized());
> @@ -787,9 +790,10 @@ static void upload_pack(void)
>  
>  static int upload_pack_config(const char *var, const char *value, void *unused)
>  {
> -	if (!strcmp("uploadpack.allowtipsha1inwant", var))
> -		allow_tip_sha1_in_want = git_config_bool(var, value);
> -	else if (!strcmp("uploadpack.keepalive", var)) {
> +	if (!strcmp("uploadpack.allowtipsha1inwant", var)) {
> +		if (git_config_bool(var, value))
> +			allow_request_with_bare_object_name |= ALLOW_TIP;
> +	} else if (!strcmp("uploadpack.keepalive", var)) {
>  		keepalive = git_config_int(var, value);
>  		if (!keepalive)
>  			keepalive = -1;
