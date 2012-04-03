From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv2 1/2] fast-import: test behavior of garbage after mark
 references
Date: Tue, 3 Apr 2012 09:00:55 -0500
Message-ID: <20120403140055.GC15589@burratino>
References: <20120401225407.GA12127@padd.com>
 <1333417910-17955-1-git-send-email-pw@padd.com>
 <1333417910-17955-2-git-send-email-pw@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Dmitry Ivankov <divanorama@gmail.com>,
	David Barr <davidbarr@google.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Tue Apr 03 16:01:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SF4IO-00039j-5K
	for gcvg-git-2@plane.gmane.org; Tue, 03 Apr 2012 16:01:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754068Ab2DCOBK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Apr 2012 10:01:10 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:49451 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752209Ab2DCOBJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2012 10:01:09 -0400
Received: by obbtb18 with SMTP id tb18so3591804obb.19
        for <git@vger.kernel.org>; Tue, 03 Apr 2012 07:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=4/cqrzNeB67A1OE9Zo8crevnX5ZHfmyW23z/lYJPU5U=;
        b=VwhO60r03dpMrI3nIf+EDB8ISYw6aAvT0/7nHVU8zt32fKBo2ursBAcATJT9h4d4+H
         2dK0FgfNIsvQoJe54Ly8IJ8DfIhT7sCSFwMRGN1BXwmoEnyq+35+DwwMOKKfWeNdV+xz
         zcdMNz+jzRV0RPeGnAQVfR8cv3IUsv5n+YsilrwRICtroZ3Z+crex6xn1edXvqthvywN
         sR++S1sU4YQaHWshHnYp+9pSaFzjDFwHAl/31VS22mndhs798+zFUIMpQ4ZkwM3ifFD2
         aP8kYHGXVBaQZyn3lbCaR6RA6B7T/XJXzlUIJnrDxQyO3t1OonkmfU8ZcCFYllU/9LHQ
         p8eA==
Received: by 10.182.14.35 with SMTP id m3mr11542717obc.34.1333461668511;
        Tue, 03 Apr 2012 07:01:08 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id w4sm16867810oeg.12.2012.04.03.07.01.05
        (version=SSLv3 cipher=OTHER);
        Tue, 03 Apr 2012 07:01:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1333417910-17955-2-git-send-email-pw@padd.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194624>

Pete Wyckoff wrote:

> --- a/t/t9300-fast-import.sh
> +++ b/t/t9300-fast-import.sh
> @@ -2635,4 +2635,271 @@ test_expect_success \
>  	'n=$(grep $a verify | wc -l) &&
>  	 test 1 = $n'
>  
> +###
> +### series S
> +###
> +#
> +# Set up is roughly this.  Commits marked 1,2,3,4.  Blobs
> +# marked 100 + commit.  Notes 200 +.  Make sure missing spaces
> +# and EOLs after mark references cause errors.

Nit: "Set up" should be "Setup" when it is a noun.

[...]
> +test_expect_success 'S: add commits 1 and 2, and blob 103' '
> +	git fast-import --export-marks=marks <input
> +'

Ok, this one sets up for later ones...

> +
> +#
> +# filemodify, three datarefs
> +#
> +test_expect_failure 'S: filemodify markref no space' '

What is this testing for?  The ideal is that each test_expect_foo line
contains a proposition and the test checks whether that proposition is
true or false.  For example:

	test_expect_failure 'S: filemodify with garbage after mark errors out' '

Likewise in later tests.

> +	test_must_fail git fast-import --import-marks=marks <<-EOF 2>err &&
> +	commit refs/heads/S
> +	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
> +	data <<COMMIT
> +	commit N
> +	COMMIT
> +	M 100644 :103x hello.c
> +	EOF
> +	cat err &&
> +	grep -q "Missing space after mark" err

Is this using "grep -q" to avoid repeating the same line in the output
twice?  It seems better to use plain grep or test_i18ngrep.

I'm also worried that if someone wants to change these messages
(perhaps to make the 'm' in "Missing" lowercase or something), they
will have to change all of these tests.  If we want to be absolutely
sure that git detects the right error instead of something else, I
would suggest

	test_i18ngrep "space after mark" message

I'm also not convinced the error message is worth checking at all ---
as long as fast-import errors out, won't the frontend author be able
to look in the logs to find out the problematic line anyway?

> +'
> +
> +test_expect_failure 'S: filemodify inline no space' '
> +	test_must_fail git fast-import --import-marks=marks <<-EOF 2>err &&
> +	commit refs/heads/S
> +	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
> +	data <<COMMIT
> +	commit N
> +	COMMIT
> +	M 100644 inlineX hello.c
> +	data <<BLOB
> +	inline
> +	BLOB
> +	EOF
> +	cat err &&
> +	grep -q "Missing space after .inline." err

Does this fail because the error message is "Missing space after SHA1"
instead?  I'm not sure that's actually a bug, unless we want to
correctly nitpick that the keyword "inline" that is a stand-in for an
object name is not itself one.

I don't think the tests for exact error messages make too much sense
without the next patch, so I would suggest leaving them out if this
patch is supposed to be applicable on its own.

Thanks for some thorough tests.

Hope that helps,
Jonathan
