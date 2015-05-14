From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] sha1_file: pass empty buffer to index empty file
Date: Thu, 14 May 2015 11:43:59 -0700
Message-ID: <xmqqbnhnknio.fsf@gitster.dls.corp.google.com>
References: <1431624219-25045-1-git-send-email-gjthill@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jim Hill <gjthill@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 14 20:44:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ysy76-0000lP-Co
	for gcvg-git-2@plane.gmane.org; Thu, 14 May 2015 20:44:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933440AbbENSoE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2015 14:44:04 -0400
Received: from mail-ig0-f175.google.com ([209.85.213.175]:35585 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933275AbbENSoB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2015 14:44:01 -0400
Received: by igbyr2 with SMTP id yr2so175035266igb.0
        for <git@vger.kernel.org>; Thu, 14 May 2015 11:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=t+qPudfv+oyA+zYhMYvv1oghibI9d0E3srT1/bC8fy0=;
        b=vFOliqh7NQtHCVT9tg0H3dDONX1Qi/+FCr1BjRrQCPjhqB/BGfGlWV+5iIyVrHHThv
         74q+ZviTDhiNPw8HUTZqkfGh52WdJ2N6I+n5N76oopputlrA3ojLRO3Eky+z9Ce7j9ij
         J/LXiAHQFjRw7pypVDr5k+W2iUri79Fxh3+dA7R2JnFDjjBli7K9sN7dYepI/qBMHDu2
         YBpvr+9GhEzeJfunwkD+2m3uHGNbL9pYkr8CSSiXeyznCsj3SzJnsirzrSzop71ZZIZK
         ZMDebOb7HYHijNMZaXqphDQ012sxNX2j4fR5mACr42Z2Iyzw9nBDzDvUdTHE6FextRo7
         Z4Ug==
X-Received: by 10.50.43.137 with SMTP id w9mr12023491igl.30.1431629040937;
        Thu, 14 May 2015 11:44:00 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:74eb:19e4:cd06:a6b6])
        by mx.google.com with ESMTPSA id j20sm6407790igt.16.2015.05.14.11.44.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 14 May 2015 11:44:00 -0700 (PDT)
In-Reply-To: <1431624219-25045-1-git-send-email-gjthill@gmail.com> (Jim Hill's
	message of "Thu, 14 May 2015 10:23:39 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269065>

Jim Hill <gjthill@gmail.com> writes:

> `git add` of an empty file with a filter currently pops complaints from
> `copy_fd` about a bad file descriptor.

Our log message typically begins with the description of a problem
that exists; "currently" is redundant in that context.  Please lose
that word.

> This traces back to these lines in sha1_file.c:index_core:
>
> 	if (!size) {
> 		ret = index_mem(sha1, NULL, size, type, path, flags);
>
> The problem here is that content to be added to the index can be
> supplied from an fd, or from a memory buffer, or from a pathname. This
> call is supplying a NULL buffer pointer and a zero size.

Good spotting.

I think the original thinking was that "we'd feed mem[0..size) to
the hash function, so mem being NULL should not matter", but as you
analysed, mem being NULL is used as a signal with a different meaning,
and your fix is the right one.

I am not enthused to see a new test script wasted just for one piece
of test.  Don't we have other "run 'git add' with clean/smudge
filters" test to which you can add this new one to?  If there is
none, then a new test script is good, but then it should be a place
to _add_ missing "run 'git add' with filters" test and its name
should not be so specific to this "empty" special case.

> diff --git a/sha1_file.c b/sha1_file.c
> index f860d67..61e2735 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -3186,7 +3186,7 @@ static int index_core(unsigned char *sha1, int fd, size_t size,
>  	int ret;
>  
>  	if (!size) {
> -		ret = index_mem(sha1, NULL, size, type, path, flags);
> +		ret = index_mem(sha1, "", size, type, path, flags);
>  	} else if (size <= SMALL_FILE_SIZE) {
>  		char *buf = xmalloc(size);
>  		if (size == read_in_full(fd, buf, size))
> diff --git a/t/t2205-add-empty-filtered-file.sh b/t/t2205-add-empty-filtered-file.sh
> new file mode 100755
> index 0000000..28903c4
> --- /dev/null
> +++ b/t/t2205-add-empty-filtered-file.sh
> @@ -0,0 +1,21 @@
> +#!/bin/sh
> +
> +test_description='adding empty filtered file'
> +
> +. ./test-lib.sh
> +
> +test_expect_success setup '
> +	echo "* filter=test" >>.gitattributes &&
> +	git config filter.test.clean cat &&
> +	git config filter.test.smudge cat &&
> +	git add . &&
> +	git commit -m-
> +
> +'

Please do not be cryptic and show a good example, e.g.

	git commit -m test

Also lose the blank line from that test.

> +
> +test_expect_success "add of empty filtered file produces no complaints" '
> +	touch emptyfile &&

"touch" is to be used when you care about the timestamp.  When you
care more about the _presence_ of the file than what timestamp it
has, do not use "touch".  Say

	>emptyfile &&

instead.  This is especially true in this case, because you not only
care about the presence but you care about it being _empty_.

> +	git add emptyfile 2>out &&
> +	test -e out -a ! -s out

Future generation of Git users may want to see "git add emptyfile"
that succeeds to still say something and that something may be
different from "the complaint about a bad file descriptor".  Don't
force the person who makes such a change to update this test.

You may do

	git add emptyfile 2>err &&

and check that 'err' does not contain the copy-fd error (in other
words, this test is not in a good position to reject any other
output to the standard error stream), if you really wanted to, but I
do not think it is worth it.

My preference is to lose the test on 'out' and end this test like
this:

	git add emptyfile

> +'
> +test_done

Thanks.
