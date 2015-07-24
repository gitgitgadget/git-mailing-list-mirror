From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 01/18] rerere: fix an off-by-one non-bug
Date: Fri, 24 Jul 2015 12:46:14 -0700
Message-ID: <xmqq7fppmj95.fsf@gitster.dls.corp.google.com>
References: <1435730699-9124-1-git-send-email-gitster@pobox.com>
	<1437171880-21590-1-git-send-email-gitster@pobox.com>
	<1437171880-21590-2-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 24 21:46:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZIivF-0003BG-Nv
	for gcvg-git-2@plane.gmane.org; Fri, 24 Jul 2015 21:46:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752203AbbGXTqR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jul 2015 15:46:17 -0400
Received: from mail-pd0-f180.google.com ([209.85.192.180]:33864 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751824AbbGXTqQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jul 2015 15:46:16 -0400
Received: by pdbbh15 with SMTP id bh15so18023519pdb.1
        for <git@vger.kernel.org>; Fri, 24 Jul 2015 12:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=OToM6ILFxqB18tM+wLoPXliO7DE78xokDfwp4hEfBgk=;
        b=KQ+/FbQSYLPLcchyo9N/mCQRpKL3hKDKR8miersAWF3wVcXli+KWFR5CF7MSWNSSIU
         GnZKp+CSWuZEl/dv9Nt6cIUIwxZAdRi57pF4cccVzSafKsQlI4AlYH5a6qIJgfobbDpP
         Jw4SsznceiRbyyk+s1qqgJiIwByYbAj6dqDg9kFDZA1KfNzaBYhKmxJluCZ1j2z5zwjQ
         sn/tNlhjsrsokfg0SHOehDjMMkvbHaxjc0M2Iz7h82/JFYVD3kKQ47/i6GBvw6oHdKj3
         npO8+CmWI9ciGEx1908EuMNr0i3f6ko0+ikfFnhGDHFdCAe7tQjzHINwOMZXQ5A5LZKa
         JQQw==
X-Received: by 10.66.186.195 with SMTP id fm3mr34285669pac.91.1437767176223;
        Fri, 24 Jul 2015 12:46:16 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:bdad:9e5d:aa9:33a9])
        by smtp.gmail.com with ESMTPSA id o8sm15995580pdp.70.2015.07.24.12.46.14
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Fri, 24 Jul 2015 12:46:15 -0700 (PDT)
In-Reply-To: <1437171880-21590-2-git-send-email-gitster@pobox.com> (Junio
	C. Hamano's message of "Fri, 17 Jul 2015 15:24:23 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274593>

Junio C Hamano <gitster@pobox.com> writes:

> When ac49f5ca (rerere "remaining", 2011-02-16) split out a new
> helper function check_one_conflict() out of find_conflict()
> function, so that the latter will use the returned value from the
> new helper to update the loop control variable that is an index into
> active_cache[], the new variable incremented the index by one too
> many when it found a path with only stage #1 entry at the very end
> of active_cache[].
>
> This "strange" return value does not have any effect on the loop
> control of two callers of this function, as they all notice that
> active_nr+2 is larger than active_nr just like active_nr+1 is, but
> nevertheless it puzzles the readers when they are trying to figure
> out what the function is trying to do.
>
> In fact, there is no need to do an early return.  The code that
> follows after skipping the stage #1 entry is fully prepared to
> handle a case where the entry is at the very end of active_cache[].
>
> Help future readers from unnecessary confusion by dropping an early
> return.  We skip the stage #1 entry, and if there are stage #2 and
> stage #3 entries for the same path, we diagnose the path as
> THREE_STAGED (otherwise we say PUNTED), and then we skip all entries
> for the same path.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  rerere.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/rerere.c b/rerere.c
> index 31644de..e307711 100644
> --- a/rerere.c
> +++ b/rerere.c
> @@ -369,10 +369,8 @@ static int check_one_conflict(int i, int *type)
>  	}
>  
>  	*type = PUNTED;
> -	if (ce_stage(e) == 1) {
> -		if (active_nr <= ++i)
> -			return i + 1;
> -	}
> +	if (ce_stage(e) == 1)
> +		i++;

As a conflicted index can have multiple stage #1 entries when
dealing with a criss-cross merge, this should probably be

	while (ce_stage(e) == 1)
        	i++;

instead.

>  	/* Only handle regular files with both stages #2 and #3 */
>  	if (i + 1 < active_nr) {
