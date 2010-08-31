From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/2] tests: make test_must_fail more verbose
Date: Tue, 31 Aug 2010 12:10:55 -0500
Message-ID: <20100831171055.GO2315@burratino>
References: <20100831155457.GB11014@sigill.intra.peff.net>
 <20100831155636.GA11530@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jon Seymour <jon.seymour@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Aug 31 19:12:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqUO8-0002X7-A0
	for gcvg-git-2@lo.gmane.org; Tue, 31 Aug 2010 19:12:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754226Ab0HaRMn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Aug 2010 13:12:43 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:53829 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752767Ab0HaRMm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Aug 2010 13:12:42 -0400
Received: by vws3 with SMTP id 3so5562862vws.19
        for <git@vger.kernel.org>; Tue, 31 Aug 2010 10:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=soFegvQbD6sCqIalFGm7868x3WiXvG2ozxPmB/NDuEQ=;
        b=r3oFK2Xv11TwsonkWitY+qzJDW9WAbZnZfSpOZlyu4Gd27gDrLke2datztP8kbF4N2
         UUSU/WZ8xtimsfpCEu7yeI8kbcHPvx6t1lqPcMFy1ZFMjBj76WLTTrYXFoWL6N5aAHoF
         na5qlx22ji/nXWMS2RGN7jKtjxyFVQf0M03RA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=kXH5UYAGneACizz4OJIhLPYbpqFIixgqg8wvmdNwZWKLJaQe7tZtSETLOoP22GdLqD
         nIJovv47Md9I2kXr//Z3kmq9F5I4AgzXvRyiW/T9kvEl9XVcaCeTcDmLSq1uDaKej/hD
         A7oVQicMVnFkAwUHqrF8AsokRJ/SexX4o0fwE=
Received: by 10.220.123.132 with SMTP id p4mr3566251vcr.46.1283274760164;
        Tue, 31 Aug 2010 10:12:40 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id b8sm2954807vci.21.2010.08.31.10.12.38
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 31 Aug 2010 10:12:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100831155636.GA11530@sigill.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154942>

Jeff King wrote:

> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -591,7 +591,15 @@ test_path_is_missing () {
>  
>  test_must_fail () {
>  	"$@"
> -	test $? -gt 0 -a $? -le 129 -o $? -gt 192
> +	exit_code=$?
> +	if test $exit_code = 0; then
> +		echo >&2 "test_must_fail: command succeeded: $*"
> +		return 1
> +	elif test $exit_code -gt 129 -a $exit_code -le 192; then
> +		echo >&2 "test_must_fail: died by signal: $*"
> +		return 1
> +	fi
> +	return 0
>  }

Can the exit status (e.g. from a shell function) be negative?

Though your patch does not affect this, a command interrupted by a
signal will receive exit status > 192 in shells like ksh93.  Posix
says:

	As explained in other sections, certain exit status values
	have been reserved for special uses and should be used by
	applications only for those purposes:

	126
		A file to be executed was found, but it was not an
		executable utility.
	127
		A utility to be executed was not found.
	>128
		A command was interrupted by a signal.

Unfortunately that does not agree with git usage.

	129
		Incorrect command-line usage, or help requested
		(rather than SIGHUP).
	255
		Failed to create pipe for child process, fork
		failed, execvp failed, wait failed, invalid
		pathspec for add --patch, "git archive" or
		"git daemon" failure (rather than signal 127).

Here's a test_might_fail patch for consistency.

-- 8< --
Subject: tests: make test_might_fail more verbose

Let test_might_fail say something about its failures for consistency
with test_must_fail.

Cc: Jeff King <peff@peff.net>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/test-lib.sh |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 285bfd8..506787c 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -615,7 +615,12 @@ test_must_fail () {
 
 test_might_fail () {
 	"$@"
-	test $? -ge 0 -a $? -le 129 -o $? -gt 192
+	exit_code=$?
+	if test $exit_code -gt 129 -a $exit_code -le 192; then
+		echo >&2 "test_might_fail: died by signal: $*"
+		return 1
+	fi
+	return 0
 }
 
 # test_cmp is a helper function to compare actual and expected output.
-- 
1.7.2.2
