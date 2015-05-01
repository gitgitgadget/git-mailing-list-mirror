From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 2/2] lock_packed_refs(): allow retries when acquiring the
 packed-refs lock
Date: Fri, 1 May 2015 10:51:47 -0700
Message-ID: <CAGZ79kZnhv+aW_GW8mBDyhfv_k54ScAFsHQz=8zfHBUJ8WrVUw@mail.gmail.com>
References: <1430491977-25817-1-git-send-email-mhagger@alum.mit.edu>
	<1430491977-25817-3-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri May 01 19:51:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YoF6P-0002qx-8S
	for gcvg-git-2@plane.gmane.org; Fri, 01 May 2015 19:51:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750839AbbEARvt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 May 2015 13:51:49 -0400
Received: from mail-ig0-f173.google.com ([209.85.213.173]:33379 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750812AbbEARvs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 May 2015 13:51:48 -0400
Received: by igbpi8 with SMTP id pi8so31756409igb.0
        for <git@vger.kernel.org>; Fri, 01 May 2015 10:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=naFYOGCywmdBoZiwOKPFXkjrAHGV1jYlGGXXbznN/wg=;
        b=ZdPl20kAOQQNfZL6wbYduS1AI2PCn+OMdXJP+FA4F+2Sphub0DSm9YnIHZUgewsRJc
         skHH93SjJAPL5vVzXj215XTF3rypNwfxZE2kV7ScODcgJqtekVsZ/IACcKbhcxkeJTni
         WcI64fMasg8ow80Ra/U+eT8aIEEaj4JDa9itK4T0VvKMeE1bFI+4/OoeYSh0fYZuVuvv
         4zXIhlf3LQ0zu2ISVkyRP8KHZ0QuOiI/WMWpAZzOg/4gu5YU82M8PkjoLa163htlaGEi
         fW2FTN935ZapdLn0OH5c9Z5Z6lE19jQNUQPk+jNKLwHX8YLbO86PITWiOgrBOJedbcwI
         YN/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=naFYOGCywmdBoZiwOKPFXkjrAHGV1jYlGGXXbznN/wg=;
        b=G8KdQx7TxIzVgT3DpvQWUSa7ykg3uoxO78jSzI+WA3jF+ZxVoVVviOiz+W2Vwycx3q
         riuG2JH9SW/9TOtvXK7waS7gcnT+t2AAyJ0F98DrLzGF0YZv/JvADv6MSMiepWChWND+
         qoLaGcVH6mW+BferPbpGcf1Y23r/oymOeghO+SyZGw8giYvOKoaVtCTvHujLFMDXHztl
         lVuAy47hloFaWyAma6CD6UOSBB8hoseXEOp4LMSqdzAGP8iFMN1rlrUEQaQWHzUDixY6
         2YnDGtgcZR0q/oOxnGoeuxIhltEy1Ki2qEFqOh9PdmSdW2svE/ApHV6DHkqYeDRPJ6rK
         MC/g==
X-Gm-Message-State: ALoCoQn7rYTJRwozCtcg+RF+sQeB6/ZhmOekFqjM+SE7rG3JA1OF4s8GMhWisNIib8M/nT7/U5qN
X-Received: by 10.107.132.223 with SMTP id o92mr13850560ioi.49.1430502707692;
 Fri, 01 May 2015 10:51:47 -0700 (PDT)
Received: by 10.107.46.22 with HTTP; Fri, 1 May 2015 10:51:47 -0700 (PDT)
In-Reply-To: <1430491977-25817-3-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268166>

On Fri, May 1, 2015 at 7:52 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> Currently, there is only one attempt to acquire any lockfile, and if
> the lock is held by another process, the locking attempt fails
> immediately.
>
> This is not such a limitation for loose reference files. First, they
> don't take long to rewrite. Second, most reference updates have a
> known "old" value, so if another process is updating a reference at
> the same moment that we are trying to lock it, then probably the
> expected "old" value will not longer be valid, and the update will
> fail anyway.
>
> But these arguments do not hold for packed-refs:
>
> * The packed-refs file can be large and take significant time to
>   rewrite.
>
> * Many references are stored in a single packed-refs file, so it could
>   be that the other process was changing a different reference than
>   the one that we are interested in.
>
> Therefore, it is much more likely for there to be spurious lock
> conflicts in connection to the packed-refs file, resulting in
> unnecessary command failures.
>
> So, if the first attempt to lock the packed-refs file fails, continue
> retrying for a configurable length of time before giving up. The
> default timeout is 1 second.
>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>
> Notes (discussion):
>     At first I wasn't going to make this setting configurable. After all,
>     who could object to one second?
>
>     But then I realized that making the length of the timeout configurable
>     would make it easier to test. Since sleep(1) is only guaranteed to
>     have a 1-second resolution, it is helpful to set the timeout longer
>     than 1 second in the test. So I made it configurable, and documented
>     the setting.
>
>     I don't have a strong opinion either way.
>
>     By the way, if anybody has a better idea for how to test this, please
>     chime up. As written, the two new tests each take about one second to
>     run (though they are mostly idle during that time, so they parallelize
>     well with other tests).
>
>  Documentation/config.txt |  6 ++++++
>  refs.c                   | 12 +++++++++++-
>  t/t3210-pack-refs.sh     | 17 +++++++++++++++++
>  3 files changed, 34 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 2e5ceaf..3c24e10 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -622,6 +622,12 @@ core.commentChar::
>  If set to "auto", `git-commit` would select a character that is not
>  the beginning character of any line in existing commit messages.
>
> +core.packedRefsTimeout::
> +       The length of time, in milliseconds, to retry when trying to
> +       lock the `packed-refs` file. Value 0 means not to retry at
> +       all; -1 means to try indefinitely. Default is 1000 (i.e.,
> +       retry for 1 second).
> +
>  sequence.editor::
>         Text editor used by `git rebase -i` for editing the rebase instruction file.
>         The value is meant to be interpreted by the shell when it is used.
> diff --git a/refs.c b/refs.c
> index 47e4e53..3f8ac63 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -2413,9 +2413,19 @@ static int write_packed_entry_fn(struct ref_entry *entry, void *cb_data)
>  /* This should return a meaningful errno on failure */
>  int lock_packed_refs(int flags)
>  {
> +       static int timeout_configured = 0;
> +       static int timeout_value = 1000;

I'd personally be more happier with a default value of 100 ms or less
The reason is found in the human nature, as humans tend to perceive
anything faster than 100ms as "instant"[1], while a 100ms is a long time
for computers.

Now a small default time may lead to to little retries, so maybe it's worth
checking at the very end of the time again (ignoring the computed backoff
times). As pushes to $server usually take a while (connecting, packing packs,
writing objects etc), this may be overcautios bikeshedding from my side.

[1] http://stackoverflow.com/questions/536300/what-is-the-shortest-perceivable-application-response-delay


> +
>         struct packed_ref_cache *packed_ref_cache;
>
> -       if (hold_lock_file_for_update(&packlock, git_path("packed-refs"), flags) < 0)
> +       if (!timeout_configured) {
> +               git_config_get_int("core.packedrefstimeout", &timeout_value);
> +               timeout_configured = 1;
> +       }
> +
> +       if (hold_lock_file_for_update_timeout(
> +                           &packlock, git_path("packed-refs"),
> +                           flags, timeout_value) < 0)
>                 return -1;
>         /*
>          * Get the current packed-refs while holding the lock.  If the
> diff --git a/t/t3210-pack-refs.sh b/t/t3210-pack-refs.sh
> index aa9eb3a..d18b726 100755
> --- a/t/t3210-pack-refs.sh
> +++ b/t/t3210-pack-refs.sh
> @@ -187,4 +187,21 @@ test_expect_success 'notice d/f conflict with existing ref' '
>         test_must_fail git branch foo/bar/baz/lots/of/extra/components
>  '
>
> +test_expect_success 'timeout if packed-refs.lock exists' '
> +       LOCK=.git/packed-refs.lock &&
> +       >$LOCK &&
> +       test_when_finished "rm -f $LOCK" &&
> +       test_must_fail git pack-refs --all --prune
> +'
> +
> +test_expect_success 'retry acquiring packed-refs.lock' '
> +       LOCK=.git/packed-refs.lock &&
> +       >$LOCK &&
> +       test_when_finished "rm -f $LOCK" &&
> +       {
> +               ( sleep 1 ; rm -f $LOCK ) &
> +       } &&
> +       git -c core.packedrefstimeout=3000 pack-refs --all --prune
> +'
> +
>  test_done
> --
> 2.1.4
>
