From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v4 2/4] Add testcases for the --detect-dir-renames
 diffcore flag.
Date: Mon, 4 Oct 2010 17:09:23 -0500
Message-ID: <20101004220923.GA9491@burratino>
References: <1286138529-6780-1-git-send-email-ydirson@altern.org>
 <1286138529-6780-2-git-send-email-ydirson@altern.org>
 <1286138529-6780-3-git-send-email-ydirson@altern.org>
 <20101004203241.GF6466@burratino>
 <20101004213703.GW4983@home.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Yann Dirson <ydirson@free.fr>
X-From: git-owner@vger.kernel.org Tue Oct 05 00:12:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2tH8-0005Qk-2z
	for gcvg-git-2@lo.gmane.org; Tue, 05 Oct 2010 00:12:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755295Ab0JDWMp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Oct 2010 18:12:45 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:45460 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755246Ab0JDWMo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Oct 2010 18:12:44 -0400
Received: by wwj40 with SMTP id 40so4791639wwj.1
        for <git@vger.kernel.org>; Mon, 04 Oct 2010 15:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=o1SioYBxIp7xTR8KWnmZeuT9n+VDRsXbo/UtY/7afVI=;
        b=DK5CUBRxl6cunDs0tQ8btLcSfMky1xU0wYALghh49dabccNLedmui+wnfcDPw4c9Fr
         eZeqPslkIElTMkMaboKwlopbL3ZrXQJkcQIVh+mgO8rBh4r8IVKNtDV12okLzQ2lHrz5
         f5lxd/8/M6lkvPkbGnHtN+73UvQIJ/Mqiivnc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=XZGrUZgyu7ySGfH+4bF2Ej0q0V8WLR6kC4rNHtG87Ux6i2rAHJVcHljiAUko9FPmvT
         YHlgC1+e8icdNkrTWisIibJPMuug+fiiYl/pR6kHn8g4Nul/3tAiLIW/nnqInMX03qIg
         APBIIa6wD7aR4H1x6Rl8XCBo7k/cZSk6FTdSQ=
Received: by 10.227.146.4 with SMTP id f4mr9049593wbv.14.1286230363136;
        Mon, 04 Oct 2010 15:12:43 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id r18sm3374191weo.24.2010.10.04.15.12.41
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 04 Oct 2010 15:12:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101004213703.GW4983@home.lan>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158128>

Yann Dirson wrote:
> On Mon, Oct 04, 2010 at 03:32:41PM -0500, Jonathan Nieder wrote:

>> It might make sense to compute the tree, commit, etc one at a time
>> instead of this long one-liner.
>
> If moved into a function which would make it readable, yes.

Something like

	commit_index () {
		test_tick &&
		tree=$(git write-tree) &&
		commit=$(
			printf "%s\n" "$*" |
			git commit-tree $tree
		) &&
		git update-ref HEAD $commit
	}

? Maybe the following (similar to what you use in later tests)
would be even better, for more verbose output when running with -v.

	commit_index () {
		test_tick &&
		git commit -m "$*"
	}

>> 	printf "Line %s\n" 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 >a/path0 &&
>> 	...
>
> Well, when seeing for the first time such a construct, i tend to
> wonder how portable it is amont printf implementations.

Yes, it's portable.

>> Nit: although compare_diff_patch ensures the result is not dependent
>> on the hash function, these hard-coded hashes are still hard for a
>> human to read.  Could they be computed instead?
>
> Well, that would just make the test harder to read imho.  Using
> regexps would help for readability

If you had said "writability" I would agree with you here.  And that's
an important concern, too.

What I was suggesting looks like this:

	path0_id2=$(git rev-parse :b/path0) &&
	path100_id=$(git rev-parse :b/path100) &&
	cat >expected <<-EOF &&
	:040000 040000 $zeroes $zeroes R100	a/	b/
	:100644 000000 $path3_id $zeroes D	a/path3
	:100644 100644 $path2_id $path2_id R100	a/path2	b/2path
	:100644 100644 $path0_id $path0_id2 R093	a/path0	b/path0
	:100644 100644 $path1_id $path1_id R100	a/path1	b/path1
	:000000 100644 $zeroes $path100_id A	b/path100
	EOF
	...

Maybe it would be better to do

	cat >expected <<-\EOF &&
	:040000 040000 X X R100	a/	b/
	:100644 000000 X X D	a/path3
	:100644 100644 X X R100	a/path2	b/2path
	:100644 100644 X X R093	a/path0	b/path0
	:100644 100644 X X R100	a/path1	b/path1
	:000000 100644 X X A	b/path100
	EOF

since the hashes are not being checked, anyway.
