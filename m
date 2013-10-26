From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: Re: [PATCH v3 2/2] merge-base: teach "--fork-point" mode
Date: Fri, 25 Oct 2013 22:15:41 -0700
Message-ID: <CANiSa6h7x=CcwwAqvoaOm4-y+6MCugV5BE0OXnfGHvf+iJ66MA@mail.gmail.com>
References: <xmqqhac6o5hj.fsf@gitster.dls.corp.google.com>
	<1382641884-14756-1-git-send-email-gitster@pobox.com>
	<1382641884-14756-3-git-send-email-gitster@pobox.com>
	<CAPig+cQrBMMqSmOk0GSZJ9PTHNt-t+vuOG2Aq=7VTR1EZSeLsw@mail.gmail.com>
	<xmqq61smmkc0.fsf@gitster.dls.corp.google.com>
	<CAPig+cQ2tWFXX-RYnUrHEZCaqaPV6ZwgoPfiNPv9P1jFNTGEYg@mail.gmail.com>
	<xmqqwql2l3ln.fsf@gitster.dls.corp.google.com>
	<xmqqsivql37i.fsf_-_@gitster.dls.corp.google.com>
	<526A19CA.9020609@viscovery.net>
	<xmqqmwlxjnq6.fsf@gitster.dls.corp.google.com>
	<xmqq61sljakf.fsf_-_@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Johannes Sixt <j.sixt@viscovery.net>,
	John Keeping <john@keeping.me.uk>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 26 07:16:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZwED-00043T-TG
	for gcvg-git-2@plane.gmane.org; Sat, 26 Oct 2013 07:16:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751494Ab3JZFPn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Oct 2013 01:15:43 -0400
Received: from mail-wg0-f52.google.com ([74.125.82.52]:39815 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751020Ab3JZFPn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Oct 2013 01:15:43 -0400
Received: by mail-wg0-f52.google.com with SMTP id f12so4660257wgh.31
        for <git@vger.kernel.org>; Fri, 25 Oct 2013 22:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=U/ygMrvN6LKeIeumN/5B/IqzeAwqqR1eJtxfqmMTfhE=;
        b=ImdutB3SSvMzD7KSyJuJlxzJWvl+bFI8w0wGOJaVTIOTTvwaNUuKCK2zgOaoNUcqPd
         PQiqY18e/t4VLM6Q0UbzwQYaKxvBqOpo3r7SaiS78OpzEXmtfArTSOa2khU+CRkT89A6
         N7+r3PEbAvFoktRDUFWVV3O7R3q9hYkaTz7e9qFUsT768g0l5unWK7GsKvQqiBR/6hpL
         hSEfflTI/pB1cjFZq9etLdkOEWZd8VjGl60d8LyHiY1+2TJVZ+AqYT/f27KwL+qAGVRz
         YiUXF/pjrkxp8WI77wLZfV90ILR1gDlS3nVl6IjvCA8B6cnwgeDq5yuqsDfpjxHi/MZy
         5BIw==
X-Received: by 10.194.24.168 with SMTP id v8mr10292839wjf.28.1382764541517;
 Fri, 25 Oct 2013 22:15:41 -0700 (PDT)
Received: by 10.180.80.67 with HTTP; Fri, 25 Oct 2013 22:15:41 -0700 (PDT)
In-Reply-To: <xmqq61sljakf.fsf_-_@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236733>

Thanks for taking care of this! Maybe John or I can finally get the
changes to rebase done after this.

A few comments below. Sorry I didn't find time to review the earlier revisions.

On Fri, Oct 25, 2013 at 2:38 PM, Junio C Hamano <gitster@pobox.com> wrote:
> +
> +where `origin/master` used to point at commits B3, B2, B1 and now it
> +points at B, and your `topic` branch was stated on top of it back

s/stated/started/

> +       bases = get_merge_bases_many(derived, revs.nr, revs.commit, 0);
> +
> +       /*
> +        * There should be one and only one merge base, when we found
> +        * a common ancestor among reflog entries.
> +        */
> +       if (!bases || bases->next)
> +               return 1;
> +
> +       /* And the found one must be one of the reflog entries */
> +       for (i = 0; i < revs.nr; i++)
> +               if (&bases->item->object == &revs.commit[i]->object)
> +                       break; /* found */
> +       if (revs.nr <= i)
> +               return 1; /* not found */
> +
> +       printf("%s\n", sha1_to_hex(bases->item->object.sha1));
> +       free_commit_list(bases);
> +       return 0;

Should free_commit_list also be called in the two "return 1" cases
above? I suppose the process will exit soon after this, but that seems
to be true for all three cases.

> diff --git a/t/t6010-merge-base.sh b/t/t6010-merge-base.sh
> index f80bba8..4f09db0 100755
> --- a/t/t6010-merge-base.sh
> +++ b/t/t6010-merge-base.sh
> @@ -230,4 +230,31 @@ test_expect_success 'criss-cross merge-base for octopus-step' '
>         test_cmp expected.sorted actual.sorted
>  '
>
> +test_expect_success 'using reflog to find the fork point' '
> +       git reset --hard &&
> +       git checkout -b base $E &&
> +
> +       (
> +               for count in 1 2 3 4 5
> +               do
> +                       git commit --allow-empty -m "Base commit #$count" &&
> +                       git rev-parse HEAD >expect$count &&
> +                       git checkout -B derived &&
> +                       git commit --allow-empty -m "Derived #$count" &&
> +                       git rev-parse HEAD >derived$count &&
> +                       git checkout base || exit 1

I think this creates a history like

---E---B1--B2--B3--B4--B5 (base)
        \   \   \   \   \
         D1  D2  D3  D4  D5 (derived)

So I think the following test would pass even if you drop the
--fork-point. Did you mean to create a fan-shaped history by resetting
base to $E on every iteration above?

> +                       git merge-base --fork-point base $(cat derived$count) >actual &&
> +                       test_cmp expect$count actual || exit 1
