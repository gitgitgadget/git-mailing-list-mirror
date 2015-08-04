From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 6/6] clone: add tests for cloning with empty path
Date: Tue, 4 Aug 2015 14:37:51 -0400
Message-ID: <CAPig+cT1utggwL_E2+Mmp7LqscywhrWx_Dr0XOSbTJU5oq7NLQ@mail.gmail.com>
References: <1437997708-10732-1-git-send-email-ps@pks.im>
	<1438687797-14254-1-git-send-email-ps@pks.im>
	<1438687797-14254-7-git-send-email-ps@pks.im>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
X-From: git-owner@vger.kernel.org Tue Aug 04 20:37:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMh63-000056-50
	for gcvg-git-2@plane.gmane.org; Tue, 04 Aug 2015 20:37:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754297AbbHDShw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2015 14:37:52 -0400
Received: from mail-yk0-f173.google.com ([209.85.160.173]:36087 "EHLO
	mail-yk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754241AbbHDShv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2015 14:37:51 -0400
Received: by ykeo23 with SMTP id o23so15575041yke.3
        for <git@vger.kernel.org>; Tue, 04 Aug 2015 11:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=EVifEaO5aIhRvnkHrCD9udx7esh5X7kQvIJ3jJ1VZ2A=;
        b=IqRo7z1iPVwf9JyCBAyVGsxPrfSRum8zKJOTUa1vY/Wj7KLqPJyHMGb6f2On7W1O/h
         wQswjpmvXI9yi34V8PON6ShTooUKUq9esZ2P6RSZ1qdr4f5VqexmE2eCdUTHQgu1fTd4
         BTd2EHv8B+xm4BZIfv1w0CSl3JwGVFbGUfB2v7ijJuQ5RQSzOZ01vAWIpzujjLkWCCEt
         pINlJVx1pXqRgt8s2Gdq7HskBLL/NZtynViR9u+CqynXiTubdaSyWvldXi/Va5kAhhsr
         JbZvo5OVLzjO0RyDcrXiExP3q+LtpLTKA9XfNWGwi0nzzrlOM1w1nSMuLecksgionOib
         QV7w==
X-Received: by 10.170.81.133 with SMTP id x127mr5299054ykx.13.1438713471087;
 Tue, 04 Aug 2015 11:37:51 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Tue, 4 Aug 2015 11:37:51 -0700 (PDT)
In-Reply-To: <1438687797-14254-7-git-send-email-ps@pks.im>
X-Google-Sender-Auth: aOAy8l3XPUhF5stKmeB93as7Pzk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275332>

On Tue, Aug 4, 2015 at 7:29 AM, Patrick Steinhardt <ps@pks.im> wrote:
> Test behavior of `git clone` when working with an empty path
> component. This may be the case when cloning a file system's root
> directory or from a remote server's root.

A few minor, mostly style-related, comments below...

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
> diff --git a/t/t1509-root-worktree.sh b/t/t1509-root-worktree.sh
> index 553a3f6..d521ca3 100755
> --- a/t/t1509-root-worktree.sh
> +++ b/t/t1509-root-worktree.sh
> @@ -237,6 +237,49 @@ test_foobar_foobar
>
>  test_expect_success 'cleanup' 'rm -rf /.git'
>
> +say "clone .git at root without reponame"
> +
> +test_expect_success 'go to /' 'cd /'
> +test_expect_success 'setup' '
> +       echo "Initialized empty Git repository in /.git/" > expected &&
> +       git init > result &&
> +       test_cmp expected result
> +'
> +
> +test_clone_expect_dir() {
> +       URL="$1"
> +       DIR="$2"

It would be nice for the &&-chain to be intact for these two lines, as
well, since you never know where someone may insert code in the
future. If code is inserted above or between these lines, and the code
fails, its failure will go unnoticed due to the broken &&-chain.

> +       cat <<-EOF >expected &&

In this codebase, it's customary to say:

    cat >expected <<-EOF &&

> +               Cloning into '$DIR'...
> +               warning: You appear to have cloned an empty repository.
> +               EOF

In this codebase, it's customary to place the content and EOF at the
same indentation level as the opening 'cat <<EOF'.

> +       git clone "$URL" >result 2>&1 &&
> +       rm -rf "$DIR" &&
> +       test_cmp expected result
> +}
> +
> +test_expect_success 'go to /clones' 'mkdir /clones && cd /clones'
> +test_expect_success 'simple clone of /' '
> +       cat <<-EOF >expected &&

Since you don't expect any variable interpolation in this case, you
can telegraph that intent more clearly via:

    cat >expected <<-\EOF &&

> +               fatal: No directory name could be guessed.
> +               Please specify a directory on the command line
> +               EOF
> +       test_expect_code 128 git clone / >result 2>&1 &&
> +       test_cmp expected result'
> +
> +test_expect_success 'clone with file://host/' '
> +       test_clone_expect_dir file://127.0.0.1/ 127.0.0.1'
> +test_expect_success 'clone with file://user@host/' '
> +       test_clone_expect_dir file://user@127.0.0.1/ 127.0.0.1'
> +test_expect_success 'clone with file://user:password@host/' '
> +       test_clone_expect_dir file://user:password@127.0.0.1/ 127.0.0.1'
> +test_expect_success 'clone with file://host:port/' '
> +       test_clone_expect_dir file://127.0.0.1:9999/ 127.0.0.1'
> +test_expect_success 'clone with file://user:password@host:port' '
> +       test_clone_expect_dir file://user:password@127.0.0.1:9999/ 127.0.0.1'
> +
> +test_expect_success 'cleanup' 'rm -rf /.git /clones'
> +
>  say "auto bare gitdir"
>
>  # DESTROYYYYY!!!!!
> --
> 2.5.0
