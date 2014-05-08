From: ovhrb6ho1pnnv7lo@mailinator.com
Subject: unexpected behaviour for "git diff --word-diff"
Date: Thu, 8 May 2014 18:39:49 +0200
Message-ID: <20140508163949.GA1801@else-banjo.ktb.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Qxx1br4bt0+wmkIi"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 08 19:00:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WiRfr-0000JR-Ka
	for gcvg-git-2@plane.gmane.org; Thu, 08 May 2014 18:59:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754599AbaEHQ74 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2014 12:59:56 -0400
Received: from mout1.freenet.de ([195.4.92.91]:49843 "EHLO mout1.freenet.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754555AbaEHQ7z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2014 12:59:55 -0400
X-Greylist: delayed 850 seconds by postgrey-1.27 at vger.kernel.org; Thu, 08 May 2014 12:59:55 EDT
Received: from [195.4.92.141] (helo=mjail1.freenet.de)
	by mout1.freenet.de with esmtpa (ID b-thomas@freenet.de) (port 25) (Exim 4.82 #1)
	id 1WiRS3-0000D6-L6
	for git@vger.kernel.org; Thu, 08 May 2014 18:45:43 +0200
Received: from localhost ([::1]:59979 helo=mjail1.freenet.de)
	by mjail1.freenet.de with esmtpa (ID b-thomas@freenet.de) (Exim 4.80.1 #4)
	id 1WiRS3-0000DJ-Fn
	for git@vger.kernel.org; Thu, 08 May 2014 18:45:43 +0200
Received: from mx8.freenet.de ([195.4.92.18]:50598)
	by mjail1.freenet.de with esmtpa (ID b-thomas@freenet.de) (Exim 4.80.1 #4)
	id 1WiRPp-0005zg-P7
	for git@vger.kernel.org; Thu, 08 May 2014 18:43:25 +0200
Received: from p4fc4e784.dip0.t-ipconnect.de ([79.196.231.132]:48125 helo=else-banjo.ktb.de)
	by mx8.freenet.de with esmtpsa (ID b-thomas@freenet.de) (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256) (port 587) (Exim 4.80.1 #4)
	id 1WiRPp-00056C-GR
	for git@vger.kernel.org; Thu, 08 May 2014 18:43:25 +0200
Received: by else-banjo.ktb.de (Postfix, from userid 501)
	id 038E0807; Thu,  8 May 2014 16:39:49 +0000 (GMT)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originated-At: 79.196.231.132!48125
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248422>


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I get an unexpected behaviour for "git diff --word-diff" if 2 adjacent lines
start and end with the same letter. I tried versions 1.7.9 and 1.9.0.

Attached is a script with 7 examples. For each example, a file with 2 lines is
compared to a file with the same lines, only 1 or 2 letters appended in each
line. Each example is executed 4 times: with and without --word-diff-regex=.,
and with and without -R. The script prints the result of the diff of the 2
files. Just below it also prints the result of a counterexample: the same 2
lines with 2 lines (1 was sometimes not enough) of "xxx" between them.

Only for tests 5c,d and 6c,d the result matches the result for the
counterexample.

Kind regards,
Thomas

--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="test.git-diff"

#!/bin/bash

##########################################
# execute 6 tests with counterexamples for "git diff --word-diff"
#
# (optional) argument: (sub-)test to execute, e.g. "1" or "3b"
#   if none/empty: all tests are executed
#
# common header lines of the diff output are removed
##########################################

# init global variables:
#   command to execute
GITDIFF="git diff --word-diff=plain --no-index --no-color"
#   names of test files
file1=$0.1
file2=$0.2
file1x=$0.1x
file2x=$0.2x
#   wanted test case, info to print
want=
info=

##########################################
# do_sub_test()
#   call "git diff" for a sub-test and its counterexample
#   common header lines of the diff output are removed
do_sub_test() {
    curr_sub_test=$1

    # set additional arguments for git diff
    case $curr_sub_test in
        *a) add_args=;;
        *b) add_args=-R;;
        *c) add_args=--word-diff-regex=.;;
        *d) add_args="-R --word-diff-regex=.";;
    esac

    # execute original test
    echo "  -- test" $curr_sub_test: DIFF $add_args: $info
    $GITDIFF $add_args $file1 $file2 | sed '/^[di+-]\|^@@ -1,2 +1,2 /d'

    # execute counterexample
    echo "    -- expected:"
    $GITDIFF $add_args $file1x $file2x | sed '/^[di+-]\|^xxx$\|^@@ -1,4 +1,4 /d'
}

##########################################
# do_test()
#   create files for a test, call do_sub_test for wanted sub-test (or all)
do_test() {
    curr_test=$1
    line1=$2
    line2=$3
    append=$4

    # create files for test
    echo -e "$line1\n$line2" > $file1
    echo -e "$line1$append\n$line2$append" > $file2

    # create files for counterexample
    echo -e "$line1\nxxx\nxxx\n$line2" > $file1x
    echo -e "$line1$append\nxxx\nxxx\n$line2$append" > $file2x

    info="append '$append' to '$line1' <nl> '$line2'"

    # call do_sub_test for wanted sub-test (or all)
    case $want in ?a|?|'') do_sub_test ${curr_test}a;; esac
    case $want in ?b|?|'') do_sub_test ${curr_test}b;; esac
    case $want in ?c|?|'') do_sub_test ${curr_test}c;; esac
    case $want in ?d|?|'') do_sub_test ${curr_test}d;; esac
}

##########################################
# do_all_tests()
#   call do_test for wanted test (or all)
do_all_tests() {
    want=$1

    case $want in 1*|'') do_test 1 '' .a .   ;; esac
    case $want in 2*|'') do_test 2 .  .a .   ;; esac
    case $want in 3*|'') do_test 3 '' a  a   ;; esac
    case $want in 4*|'') do_test 4 a  aa a   ;; esac
    case $want in 5*|'') do_test 5 '' a  b   ;; esac
    case $want in 6*|'') do_test 6 '' a  'b ';; esac
}

##########################################
# main()
#   prepare cleanup, do tests

# clean up test files on exit and some signals
trap "rm -f $file1 $file2 $file1x $file2x; exit" 0 1 2 15

usage="Usage: $0 [<testcase>]\n  <testcase> can be [1-6][a-d] or empty\n  e.g. '$0 1' or '$0 3b'"

case $1 in
    [1-6]|[1-6][a-d]|'')
    ;;

    -h|--help)
        echo -e $usage
        exit
    ;;

    *)
        echo -e "Error: invalid argument '$1'\n$usage"
        exit
    ;;
esac

# do tests
do_all_tests $1

--Qxx1br4bt0+wmkIi--
