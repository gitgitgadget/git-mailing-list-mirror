From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] ref-filter: add ref-filter API
Date: Sat, 23 May 2015 10:18:04 -0700
Message-ID: <xmqqoalbciwj.fsf@gitster.dls.corp.google.com>
References: <555C88C2.8060902@gmail.com>
	<1432127904-21070-2-git-send-email-karthik.188@gmail.com>
	<vpqr3qagvv6.fsf@anie.imag.fr> <555E1CE7.8090507@gmail.com>
	<vpqbnhd157k.fsf@anie.imag.fr> <555F252C.2060601@gmail.com>
	<vpq8ucffj8h.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: karthik nayak <karthik.188@gmail.com>, git@vger.kernel.org,
	christian.couder@gmail.com
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sat May 23 19:18:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YwD3r-0003BQ-K1
	for gcvg-git-2@plane.gmane.org; Sat, 23 May 2015 19:18:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758050AbbEWRSH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 May 2015 13:18:07 -0400
Received: from mail-ie0-f177.google.com ([209.85.223.177]:32779 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757985AbbEWRSG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 May 2015 13:18:06 -0400
Received: by iebgx4 with SMTP id gx4so50474753ieb.0
        for <git@vger.kernel.org>; Sat, 23 May 2015 10:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=TQ1Dng9xqNulBQa4I0kWqyVV7NIH3utgiPxRgGxxGPA=;
        b=TJ3VyRJN9u8Qh6o918KtqwJ2xGZDM7LzKX1418Sru0KpIrXrHgdGORmivGySVxVEKh
         /agcim853MzTls4mJVUeiiSIQCH06pMIdGGCJd2pwmKHnlkQy2UYWxmwb1glZ9y3mIWP
         5UVPlxeHewMb4ly+TJ20AE52yaLrInJim0earPzaF0nF67Nzk3ek/KjCflJD4GZf3kNk
         qLtyd2vzCLWEmTsSx5+Mr3id6rhP3hUhtFjDi24FS7AgbPnto55IBzs4y01aypotwKGn
         n8iaX/xIcneX9p/rtVYYhG50glXvvA5Wlgfp8R1kWX9Okh+hHS1d0dAdSRzsUp6z18/n
         uXsw==
X-Received: by 10.50.29.40 with SMTP id g8mr12965316igh.41.1432401485559;
        Sat, 23 May 2015 10:18:05 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:609e:6a22:2d9d:c8d5])
        by mx.google.com with ESMTPSA id d185sm4560298ioe.42.2015.05.23.10.18.04
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 23 May 2015 10:18:05 -0700 (PDT)
In-Reply-To: <vpq8ucffj8h.fsf@anie.imag.fr> (Matthieu Moy's message of "Sat,
	23 May 2015 16:42:38 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269810>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> But I think this could be clearer in the code (and/or comment + commit
> message). Perhaps stg like:
>
> struct ref_filter_data /* Probably not the best name */ {
>         struct ref_list list;
>         struct ref_filter filter;
> };
>
> struct ref_list {
>  	int count, alloc;
>  	struct ref_filter_item **items;
> };

If you plan to use ALLOC_GROW() API, name the bookkeeping variables
"alloc" & "nr", unless you have a compelling reason to deviate from
the prevailing practice.

> struct ref_filter {
> 	const char **name_patterns;
> 	/* There will be more here later */
> };

Very good suggestion.

Whatever the final name would be, it is a good idea to separate the
"list of things that are operated on" and the "set of operations to
be applied".  That makes things conceptually cleaner; you can have
multiple of the former operated on with a singleton of the latter
and then their results merged, etc. etc.

And I do not think an array of things that are operated on should
not be named "ref_filter_item".

Surely, the latter "set of operations to be applied" may currently
be only filtering, but who says it has to stay that way?  "I have a
set of refs that represent my local branches I am interested
in. Please map them to their corresponding @{upstream}" is a
reasonable request once you have an infrastructure to represent "set
of refs to be worked on" and "set of operations to apply", and at
that point, the items are no longer filter-items (map-items?).
