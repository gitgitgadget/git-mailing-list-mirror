From: Alexander Shukaev <git@Alexander.Shukaev.name>
Subject: Git 'pre-receive' hook and 'git-clang-format' script to reliably
 reject pushes that violate code style conventions
Date: Sat, 28 Nov 2015 23:18:15 +0100
Message-ID: <565A2827.3000609@Alexander.Shukaev.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 28 23:21:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a2ns6-0004iA-92
	for gcvg-git-2@plane.gmane.org; Sat, 28 Nov 2015 23:21:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751362AbbK1WVA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Nov 2015 17:21:00 -0500
Received: from slow1-d.mail.gandi.net ([217.70.178.86]:50619 "EHLO
	slow1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751073AbbK1WU6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Nov 2015 17:20:58 -0500
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	by slow1-d.mail.gandi.net (Postfix) with ESMTP id C1A4E47B6CC
	for <git@vger.kernel.org>; Sat, 28 Nov 2015 23:18:33 +0100 (CET)
Received: from mfilter22-d.gandi.net (mfilter22-d.gandi.net [217.70.178.150])
	by relay5-d.mail.gandi.net (Postfix) with ESMTP id 77AE841C074
	for <git@vger.kernel.org>; Sat, 28 Nov 2015 23:18:31 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mfilter22-d.gandi.net
Received: from relay5-d.mail.gandi.net ([IPv6:::ffff:217.70.183.197])
	by mfilter22-d.gandi.net (mfilter22-d.gandi.net [::ffff:10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id QoIAIHqSBakj for <git@vger.kernel.org>;
	Sat, 28 Nov 2015 23:18:30 +0100 (CET)
X-Originating-IP: 188.107.44.57
Received: from [192.168.2.109] (dslb-188-107-044-057.188.107.pools.vodafone-ip.de [188.107.44.57])
	(Authenticated sender: forum@alexander.shukaev.name)
	by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id DDE8041C076
	for <git@vger.kernel.org>; Sat, 28 Nov 2015 23:18:28 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281796>

Hello,

I have posted a question on Stack Overflow [1].  I would like to post it 
here as well since nobody has answered it yet.

Let's immediately start with a scrap of the `pre-receive` hook that I've 
already written:

     #!/bin/sh
     ##
       format_bold='\e[1m'
        format_red='\e[31m'
     format_normal='\e[0m'
     ##
     log_error="${format_bold}${format_red}error${format_normal}"
     ##
     stdout() {
       printf "${1}" "${@:2}"
     }
     ##
     stderr() {
       stdout "${@}" 1>&2
     }
     ##
     output() {
       stdout "${1}\n" "${@:2}"
     }
     ##
     error() {
       stderr "${log_error}: ${1}\n" "${@:2}"
     }
     ##
     die() {
       error "${@}"
       exit 1
     }
     ##
     list() {
       git rev-list "${@}"
     }
     ##
     clang_format() {
       git --no-pager clang-format --style='file' "${@}"
     }
     ##
     while read sha1_old sha1_new ref; do
       case "${ref}" in
       refs/heads/*)
         branch="$(expr "${ref}" : 'refs/heads/\(.*\)')"
         if [ "$(expr "${sha1_new}" : '0*$')" -ne 0 ]; then # delete
           unset sha1_new
           # ...
         else # update
           if [ "$(expr "${sha1_old}" : '0*$')" -ne 0 ]; then # create
             unset sha1_old
             sha1_range="${sha1_new}"
           else
             sha1_range="${sha1_old}..${sha1_new}"
             # ...
             fi
           fi
           # ...
                  GIT_WORK_TREE="$(mktemp --tmpdir -d 'gitXXXXXX')"
           export GIT_WORK_TREE
                  GIT_DIR="${GIT_WORK_TREE}/.git"
           export GIT_DIR
           mkdir -p "${GIT_DIR}"
           cp -a * "${GIT_DIR}/"
           ln -s "${PWD}/../.clang-format" "${GIT_WORK_TREE}/"
           error=
           for sha1 in $(list "${sha1_range}"); do
             git checkout --force "${sha1}" > '/dev/null' 2>&1
             if [ "$(list --count "${sha1}")" -eq 1 ]; then
               # What should I put here?
             else
               git reset --soft 'HEAD~1' > '/dev/null' 2>&1
             fi
             diff="$(clang_format --diff)"
             if [ "${diff%% *}" = 'diff' ]; then
               error=1
               error '%s: %s\n%s'                                       \
                     'Code style issues detected'                       \
                     "${sha1}"                                          \
                     "${diff}"                                          \
                     1>&2
             fi
           done
           if [ -n "${error}" ]; then
             die '%s' 'Code style issues detected'
           fi
         fi
         ;;
       refs/tags/*)
         tag="$(expr "${ref}" : 'refs/tags/\(.*\)')"
         # ...
         ;;
       *)
         # ...
         ;;
       esac
     done
     exit 0

**NOTE:**
Places with irrelevant code are stubbed with `# ...`.

**NOTE:**
If you are not familiar with `git-clang-format`, take a look [here][2].

That hook works as expected, and so far, I didn't notice any bugs, but 
if you spot any problem or have an improvement suggestion, I'd 
appreciate any report.  Probably, I should give a comment on what's the 
intention behind this hook.  Well, it does check every pushed revision 
for compliance with code style conventions using `git-clang-format`, and 
if any of them does not comply, it will output the relevant diff (the 
one telling developers what should be fixed) for each of them. 
Basically, I have two in-depth questions regarding this hook.

First, notice that I perform copy of the remote's (server) bare 
repository to some temporary directory and check out the code for 
analysis there.  Let me explain the intention of this.  Note that I do 
several `git checkout`s and `git reset`s (due to `for` loop) in order to 
analyze all of the pushed revisions individually with 
`git-clang-format`.  What I am trying to avoid here, is the (possible) 
concurrency issue on push access to the remote's (server) bare 
repository.  That is, I'm under impression that if multiple developers 
will try to push at the same time to a remote with this `pre-receive` 
hook installed, that might cause problems if each of these push 
"sessions" does not do `git checkout`s and `git reset`s with its private 
copy of the repository.  So, to put it simple, does `git-daemon` have 
built-in lock management for concurrent push "sessions"?  Will it 
execute the corresponding `pre-receive` hook instances strictly 
sequentially or there is a possibility of interleaving (which can 
potentially cause undefined behavior)?  Something tells me that there 
should be a built-in solution for this problem with concrete guarantees, 
otherwise how would remotes work in general (even without complex hooks) 
being subjected to concurrent pushes?  If there is such a built-in 
solution, then the copy is redundant and simply reusing the bare 
repository would actually speed up the processing.  By the way, any 
reference to official documentation regarding this question is very welcome.

Second, `git-clang-format` processes only *staged* (but not committed) 
changes vs. specific commit (`HEAD` by default).  Thus, you can easily 
see where a corner case lies.  Yes, it's with the *root* commits 
(revisions).  In fact, `git reset --soft 'HEAD~1'` cannot be applied to 
root commits as they have no parents to reset to.  Hence, the following 
check with my second question is there:

             if [ "$(list --count "${sha1}")" -eq 1 ]; then
               # What should I put here?
             else
               git reset --soft 'HEAD~1' > '/dev/null' 2>&1
             fi

I've tried `git update-ref -d 'HEAD'` but this breaks the repository in 
such a way that `git-clang-format` is not able to process it anymore.  I 
believe this is related to the fact that all of these pushed revisions 
that are being analyzed (including this root one) do not really belong 
to any branch yet.  That is, they are in *detached* `HEAD` state.  It 
would be perfect to find a solution to this corner case as well, so that 
*initial* commits can also undergo the same check by `git-clang-format` 
for compliance with code style conventions.

Peace.

[1] http://stackoverflow.com/q/33924519/1743860
[2] 
http://llvm.org/svn/llvm-project/cfe/trunk/tools/clang-format/git-clang-format
