From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 1/2] git-p4: add test case for "Translation of file content failed" error
Date: Mon, 21 Sep 2015 11:09:31 -0700
Message-ID: <xmqqio73abl0.fsf@gitster.mtv.corp.google.com>
References: <1442829701-2347-1-git-send-email-larsxschneider@gmail.com>
	<1442829701-2347-2-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, luke@diamand.org, sunshine@sunshineco.com,
	tboegi@web.de
To: larsxschneider@gmail.com
X-From: git-owner@vger.kernel.org Mon Sep 21 20:10:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ze5XX-00058w-0N
	for gcvg-git-2@plane.gmane.org; Mon, 21 Sep 2015 20:10:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756654AbbIUSJ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Sep 2015 14:09:56 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:35329 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756677AbbIUSJd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Sep 2015 14:09:33 -0400
Received: by pacfv12 with SMTP id fv12so125488133pac.2
        for <git@vger.kernel.org>; Mon, 21 Sep 2015 11:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=boiTTVKw7S229pJNSALfaa9agqzYxZBcBIOKqsbey6w=;
        b=OC8U+01MtG/6ESCvqOkAMOS3B+Sf2rsQS0aYE+BKg+3RlD/5rrPz4m7R+GlZnpJuj7
         okCkwvpDhyADaoHBw7jpQLjmaAdrb49lWbKxOesN7vt4d1NxnZKrvjnp3587B/RJZpxx
         gUFTTanLbhLgXGJuZ/Zy7WUXqQ3/6/9E1C61zhj+8WOiHgQAAtYNDSWd4UgZYPDVNl9r
         AGhel80RhCYyV5bn2vYMkZycmG6IQXA1zf1Zh6vzzxqjobrsl/EnYZ8M/ulMKCJcqy0q
         kS7ivnVxXftVUrgBx5fNrJOXMvK/p7WPMBJxrOju+AIO90O5sDEBSJmheOdF9VUePZo2
         5k2A==
X-Received: by 10.68.183.5 with SMTP id ei5mr9573567pbc.124.1442858973394;
        Mon, 21 Sep 2015 11:09:33 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:89f8:25c:a9fe:f701])
        by smtp.gmail.com with ESMTPSA id fa1sm25751570pbb.35.2015.09.21.11.09.32
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Mon, 21 Sep 2015 11:09:32 -0700 (PDT)
In-Reply-To: <1442829701-2347-2-git-send-email-larsxschneider@gmail.com>
	(larsxschneider@gmail.com's message of "Mon, 21 Sep 2015 12:01:40
	+0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278322>

larsxschneider@gmail.com writes:

> From: Lars Schneider <larsxschneider@gmail.com>
>
> A P4 repository can get into a state where it contains a file with
> type UTF-16 that does not contain a valid UTF-16 BOM. If git-p4
> attempts to retrieve the file then the process crashes with a
> "Translation of file content failed" error.
>
> More info here: http://answers.perforce.com/articles/KB/3117
>
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> ---
>  t/t9825-git-p4-handle-utf16-without-bom.sh | 50 ++++++++++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
>  create mode 100755 t/t9825-git-p4-handle-utf16-without-bom.sh
>
> diff --git a/t/t9825-git-p4-handle-utf16-without-bom.sh
> b/t/t9825-git-p4-handle-utf16-without-bom.sh
> new file mode 100755
> index 0000000..65c3c4e
> --- /dev/null
> +++ b/t/t9825-git-p4-handle-utf16-without-bom.sh
> @@ -0,0 +1,50 @@
> +#!/bin/sh
> +
> +test_description='git p4 handling of UTF-16 files without BOM'
> +
> +. ./lib-git-p4.sh
> +
> +UTF16="\227\000\227\000"
> +
> +test_expect_success 'start p4d' '
> +	start_p4d
> +'
> +
> +test_expect_success 'init depot with UTF-16 encoded file and artificially remove BOM' '
> +	(
> +		cd "$cli" &&
> +		printf "$UTF16" >file1 &&
> +		p4 add -t utf16 file1 &&
> +		p4 submit -d "file1"
> +	) &&
> +
> +	(
> +		cd "db" &&
> +		p4d -jc &&
> +		# P4D automatically adds a BOM. Remove it here to make the file invalid.
> +		sed -e "$ d" depot/file1,v >depot/file1,v.new &&

Do you need the space between the address $ (i.e. the last line) and
operation 'd' (i.e. delete it)?  I am asking because that looks very
unusual at least in our codebase.

> +		mv -- depot/file1,v.new depot/file1,v &&
> +		printf "@$UTF16@" >>depot/file1,v &&
> +		p4d -jrF checkpoint.1
> +	)
> +'
> +
> +test_expect_failure 'clone depot with invalid UTF-16 file in verbose mode' '
> +	git p4 clone --dest="$git" --verbose //depot &&
> +	test_when_finished cleanup_git &&
> +	(
> +		cd "$git" &&
> +		printf "$UTF16" >expect &&
> +		test_cmp_bin expect file1
> +	)
> +'
> +
> +test_expect_failure 'clone depot with invalid UTF-16 file in non-verbose mode' '
> +	git p4 clone --dest="$git" //depot
> +'
> +
> +test_expect_success 'kill p4d' '
> +	kill_p4d
> +'
> +
> +test_done
