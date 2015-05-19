From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] upload-pack: optionally allow fetching reachable sha1
Date: Tue, 19 May 2015 15:06:15 -0700
Message-ID: <xmqqvbfo5ijs.fsf@gitster.dls.corp.google.com>
References: <CAPig+cQe3=Y15+RBZCxry7-78kbNL6H0PfdYs=OV_DMifOWxaA@mail.gmail.com>
	<1432068269-14895-1-git-send-email-fredrik.medley@gmail.com>
	<1432068269-14895-3-git-send-email-fredrik.medley@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Christian Halstrick <christian.halstrick@gmail.com>,
	Dan Johnson <computerdruid@gmail.com>,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>
To: Fredrik Medley <fredrik.medley@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 20 00:06:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YupeZ-0008Oo-Mx
	for gcvg-git-2@plane.gmane.org; Wed, 20 May 2015 00:06:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751689AbbESWGT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2015 18:06:19 -0400
Received: from mail-ie0-f172.google.com ([209.85.223.172]:35881 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751339AbbESWGS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2015 18:06:18 -0400
Received: by iepj10 with SMTP id j10so25248346iep.3
        for <git@vger.kernel.org>; Tue, 19 May 2015 15:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=Ecku+OI3PqHsFKnEnVmVZv4G+qzeFaRujOGiPzy/qwI=;
        b=z+QGviueFNWYoTSRvpxdIRfdrsTzke+D7IZLJu5AFrH2KWdYzE3oAUI6+6nvQqolBh
         dujYnhFnC2ikn3+ktaqiDvk9oNE89GU3HGxooDTiZkTmVyrKaFHy85c9LOfLh78HskIY
         PqWpPGJZIiE44Tz0Az0ONpIQrN9GlBsYjM+gdoO9xGiTdJBInecjBobhSPBk4UzX5i4E
         0r9FMACw1mmn528vWmcURjwCrwdd/wYznRSPUDitrQjU7gyhwzc4E0vHQjCr56khtUwr
         3gQnX8B+sRyjIvOFVMDy7aItm+o+PS/wsT8yvDdoiYHnC+p0KNb9lEN6AI1xwAKxB5Kr
         YwmQ==
X-Received: by 10.43.171.70 with SMTP id nt6mr41710421icc.73.1432073177743;
        Tue, 19 May 2015 15:06:17 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:6ddd:2b37:d23b:a593])
        by mx.google.com with ESMTPSA id rj5sm191714igc.2.2015.05.19.15.06.16
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 19 May 2015 15:06:16 -0700 (PDT)
In-Reply-To: <1432068269-14895-3-git-send-email-fredrik.medley@gmail.com>
	(Fredrik Medley's message of "Tue, 19 May 2015 22:44:29 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269414>

Fredrik Medley <fredrik.medley@gmail.com> writes:

> diff --git a/fetch-pack.c b/fetch-pack.c
> index 699f586..875b688 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -45,7 +45,9 @@ static int marked;
>  static struct prio_queue rev_list = { compare_commits_by_commit_date };
>  static int non_common_revs, multi_ack, use_sideband;
>  /* Allow specifying sha1 if it is a ref tip. */
> -#define ALLOW_TIP_SHA1	01
> +#define ALLOW_TIP_SHA1		01

What is this change about?  You do not have to align value columns.


> -	if ((allow_unadvertised_object_request & ALLOW_TIP_SHA1)) {
> +	if ((allow_unadvertised_object_request & (ALLOW_TIP_SHA1 | ALLOW_REACHABLE_SHA1))) {

Perhaps wrap it like this?

	if ((allow_unadvertised_object_request &
            (ALLOW_TIP_SHA1 | ALLOW_REACHABLE_SHA1))) {

> @@ -444,7 +446,8 @@ static int get_common_commits(void)
>  
>  static int is_our_ref(struct object *o)
>  {
> -	int allow_hidden_ref = (allow_unadvertised_object_request & ALLOW_TIP_SHA1);
> +	int allow_hidden_ref = (allow_unadvertised_object_request &
> +		(ALLOW_TIP_SHA1 | ALLOW_REACHABLE_SHA1));

Good, but push that to even more right?

> @@ -793,6 +802,9 @@ static int upload_pack_config(const char *var, const char *value, void *unused)
>  	if (!strcmp("uploadpack.allowtipsha1inwant", var)) {
>  		if (git_config_bool(var, value))
>  			allow_unadvertised_object_request |= ALLOW_TIP_SHA1;
> +	} else if (!strcmp("uploadpack.allowreachablesha1inwant", var)) {
> +		if (git_config_bool(var, value))
> +			allow_unadvertised_object_request |= ALLOW_REACHABLE_SHA1;
>  	} else if (!strcmp("uploadpack.keepalive", var)) {
>  		keepalive = git_config_int(var, value);
>  		if (!keepalive)

Same issue as [2/3]

		...
	} else if (!strcmp("configVariable", var)) {
        	if (git_config_bool(var, value))
			value |= ALLOW_THIS;
		else
                	value &= ~ALLOW_THIS;
	} else if ...

should be OK.

Thanks.
