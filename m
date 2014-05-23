From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] Add an explicit GIT_DIR to the list of excludes
Date: Fri, 23 May 2014 00:39:35 -0400
Message-ID: <CAPig+cTZuxd7vFdoLDb=_CUuoaKbHLKRftvBJd6XQDD_5R5+tA@mail.gmail.com>
References: <1400789477-27906-1-git-send-email-pasha.bolokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>
To: Pasha Bolokhov <pasha.bolokhov@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 23 06:39:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnhGe-0002sb-Md
	for gcvg-git-2@plane.gmane.org; Fri, 23 May 2014 06:39:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752198AbaEWEjg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2014 00:39:36 -0400
Received: from mail-yk0-f178.google.com ([209.85.160.178]:57432 "EHLO
	mail-yk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752191AbaEWEjg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2014 00:39:36 -0400
Received: by mail-yk0-f178.google.com with SMTP id 20so3582719yks.23
        for <git@vger.kernel.org>; Thu, 22 May 2014 21:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=0z2wagHK0varO1zuN80ajSVndkxUSbN3JOp3vZrqxD4=;
        b=F/Zh7xUXy5QQ36rGdnd2QCv5HrLTm58CDLau265v8Aog4mleJCw0rAE1fEHOtFc/qA
         3uzIo7esK6bILddfVRbH/eXsHG0u/BHUwDZ65hk8mcukZ1zHq61f/WdmaDsSwvHnOXiQ
         hZf6q9u64QkXMhV+l/5NqmhwgPcS0ekzrvHLAVUdNJSC0Ag7qDh8dTEREUBPptYZypI3
         lGAYwk7bIx3w9o8bambkI1/xJoIngpCxQbDCQGWnKwjsa8ub4Si/ANfySbY2wxNdVd9m
         nZbKSku5oTbCJaSh5IaHrIdTERNfUCwzjsMu5q6FctvfqDyMMu8EP8XkJ2aGfZOUYyJI
         eF9w==
X-Received: by 10.236.84.202 with SMTP id s50mr3232657yhe.77.1400819975373;
 Thu, 22 May 2014 21:39:35 -0700 (PDT)
Received: by 10.170.169.65 with HTTP; Thu, 22 May 2014 21:39:35 -0700 (PDT)
In-Reply-To: <1400789477-27906-1-git-send-email-pasha.bolokhov@gmail.com>
X-Google-Sender-Auth: -PGdq8DHF3u1W5_JF8xTL2vUwTQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249970>

On Thu, May 22, 2014 at 4:11 PM, Pasha Bolokhov
<pasha.bolokhov@gmail.com> wrote:
> diff --git a/t/t2205-add-gitdir.sh b/t/t2205-add-gitdir.sh
> new file mode 100755
> index 0000000..3c6b853
> --- /dev/null
> +++ b/t/t2205-add-gitdir.sh
> @@ -0,0 +1,61 @@
> +#!/bin/sh
> +#
> +# Copyright (c) 2014 Pasha Bolokhov
> +#
> +
> +test_description='alternative repository path specified by --git-dir is ignored by add and status'
> +
> +. ./test-lib.sh
> +
> +test_expect_success "setup" '
> +       git --git-dir=meta init &&
> +       for f in a b c d
> +       do
> +               echo "DATA" > "$f" || exit 1

On this project, it's customary to say 'foo >bar' (no whitespace after
'>'). Ditto for the rest of the file.

> +       done &&
> +       mkdir subdir1 &&
> +       for f in e f g h
> +       do
> +               echo "MORE DATA" > "subdir1/$f" || exit 1
> +       done &&
> +       mkdir subdir1/meta &&
> +       echo "EVEN more Data" > subdir1/meta/aa &&
> +       mkdir subdir1/ssubdir subdir1/ssubdir/meta &&
> +       echo "So much more data" > subdir1/ssubdir/meta/aaa
> +'
> +
> +test_expect_success "'git status' acknowledges files 'meta' if repository is not within work tree" '
> +       test_might_fail rm -rf meta/ &&
> +       (
> +               cd subdir1 &&
> +               git --git-dir=../meta init

Broken &&-chain.

> +               git --git-dir=../meta --work-tree=. status --porcelain > status2.out &&
> +               test_might_fail grep meta status2.out > out2 &&
> +               test -s out2
> +       )
> +'
> +
> +test_done
> --
> 1.9.1
