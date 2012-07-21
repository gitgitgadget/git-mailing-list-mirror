From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC/PATCH] t3300-*.sh: Fix a TAP parse error
Date: Sat, 21 Jul 2012 13:20:49 -0500
Message-ID: <20120721182049.GL19860@burratino>
References: <500AEB11.4050006@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Sat Jul 21 20:21:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SseIb-00033d-BL
	for gcvg-git-2@plane.gmane.org; Sat, 21 Jul 2012 20:21:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751480Ab2GUSU7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 Jul 2012 14:20:59 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:44945 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750969Ab2GUSU7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Jul 2012 14:20:59 -0400
Received: by yenl2 with SMTP id l2so4753451yen.19
        for <git@vger.kernel.org>; Sat, 21 Jul 2012 11:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=HnEL7/fv6FdiYPn+LtwVnJJIxrVPuu2CwS6T4WBzodM=;
        b=zqYArfZnMb/EerJ2GprTin1ZAdWbFOf72vc60Z74FIQqOLjTWH1D1yQOERaDgKDS6J
         +uxYml+Ftl79CFFP28AtnB1KJnfVxUK3+53nWNQJvH9BacTX4Q3NzTLS2WhQkeavR11z
         nnsG2K4LHEoiXvgkx9qSbsaMhu0Uj0PH0DOOG+w3e+zLyrK7HQnAPov0aJq95YifOzaa
         GHNwNZjpR5MVf50F9VHNOpasti5Q954/gC4fgvbKcsa+QIsqjGpUuX/VSc8LRfIw6N9o
         V9LoLbzO3ezHtIrPE1ZXzi8d3OKqyfbw3ogUZFzPeR7xGKbCorlFfJVQHI22XnF+4PFc
         OLCg==
Received: by 10.50.15.202 with SMTP id z10mr7012292igc.67.1342894858445;
        Sat, 21 Jul 2012 11:20:58 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id z3sm1891571igc.7.2012.07.21.11.20.57
        (version=SSLv3 cipher=OTHER);
        Sat, 21 Jul 2012 11:20:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <500AEB11.4050006@ramsay1.demon.co.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201829>

(cc-ing =C3=86var, TAP wizard)
Hi,

Ramsay Jones wrote:

>     $ ./t3300-funny-names.sh
>     ok 1 - setup
>     # passed all 1 test(s)
>     1..1 # SKIP Your filesystem does not allow tabs in filenames
>     $
>
> Unfortunately, this is not valid TAP output, which prove notes
> as follows:
[...]
>       Parse errors: No plan found in TAP output
[...]
> This is an RFC because I suspect some people may prefer the much
> simpler patch:
[...]
>      	# since FAT/NTFS does not allow tabs in filenames, skip this te=
st
>     -	skip_all=3D'Your filesystem does not allow tabs in filenames'
>     +	say '# SKIP Your filesystem does not allow tabs in filenames'
>      	test_done
[...]
> ... the output of which looks like:
[...]
>     ok 1 - setup
>     # SKIP Your filesystem does not allow tabs in filenames
>     # passed all 1 test(s)
>     1..1
[..]
> Needless to say, I much prefer the patch below. :-D

Thanks for a nice explanation.  In general I definitely like getting
rid of these setup tests when possible.  Let's see:

[...]
> --- a/t/t3300-funny-names.sh
> +++ b/t/t3300-funny-names.sh
> @@ -15,28 +15,20 @@ p0=3D'no-funny'
>  p1=3D'tabs	," (dq) and spaces'
>  p2=3D'just space'
> =20
> -test_expect_success 'setup' '
> -	cat >"$p0" <<-\EOF &&
> -	1. A quick brown fox jumps over the lazy cat, oops dog.
> -	2. A quick brown fox jumps over the lazy cat, oops dog.
> -	3. A quick brown fox jumps over the lazy cat, oops dog.
> -	EOF
> +cat >"$p0" <<\EOF
> +1. A quick brown fox jumps over the lazy cat, oops dog.
> +2. A quick brown fox jumps over the lazy cat, oops dog.
> +3. A quick brown fox jumps over the lazy cat, oops dog.
> +EOF

The problem is that on platforms not supporting funny filenames, it
will write a complaint to stderr and because the code is not guarded
by test_expect_success, that output goes to the terminal.  So I think
this is a wrong approach.

Would it make sense to avoid the "# SKIP" comment when a test has
been run, like this?

diff --git i/t/test-lib.sh w/t/test-lib.sh
index acda33d1..038f6e9f 100644
--- i/t/test-lib.sh
+++ w/t/test-lib.sh
@@ -354,6 +354,11 @@ test_done () {
 	case "$test_failure" in
 	0)
 		# Maybe print SKIP message
+		if test -n "$skip_all" && test "$test_count" !=3D 0
+		then
+			say "# SKIP $skill_all"
+			skip_all=3D
+		fi
 		[ -z "$skip_all" ] || skip_all=3D" # SKIP $skip_all"
=20
 		if test $test_external_has_tap -eq 0; then
