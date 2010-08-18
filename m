From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC/PATCH] Add test case for dealing with a tracked file in an ignored directory
Date: Wed, 18 Aug 2010 11:50:05 +0200
Message-ID: <vpq8w44mer6.fsf@bauges.imag.fr>
References: <AANLkTiky+azVAnXEBFWR1q9_8NH8TX2TfuonXCpA_-ms@mail.gmail.com>
	<1282123788-24055-1-git-send-email-gdb@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: avarab@gmail.com, git@vger.kernel.org, gitster@pobox.com,
	Jens.Lehmann@web.de, jrnieder@gmail.com
To: Greg Brockman <gdb@MIT.EDU>
X-From: git-owner@vger.kernel.org Wed Aug 18 11:53:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlfKx-0004Nx-Qy
	for gcvg-git-2@lo.gmane.org; Wed, 18 Aug 2010 11:53:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751820Ab0HRJxb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Aug 2010 05:53:31 -0400
Received: from imag.imag.fr ([129.88.30.1]:42525 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750974Ab0HRJx3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Aug 2010 05:53:29 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id o7I9o5wm016673
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 18 Aug 2010 11:50:05 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1OlfHZ-0003iI-JQ; Wed, 18 Aug 2010 11:50:05 +0200
In-Reply-To: <1282123788-24055-1-git-send-email-gdb@mit.edu> (Greg Brockman's message of "Wed\, 18 Aug 2010 04\:29\:48 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Wed, 18 Aug 2010 11:50:06 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153825>

Greg Brockman <gdb@MIT.EDU> writes:

> This test case attempts to match the behavior of 'git add ignore-file'
> with 'git add ignore-dir/file' when .gitignore contains entries for
> ignore-file and ignore-dir.

Good :-).

> +test_expect_success 'git add with file in ignored directory' '

In the final version, you can make the tests test_expect_failure in
the first patch, and turn them back into test_expect_success in the
second (which fixes the issue). This makes it clear what your change
to the code do, and makes sure the test suite passes for each commit.

> +	mkdir ignored-dir &&
> +	echo ignored-dir >> .gitignore &&
> +	touch ignored-dir/file &&

I think >ignored-dir/file is more portable than touch, and is
recommanded in the testsuite. But a quick grep shows that touch is
already used.

> +	test_must_fail git add ignored-dir/file >actual 2>&1 &&
> +	test_cmp actual expect &&
> +	git add -f ignored-dir/file &&
> +	git add ignored-dir/file &&

(so, this is the first thing you're fixing, shouldn't be
controversial)

> +test_expect_success 'git add with ignored directory using git globs' "
> +	mkdir ignored-dir2 && echo ignored-dir2 >> .gitignore && touch ignored-dir2/file &&
> +	git add 'ignored-dir2/*' >actual 2>&1 &&
> +	echo \"fatal: pathspec 'ignored-dir2/*' did not match any files\" | test_cmp - actual

Currently, "git add 'dir/*'" will add the files under dir/ if dir/
isn't ignored, and require -f if dir is ignored.

I don't think you want to complain with "did not match any files"
here.

> +	git add -f ignored-dir2/file && echo change > ignored-dir2/file &&
> +	git add 'ignored-dir2/*' >actual 2>&1 &&

Just making sure I'm reading correctly: this is the second thing that
should be fixed, and that your earlier patch didn't.

You're not testing the case

  git add ignored-dir/

which gives another case where Git tries to add files not explicitely
given on the command-line. But the correct behavior of this case may
be more controversial, so maybe it's indeed better to focus on the
other cases.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
