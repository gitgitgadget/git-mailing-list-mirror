From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/9] t5520: ensure origin refs are updated
Date: Wed, 13 May 2015 07:27:19 -0700
Message-ID: <xmqqegmkbliw.fsf@gitster.dls.corp.google.com>
References: <1431508136-15313-1-git-send-email-pyokagan@gmail.com>
	<1431508136-15313-3-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Elijah Newren <newren@gmail.com>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 13 16:27:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsXd9-0004FC-5S
	for gcvg-git-2@plane.gmane.org; Wed, 13 May 2015 16:27:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965106AbbEMO1X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2015 10:27:23 -0400
Received: from mail-ig0-f169.google.com ([209.85.213.169]:38854 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964874AbbEMO1V (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2015 10:27:21 -0400
Received: by igbhj9 with SMTP id hj9so46284249igb.1
        for <git@vger.kernel.org>; Wed, 13 May 2015 07:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=Ew5S6M3Jyf+1d1iygSswWIjh0qKwVwJRyJL3fzA9LgA=;
        b=GlaDbx8UOpQ98QczJFnGOf4j67CUe2d6mKVEouPNQuKMnPecgAzhVWTq8Mifxg2enw
         b5a4dbnhhOIIcQqd984nvKr64MPPjUZhY4Bz65gvp8n4lR+lFqM1OhzUdNWW+kDbCzfL
         JhlVGBGglbtMCtcbbj9hADINIuqhS2J3Zb8FnUkWd9vYTwpLcysvqi7mXP9YNO1AAKar
         gkv3IsaxpAZLSriMAoq4uhgnoPpwkKQ+RvSczOTyywcxwgeuiYJWy0U7QRbwmMevEcYO
         mTJ94YJnl0qfb1cDMPUph/xQ0z/LtohwNqWrf6FOGtlN/1pZIUzfI5rg9rSGj/PrcRQd
         AGXQ==
X-Received: by 10.50.45.103 with SMTP id l7mr10999024igm.41.1431527241163;
        Wed, 13 May 2015 07:27:21 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:3cfa:54ee:8e48:89ad])
        by mx.google.com with ESMTPSA id fv2sm3670026igb.22.2015.05.13.07.27.20
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 13 May 2015 07:27:20 -0700 (PDT)
In-Reply-To: <1431508136-15313-3-git-send-email-pyokagan@gmail.com> (Paul
	Tan's message of "Wed, 13 May 2015 17:08:49 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268984>

Paul Tan <pyokagan@gmail.com> writes:

> Should all of the tests before "setup for avoiding reapplying old
> patches" fail or be skipped, the repo "dst" will not have fetched the
> updated refs from origin. To be resilient against such failures, run
> "git fetch origin".
>
> Signed-off-by: Paul Tan <pyokagan@gmail.com>
> ---
> * Hmm, no reviews the last round?

It is not unusual when the change is trivially correct.

I do not think this hurts, but I do not think that this is vastly
better, either.  If you suspect that the previous one may fail but
you at the same time are so trusting that the one before that one
would succeed, yes, this will help in that case.  But if you suspect
the previous one may fail, the one before that may have also failed,
in which case this may not be sufficient (the result of fetching may
not match what this test expects to see).

It all depends on where our paranoia ends. The current code is very
much trusting all previous ones equally, and accepts "upon the first
error, all bets are off for the later ones". With this patch, it
becomes slightly less trusting.

If everything else were equal, I would say this change is a "Meh" to
me, but I think the change improves this test in a different way.

It begins with "Run 'git rebase --abort', just in case"; which is a
signal that it does consider that the previous one may have failed
and attempts to prepare for that possibility, while trusting the one
before that would have succeeded.  And under that assumption, what
it currently does is _not_ consistent; the previous "pull --rebase"
may have failed in the "rebase" phase, in which case "abort just in
case" is a good measure to go back to the clean state, but it may
have failed in the "fetch" phase, in which case "abort" does not
help.  And this patch is needed to fix that inconsistency.

If justified in that way in the log message, then I wouldn't have
said "I do not think that this is vastly better", I think.

>  t/t5520-pull.sh | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
> index 20ad373..14a9280 100755
> --- a/t/t5520-pull.sh
> +++ b/t/t5520-pull.sh
> @@ -339,6 +339,7 @@ test_expect_success 'git pull --rebase detects upstreamed changes' '
>  test_expect_success 'setup for avoiding reapplying old patches' '
>  	(cd dst &&
>  	 test_might_fail git rebase --abort &&
> +	 git fetch origin &&
>  	 git reset --hard origin/master
>  	) &&
>  	git clone --bare src src-replace.git &&
