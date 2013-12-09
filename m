From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH] diff: don't read index when --no-index is given
Date: Mon, 09 Dec 2013 20:14:01 +0100
Message-ID: <87siu1n8g6.fsf@gmail.com>
References: <1386590745-4412-1-git-send-email-t.gummerer@gmail.com> <20131209151609.GA14841@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Alexey Borzenkov <snaury@gmail.com>,
	"Ren\?\? Scharfe" <l.s.r@web.de>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Tim Henigan <tim.henigan@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Bobby Powers <bobbypowers@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>, Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 09 20:14:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vq6HS-0007oc-Q1
	for gcvg-git-2@plane.gmane.org; Mon, 09 Dec 2013 20:14:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761525Ab3LITOF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Dec 2013 14:14:05 -0500
Received: from mail-yh0-f42.google.com ([209.85.213.42]:36200 "EHLO
	mail-yh0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761323Ab3LITOB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Dec 2013 14:14:01 -0500
Received: by mail-yh0-f42.google.com with SMTP id z6so3068103yhz.1
        for <git@vger.kernel.org>; Mon, 09 Dec 2013 11:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:in-reply-to:references:user-agent:date
         :message-id:mime-version:content-type;
        bh=SdF1//ZyEQWX96DT8Q+6yefGafKsrn46B78jaLCEdKI=;
        b=XaSKq7hq6dt+1Wh0GIlmKhRUs7XRGftQiq9iMkEfAiD2tVaHj4faiKw7SSDkvj46nR
         zu6E2B4YrDoOhKnXoOKXhRRr3p54rhpmUuZOYjV3+6oUVrmLL1+cwoFerydgzN6ChRRF
         CD2w3fkHZZQwdWddK7M40VZZOLDn+G+BRD0tOo2yRUXZfNTznmCK3g3Nfbz57Hdk2SXU
         8x1G4D5nAaQDlO9POOdH6o8DODRIhoT98AWSc3htTkoZsKkYRiyYhSSlGmKcGJxcgJL7
         pArQ/a04nT3KK2cAX4EOHv/O9G7b5pO3PrNJTyZaYE0WyTP+NDwIdj0IJp3MMuIrBRPf
         iKJQ==
X-Received: by 10.236.41.84 with SMTP id g60mr20257yhb.158.1386616440666;
        Mon, 09 Dec 2013 11:14:00 -0800 (PST)
Received: from localhost ([2001:5c0:1400:a::1267])
        by mx.google.com with ESMTPSA id m68sm17981333yhj.22.2013.12.09.11.13.57
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Dec 2013 11:13:59 -0800 (PST)
In-Reply-To: <20131209151609.GA14841@google.com>
User-Agent: Notmuch/0.17~rc1+8~g4a09c1a (http://notmuchmail.org) Emacs/24.3.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239079>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Thomas Gummerer wrote:
>
>> git diff --no-index ... currently reads the index, during setup, when
>> calling gitmodules_config().  In the usual case this gives us some
>> performance drawbacks,
>
> Makes sense.
>
>>                        but it's especially annoying if there is a broken
>> index file.
>
> Is this really a normal case?  It makes sense that as a side-effect it
> is easier to use "git diff --no-index" as a general-purpose tool while
> investigating a broken repo, but I would have thought that quickly
> learning a repo is broken is a good thing in any case.
>
> A little more information about the context where this came up would
> be helpful, I guess.

It came up while I was working on index-v5, where I had to investigate
quite a few repositories where the index was broken, especially when I
was changing the index format slightly.  For example I would take one
version, use test-dump-cache-tree to dump the cache tree to a file,
change the format slightly, use test-dump-cache-tree again, and check
the difference with "git diff --no-index".

This might not be a very common use case, but maybe the patch might help
someone else too. (In addition to the performance improvements)

I'm not sure how much diff --no-index is used normally, but when the
index is broken that would be detected relatively soon anyway.  I'm not
so worried about one more command working when it's broken.

> [...]
>> --- a/builtin/diff.c
>> +++ b/builtin/diff.c
> [...]
>> @@ -282,9 +282,18 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
>>  	 *
>>  	 * Other cases are errors.
>>  	 */
>> +	for (i = 1; i < argc; i++) {
>> +		if (!strcmp(argv[i], "--"))
>> +			break;
>> +		if (!strcmp(argv[i], "--no-index")) {
>> +			no_index = 1;
>> +			break;
>> +		}
>
> setup_revisions() uses the same logic that doesn't handle options that
> take arguments in their "unstuck" form (e.g., "--word-diff-regex --"),
> so this is probably not a regression, though I haven't checked. :)

The same logic is used in diff_no_index(), so I think it should be fine.

> [...]
>>  	prefix = setup_git_directory_gently(&nongit);
>> -	gitmodules_config();
>> +	if (!no_index)
>> +		gitmodules_config();
>
> Perhaps we can improve performance and behavior by skipping the
> setup_git_directory_gently() call, too?
>
> That would help with the repairing-broken-repository case by
> working even if .git/config or .git/HEAD is broken, and I think
> it is more intuitive that the repository-local configuration is
> ignored by "git diff --no-index".  It would also help with
> performance by avoiding some filesystem access.

Yes, I think that would make sense, thanks.  I tested it, and it didn't
change the performance, but it's still a good change for the broken
repository case.  Will change in the re-roll and add a test for that.

> [...]
>> +test_expect_success 'git diff --no-index with broken index' '
>> +	cd repo &&
>> +	echo broken >.git/index &&
>> +	test_expect_code 0 git diff --no-index a ../non/git/a
>
> Clever.  I wouldn't use "test_expect_code 0", since that's
> already implied by including the "git diff --no-index" call
> in the && chain.

Thanks, will change.  Thanks a lot for your review.  Will send a re-roll
soon.

> Thanks and hope that helps,
> Jonathan

--
Thomas
