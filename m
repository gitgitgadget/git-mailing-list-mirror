From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 1/3] clone: do not include authentication data in guessed dir
Date: Wed, 05 Aug 2015 10:43:06 -0700
Message-ID: <xmqqzj253a39.fsf@gitster.dls.corp.google.com>
References: <1437997708-10732-1-git-send-email-ps@pks.im>
	<1438769179-5943-1-git-send-email-ps@pks.im>
	<1438769179-5943-2-git-send-email-ps@pks.im>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, sunshine@sunshineco.com, peff@peff.net,
	pclouds@gmail.com
To: Patrick Steinhardt <ps@pks.im>
X-From: git-owner@vger.kernel.org Wed Aug 05 19:43:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZN2im-0000Pz-Pg
	for gcvg-git-2@plane.gmane.org; Wed, 05 Aug 2015 19:43:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753250AbbHERnJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2015 13:43:09 -0400
Received: from mail-pd0-f169.google.com ([209.85.192.169]:34159 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752050AbbHERnI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2015 13:43:08 -0400
Received: by pdber20 with SMTP id er20so21195700pdb.1
        for <git@vger.kernel.org>; Wed, 05 Aug 2015 10:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=ARlGtSPwaVWzKxNKaLKkRQiVsSHpC3Uz+0DcFSXjJOk=;
        b=wboVvfPK+37HS+/7p4u2WhtYmWC5fWaK7WTN82Cn7MDCtWAPxmhJkufMfT9MoiHFJF
         HqXDztBjSjPhotvJSDgKRTEQqmXYhtJwWycnP2FxW6BCaWW8vIweOaO90641h3H9TpL6
         liDDTOVd096tOYIGblEHL4cxmEvXWknXe3lqMmh0liXFtNyY+6OhWdmCeKXLvbUJEmwQ
         2hlht0KTlfFnUcpZuxbFKN18i1BZp2W492iVS75NgLVZTpT2ZxYZIHSHeqvz2tPO8DI+
         Oy/iimJy6742RZtNM1E+O4yJx+bSb2CvepqEsBG5GeBBC1L7LRKLLk1btCsagxMTOMQ8
         5m0g==
X-Received: by 10.70.91.14 with SMTP id ca14mr97634pdb.79.1438796588081;
        Wed, 05 Aug 2015 10:43:08 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:5cf0:2451:9503:37d])
        by smtp.gmail.com with ESMTPSA id fv2sm3579678pbd.54.2015.08.05.10.43.07
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 05 Aug 2015 10:43:07 -0700 (PDT)
In-Reply-To: <1438769179-5943-2-git-send-email-ps@pks.im> (Patrick
	Steinhardt's message of "Wed, 5 Aug 2015 12:06:17 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275381>

Patrick Steinhardt <ps@pks.im> writes:

> If the URI contains authentication data and the URI's path
> component is empty we fail to guess a sensible directory name.
> E.g. cloning a repository 'ssh://user:password@example.com/' we
> guess a directory name 'password@example.com' where we would want
> the hostname only, e.g. 'example.com'.
>
> ...
> +	ptr = start;
> +	while (ptr < end && !is_dir_sep(*ptr) && *ptr != '@')
> +		ptr++;

Hmm....

> +	if (*ptr == '@')
> +		start = ptr + 1;
> +
> +	 * Find last component. To remain backwards compatible we
> +	 * also regard colons as path separators, such that
> +	 * cloning a repository 'foo:bar.git' would result in a
> +	 * directory 'bar' being guessed.
>  	 */

I think this is a reasonable thing to do (besides, I think some
people cannot have colon in their filenames, so keeping this aspect
the same as before would avoid unintended regressions).

> -	start = end;
> -	while (repo < start && !is_dir_sep(start[-1]) && start[-1] != ':')
> -		start--;
> +	ptr = end;
> +	while (start < ptr && !is_dir_sep(ptr[-1]) && ptr[-1] != ':')
> +		ptr--;
> +	start = ptr;
>  
>  	/*
>  	 * Strip .{bundle,git}.
> diff --git a/t/t5603-clone-dirname.sh b/t/t5603-clone-dirname.sh
> index 46725b9..3a454f9 100755
> --- a/t/t5603-clone-dirname.sh
> +++ b/t/t5603-clone-dirname.sh
> @@ -64,6 +64,7 @@ test_clone_dir ssh://host/foo/.git/ foo
>  # omitting the path should default to the hostname
>  test_clone_dir ssh://host/ host
>  test_clone_dir ssh://host:1234/ host fail
> -test_clone_dir ssh://user@host/ host fail
> +test_clone_dir ssh://user@host/ host
> +test_clone_dir ssh://user:password@host/ host

Perhaps add

"test_clone_dir ssh://user:passw@rd@host/ host"

here?  How is this expected to be parsed?

>  test_done
