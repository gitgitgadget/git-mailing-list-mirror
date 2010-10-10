From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/5] t7607: use test_commit and test_must_fail
Date: Sun, 10 Oct 2010 01:35:27 -0500
Message-ID: <20101010063527.GC23100@burratino>
References: <7v4oepaup7.fsf@alter.siamese.dyndns.org>
 <1286632380-7002-2-git-send-email-drizzd@aon.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Sun Oct 10 08:40:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4pZl-0008UC-Cc
	for gcvg-git-2@lo.gmane.org; Sun, 10 Oct 2010 08:40:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751404Ab0JJGik (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Oct 2010 02:38:40 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:51146 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751240Ab0JJGij (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Oct 2010 02:38:39 -0400
Received: by iwn6 with SMTP id 6so2022390iwn.19
        for <git@vger.kernel.org>; Sat, 09 Oct 2010 23:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=TTuB+uFnHi1CGEbJ8WoAdB6PIlBAco9r94wfp0m+0Ts=;
        b=uYNKX7wa0CPsWhnYo4vEj4ipZfuRoUsCYDdrjsfELlzATLQf6tQRwg6GxAu5XzjgXI
         zTDiQOJGfJcv/4vBQnslxqL+vNAs98Kd8WOM4JOiQ4YhwDRhfu+1uLFcegYZ3hAHDdwR
         3H+rIx1kQsrje2R9M3p1/d/TjbPAPSYQKHnbI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=ls5HECRY/4bEYdmmBw5FLsLhs7rOADDjd02CnU6PFKu5G2+6+SvdaT7xDceoscf/Pe
         hnx4sn3NG+fY9gVs5sYcLTd0BGQIT4rcg0s9i5mM6mKPzzw3cS6e9y90TUT6tGdpIbmC
         ibJmwQa/XB5Z0FoQAevAOcQwYZmH57oTqlkPQ=
Received: by 10.42.176.72 with SMTP id bd8mr607083icb.172.1286692718466;
        Sat, 09 Oct 2010 23:38:38 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id d40sm3471811ibc.1.2010.10.09.23.38.37
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 09 Oct 2010 23:38:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1286632380-7002-2-git-send-email-drizzd@aon.at>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158648>

Clemens Buchacher wrote:

> [Subject: t7607: use test_commit and test_must_fail]
>
> Also make sure that aborted merges do not leave
> MERGE_HEAD except in the "will not overwrite
> removed file" test, where we cannot do so.

Motivation?

> See
> also the discussion in the following thread.
>
> http://mid.gmane.org/7vskopwxej.fsf@gitster.siamese.dyndns.org

That subthread is about teaching merge-recursive to write its results
to the index first without touching the worktree for robustness.  It
is not immediately obvious what that has to do with not leaving
MERGE_HEAD.  Could you summarize the relevant part for the commit
message so the reader does not have to track it down?

> --- a/t/t7607-merge-overwrite.sh
> +++ b/t/t7607-merge-overwrite.sh
> @@ -7,81 +7,73 @@ Do not overwrite changes.'
>  . ./test-lib.sh
>  
>  test_expect_success 'setup' '
> -	echo c0 > c0.c &&
> -	git add c0.c &&
> -	git commit -m c0 &&
> -	git tag c0 &&
> +	test_commit c0 &&

Behavior changes:

 . filename is c0.t instead of c0.c
 . uses test_tick for timestamp

Sounds good.

> -	echo c1 > c1.c &&
> -	git add c1.c &&
> -	git commit -m c1 &&
> -	git tag c1 &&
> +	test_commit c1 &&

Another almost-noop (good).

> -	git reset --hard c0 &&
> -	echo c2 > c2.c &&
> -	git add c2.c &&
> -	git commit -m c2 &&
> -	git tag c2 &&
> -	git reset --hard c1 &&
> -	echo "c1 a" > c1.c &&
> -	git add c1.c &&
> -	git commit -m "c1 a" &&
> -	git tag c1a &&
> +	test_commit "c1a" "c1.t" "c1 a" &&
> +	git reset --hard c0 &&
> +	test_commit c2 &&

The reader might not remember the c1.t filename.  Maybe
it would be good to be explicit in the 'test_commit c1' line:

	test_commit c1 c1.t

?  Or maybe a comment could help?

	# Commit rewriting the file from c1

>  	echo "VERY IMPORTANT CHANGES" > important
>  '
>  
>  test_expect_success 'will not overwrite untracked file' '
>  	git reset --hard c1 &&
> -	cat important > c2.c &&
> +	cp important c2.t &&
>  	test_must_fail git merge c2 &&
> -	test_cmp important c2.c
> +	! test -f .git/MERGE_HEAD &&
> +	test_cmp important c2.t
>  '

Nit: if backportability is not important, maybe

	test_path_is_missing .git/MERGE_HEAD &&

for better error messages when running tests with -v and
the file is present?

[...]
> -	cat important > c2.c &&
> -	git add c2.c &&
> -	rm c2.c &&
> +	cp important c2.t &&
> +	git add c2.t &&
> +	rm c2.t &&

These changes make for a lot of noise.  Why not specify the
filenames in the setup test to keep the .c extension?

The main change (checking that MERGE_HEAD is not present
for a merge that fails due to pre-merge checks) seems good.
Thanks.
