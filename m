From: greened@obbligato.org (David A. Greene)
Subject: Re: [PATCH 1/7] contrib/subtree: Clean and refactor test code
Date: Tue, 10 Nov 2015 20:52:39 -0600
Message-ID: <87egfx1c3s.fsf@waller.obbligato.org>
References: <1446780903-22156-1-git-send-email-greened@obbligato.org>
	<1446780903-22156-2-git-send-email-greened@obbligato.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: techlivezheng@gmail.com, alex.crezoff@gmail.com, davvid@gmail.com,
	cbailey32@bloomberg.net, danny0838@gmail.com, prohaska@zib.de,
	th.acker@arcor.de, sschuberth@gmail.com, peff@peff.net,
	gitter.spiros@gmail.com, nod.helm@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 11 03:53:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZwLXV-0003vO-Ce
	for gcvg-git-2@plane.gmane.org; Wed, 11 Nov 2015 03:53:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752165AbbKKCxZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Nov 2015 21:53:25 -0500
Received: from li209-253.members.linode.com ([173.255.199.253]:55994 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752156AbbKKCwz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Nov 2015 21:52:55 -0500
Received: from chippewa-nat.cray.com ([136.162.34.1] helo=waller.obbligato.org)
	by johnson.obbligato.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
	(Exim 4.85)
	(envelope-from <greened@obbligato.org>)
	id 1ZwLXJ-0007fj-2K; Tue, 10 Nov 2015 20:53:25 -0600
In-Reply-To: <1446780903-22156-2-git-send-email-greened@obbligato.org> (David
	Greene's message of "Thu, 5 Nov 2015 21:34:57 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
X-Filter-Spam-Score: ()
X-Filter-Spam-Report: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281149>

David Greene <greened@obbligato.org> writes:

Just a ping to ask if anyone has looked at this.  Apparently send-email
uses the commit author as the From address.  These messages are actually
from me, sent on behalf of the commit authors.

I've got more coming, but want to get these in first as they clean up
the testsuite and will make adding future changes easier.

                      -David

> From: Techlive Zheng <techlivezheng@gmail.com>
>
> Mostly prepare for the later tests refactoring.  This moves some
> common code to helper functions and generally cleans things up to be
> more presentable.
>
> Signed-off-by: Techlive Zheng <techlivezheng@gmail.com>
> Signed-off-by: David A. Greene <greened@obbligato.org>
> ---
>  contrib/subtree/t/Makefile         |  31 ++++++++---
>  contrib/subtree/t/t7900-subtree.sh | 103 ++++++++++++++++++++-----------------
>  2 files changed, 79 insertions(+), 55 deletions(-)
>
> diff --git a/contrib/subtree/t/Makefile b/contrib/subtree/t/Makefile
> index c864810..276898e 100644
> --- a/contrib/subtree/t/Makefile
> +++ b/contrib/subtree/t/Makefile
> @@ -13,11 +13,23 @@ TAR ?= $(TAR)
>  RM ?= rm -f
>  PROVE ?= prove
>  DEFAULT_TEST_TARGET ?= test
> +TEST_LINT ?= test-lint
> +
> +ifdef TEST_OUTPUT_DIRECTORY
> +TEST_RESULTS_DIRECTORY = $(TEST_OUTPUT_DIRECTORY)/test-results
> +else
> +TEST_RESULTS_DIRECTORY = ../../../t/test-results
> +endif
>  
>  # Shell quote;
>  SHELL_PATH_SQ = $(subst ','\'',$(SHELL_PATH))
> +PERL_PATH_SQ = $(subst ','\'',$(PERL_PATH))
> +TEST_RESULTS_DIRECTORY_SQ = $(subst ','\'',$(TEST_RESULTS_DIRECTORY))
>  
> -T = $(wildcard t[0-9][0-9][0-9][0-9]-*.sh)
> +T = $(sort $(wildcard t[0-9][0-9][0-9][0-9]-*.sh))
> +TSVN = $(sort $(wildcard t91[0-9][0-9]-*.sh))
> +TGITWEB = $(sort $(wildcard t95[0-9][0-9]-*.sh))
> +THELPERS = $(sort $(filter-out $(T),$(wildcard *.sh)))
>  
>  all: $(DEFAULT_TEST_TARGET)
>  
> @@ -26,20 +38,22 @@ test: pre-clean $(TEST_LINT)
>  
>  prove: pre-clean $(TEST_LINT)
>  	@echo "*** prove ***"; GIT_CONFIG=.git/config $(PROVE) --exec '$(SHELL_PATH_SQ)' $(GIT_PROVE_OPTS) $(T) :: $(GIT_TEST_OPTS)
> -	$(MAKE) clean
> +	$(MAKE) clean-except-prove-cache
>  
>  $(T):
>  	@echo "*** $@ ***"; GIT_CONFIG=.git/config '$(SHELL_PATH_SQ)' $@ $(GIT_TEST_OPTS)
>  
>  pre-clean:
> -	$(RM) -r test-results
> +	$(RM) -r '$(TEST_RESULTS_DIRECTORY_SQ)'
>  
> -clean:
> -	$(RM) -r 'trash directory'.* test-results
> +clean-except-prove-cache:
> +	$(RM) -r 'trash directory'.* '$(TEST_RESULTS_DIRECTORY_SQ)'
>  	$(RM) -r valgrind/bin
> +
> +clean: clean-except-prove-cache
>  	$(RM) .prove
>  
> -test-lint: test-lint-duplicates test-lint-executable
> +test-lint: test-lint-duplicates test-lint-executable test-lint-shell-syntax
>  
>  test-lint-duplicates:
>  	@dups=`echo $(T) | tr ' ' '\n' | sed 's/-.*//' | sort | uniq -d` && \
> @@ -51,12 +65,15 @@ test-lint-executable:
>  		test -z "$$bad" || { \
>  		echo >&2 "non-executable tests:" $$bad; exit 1; }
>  
> +test-lint-shell-syntax:
> +	@'$(PERL_PATH_SQ)' ../../../t/check-non-portable-shell.pl $(T) $(THELPERS)
> +
>  aggregate-results-and-cleanup: $(T)
>  	$(MAKE) aggregate-results
>  	$(MAKE) clean
>  
>  aggregate-results:
> -	for f in ../../../t/test-results/t*-*.counts; do \
> +	for f in '$(TEST_RESULTS_DIRECTORY_SQ)'/t*-*.counts; do \
>  		echo "$$f"; \
>  	done | '$(SHELL_PATH_SQ)' ../../../t/aggregate-results.sh
>  
> diff --git a/contrib/subtree/t/t7900-subtree.sh b/contrib/subtree/t/t7900-subtree.sh
> index dfbe443..f9dda3d 100755
> --- a/contrib/subtree/t/t7900-subtree.sh
> +++ b/contrib/subtree/t/t7900-subtree.sh
> @@ -5,7 +5,7 @@
>  #
>  test_description='Basic porcelain support for subtrees
>  
> -This test verifies the basic operation of the merge, pull, add
> +This test verifies the basic operation of the add, pull, merge
>  and split subcommands of git subtree.
>  '
>  
> @@ -20,7 +20,6 @@ create()
>  	git add "$1"
>  }
>  
> -
>  check_equal()
>  {
>  	test_debug 'echo'
> @@ -38,6 +37,30 @@ undo()
>  	git reset --hard HEAD~
>  }
>  
> +# Make sure no patch changes more than one file.
> +# The original set of commits changed only one file each.
> +# A multi-file change would imply that we pruned commits
> +# too aggressively.
> +join_commits()
> +{
> +	commit=
> +	all=
> +	while read x y; do
> +		if [ -z "$x" ]; then
> +			continue
> +		elif [ "$x" = "commit:" ]; then
> +			if [ -n "$commit" ]; then
> +				echo "$commit $all"
> +				all=
> +			fi
> +			commit="$y"
> +		else
> +			all="$all $y"
> +		fi
> +	done
> +	echo "$commit $all"
> +}
> +
>  last_commit_message()
>  {
>  	git log --pretty=format:%s -1
> @@ -123,9 +146,11 @@ test_expect_success 'add subproj to mainline' '
>  	check_equal ''"$(last_commit_message)"'' "Add '"'sub dir/'"' from commit '"'"'''"$(git rev-parse sub1)"'''"'"'"
>  '
>  
> -# this shouldn't actually do anything, since FETCH_HEAD is already a parent
> -test_expect_success 'merge fetched subproj' '
> -	git merge -m "merge -s -ours" -s ours FETCH_HEAD
> +test_expect_success 'merge the added subproj again, should do nothing' '
> +	# this shouldn not actually do anything, since FETCH_HEAD
> +	# is already a parent
> +	result=$(git merge -s ours -m "merge -s -ours" FETCH_HEAD) &&
> +	check_equal "${result}" "Already up-to-date."
>  '
>  
>  test_expect_success 'add main-sub5' '
> @@ -167,7 +192,7 @@ test_expect_success 'merge new subproj history into subdir' '
>  	undo
>  '
>  
> -test_expect_success 'Check that prefix argument is required for split' '
> +test_expect_success 'split requires option --prefix' '
>  	echo "You must provide the --prefix option." > expected &&
>  	test_must_fail git subtree split > actual 2>&1 &&
>  	test_debug "printf '"'"'expected: '"'"'" &&
> @@ -178,15 +203,15 @@ test_expect_success 'Check that prefix argument is required for split' '
>  	rm -f expected actual
>  '
>  
> -test_expect_success 'Check that the <prefix> exists for a split' '
> -	echo "'"'"'non-existent-directory'"'"'" does not exist\; use "'"'"'git subtree add'"'"'" > expected &&
> +test_expect_success 'split requires path given by option --prefix must exist' '
> +	echo "'\''non-existent-directory'\'' does not exist; use '\''git subtree add'\''" > expected &&
>  	test_must_fail git subtree split --prefix=non-existent-directory > actual 2>&1 &&
>  	test_debug "printf '"'"'expected: '"'"'" &&
>  	test_debug "cat expected" &&
>  	test_debug "printf '"'"'actual: '"'"'" &&
>  	test_debug "cat actual" &&
> -	test_cmp expected actual
> -#	rm -f expected actual
> +	test_cmp expected actual &&
> +	rm -f expected actual
>  '
>  
>  test_expect_success 'check if --message works for split+rejoin' '
> @@ -279,18 +304,22 @@ test_expect_success 'merge split into subproj' '
>  
>  chkm="main4
>  main6"
> +
>  chkms="main-sub10
>  main-sub5
>  main-sub7
>  main-sub8"
> +
>  chkms_sub=$(cat <<TXT | sed 's,^,sub dir/,'
>  $chkms
>  TXT
>  )
> +
>  chks="sub1
>  sub2
>  sub3
>  sub9"
> +
>  chks_sub=$(cat <<TXT | sed 's,^,sub dir/,'
>  $chks
>  TXT
> @@ -301,6 +330,7 @@ test_expect_success 'make sure exactly the right set of files ends up in the sub
>  	check_equal "$subfiles" "$chkms
>  $chks"
>  '
> +
>  test_expect_success 'make sure the subproj history *only* contains commits that affect the subdir' '
>  	allchanges=''"$(git log --name-only --pretty=format:'"''"' | sort | sed "/^$/d")"'' &&
>  	check_equal "$allchanges" "$chkms
> @@ -324,26 +354,27 @@ $chks_sub"
>  '
>  
>  test_expect_success 'make sure each filename changed exactly once in the entire history' '
> -	# main-sub?? and /subdir/main-sub?? both change, because those are the
> -	# changes that were split into their own history.  And subdir/sub?? never
> +	# main-sub?? and sub dir/main-sub?? both change, because those are the
> +	# changes that were split into their own history.  And sub dir/sub?? never
>  	# change, since they were *only* changed in the subtree branch.
>  	allchanges=''"$(git log --name-only --pretty=format:'"''"' | sort | sed "/^$/d")"'' &&
> -	check_equal "$allchanges" ''"$(cat <<TXT | sort
> +	expected=''"$(cat <<TXT | sort
>  $chkms
>  $chkm
>  $chks
>  $chkms_sub
>  TXT
> -)"''
> +)"'' &&
> +	check_equal "$allchanges" "$expected"
>  '
>  
>  test_expect_success 'make sure the --rejoin commits never make it into subproj' '
> -	check_equal ''"$(git log --pretty=format:'"'%s'"' HEAD^2 | grep -i split)"'' ""
> +	check_equal "$(git log --pretty=format:"%s" HEAD^2 | grep -i split)" ""
>  '
>  
>  test_expect_success 'make sure no "git subtree" tagged commits make it into subproj' '
>  	# They are meaningless to subproj since one side of the merge refers to the mainline
> -	check_equal ''"$(git log --pretty=format:'"'%s%n%b'"' HEAD^2 | grep "git-subtree.*:")"'' ""
> +	check_equal "$(git log --pretty=format:"%s%n%b" HEAD^2 | grep "git-subtree.*:")" ""
>  '
>  
>  # prepare second pair of repositories
> @@ -408,13 +439,13 @@ test_expect_success 'split for main-sub4 without --onto' '
>  	git subtree split --prefix "sub dir" --branch mainsub4
>  '
>  
> -# at this point, the new commit parent should be sub3 if it is not,
> +# At this point, the new commit parent should be sub3.  If it is not,
>  # something went wrong (the "newparent" of "master~" commit should
>  # have been sub3, but it was not, because its cache was not set to
> -# itself)
> +# itself).
>  
>  test_expect_success 'check that the commit parent is sub3' '
> -	check_equal ''"$(git log --pretty=format:%P -1 mainsub4)"'' ''"$(git rev-parse sub3)"''
> +	check_equal "$(git log --pretty=format:%P -1 mainsub4)" "$(git rev-parse sub3)"
>  '
>  
>  test_expect_success 'add main-sub5' '
> @@ -431,36 +462,12 @@ test_expect_success 'split for main-sub5 without --onto' '
>  	check_equal ''"$(git log --pretty=format:%P -1 mainsub5)"'' ""
>  '
>  
> -# make sure no patch changes more than one file.  The original set of commits
> -# changed only one file each.  A multi-file change would imply that we pruned
> -# commits too aggressively.
> -joincommits()
> -{
> -	commit=
> -	all=
> -	while read x y; do
> -		#echo "{$x}" >&2
> -		if [ -z "$x" ]; then
> -			continue
> -		elif [ "$x" = "commit:" ]; then
> -			if [ -n "$commit" ]; then
> -				echo "$commit $all"
> -				all=
> -			fi
> -			commit="$y"
> -		else
> -			all="$all $y"
> -		fi
> -	done
> -	echo "$commit $all"
> -}
> -
>  test_expect_success 'verify one file change per commit' '
>  	x= &&
> -	list=''"$(git log --pretty=format:'"'commit: %H'"' | joincommits)"'' &&
> +	list=''"$(git log --pretty=format:'"'commit: %H'"' | join_commits)"'' &&
>  #	test_debug "echo HERE" &&
>  #	test_debug "echo ''"$list"''" &&
> -	(git log --pretty=format:'"'commit: %H'"' | joincommits |
> +	git log --pretty=format:'"'commit: %H'"' | join_commits |
>  	(	while read commit a b; do
>  			test_debug "echo Verifying commit "''"$commit"''
>  			test_debug "echo a: "''"$a"''
> @@ -468,15 +475,15 @@ test_expect_success 'verify one file change per commit' '
>  			check_equal "$b" ""
>  			x=1
>  		done
> -		check_equal "$x" 1
> -	))
> +		check_equal "$x" "1"
> +	)
>  '
>  
>  # test push
>  
>  cd ../..
>  
> -mkdir test-push
> +mkdir -p test-push
>  
>  cd test-push
