From: Thomas Miller <jackerran@gmail.com>
Subject: Re: [PATCH/WIP] Repair DF conflicts during fetch.
Date: Sun, 1 Dec 2013 09:03:58 -0600
Message-ID: <CAECD2aGaL84n01-0fuNfyy-mx8NPKz2Vbhy3LpTgdOxgWayERw@mail.gmail.com>
References: <1385747858-29343-1-git-send-email-jackerran@gmail.com>
	<1385747858-29343-2-git-send-email-jackerran@gmail.com>
	<871u1zf2nd.fsf@thomasrast.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Thomas Rast <tr@thomasrast.ch>
X-From: git-owner@vger.kernel.org Sun Dec 01 16:04:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vn8ZL-0006Hp-M9
	for gcvg-git-2@plane.gmane.org; Sun, 01 Dec 2013 16:04:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751529Ab3LAPD7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Dec 2013 10:03:59 -0500
Received: from mail-qa0-f45.google.com ([209.85.216.45]:54435 "EHLO
	mail-qa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751123Ab3LAPD7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Dec 2013 10:03:59 -0500
Received: by mail-qa0-f45.google.com with SMTP id o15so3445314qap.4
        for <git@vger.kernel.org>; Sun, 01 Dec 2013 07:03:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=xU1eYuT9joWtFrcqwpIGNZIwMRfp1yxmldRVxD63T58=;
        b=fxfo47kJKV8w/+x6OJ3gMjgcQhToCCEUlsTJJ30aDufcshWDG23/U8ynEZtdXYP7Dz
         CreAdKKG7PJ+zQxiZXfroWrMQC8DuQCVKhOGsZ4HFLX0xHyNIgOsCG0KwO7y/L+xmLyI
         MNnxt46gqHkwNXX9p5VBOhpD00f7o7MjAAbacbXy3YRLZ4yvGtj6PO4nNvlJvg+kIcOY
         KjWxkWtIJPTyp8eyFAVt9pmeLCojtZQVphkiCyAgtlZsEwL8xjlP1muMGTdqIoGMYvEc
         p4XeE+2aq8vV0v3KRsnMXO0aZ9aRTzYciLrw2hr2gqF04RN0rSh1az9Ly+jdoBybUjoQ
         18MQ==
X-Received: by 10.224.66.5 with SMTP id l5mr107638036qai.31.1385910238574;
 Sun, 01 Dec 2013 07:03:58 -0800 (PST)
Received: by 10.229.11.196 with HTTP; Sun, 1 Dec 2013 07:03:58 -0800 (PST)
In-Reply-To: <871u1zf2nd.fsf@thomasrast.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238589>

On Fri, Nov 29, 2013 at 1:07 PM, Thomas Rast <tr@thomasrast.ch> wrote:
> Tom Miller <jackerran@gmail.com> writes:
>
>> When a DF conflict occurs during a fetch, --prune should be able to fix
>> it. When fetching with --prune, the fetching process happens before
>> pruning causing the DF conflict to persist and report an error. This
>> patch prunes before fetching, thus correcting DF conflicts during a
>> fetch.
>>
>> Signed-off-by: Tom Miller <jackerran@gmail.com>
>> ---
>>  builtin/fetch.c | 10 +++++-----
>>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> Good catch.
>
> I can't comment on the correctness of the patch right now, but here's a
> test you could steal.  It just reproduces what you describe, and I did
> verify that it confirms the fix ;-)
>
> diff --git i/t/t5510-fetch.sh w/t/t5510-fetch.sh
> index 5d4581d..a981125 100755
> --- i/t/t5510-fetch.sh
> +++ w/t/t5510-fetch.sh
> @@ -614,4 +614,18 @@ test_expect_success 'all boundary commits are excluded' '
>         test_bundle_object_count .git/objects/pack/pack-${pack##pack    }.pack 3
>  '
>
> +test_expect_success 'branchname D/F conflict resolved by --prune' '
> +       git branch dir/file &&
> +       git clone . prune-df-conflict &&
> +       git branch -D dir/file &&
> +       git branch dir &&
> +       (
> +               cd prune-df-conflict &&
> +               git fetch --prune &&
> +               git rev-parse origin/dir >../actual
> +       ) &&
> +       git rev-parse dir >expect &&
> +       test_cmp expect actual
> +'
> +
>  test_done
>
>
> --
> Thomas Rast
> tr@thomasrast.ch

Thanks, I appreciate the test. I have added it and gave credit via a
"Tested-by" section. I have been looking into adding a pruning header
to "fix" the output, but that is just the first solution I've been able to
come up with. I believe before I have an elegant solution I'll have to
read the code more carefully and brush up on my C.

Thanks,
Tom Miller

PS. I apologize for the duplicate message the mailing list rejected my
first for not being plaintext only.
