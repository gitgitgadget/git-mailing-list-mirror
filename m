From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: branch --contains is unbearably slow [Re: [PATCHv2] Warnings before rebasing -i published history]
Date: Tue, 12 Jun 2012 00:04:46 +0200
Message-ID: <87vcix8pz5.fsf@thomas.inf.ethz.ch>
References: <1339104053-7782-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
	<1339409091-28150-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
	<87r4tmhy12.fsf_-_@thomas.inf.ethz.ch>
	<7vvcix7rim.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Thomas Rast <trast@student.ethz.ch>,
	Lucien Kong <Lucien.Kong@ensimag.imag.fr>,
	<git@vger.kernel.org>,
	Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>,
	Franck Jonas <Franck.Jonas@ensimag.imag.fr>,
	Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>,
	Huynh Khoi Nguyen Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>,
	"Matthieu Moy" <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 12 00:05:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeCjH-0007dH-SO
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jun 2012 00:04:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752442Ab2FKWEw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jun 2012 18:04:52 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:39919 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751856Ab2FKWEu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2012 18:04:50 -0400
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 12 Jun
 2012 00:04:46 +0200
Received: from thomas.inf.ethz.ch.ethz.ch (46.126.8.85) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 12 Jun
 2012 00:04:47 +0200
In-Reply-To: <7vvcix7rim.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 11 Jun 2012 09:16:49 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [46.126.8.85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199743>

Junio C Hamano <gitster@pobox.com> writes:

> Thomas Rast <trast@student.ethz.ch> writes:
>
>>   $ time git branch -r --contains origin/next
>>     origin/next
>>
>>   real    0m32.060s
>>
>> I think an upper bound for the runtime of any 'git branch --contains'
>> should be generating the *complete* topology like this:
>>
>>   $ time git log --graph --oneline --all >/dev/null
>>
>>   real    0m2.637s
>
> Hrm, there must be something I am doing wrong.
>
>     $ time git log --graph --oneline --all >/dev/null
>
>     real    0m3.896s
>
> Ok, so my disk is slower than yours, perhaps.

That was all hot cache, so that shouldn't be an issue.

> But
>
>     $ time git branch -r --contains next
>       github2/next
>       gph/next
>       ko/next
>       repo/next
>
>     real    0m3.853s

I suspect most of your branches are in some way closely related to next,
while I have a lot of cruft fetched from all sorts of people that fell
behind over the years.  Can you try

  git for-each-ref refs/remotes/ |
  while read sha tp ref; do
    printf "%8d %8d %s\n" $(
      git rev-list --left-right --count $ref...next
    ) $ref
  done

For me the output is as listed below (I ran it with origin/next instead
of next).  Note that for almost all of them, a naive merge-base walk
(going back from both until a common commit is found) has to walk
thousands of commits.

I'll get rid of all this cruft now, but this command doesn't scale in
the direction I'm abusing it :-)

    1027    29494 refs/remotes/alt-git/html
       0     2349 refs/remotes/alt-git/maint
     921    29494 refs/remotes/alt-git/man
       0     2245 refs/remotes/alt-git/master
      27     2191 refs/remotes/alt-git/next
      80     2130 refs/remotes/alt-git/pu
     922    29494 refs/remotes/alt-git/todo
       1     6232 refs/remotes/avar/Makefile-add-CC-to-TRACK_CFLAGS
     121     6615 refs/remotes/avar/a2c5c4b-broke-tracking-info-test
      92     4508 refs/remotes/avar/ab/i18n
     164     5961 refs/remotes/avar/ab/i18n-WIP
      65     6280 refs/remotes/avar/ab/i18n-add-translations
      43     2430 refs/remotes/avar/ab/i18n-all
      78     6275 refs/remotes/avar/ab/i18n-all-continue
      78     6275 refs/remotes/avar/ab/i18n-all-continue-squash
      78     5098 refs/remotes/avar/ab/i18n-c-_-only
      93     6240 refs/remotes/avar/ab/i18n-continue
      93     6248 refs/remotes/avar/ab/i18n-continue-hi.po
      99     6269 refs/remotes/avar/ab/i18n-continue-more
      94     6240 refs/remotes/avar/ab/i18n-continue-with-hindi
     170     5114 refs/remotes/avar/ab/i18n-docs
     161     6069 refs/remotes/avar/ab/i18n-even-more
      92     6232 refs/remotes/avar/ab/i18n-for-junio
      98     6228 refs/remotes/avar/ab/i18n-for-junio-with-docs
     162     6069 refs/remotes/avar/ab/i18n-german
      63     6280 refs/remotes/avar/ab/i18n-gettextize
     140     6191 refs/remotes/avar/ab/i18n-in-pu
     160     6123 refs/remotes/avar/ab/i18n-libcharset
       1     4463 refs/remotes/avar/ab/i18n-missing-Q_-pot-target
       7     4463 refs/remotes/avar/ab/i18n-more-gettextize
       9     3008 refs/remotes/avar/ab/i18n-po
       2     5880 refs/remotes/avar/ab/i18n-prereqs
     159     6191 refs/remotes/avar/ab/i18n-rebase-out-bugs
     160     6191 refs/remotes/avar/ab/i18n-rewrite
     161     6191 refs/remotes/avar/ab/i18n-rewrite-with-po-line-numbers
      54     3977 refs/remotes/avar/ab/i18n-sh-only
       1     2397 refs/remotes/avar/ab/i18n-slimmed
     161     5880 refs/remotes/avar/ab/i18n-squashed
     140     6228 refs/remotes/avar/ab/i18n-v2
       8     6123 refs/remotes/avar/ab/icase-directory
       8     6123 refs/remotes/avar/ab/icase-directory-v2
       4     3804 refs/remotes/avar/ab/jk/tag-contains
       1     5782 refs/remotes/avar/add-HTTPS_PROXY-env-variable-to-docs
     134     6338 refs/remotes/avar/add-fallback-bsd-printf-and-revert-107880a
       2     5092 refs/remotes/avar/add-missing-const
       1     5114 refs/remotes/avar/add-platform-specific-tweaks
     127     6615 refs/remotes/avar/another-test-dont-skip-but-prereq
     127     6615 refs/remotes/avar/another-test-dont-skip-but-prereq-v2
       6     7501 refs/remotes/avar/avar/cvsserver-pserver-auth-support
      26     2591 refs/remotes/avar/avar/fe-fixes
       2     2430 refs/remotes/avar/avar/fixup-gettext-poison-breakage
       1     5098 refs/remotes/avar/avar/git-cherry-example
       1     7776 refs/remotes/avar/avar/git-commit-allow-empty-message
       1     7689 refs/remotes/avar/avar/git-commit-synopsis-no-allow-empty
       0     7909 refs/remotes/avar/avar/git-config.d
       1     7576 refs/remotes/avar/avar/git-svn-no-yoda
       3     5092 refs/remotes/avar/avar/gitweb-513-warnings
       5     3829 refs/remotes/avar/avar/jk/tag-contains
       1     7351 refs/remotes/avar/avar/makefile-remove-INSTLIBDIR
       3     5203 refs/remotes/avar/avar/minor-patches-to-t-t5400-send-pack.sh
       3     2430 refs/remotes/avar/avar/nuke-pointless-unsigned-comparisons
       1     2430 refs/remotes/avar/avar/pull-rebase-config
       1     3504 refs/remotes/avar/avar/tag-contains-skew
       6     7576 refs/remotes/avar/avar/test-tap
       2     7491 refs/remotes/avar/avar/usr-bin-env-not-usr-bin-perl
       3     6743 refs/remotes/avar/better-test-prereq-handling
      66     6454 refs/remotes/avar/blah-poison
       1     7016 refs/remotes/avar/builtin-fetch-errors-to-stderr
       2     6191 refs/remotes/avar/bump-perl-to-5.8
       1     6781 refs/remotes/avar/clang
       2     7165 refs/remotes/avar/cvs-pass
      69     6454 refs/remotes/avar/debug-gettext-poison
     143     6338 refs/remotes/avar/disable-gettext-by-default-in-releases
     217     6773 refs/remotes/avar/dont-be-quiet-under-tap
      50     6607 refs/remotes/avar/dont-run-todo-in-t0000-basic
     164     6533 refs/remotes/avar/dont-run-todo-in-t0000-basic-v2
     102     6439 refs/remotes/avar/dont-run-todo-in-t0000-basic-v3
     134     6615 refs/remotes/avar/fix-multiple-prereq-bug
     134     6615 refs/remotes/avar/fix-multiple-prereq-bug-v2
       1     4508 refs/remotes/avar/fix-poison-for-head-is-now-at
     192     6894 refs/remotes/avar/forgot-old-git-gettext-v5
     192     6894 refs/remotes/avar/forgot-old-git-gettext-v6
      49     6800 refs/remotes/avar/forgot-old-git-gettext-v7-ontop-of-pu-fixup-RHEL-error
       1     6692 refs/remotes/avar/friendlier-git-reset-mixed-deprecated-message
       1     6692 refs/remotes/avar/friendlier-git-reset-mixed-deprecated-message-v2
      49     6800 refs/remotes/avar/gettext
     129     6296 refs/remotes/avar/gettext-pu
     128     6270 refs/remotes/avar/gettext-remove-old-sanity-test
     154     6270 refs/remotes/avar/gettextize-git-in-german
     127     6279 refs/remotes/avar/gettextize-git-mainporcelain
     153     6270 refs/remotes/avar/gettextize-git-mainporcelain-even-more
     127     6270 refs/remotes/avar/gettextize-git-mainporcelain-more
     144     6338 refs/remotes/avar/gettextize-git-mainporcelain-v2
     144     6338 refs/remotes/avar/gettextize-git-mainporcelain-v3
     143     6338 refs/remotes/avar/gettextize-git-mainporcelain-with-perl
       1     7501 refs/remotes/avar/git-am-allow-leading-whitespace
       3     6714 refs/remotes/avar/git-am-ignore-whitespace-before-patches
      25     6746 refs/remotes/avar/git-am-ignore-whitespace-before-patches-v2
       1     7587 refs/remotes/avar/git-config.d-glob
       1     7909 refs/remotes/avar/git-config.d-hack
       6     6815 refs/remotes/avar/git-cover
       7     6815 refs/remotes/avar/git-cover-2
       7     6815 refs/remotes/avar/git-cover-3
     142     6591 refs/remotes/avar/git-cvsimport-alarm-on-while
       1     6228 refs/remotes/avar/git-send-email-use-catfile
      98     6711 refs/remotes/avar/git-smoke
      99     6711 refs/remotes/avar/git-smoke-v2
      99     6711 refs/remotes/avar/git-smoke-v3
      99     6664 refs/remotes/avar/git-smoke-v4
      99     6664 refs/remotes/avar/git-smoke-v5
     102     6664 refs/remotes/avar/git-smoke-v6
       1     7501 refs/remotes/avar/git-submodule-toplevel
       1     7501 refs/remotes/avar/gitignore-patches
       1     5114 refs/remotes/avar/gitignore-test-mktemp
       1     6837 refs/remotes/avar/gnu-regex-lib
     909    29494 refs/remotes/avar/html
       1     3911 refs/remotes/avar/i18n-synopsis
       1     6743 refs/remotes/avar/imap-send-clang-warnings
     151     6591 refs/remotes/avar/in-progress-dont-depend-on-perl
     142     6591 refs/remotes/avar/internal-error-regression-test
     145     6553 refs/remotes/avar/internal-error-regression-test-v2
     121     6615 refs/remotes/avar/lib-git-svn-use-PERL_PATH
       0     8073 refs/remotes/avar/maint
       1     6069 refs/remotes/avar/make-autoconf-failure-warning
       1     5961 refs/remotes/avar/makefile-move-platform-specific-tweaks-above-lib_h-and-lib_objs
     815    29494 refs/remotes/avar/man
      93     4508 refs/remotes/avar/master
      78     6731 refs/remotes/avar/merge-dir-to-symlink-todo-test
     127     6342 refs/remotes/avar/minor-gettext-infrastructure-fixes
     142     6591 refs/remotes/avar/mkdir-test-results-on-smoking
       1     2430 refs/remotes/avar/more-grep-cpus
     185     6925 refs/remotes/avar/my-next
     127     6615 refs/remotes/avar/my-pu
       1     6123 refs/remotes/avar/netbsd-S_IFREG-warning
       1     6123 refs/remotes/avar/netbsd-S_IFREG-warning-v2
      44     6607 refs/remotes/avar/next
       1     6781 refs/remotes/avar/perl-makefile-install-base
     150     6610 refs/remotes/avar/perl-makefile-install-base-v2-onto-pu
     148     4952 refs/remotes/avar/pu
     121     6615 refs/remotes/avar/run-partial-expensive-git-notes-test-everywhere
     131     6615 refs/remotes/avar/run-partial-expensive-git-notes-test-everywhere-v2
       1     6765 refs/remotes/avar/run-tests-as-root
       4     6743 refs/remotes/avar/run-tests-as-root-v2
      16     6128 refs/remotes/avar/send-email-perl-cleanup
      16     6128 refs/remotes/avar/send-email-perl-cleanup-v2
      99     6439 refs/remotes/avar/squash-compat-regex-warnings-sent-to-gawk-maintainer
     186     6925 refs/remotes/avar/submodule-add-f-on-add
      86     7119 refs/remotes/avar/sun-studio-12-builtin-notes
      99     6439 refs/remotes/avar/svn-fe-test-x
      27     6796 refs/remotes/avar/t/doc-config-extraction
     161     6533 refs/remotes/avar/t3507-cherry-pick-conflict-sh-error
       1     6069 refs/remotes/avar/t5560-http-backend-noserver-export-fix
       1     5092 refs/remotes/avar/t7500-commit.sh-use-test_cmp-instead-of-test
     139     6228 refs/remotes/avar/temp
      99     6232 refs/remotes/avar/temp-swedish
     160     6533 refs/remotes/avar/test-fixes
     134     6615 refs/remotes/avar/test-intra-progress-using-tap-subtests
     136     6615 refs/remotes/avar/test-intra-progress-using-tap-subtests-v2
       1     6894 refs/remotes/avar/test-lib-no-test-results-under-harness
     121     6615 refs/remotes/avar/test-lib-no-test-results-under-harness-v2
     126     6338 refs/remotes/avar/test-lib-use-subshell-instead-of-chdir-back
     119     7202 refs/remotes/avar/test-tap-onto-next
     170     6997 refs/remotes/avar/test-tap-onto-next-v4
     170     6997 refs/remotes/avar/test-tap-onto-next-v5
     171     6997 refs/remotes/avar/test-tap-onto-next-v6
     171     6997 refs/remotes/avar/test-tap-onto-next-v7
     193     6925 refs/remotes/avar/test-tap-readme-docs-v1
     193     6925 refs/remotes/avar/test-tap-readme-docs-v2
     217     6773 refs/remotes/avar/tests-remove-no-python
       1     6228 refs/remotes/avar/tests-use-test-cmp-instead-of-diff-1
     712    29494 refs/remotes/avar/todo
       2     7347 refs/remotes/avar/topic/gettext
       9     7347 refs/remotes/avar/topic/gettext-rewrote-translations-out-of-infrastructure-work
       2     7342 refs/remotes/avar/topic/git-gettext
       7     7347 refs/remotes/avar/topic/git-gettext-squashed
       2     7250 refs/remotes/avar/topic/git-gettext-v10
       2     7250 refs/remotes/avar/topic/git-gettext-v11
       2     7347 refs/remotes/avar/topic/git-gettext-v6
       2     7347 refs/remotes/avar/topic/git-gettext-v7
       2     7342 refs/remotes/avar/topic/git-gettext-v8
       2     7342 refs/remotes/avar/topic/git-gettext-v9
       1     6123 refs/remotes/avar/turn-test-expect-code-into-a-function
       1     6123 refs/remotes/avar/turn-test-expect-code-into-a-function-v2
       1     6123 refs/remotes/avar/turn-test-expect-code-into-a-function-v3
      47     6607 refs/remotes/avar/update-fallback-regex-engine
      47     6607 refs/remotes/avar/update-fallback-regex-engine-v2
      49     6607 refs/remotes/avar/update-fallback-regex-engine-v3
      45     6607 refs/remotes/avar/update-index-after-running-pre-commit-hook
       1     6553 refs/remotes/avar/use-builtin-h-for-builtin-commands
       1     6280 refs/remotes/avar/use-builtin-h-for-builtin-commands-v2
     173     5092 refs/remotes/avar/wip/ab/i18n
     151     6591 refs/remotes/avar/yet-another-test-dont-skip-but-prereq
     150     6610 refs/remotes/avar/your-vsnprintf-is-broken
      15    11483 refs/remotes/bigfiles/master
      65     7016 refs/remotes/byang/diff-range
      52     7256 refs/remotes/byang/diff-range-split
      29     6815 refs/remotes/byang/line-log
      19     6815 refs/remotes/byang/line-log-rebasing
       1     6932 refs/remotes/byang/master
      43     6692 refs/remotes/byang/mc-detect
      48     6692 refs/remotes/byang/mc-detect-2
      24     6932 refs/remotes/byang/parent-rewrite
      26     6925 refs/remotes/byang/parent-rewrite-rebase
      29     6815 refs/remotes/byang/parent-rewrite-submmiting
      26     7256 refs/remotes/byang/playaround
      19     6815 refs/remotes/byang/rebasing-p2
      20     6815 refs/remotes/byang/rebasing-p3
      18     6692 refs/remotes/byang/rebasing-p4
      14     6932 refs/remotes/byang/round2
      14     6894 refs/remotes/byang/round2-fix
      19     6692 refs/remotes/byang/series-1
      49     6692 refs/remotes/byang/series-2
      13     7016 refs/remotes/byang/submitting
       4     1048 refs/remotes/de-po/maint
       1      596 refs/remotes/de-po/master
       2    11826 refs/remotes/dscho/2gb
     130    11252 refs/remotes/dscho/add-e
     127    15429 refs/remotes/dscho/after-1.5.5
     206    29494 refs/remotes/dscho/blog
       4    18539 refs/remotes/dscho/branchnewworkdir
    1008    17197 refs/remotes/dscho/builtin-fast-export
     974    17250 refs/remotes/dscho/builtin-merge-one-file
      57    15850 refs/remotes/dscho/builtin-remote
      59    15219 refs/remotes/dscho/color-words
     971    17250 refs/remotes/dscho/cover-letter
    2512     6301 refs/remotes/dscho/devel
       2    16599 refs/remotes/dscho/diff-no-stdout
       4     9756 refs/remotes/dscho/diff-submodule-summary
     131    11252 refs/remotes/dscho/diffopts
     158     9715 refs/remotes/dscho/enhance_git_diff_for_submodules
    1040    16827 refs/remotes/dscho/execv-builtin
      74    15799 refs/remotes/dscho/fast-make-doc
     143    10261 refs/remotes/dscho/grafts
      20    12474 refs/remotes/dscho/hardlinks
       1    17820 refs/remotes/dscho/hpux
      42    10104 refs/remotes/dscho/junio/next
     143     9736 refs/remotes/dscho/log-rewrap
       7    29494 refs/remotes/dscho/logos
       2    16377 refs/remotes/dscho/lstat
     139    15090 refs/remotes/dscho/mailsplit
       3     7794 refs/remotes/dscho/master
     272    11983 refs/remotes/dscho/mob
      28    13909 refs/remotes/dscho/my-master
     252    12054 refs/remotes/dscho/my-next
     679    29494 refs/remotes/dscho/my-todo
     158    12336 refs/remotes/dscho/name-objects
     291    12547 refs/remotes/dscho/notes
     106    14892 refs/remotes/dscho/nul-fix
      28    14636 refs/remotes/dscho/parseopt
      43    12424 refs/remotes/dscho/patience
      77    11536 refs/remotes/dscho/percent-branch
       4    29494 refs/remotes/dscho/presentations
     973    17259 refs/remotes/dscho/push-mirror
     118    12170 refs/remotes/dscho/rebase-early
     137    12170 refs/remotes/dscho/rebase-i-p
     107    12177 refs/remotes/dscho/rebase-i-submodule
      32     9715 refs/remotes/dscho/remote-hg
     140    15022 refs/remotes/dscho/sanitize-submodules
     111    10334 refs/remotes/dscho/shortlog-toy
     148    12006 refs/remotes/dscho/submodule
     150     9715 refs/remotes/dscho/submodule-summary
     256     8329 refs/remotes/dscho/tmp
       8    22811 refs/remotes/dscho/utf8
     118    12177 refs/remotes/dscho/valgrind
    2132     6925 refs/remotes/dscho/work/msvc-fixes
       0     2249 refs/remotes/mhagger/master
      51     2249 refs/remotes/mhagger/ref-api-D
      15     2638 refs/remotes/mhagger/refname-full
       2     3600 refs/remotes/mhagger/refperf
       0      218 refs/remotes/origin/HEAD
    1100    29494 refs/remotes/origin/html
       0      861 refs/remotes/origin/maint
     980    29494 refs/remotes/origin/man
       0      218 refs/remotes/origin/master
       0        0 refs/remotes/origin/next
     100      200 refs/remotes/origin/pu
    1012    29494 refs/remotes/origin/todo
       1     1845 refs/remotes/peff/git2-attrs
       1     1225 refs/remotes/peff/jk/blame-tree
       2     1225 refs/remotes/peff/jk/builtin-attr
      14     1225 refs/remotes/peff/jk/bundle-fetch
       1     1225 refs/remotes/peff/jk/byte-diff
       7     1225 refs/remotes/peff/jk/cache-patch-id
       1     1225 refs/remotes/peff/jk/child-cleanup
       1     1225 refs/remotes/peff/jk/commits-notes-wip
       1     1225 refs/remotes/peff/jk/config-sources
       0     1225 refs/remotes/peff/jk/dash-tests
       1     1225 refs/remotes/peff/jk/describe
       2     1225 refs/remotes/peff/jk/diff-highlight
       1     1224 refs/remotes/peff/jk/dumpstat
       3     1225 refs/remotes/peff/jk/envirostat
       3     1225 refs/remotes/peff/jk/fast-commit-list
       1     1225 refs/remotes/peff/jk/fetch-tracking
       4     1225 refs/remotes/peff/jk/follow-multiple-wip
       1     1225 refs/remotes/peff/jk/format-patch-fix
       9     1225 refs/remotes/peff/jk/generations
       1     1225 refs/remotes/peff/jk/leading-symlinks
       1     4203 refs/remotes/peff/jk/maint-ignore-have
       5     1225 refs/remotes/peff/jk/metadata-cache
       1     1225 refs/remotes/peff/jk/pager
       1     1225 refs/remotes/peff/jk/pager-subcommand
       1     1225 refs/remotes/peff/jk/pretty-nul
       1     1225 refs/remotes/peff/jk/read-tree-content-merge
       1     1225 refs/remotes/peff/jk/reflog-rewind
       0     1225 refs/remotes/peff/jk/remote-helper-disconnect
       4     1225 refs/remotes/peff/jk/rename-progress
       1     1225 refs/remotes/peff/jk/repack-alternates
       1     1225 refs/remotes/peff/jk/sockstats
       3     1225 refs/remotes/peff/jk/stash-apply-p
       0     1225 refs/remotes/peff/jk/stream-filter
       1     1225 refs/remotes/peff/jk/stupid-git-tricks
       2     1225 refs/remotes/peff/jk/unreachable-archive-loosen
     106    29494 refs/remotes/peff/meta
     217     1218 refs/remotes/peff/private
       1    13904 refs/remotes/sbeyer/extern
       6    12486 refs/remotes/sbeyer/leaks
     465    10238 refs/remotes/sbeyer/master
     454    10238 refs/remotes/sbeyer/mob
     454    10238 refs/remotes/sbeyer/seq-builtin-dev
      24    10238 refs/remotes/sbeyer/seq-builtin-rfc
       7    14109 refs/remotes/sbeyer/seq-proto-rfc
       0    10146 refs/remotes/spearce/maint
       0     9760 refs/remotes/spearce/master
     145     9719 refs/remotes/spearce/next
     189     9714 refs/remotes/spearce/pu
     520    29494 refs/remotes/spearce/todo
     131      368 refs/remotes/tgummerer/index-v5
       0     1099 refs/remotes/tgummerer/maint
      65      368 refs/remotes/tgummerer/master
       0      678 refs/remotes/tgummerer/next
      91      737 refs/remotes/tgummerer/pu
     118      368 refs/remotes/tgummerer/pythonprototype
     986    29494 refs/remotes/tgummerer/todo
      15       52 refs/remotes/trast-github/line-log-WIP
      33     1598 refs/remotes/trast-github/line-log-cleanup
       0     1776 refs/remotes/trast-github/maint
       0     1686 refs/remotes/trast-github/master
     204     1216 refs/remotes/trast-github/next
      61     1590 refs/remotes/trast-github/pu
     184     1257 refs/remotes/trast-github/t/dangerous-linus-style-xdl-hash
      11     1224 refs/remotes/trast-github/t/perf-gather-post-1.7.10
       1     1224 refs/remotes/trast-github/t/proper-xdl-speedup
     944    29494 refs/remotes/trast-github/todo
       1      524 refs/remotes/trast-github/tr/darwin-xdl-fast-hash
       1     1139 refs/remotes/trast-github/tr/inotify-POC
       1     1224 refs/remotes/trast-github/tr/xdiff-fast-hash
       1    10853 refs/remotes/trast/LOCAL/completion
      16     9520 refs/remotes/trast/js/rebase-i-p
       2    10317 refs/remotes/trast/lh/traverse-gitlinks-on-master
      33     1598 refs/remotes/trast/line-log-cleanup
       7    12377 refs/remotes/trast/master
     178     7157 refs/remotes/trast/next
     509    29494 refs/remotes/trast/notes/full
     415    29494 refs/remotes/trast/notes/terse
       6     6815 refs/remotes/trast/t/color-porcelain-message-output
      25     6796 refs/remotes/trast/t/doc-config-extraction
       3     6046 refs/remotes/trast/t/doc-config-extraction-v2
     243     5264 refs/remotes/trast/t/gfb-both-submodule-features
     240     5264 refs/remotes/trast/t/gfb-remap-submodules
       2     5331 refs/remotes/trast/t/gfb-split-submodule
      32     2191 refs/remotes/trast/t/perf-framework
      38     2191 refs/remotes/trast/t/sha1_file-parallel-with-perf-framework
     264     2295 refs/remotes/trast/tr/alternate-grep-userdiff-parallel
       1     1224 refs/remotes/trast/tr/xdiff-fast-hash

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
