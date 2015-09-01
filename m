From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v15 06/13] ref-filter: add option to filter out tags, branches and remotes
Date: Tue, 01 Sep 2015 14:30:43 -0700
Message-ID: <xmqqa8t5rfng.fsf@gitster.mtv.corp.google.com>
References: <1441131994-13508-1-git-send-email-Karthik.188@gmail.com>
	<1441131994-13508-7-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com,
	Matthieu.Moy@grenoble-inp.fr
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 01 23:30:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWt8j-0005bP-Rb
	for gcvg-git-2@plane.gmane.org; Tue, 01 Sep 2015 23:30:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752059AbbIAVaq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Sep 2015 17:30:46 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:36553 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751373AbbIAVap (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Sep 2015 17:30:45 -0400
Received: by pacwi10 with SMTP id wi10so7999227pac.3
        for <git@vger.kernel.org>; Tue, 01 Sep 2015 14:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=DvdJy/QMsvS9i/wI9nhP36K6uuXnXcAZar3ByTsPsf4=;
        b=WZnbq5Nq2EU2qIvFv75TLB38HI6L1JHJ37jTu2tZpU6/JxZtApInqL5/OEXFnfJyF+
         MIyblZ/hnwpHIBQh0BmpPLbIjvSCfcSRs1g0edbutt0G4ciw31tvNKqikwxuGM/nhijW
         o2QOfXzhZe7iG6TskLNuwnUnzmJy11LDy+hzaMgCQ9cpZlQdglr1hNKDMWOqHD/cKolU
         UAOw8ycgbMtU9oZ8pp7KVxhPazgYVvCLVYn1EGsoPpnGk0c/HUb5a7Gf2E2mOO+csdr1
         cmTSGIAKJKkm+bzoRgmZcpKHPBGqIyuveiOAA0pbNnZqrurir1bRZGbbNuYMYmPKtDys
         1yug==
X-Received: by 10.68.233.5 with SMTP id ts5mr50071424pbc.58.1441143044960;
        Tue, 01 Sep 2015 14:30:44 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:c585:9fe7:e0d8:e718])
        by smtp.gmail.com with ESMTPSA id fx4sm19169192pbb.92.2015.09.01.14.30.43
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Tue, 01 Sep 2015 14:30:44 -0700 (PDT)
In-Reply-To: <1441131994-13508-7-git-send-email-Karthik.188@gmail.com>
	(Karthik Nayak's message of "Tue, 1 Sep 2015 23:56:27 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277042>

Karthik Nayak <karthik.188@gmail.com> writes:

> +	if (!filter->kind)
>  		die("filter_refs: invalid type");
> +	else {
> +		if (filter->kind == FILTER_REFS_BRANCHES)
> +			ret = for_each_fullref_in("refs/heads/", ref_filter_handler, &ref_cbdata, broken);
> +		else if (filter->kind == FILTER_REFS_REMOTES)
> +			ret = for_each_fullref_in("refs/remotes/", ref_filter_handler, &ref_cbdata, broken);
> +		else if (filter->kind == FILTER_REFS_TAGS)
> +			ret = for_each_fullref_in("refs/tags/", ref_filter_handler, &ref_cbdata, broken);
> +		else if (filter->kind & FILTER_REFS_ALL)
> +			ret = for_each_fullref_in("", ref_filter_handler, &ref_cbdata, broken);

This if/else if/else if/ cascade and ...

> +		if (!ret && (filter->kind & FILTER_REFS_DETACHED_HEAD))
> +			head_ref(ref_filter_handler, &ref_cbdata);
> +	}
> +
>  
>  	/*  Filters that need revision walking */
>  	if (filter->merge_commit)
> diff --git a/ref-filter.h b/ref-filter.h
> index 45026d0..0913ba9 100644
> --- a/ref-filter.h
> +++ b/ref-filter.h
> @@ -13,8 +13,15 @@
>  #define QUOTE_PYTHON 4
>  #define QUOTE_TCL 8
>  
> -#define FILTER_REFS_INCLUDE_BROKEN 0x1
> -#define FILTER_REFS_ALL 0x2
> +#define FILTER_REFS_INCLUDE_BROKEN 0x0001
> +#define FILTER_REFS_TAGS           0x0002
> +#define FILTER_REFS_BRANCHES       0x0004
> +#define FILTER_REFS_REMOTES        0x0008
> +#define FILTER_REFS_OTHERS         0x0010

... the bit assignment here conceptually do not mesh well with each
other.  These bits look as if I can ask for both tags and branches
by passing 0x0006, and if the code above were

	empty the result set;
	if (filter->kind & FILTER_REFS_BRANCHES)
        	add in things from refs/heads/ to the result set;
	if (filter->kind & FILTER_REFS_TAGS)                
        	add in things from refs/tags/ to the result set;
	...

without "else if", that would conceptually make sense.

Alternatively, if the code does not (and will not ever) support such
an arbitrary mixing of bits and intends to only allow "one of
BRANCHES, REMOTES, TAGS or ALL, and no other choice", then it is
wrong to pretend as if they can be mixed by defining the constant
with values with non-overlapping bit patterns.  If you defined these
constants as

#define FILTER_REFS_TAGS           100
#define FILTER_REFS_BRANCHES       101
#define FILTER_REFS_REMOTES        102
#define FILTER_REFS_OTHERS         103

then nobody would be think that the function can collect both tags
and branches by passing FILTER_REFS_TAGS|FILTER_REFS_BRANCHES.

The former, i.e. keep the bits distinct and allow them to be OR'ed
together by updating the code to allow such callers, would be more
preferrable, of course.
