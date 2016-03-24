From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH v9 2/3] t7507-commit-verbose: make test suite use write_script
Date: Thu, 24 Mar 2016 12:00:59 +0100
Message-ID: <1458817259-11675-1-git-send-email-szeder@ira.uka.de>
References: <01020153a7ba4eae-9b88e119-0505-418f-a137-595250edaa9d-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 24 12:01:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aj317-0003i0-W0
	for gcvg-git-2@plane.gmane.org; Thu, 24 Mar 2016 12:01:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756850AbcCXLBY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2016 07:01:24 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:53955 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755246AbcCXLBX (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Mar 2016 07:01:23 -0400
Received: from x4db26f6f.dyn.telefonica.de ([77.178.111.111] helo=localhost.localdomain)
	by iramx2.ira.uni-karlsruhe.de with esmtpsa port 587 
	iface 141.3.10.81 id 1aj30t-0001aZ-11; Thu, 24 Mar 2016 12:01:20 +0100
X-Mailer: git-send-email 2.8.0.rc3.58.gc805582
In-Reply-To: <01020153a7ba4eae-9b88e119-0505-418f-a137-595250edaa9d-000000@eu-west-1.amazonses.com>
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1458817280.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289736>

> Also remove test_set_editor from global scope and use it in whichever
> test it is required.

Why?

test_set_editor sets and exports shell variables.  Since you don't
invoke test_set_editor in a subshell, after the first invocation the
editor will be part of the global scope anyway.

Also missing signoff.

> ---
>  t/t7507-commit-verbose.sh | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/t/t7507-commit-verbose.sh b/t/t7507-commit-verbose.sh
> index 2ddf28c..cf95efb 100755
> --- a/t/t7507-commit-verbose.sh
> +++ b/t/t7507-commit-verbose.sh
> @@ -3,12 +3,11 @@
>  test_description='verbose commit template'
>  . ./test-lib.sh
>  
> -cat >check-for-diff <<EOF
> -#!$SHELL_PATH
> -exec grep '^diff --git' "\$1"
> +write_script "check-for-diff" <<-\EOF &&
> +grep '^diff --git' "$1" >out &&
> +test $(wc -l <out) = 1

Our test lib offers the test_line_count helper function, which
outputs a helpful error message in case the number of lines do not
match.

The original didn't check the number of lines.  This change is not
mentioned at all in the commit message.

>  EOF
>  chmod +x check-for-diff
> -test_set_editor "$PWD/check-for-diff"
>  
>  cat >message <<'EOF'
>  subject
> @@ -23,6 +22,7 @@ test_expect_success 'setup' '
>  '
>  
>  test_expect_success 'initial commit shows verbose diff' '
> +	test_set_editor "$PWD/check-for-diff" &&
>  	git commit --amend -v
>  '
>  
> @@ -38,11 +38,13 @@ check_message() {
>  }
>  
>  test_expect_success 'verbose diff is stripped out' '
> +	test_set_editor "$PWD/check-for-diff" &&
>  	git commit --amend -v &&
>  	check_message message
>  '
>  
>  test_expect_success 'verbose diff is stripped out (mnemonicprefix)' '
> +	test_set_editor "$PWD/check-for-diff" &&
>  	git config diff.mnemonicprefix true &&
>  	git commit --amend -v &&
>  	check_message message
> @@ -66,11 +68,13 @@ test_expect_success 'diff in message is retained without -v' '
>  '
>  
>  test_expect_success 'diff in message is retained with -v' '
> +	test_set_editor "$PWD/check-for-diff" &&
>  	git commit --amend -F diff -v &&
>  	check_message diff
>  '
>  
>  test_expect_success 'submodule log is stripped out too with -v' '
> +	test_set_editor "$PWD/check-for-diff" &&
>  	git config diff.submodule log &&
>  	git submodule add ./. sub &&
>  	git commit -m "sub added" &&
> 
> --
> https://github.com/git/git/pull/218
> 
