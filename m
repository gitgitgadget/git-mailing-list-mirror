From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6] git-p4: Obey core.ignorecase when using P4 client specs.
Date: Wed, 26 Aug 2015 13:05:36 -0700
Message-ID: <xmqqa8td3je7.fsf@gitster.dls.corp.google.com>
References: <1440605295-73844-1-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: larsxschneider@gmail.com
X-From: git-owner@vger.kernel.org Wed Aug 26 22:05:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUgx5-00027L-Lj
	for gcvg-git-2@plane.gmane.org; Wed, 26 Aug 2015 22:05:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756606AbbHZUFj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Aug 2015 16:05:39 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:33032 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756560AbbHZUFi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Aug 2015 16:05:38 -0400
Received: by pacti10 with SMTP id ti10so98352631pac.0
        for <git@vger.kernel.org>; Wed, 26 Aug 2015 13:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=Eb0y6HWmOfOoRsokZ7rRaZmaIl8ExovSxP87P1putOM=;
        b=XcHEu3JeNu9zcEpcaFFzH6KRq2Khh33igJ7m6TDJNyrIcwtG2HLWguAVOrSAMglcT1
         Cdk5FVOiB55gLq7pI4Tm56uV1lB36uhfi1ECemsQTUAnvzKqlBabio+54MuQ0rRN3bQx
         YX2jxTWEGe2HJwJTHzgl2xwRWBu3ePL6624itl5xfknlC+yzZ+QkJPGmIismtLp7C4Bx
         J2ID9rMou81415f7JrPnqRhF/dRy5Lb5hsfg4mVc/8vIQM3ofVqSMKKtIORvALPPGTyc
         q8dmJZH0ylH6BJLNqAzuryPL3tgYesCaEzUbQPCJymspiEZKGB/uYBBnPZRvmtQ6UG3H
         0S6A==
X-Received: by 10.67.22.99 with SMTP id hr3mr428501pad.41.1440619537704;
        Wed, 26 Aug 2015 13:05:37 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:ac9b:ef8c:b4db:d257])
        by smtp.gmail.com with ESMTPSA id l4sm10825623pde.31.2015.08.26.13.05.37
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Wed, 26 Aug 2015 13:05:37 -0700 (PDT)
In-Reply-To: <1440605295-73844-1-git-send-email-larsxschneider@gmail.com>
	(larsxschneider@gmail.com's message of "Wed, 26 Aug 2015 18:08:15
	+0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276633>

larsxschneider@gmail.com writes:

> From: Lars Schneider <larsxschneider@gmail.com>
>
> We run P4 servers on Linux and P4 clients on Windows. For an unknown
> reason the file path for a number of files in P4 does not match the
> directory path with respect to case sensitivity.

Thanks, but is this still "For an unknown reason", or during the
course of debugging you found the root cause, which is what led to
this fix?

>
> E.g. "p4 files" might return
> //depot/path/to/file1
> //depot/pATH/to/file2
>
> If you use P4/P4V then these files end up in the same directory, e.g.
> //depot/path/to/file1
> //depot/path/to/file2
>
> If you use git-p4 and clone the code via client spec "//depot/path/..."
> then all files not matching the case in the client spec will be ignored
> (in the example above "file2"). This is correct if core.ignorecase=false
> but not otherwise.

This sentence is hard to grok.  What are you describing?  Solution?
Current problematic behaviour?  Desired behaviour that the patch
attempts to obtain?

If I paraphrase it like this, did I understood you correctly?

    The current code always ignores paths in wrong case that do not
    match client spec.  It is correct to ignore them when
    core.ignorecase is not set; //depot/path/ and //depot/pATH/ are
    different things in that case.

    But it is a wrong thing to do if core.ignorecase is set to true.
    Let's make sure we avoid it by downcasing the depot_path when
    core.ignorecase is set to true.



>
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> Acked-by: Luke Diamand <luke@diamand.org>
> ---
>  git-p4.py                         |   7 ++
>  t/t9821-git-p4-path-variations.sh | 200 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 207 insertions(+)
>  create mode 100755 t/t9821-git-p4-path-variations.sh
>
> diff --git a/git-p4.py b/git-p4.py
> index 073f87b..0093fa3 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -1950,10 +1950,14 @@ class View(object):
>              if "unmap" in res:
>                  # it will list all of them, but only one not unmap-ped
>                  continue
> +            if gitConfigBool("core.ignorecase"):
> +                res['depotFile'] = res['depotFile'].lower()
>              self.client_spec_path_cache[res['depotFile']] = self.convert_client_path(res["clientFile"])
>  
>          # not found files or unmap files set to ""
>          for depotFile in fileArgs:
> +            if gitConfigBool("core.ignorecase"):
> +                depotFile = depotFile.lower()
>              if depotFile not in self.client_spec_path_cache:
>                  self.client_spec_path_cache[depotFile] = ""
>  
> @@ -1962,6 +1966,9 @@ class View(object):
>             depot file should live.  Returns "" if the file should
>             not be mapped in the client."""
>  
> +        if gitConfigBool("core.ignorecase"):
> +            depot_path = depot_path.lower()
> +
>          if depot_path in self.client_spec_path_cache:
>              return self.client_spec_path_cache[depot_path]
>  
> diff --git a/t/t9821-git-p4-path-variations.sh b/t/t9821-git-p4-path-variations.sh
> new file mode 100755
> index 0000000..599d16c
> --- /dev/null
> +++ b/t/t9821-git-p4-path-variations.sh
> @@ -0,0 +1,200 @@
> +#!/bin/sh
> +
> +test_description='Clone repositories with path case variations'
> +
> +. ./lib-git-p4.sh
> +
> +test_expect_success 'start p4d with case folding enabled' '
> +	start_p4d -C1
> +'
> +
> +test_expect_success 'Create a repo with path case variations' '
> +	client_view "//depot/... //client/..." &&
> +	(
> +		cd "$cli" &&
> +
> +		mkdir -p One/two &&
> +		>One/two/File2.txt &&
> +		p4 add One/two/File2.txt &&
> +		p4 submit -d "Add file2" &&
> +		rm -rf One &&
> +
> +		mkdir -p one/TWO &&
> +		>one/TWO/file1.txt &&
> +		p4 add one/TWO/file1.txt &&
> +		p4 submit -d "Add file1" &&
> +		rm -rf one &&
> +
> +		mkdir -p one/two &&
> +		>one/two/file3.txt &&
> +		p4 add one/two/file3.txt &&
> +		p4 submit -d "Add file3" &&
> +		rm -rf one &&
> +
> +		mkdir -p outside-spec &&
> +		>outside-spec/file4.txt &&
> +		p4 add outside-spec/file4.txt &&
> +		p4 submit -d "Add file4" &&
> +		rm -rf outside-spec
> +	)
> +'
> +
> +test_expect_success 'Clone root' '
> +	client_view "//depot/... //client/..." &&
> +	test_when_finished cleanup_git &&
> +	(
> +		cd "$git" &&
> +		git init . &&
> +		git config core.ignorecase false &&
> +		git p4 clone --use-client-spec --destination="$git" //depot &&
> +		# This method is used instead of "test -f" to ensure the case is
> +		# checked even if the test is executed on case-insensitive file systems.
> +		# All files are there as expected although the path cases look random.
> +		cat >expect <<-\EOF &&
> +		One/two/File2.txt
> +		one/TWO/file1.txt
> +		one/two/file3.txt
> +		outside-spec/file4.txt
> +		EOF
> +		git ls-files >actual &&
> +		test_cmp expect actual
> +	)
> +'
> +
> +test_expect_success 'Clone root (ignorecase)' '
> +	client_view "//depot/... //client/..." &&
> +	test_when_finished cleanup_git &&
> +	(
> +		cd "$git" &&
> +		git init . &&
> +		git config core.ignorecase true &&
> +		git p4 clone --use-client-spec --destination="$git" //depot &&
> +		# This method is used instead of "test -f" to ensure the case is
> +		# checked even if the test is executed on case-insensitive file systems.
> +		# All files are there as expected although the path cases look random.
> +		cat >expect <<-\EOF &&
> +		one/TWO/File2.txt
> +		one/TWO/file1.txt
> +		one/TWO/file3.txt
> +		outside-spec/file4.txt
> +		EOF
> +		git ls-files >actual &&
> +		test_cmp expect actual
> +	)
> +'
> +
> +test_expect_success 'Clone root and ignore one file' '
> +	client_view \
> +		"//depot/... //client/..." \
> +		"-//depot/one/TWO/file1.txt //client/one/TWO/file1.txt" &&
> +	test_when_finished cleanup_git &&
> +	(
> +		cd "$git" &&
> +		git init . &&
> +		git config core.ignorecase false &&
> +		git p4 clone --use-client-spec --destination="$git" //depot &&
> +		# We ignore one file in the client spec and all path cases change from
> +		# "TWO" to "two"!
> +		cat >expect <<-\EOF &&
> +		One/two/File2.txt
> +		one/two/file3.txt
> +		outside-spec/file4.txt
> +		EOF
> +		git ls-files >actual &&
> +		test_cmp expect actual
> +	)
> +'
> +
> +test_expect_success 'Clone root and ignore one file (ignorecase)' '
> +	client_view \
> +		"//depot/... //client/..." \
> +		"-//depot/one/TWO/file1.txt //client/one/TWO/file1.txt" &&
> +	test_when_finished cleanup_git &&
> +	(
> +		cd "$git" &&
> +		git init . &&
> +		git config core.ignorecase true &&
> +		git p4 clone --use-client-spec --destination="$git" //depot &&
> +		# We ignore one file in the client spec and all path cases change from
> +		# "TWO" to "two"!
> +		cat >expect <<-\EOF &&
> +		One/two/File2.txt
> +		One/two/file3.txt
> +		outside-spec/file4.txt
> +		EOF
> +		git ls-files >actual &&
> +		test_cmp expect actual
> +	)
> +'
> +
> +test_expect_success 'Clone path' '
> +	client_view "//depot/One/... //client/..." &&
> +	test_when_finished cleanup_git &&
> +	(
> +		cd "$git" &&
> +		git init . &&
> +		git config core.ignorecase false &&
> +		git p4 clone --use-client-spec --destination="$git" //depot &&
> +		cat >expect <<-\EOF &&
> +		two/File2.txt
> +		EOF
> +		git ls-files >actual &&
> +		test_cmp expect actual
> +	)
> +'
> +
> +test_expect_success 'Clone path (ignorecase)' '
> +	client_view "//depot/One/... //client/..." &&
> +	test_when_finished cleanup_git &&
> +	(
> +		cd "$git" &&
> +		git init . &&
> +		git config core.ignorecase true &&
> +		git p4 clone --use-client-spec --destination="$git" //depot &&
> +		cat >expect <<-\EOF &&
> +		TWO/File2.txt
> +		TWO/file1.txt
> +		TWO/file3.txt
> +		EOF
> +		git ls-files >actual &&
> +		test_cmp expect actual
> +	)
> +'
> +
> +# It looks like P4 determines the path case based on the first file in
> +# lexicographical order. Please note the lower case "two" directory for all
> +# files triggered through the addition of "File0.txt".
> +test_expect_success 'Add a new file and clone path with new file (ignorecase)' '
> +	client_view "//depot/... //client/..." &&
> +	(
> +		cd "$cli" &&
> +		mkdir -p One/two &&
> +		>One/two/File0.txt &&
> +		p4 add One/two/File0.txt &&
> +		p4 submit -d "Add file" &&
> +		rm -rf One
> +	) &&
> +
> +	client_view "//depot/One/... //client/..." &&
> +	test_when_finished cleanup_git &&
> +	(
> +		cd "$git" &&
> +		git init . &&
> +		git config core.ignorecase true &&
> +		git p4 clone --use-client-spec --destination="$git" //depot &&
> +		cat >expect <<-\EOF &&
> +		two/File0.txt
> +		two/File2.txt
> +		two/file1.txt
> +		two/file3.txt
> +		EOF
> +		git ls-files >actual &&
> +		test_cmp expect actual
> +	)
> +'
> +
> +test_expect_success 'kill p4d' '
> +	kill_p4d
> +'
> +
> +test_done
