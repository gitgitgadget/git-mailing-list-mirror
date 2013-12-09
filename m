From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH] diff: don't read index when --no-index is given
Date: Mon, 09 Dec 2013 22:13:06 +0100
Message-ID: <87ppp5n2xp.fsf@gmail.com>
References: <1386590745-4412-1-git-send-email-t.gummerer@gmail.com> <xmqqwqjdydga.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Alexey Borzenkov <snaury@gmail.com>,
	=?utf-8?Q?Re?= =?utf-8?Q?n=C3=A9?= Scharfe <l.s.r@web.de>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Tim Henigan <tim.henigan@gmail.com>,
	Bobby Powers <bobbypowers@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 09 22:13:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vq88d-0002h2-82
	for gcvg-git-2@plane.gmane.org; Mon, 09 Dec 2013 22:13:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761493Ab3LIVNI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Dec 2013 16:13:08 -0500
Received: from mail-yh0-f53.google.com ([209.85.213.53]:47958 "EHLO
	mail-yh0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753970Ab3LIVNF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Dec 2013 16:13:05 -0500
Received: by mail-yh0-f53.google.com with SMTP id b20so3124181yha.26
        for <git@vger.kernel.org>; Mon, 09 Dec 2013 13:13:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:in-reply-to:references:user-agent:date
         :message-id:mime-version:content-type;
        bh=zWCIap8LjKm0zZVYN+E5plLPj1mVY84Qycj1vBKsEOU=;
        b=qVohhOIR+UqZMOAMA8RhZvbnaMAcqHHD7QhpD2kXWsQueYPzIfai5ZWD+V5AzLVWj5
         q9KElETI++nJBrRPJv2sV6a7rBHbZ8cga0JFnc3s0bJ0IoMsxRg95LHEvMtiNkZJGD3X
         iE0OK7b5FDe1EfU6cFUJmYlksdW93ROAnToTZbug+L1lJx8shwD23QfIK9OnvFg+BF4x
         NSO+SkPtt2TFgrGj27W6UbxOU+R3ctQBZDg9a3ajVWhGq3gMqXvrm90YYToEhmie8QyI
         zAbYZ+QTH0HYb/jHrLk3tvJ/mvkh3mpG4C9RdL08ZuFZ1SqUh5cshigDQgqXSYi6RD9m
         EaAA==
X-Received: by 10.236.81.237 with SMTP id m73mr89433220yhe.29.1386623584856;
        Mon, 09 Dec 2013 13:13:04 -0800 (PST)
Received: from localhost ([2001:5c0:1400:a::e57])
        by mx.google.com with ESMTPSA id w8sm3047656yhg.8.2013.12.09.13.13.02
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Dec 2013 13:13:04 -0800 (PST)
In-Reply-To: <xmqqwqjdydga.fsf@gitster.dls.corp.google.com>
User-Agent: Notmuch/0.17~rc1+8~g4a09c1a (http://notmuchmail.org) Emacs/24.3.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239103>


[Sorry for not seeing this before sending out v2.]

Junio C Hamano <gitster@pobox.com> writes:

> Thomas Gummerer <t.gummerer@gmail.com> writes:
>
>> git diff --no-index ... currently reads the index, during setup, when
>> calling gitmodules_config().  In the usual case this gives us some
>> performance drawbacks, but it's especially annoying if there is a broken
>> index file.
>>
>> Avoid calling the unnecessary gitmodules_config() when the --no-index
>> option is given.  Also add a test to guard against similar breakages in the future.
>>
>> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
>> ---
>>  builtin/diff.c           | 13 +++++++++++--
>>  t/t4053-diff-no-index.sh |  6 ++++++
>>  2 files changed, 17 insertions(+), 2 deletions(-)
>>
>> diff --git a/builtin/diff.c b/builtin/diff.c
>> index adb93a9..47c0833 100644
>> --- a/builtin/diff.c
>> +++ b/builtin/diff.c
>> @@ -257,7 +257,7 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
>>  	int blobs = 0, paths = 0;
>>  	const char *path = NULL;
>>  	struct blobinfo blob[2];
>> -	int nongit;
>> +	int nongit, no_index = 0;
>>  	int result = 0;
>>
>>  	/*
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
>> +	}
>
> This seems to duplicate only half the logic at the beginning of
> diff_no_index(), right?  E.g., running "git diff /var/tmp/[12]"
> inside a working tree that is controlled by a Git repository when
> /var/tmp/ is outside, we do want to behave as if the command line
> were "git diff --no-index /var/tmp/[12]", but this half duplication
> makes these two behave differently, no?

Yes you're right, I missed that.  "git diff /var/tmp/[12]" inside a
working tree with a broken index has the same problems, which should be
fixed too.  I'll try to fix that and send a new patch afterwards.

> I think the issue you are trying to address is worth tackling, but I
> wonder if a bit of preparatory refactoring is necessary to avoid the
> partial duplication.
>
>>  	prefix = setup_git_directory_gently(&nongit);
>> -	gitmodules_config();
>> +	if (!no_index)
>> +		gitmodules_config();
>>  	git_config(git_diff_ui_config, NULL);
>>
>>  	init_revisions(&rev, prefix);
>> diff --git a/t/t4053-diff-no-index.sh b/t/t4053-diff-no-index.sh
>> index 979e983..a24ae4d 100755
>> --- a/t/t4053-diff-no-index.sh
>> +++ b/t/t4053-diff-no-index.sh
>> @@ -29,4 +29,10 @@ test_expect_success 'git diff --no-index relative path outside repo' '
>>  	)
>>  '
>>
>> +test_expect_success 'git diff --no-index with broken index' '
>> +	cd repo &&
>> +	echo broken >.git/index &&
>> +	test_expect_code 0 git diff --no-index a ../non/git/a
>> +'
>> +
>>  test_done

--
Thomas
