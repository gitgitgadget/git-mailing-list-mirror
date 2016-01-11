From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4] format-patch: introduce format.outputDirectory configuration
Date: Sun, 10 Jan 2016 22:55:18 -0500
Message-ID: <CAPig+cSoEYof0quiG=P4SRiOb7FeNDnVsGdzGoxO=oLcgfGBUA@mail.gmail.com>
References: <CAPig+cQ9kObgd5-OGRZH-YuZVnBX72ukS=kKD8OfTN51dQ0SRA@mail.gmail.com>
	<1452472227-9684-1-git-send-email-ischis2@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Alexander Kuleshov <kuleshovmail@gmail.com>
To: "Stephen P. Smith" <ischis2@cox.net>
X-From: git-owner@vger.kernel.org Mon Jan 11 04:55:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aITZk-000887-3H
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jan 2016 04:55:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758165AbcAKDzU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Jan 2016 22:55:20 -0500
Received: from mail-vk0-f66.google.com ([209.85.213.66]:34219 "EHLO
	mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757949AbcAKDzT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jan 2016 22:55:19 -0500
Received: by mail-vk0-f66.google.com with SMTP id a123so5415877vkh.1
        for <git@vger.kernel.org>; Sun, 10 Jan 2016 19:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=teJZK9PuY8G0HXDDhcKpFHSLnvFoPfwg9hb6j/otdZw=;
        b=X+E7Wn6O6jhk/19mu2bs3yR6MNkRgiH6+s8hxVN2i9SI+ElPq+95TlZC2NbAOF/DYg
         ptwdlTZE1htiHAGJZc5oTExrfd7sqthDBXZfGjSnkVE/Odbs7mkf8dYfEDWrx5P2TLnD
         7/SIAT4RKe6YtlciA4Ksvry+4JrJDPlk2FGZ8ze0LOEdnadtd+Gmyy83MS39Q1i5synC
         lkcLXaQzOs8oEySrpux5gcQHu4j46E238GJhNkK+9HOJOJfio8y4FyY6Nsw5naRkKNbK
         zcyhNFaJlyFRdpaNIKQ/zdP+lCqhVFYldWO8GY7E6q2AFJngaqrhNYQUo9k8ycuVb+Gy
         3Npw==
X-Received: by 10.31.164.78 with SMTP id n75mr54556581vke.14.1452484518440;
 Sun, 10 Jan 2016 19:55:18 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Sun, 10 Jan 2016 19:55:18 -0800 (PST)
In-Reply-To: <1452472227-9684-1-git-send-email-ischis2@cox.net>
X-Google-Sender-Auth: E0f5Ynf5H-HuTVIKGJnZnb6nyRQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283631>

On Sun, Jan 10, 2016 at 7:30 PM, Stephen P. Smith <ischis2@cox.net> wrote:
> We can pass -o/--output-directory to the format-patch command to store
> patches in some place other than the working directory. This patch
> introduces format.outputDirectory configuration option for same
> purpose.
>
> The case of usage of this configuration option can be convinience
> to not pass every time -o/--output-directory if an user has pattern
> to store all patches in the /patches directory for example.
>
> The format.outputDirectory has lower priority than command line
> option, so if user will set format.outputDirectory and pass the
> command line option, a result will be stored in a directory that
> passed to command line option.
>
> Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
> Signed-off-by: Stephen P. Smith <ischis2@cox.net>
> ---
> diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
> @@ -1445,4 +1445,20 @@ test_expect_success 'From line has expected format' '
> +test_expect_success 'format-patch format.outputDirectory option' '
> +       test_config format.outputDirectory patches &&
> +       rm -fr patches &&
> +       git format-patch master..side &&
> +       ls patches >actual &&
> +       test_line_count = 3 actual
> +'

Now that you've moved the new tests to the bottom of the script, this
test fails. This is because, at this point, there are 18 commits in
the range 'master..side', not 3 as when the test was at the top of the
script. You could change the 3 to an 18, however, that would be
fragile: if someone inserts or modifies tests above this one, then a
hard-coded 18 might become stale. One possible fix would be:

    test $(git rev-list master..side | wc -l) -eq $(ls patches)

You could also take the stance that you're not so much interested in
the number of patches in the range 'master..side' but rather you
merely care about the fact that the "patches" directory got created
and some patches were deposited there. In that case, you might do this
instead:

    git format-patch -3 side &&
    ls patches >actual &&
    test_line_count = 3 actual

I don't feel strongly about it either way, but whichever approach you
choose, please do build the project and run this test script to ensure
that it succeeds before submitting v5. Thanks.

> +test_expect_success 'format-patch -o overrides format.outputDirectory' '
> +       test_config format.outputDirectory patches &&
> +       rm -fr patches patchset &&
> +       git format-patch master..side -o patchset &&
> +       test_path_is_missing patches &&
> +       test_path_is_dir patchset
> +'
