From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 1/2] git-p4: add test case for "Translation of file
 content failed" error
Date: Sun, 20 Sep 2015 17:16:51 -0400
Message-ID: <CAPig+cThcNa2Xg6GDkNKKeOMOzApTi_FQfQz_KRAbF8-PWY5Eg@mail.gmail.com>
References: <1442766131-45017-1-git-send-email-larsxschneider@gmail.com>
	<1442766131-45017-2-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Luke Diamand <luke@diamand.org>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 20 23:17:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zdlz8-0001J0-5o
	for gcvg-git-2@plane.gmane.org; Sun, 20 Sep 2015 23:17:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755394AbbITVQx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Sep 2015 17:16:53 -0400
Received: from mail-vk0-f44.google.com ([209.85.213.44]:32825 "EHLO
	mail-vk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751404AbbITVQw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Sep 2015 17:16:52 -0400
Received: by vkgd64 with SMTP id d64so55065596vkg.0
        for <git@vger.kernel.org>; Sun, 20 Sep 2015 14:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=NMvjs9j2O3klUb++zgjH3XgDxDCpz1YeCmv0BGcD8t4=;
        b=Etd3hNvs9+PWJ37o64fRl404JpmNBP7j5qRK3YjdNRULZrultDPU6MzKviGY0yQtiQ
         z3623M0rfoP20BiF1p2pJGsR5m/wcsKR426kQdfYqUEEIt1rYg0VGuLYfdaxQJ9LSLM8
         oGoJ872A+JWpagfeXBhg8gRYJV9AJ7h+TqqV20N+KzHxayFkO5DJ2q1hmLylxHQFXE2y
         xxOYbJ9K/9gIQb7Q49QveERXTjrY4+covlAX8sXEREy7ptgKKsUVx6qkdvVmW3PS3+dt
         zkBEM7h7jPdsuqwH2hxg8Ry24pQvpYKQFOd53bmaPutbEwVcdYYph6dj4i8bvMTfr5Dn
         e9YA==
X-Received: by 10.31.56.193 with SMTP id f184mr10863117vka.115.1442783811363;
 Sun, 20 Sep 2015 14:16:51 -0700 (PDT)
Received: by 10.31.224.68 with HTTP; Sun, 20 Sep 2015 14:16:51 -0700 (PDT)
In-Reply-To: <1442766131-45017-2-git-send-email-larsxschneider@gmail.com>
X-Google-Sender-Auth: Nq54CvFV37eO8mWIJuhm7vPiWEQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278270>

On Sun, Sep 20, 2015 at 12:22 PM,  <larsxschneider@gmail.com> wrote:
> A P4 repository can get into a state where it contains a file with
> type UTF-16 that does not contain a valid UTF-16 BOM. If git-p4
> attempts to retrieve the file then the process crashes with a
> "Translation of file content failed" error.

Hmm, are these tests going to succeed only after patch 2/2 is applied?
If so, the order of these patches is backward since you want each
patch to be able to stand on its own and not introduce any sort of
breakage.

> More info here: http://answers.perforce.com/articles/KB/3117
>
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> ---
> diff --git a/t/t9824-git-p4-handle-utf16-without-bom.sh b/t/t9824-git-p4-handle-utf16-without-bom.sh
> new file mode 100755
> index 0000000..517f6da
> --- /dev/null
> +++ b/t/t9824-git-p4-handle-utf16-without-bom.sh
> @@ -0,0 +1,49 @@
> +#!/bin/sh
> +
> +test_description='git p4 handling of UTF-16 files without BOM'
> +
> +. ./lib-git-p4.sh
> +
> +UTF16="\227\000\227\000"
> +
> +test_expect_success 'start p4d' '
> +       start_p4d
> +'
> +
> +test_expect_success 'init depot with UTF-16 encoded file and artificially remove BOM' '
> +       (
> +               cd "$cli" &&
> +               printf "$UTF16" >file1 &&
> +               p4 add -t utf16 file1 &&
> +               p4 submit -d "file1"
> +       ) &&
> +
> +       (
> +               cd "db" &&
> +               p4d -jc &&
> +               # P4D automatically adds a BOM. Remove it here to make the file invalid.
> +               sed -i.bak "$ d" depot/file1,v &&
> +               printf "@$UTF16@" >>depot/file1,v &&
> +               p4d -jrF checkpoint.1
> +       )
> +'
> +
> +test_expect_success 'clone depot with invalid UTF-16 file in verbose mode' '
> +       git p4 clone --dest="$git" --verbose //depot &&
> +       test_when_finished cleanup_git &&
> +       (
> +               cd "$git" &&
> +               printf "$UTF16" >expect &&
> +               test_cmp_bin expect file1
> +       )
> +'
> +
> +test_expect_failure 'clone depot with invalid UTF-16 file in non-verbose mode' '
> +       git p4 clone --dest="$git" //depot
> +'
> +
> +test_expect_success 'kill p4d' '
> +       kill_p4d
> +'
> +
> +test_done
> --
> 2.5.1
