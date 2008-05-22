From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] Fix t6031 on filesystems without working exec bit
Date: Thu, 22 May 2008 10:16:25 +0200
Message-ID: <81b0412b0805220116h4e4ff279k2e433a8a9a1cd9fc@mail.gmail.com>
References: <20080518145727.GA3058@steel.home>
	 <7v7idqaocb.fsf@gitster.siamese.dyndns.org>
	 <20080519060015.GA3179@steel.home>
	 <7v8wy360l8.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 22 10:18:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jz5zF-0004A9-6S
	for gcvg-git-2@gmane.org; Thu, 22 May 2008 10:17:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764498AbYEVIQb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2008 04:16:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934697AbYEVIQb
	(ORCPT <rfc822;git-outgoing>); Thu, 22 May 2008 04:16:31 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:62105 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934660AbYEVIQ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2008 04:16:26 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2571959fgg.17
        for <git@vger.kernel.org>; Thu, 22 May 2008 01:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=si1sM4kX4cio+BQKn51S8tcFqVlCpkwd7bU4dV2vrZI=;
        b=hsN6lOQifa4ZdrdLIN0qDFaasbk667iZPkb7cLi/Ou0XK/0aHHLKRpuVq3UgwkNuPi//+tjWeA9tt3NWdm0b7WVDT40OB3QAFpK5VI6haqcuw84O2weYnuR0bKIjrWYlPxfUW04CFvDS+3RAXjEw43TjKWUiI8ta5tS28v8lXQs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=R8FVI3IIgO3a35+nr705f+5efEeDei6ub6V7wOclKeIFzbXL5FgvYzdVBL1EUK8rsFIPmwfSZCQO3JIZ5xFcyVimI39xqFNY3JZ6ev9nTE/bB82RmWi+15ITOOMLDKlALM1mj9srnrJl40mTYSg37BMtRRI3vEK+POYobZ/unWo=
Received: by 10.78.179.3 with SMTP id b3mr1545913huf.80.1211444185101;
        Thu, 22 May 2008 01:16:25 -0700 (PDT)
Received: by 10.78.120.17 with HTTP; Thu, 22 May 2008 01:16:25 -0700 (PDT)
In-Reply-To: <7v8wy360l8.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82603>

2008/5/21 Junio C Hamano <gitster@pobox.com>:
> Look at what the "switch to a1 branch after committing to b1" does again.
> You modify "file1" and commit to "b1" and you now have a local change in
> file1 (because you update only the index and not the work tree) that is
> effectively a revert of what you committed just now, and a1 and b1 differs
> at that path.  You get "Entry 'file1' not uptodate. Cannot merge."  when
> you try to switch to "a1".
>
>    $ sh t6031-merge-recursive.sh -i -v
>    * expecting success:
>            : >file1 &&
>            git add file1 &&
>            git commit -m initial &&
>            git checkout -b a1 master &&
>            : >dummy &&
>            git add dummy &&
>            git commit -m a &&
>            git checkout -b b1 master &&
>            git update-index --chmod=+x file1 &&
>            git commit -m b1 &&
>            git checkout a1 &&
>            git merge-recursive master -- a1 b1 &&
>            test -x file1
>
>    Created initial commit bae7a40: initial
>     0 files changed, 0 insertions(+), 0 deletions(-)
>     create mode 100644 file1
>    Switched to a new branch "a1"
>    Created commit 1f64f65: a
>     0 files changed, 0 insertions(+), 0 deletions(-)
>     create mode 100644 dummy
>    Switched to a new branch "b1"
>    Created commit 98a1cf4: b1
>     0 files changed, 0 insertions(+), 0 deletions(-)
>     mode change 100644 => 100755 file1
>    error: Entry 'file1' not uptodate. Cannot merge.
>    * FAIL 1: mode change in one branch: keep changed version

It did work for me when I tried it back then. Maybe I just accidentally
tested something else.

> If we squash the following on top of your patch, I think we can help
> filesystems without executable bit without breaking filesystems with one.
> Can you see if it works on your executable-bit-less setup?

Not in the moment.

> -- >8 --
>  t/t6031-merge-recursive.sh |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
>
> diff --git a/t/t6031-merge-recursive.sh b/t/t6031-merge-recursive.sh
> index f1c91c8..8073e0c 100755
> --- a/t/t6031-merge-recursive.sh
> +++ b/t/t6031-merge-recursive.sh
> @@ -3,6 +3,9 @@
>  test_description='merge-recursive: handle file mode'
>  . ./test-lib.sh
>
> +# Note that we follow "chmod +x F" with "update-index --chmod=+x F" to
> +# help filesystems that do not have the executable bit.
> +
>  test_expect_success 'mode change in one branch: keep changed version' '
>        : >file1 &&
>        git add file1 &&
> @@ -12,6 +15,7 @@ test_expect_success 'mode change in one branch: keep changed version' '
>        git add dummy &&
>        git commit -m a &&
>        git checkout -b b1 master &&
> +       chmod +x file1 &&

Now, this is pointless in my setup. Cygwin just ignores the operation
and decidedddds (presumably according the file _content_ or maybe
phase of the moon) that is not executable. Working tree is still modified.

Maybe I should just live with it (and disable the test locally). It is just
very broken system which hopefully no one besides me ever gets to see.
