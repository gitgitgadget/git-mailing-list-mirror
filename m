From: Nazri Ramliy <ayiehere@gmail.com>
Subject: [PATCH v4] Teach git to change to a given directory using -C option
Date: Thu, 19 Sep 2013 21:18:54 +0800
Message-ID: <20130919131854.GA19790@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 19 15:19:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VMe8N-0008A2-Og
	for gcvg-git-2@plane.gmane.org; Thu, 19 Sep 2013 15:19:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753813Ab3ISNS7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Sep 2013 09:18:59 -0400
Received: from mail-pb0-f43.google.com ([209.85.160.43]:45846 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752018Ab3ISNS6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Sep 2013 09:18:58 -0400
Received: by mail-pb0-f43.google.com with SMTP id md4so8354056pbc.2
        for <git@vger.kernel.org>; Thu, 19 Sep 2013 06:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        bh=HdTxvKJFpKDrKHdUTwmRdrrlXji3Vuwc3sNvm1oI9l4=;
        b=uVZYdbs9zwbntW9ADinZsKFhP/ER8GfXMWVz5cGtJosmYA68ETyAHYfBy245YvBs5g
         QDxv5f4S+HzyUIjcsADRIzDHpDX7k2835W5ndODPuwOLRTbnZ8mfKHSbBBAvqxM/CzTD
         otsnad6rIs5dbsAEGy23dnfFRnyrTeUK1Ji20lR++cRlox4dVcTJ8uVf4ZHEYF8sVSIg
         ZTa+Xn2TYP3/ckoqzSMiUuuEJVLQ4azirgHfsABklWPvVoWILZVjzI0AL+yhv1tNJ8zD
         K5F/d9GOz8yvYXMWNnQ1iTjWDA7FYt8/jK0J7yxZNbF/laeDIR0Tw5pi+gfj50VW/r4B
         zybw==
X-Received: by 10.66.142.193 with SMTP id ry1mr2758524pab.150.1379596738045;
        Thu, 19 Sep 2013 06:18:58 -0700 (PDT)
Received: from gmail.com ([175.142.220.107])
        by mx.google.com with ESMTPSA id fk4sm12146663pab.23.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 19 Sep 2013 06:18:56 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235014>

Hi,

Sorry it took me a while to get back on this. Reroll at the bottom ...

On Tue, Sep 10, 2013 at 12:32 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Nazri Ramliy <ayiehere@gmail.com> writes:
>
>> Subject: git: run in a directory given with -C option
>>
>> This is similar in spirit to to "make -C dir ..." and "tar -C dir ...".
>
> The doubled-"to to" which I locally fixed when I queued the last one
> (together with other rewording to make it more agreeable and easier
> to read) somehow came back ;-) Will fix locally again.

I must have mistakenly made the revision on top of my local changes
instead of the one in next - I didn't notice the fix. Thanks for the
fix.

>> +-C <path>::
>> +     Run as if git was started in '<path>' instead of the current working
>> +     directory.  When multiple '-C' options are given, each subsequent
>
> I think this should be `-C` to typeset it as "typed literally".
>
>> +     non-absolute `-C <path>` is interpreted relative to the preceding `-C
>> +     <path>`.
>> ++
>> +This option affects options that expect path name like '--git-dir' and
>> +'--work-tree' in that their interpretations of the path names would be
>
> Likewise for `--git-dir` and `--work-tree`.
>
>> +made relative to the working directory caused by the '-C' option. For
>
> and here.

Now I'm noticing that you've already made the above fixes in next ;)

>> diff --git a/t/t0056-git-C.sh b/t/t0056-git-C.sh
>> new file mode 100755
>> index 0000000..c0006da
>> --- /dev/null
>> +++ b/t/t0056-git-C.sh
>> @@ -0,0 +1,82 @@
>> +#!/bin/sh
>> +
>> +test_description='"-C <path>" option and its effects on other path-related options'
>> +
>> +. ./test-lib.sh
>> +
>> +test_expect_success '"git -C <path>" runs git from the directory <path>' '
>> +     test_create_repo dir1 &&
>> +     echo 1 >dir1/a.txt &&
>> +     (cd dir1 && git add a.txt && git commit -m "initial in dir1") &&
>
> Curious why this does not use -C here.

It didn't use -C there because it's in the "prepare the expected test
output" stage and we want that to succeed, whether -C works or not - we
haven't reached the part where we are actually testing the -C option,
which is right after that:

>> +     echo "initial in dir1" >expected &&
>> +     git -C dir1 log --format=%s >actual &&
>> +     test_cmp expected actual
>> +'
>> +
>> +test_expect_success 'Multiple -C options: "-C dir1 -C dir2" is equivalent to "-C dir1/dir2"' '
>> +     test_create_repo dir1/dir2 &&
>> +     echo 1 >dir1/dir2/a.txt &&
>> +     git -C dir1/dir2 add a.txt &&
>
> Because "a.txt" exists in both dir1 and dir1/dir2, this has less
> chance of catching a bug (if somebody breaks the feature to run it
> in dir1 not dir1/dir2, "add" will happily say "Oh, I found something
> to add", instead of saying "Huh? there is no such path".
>
> If you used b.txt instead, you would catch such a breakage.
>
> Remember, tests are not about demonstrating how cool the new feature
> is and/or how well it works in an expected setting.  Imagine ways
> other people can break your spiffy new feature in later patches, and
> design tests that are more likely to catch them.
>
> The same comment applies throughout the remainder of this script.

Noted, but I my imagination is limited at the moment so I haven't come
up with new tests to that effect yet ;)

>> +     echo "initial in dir1/dir2" >expected &&
>> +     git -C dir1/dir2 commit -m "initial in dir1/dir2" &&
>
> to reduce possibilities of breaking this test in the future due to
> typos (e.g. somebody may want to say "initial commit in dir1/dir2"),
> doing this may be a better idea:
>
>         msg="initial in dir1/dir2" &&
>         echo "$msg" >expected &&
>         git -C dir1/dir2 commit -m "$msg" &&
>
> The same comment applies to the previous one.

Fixed.

nazri
-- >8 --
Subject: git: run in a directory given with -C option

This is similar in spirit to "make -C dir ..." and "tar -C dir ...".

It takes more keypresses to invoke git command in a different
directory without leaving the current directory:

    1. (cd ~/foo && git status)
       git --git-dir=~/foo/.git --work-dir=~/foo status
       GIT_DIR=~/foo/.git GIT_WORK_TREE=~/foo git status
    2. (cd ../..; git grep foo)
    3. for d in d1 d2 d3; do (cd $d && git svn rebase); done

The methods shown above are acceptable for scripting but are too
cumbersome for quick command line invocations.

With this new option, the above can be done with fewer keystrokes:

    1. git -C ~/foo status
    2. git -C ../.. grep foo
    3. for d in d1 d2 d3; do git -C $d svn rebase; done

A new test script is added to verify the behavior of this option with
other path-related options like --git-dir and --work-tree.

Signed-off-by: Nazri Ramliy <ayiehere@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git.txt | 16 +++++++++-
 git.c                 | 13 +++++++-
 t/t0056-git-C.sh      | 84 +++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 111 insertions(+), 2 deletions(-)
 create mode 100755 t/t0056-git-C.sh

diff --git a/Documentation/git.txt b/Documentation/git.txt
index c4f0ed5..5d68d33 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -9,7 +9,7 @@ git - the stupid content tracker
 SYNOPSIS
 --------
 [verse]
-'git' [--version] [--help] [-c <name>=<value>]
+'git' [--version] [--help] [-C <path>] [-c <name>=<value>]
     [--exec-path[=<path>]] [--html-path] [--man-path] [--info-path]
     [-p|--paginate|--no-pager] [--no-replace-objects] [--bare]
     [--git-dir=<path>] [--work-tree=<path>] [--namespace=<name>]
@@ -395,6 +395,20 @@ displayed. See linkgit:git-help[1] for more information,
 because `git --help ...` is converted internally into `git
 help ...`.
 
+-C <path>::
+	Run as if git was started in '<path>' instead of the current working
+	directory.  When multiple `-C` options are given, each subsequent
+	non-absolute `-C <path>` is interpreted relative to the preceding `-C
+	<path>`.
++
+This option affects options that expect path name like `--git-dir` and
+`--work-tree` in that their interpretations of the path names would be
+made relative to the working directory caused by the `-C` option. For
+example the following invocations are equivalent:
+
+    git --git-dir=a.git --work-tree=b -C c status
+    git --git-dir=c/a.git --work-tree=c/b status
+
 -c <name>=<value>::
 	Pass a configuration parameter to the command. The value
 	given will override values from configuration files.
diff --git a/git.c b/git.c
index b3893e7..1188979 100644
--- a/git.c
+++ b/git.c
@@ -7,7 +7,7 @@
 #include "commit.h"
 
 const char git_usage_string[] =
-	"git [--version] [--help] [-c name=value]\n"
+	"git [--version] [--help] [-C <path>] [-c name=value]\n"
 	"           [--exec-path[=<path>]] [--html-path] [--man-path] [--info-path]\n"
 	"           [-p|--paginate|--no-pager] [--no-replace-objects] [--bare]\n"
 	"           [--git-dir=<path>] [--work-tree=<path>] [--namespace=<name>]\n"
@@ -165,6 +165,17 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 			set_alternate_shallow_file((*argv)[0]);
 			if (envchanged)
 				*envchanged = 1;
+		} else if (!strcmp(cmd, "-C")) {
+			if (*argc < 2) {
+				fprintf(stderr, "No directory given for -C.\n" );
+				usage(git_usage_string);
+			}
+			if (chdir((*argv)[1]))
+				die_errno("Cannot change to '%s'", (*argv)[1]);
+			if (envchanged)
+				*envchanged = 1;
+			(*argv)++;
+			(*argc)--;
 		} else {
 			fprintf(stderr, "Unknown option: %s\n", cmd);
 			usage(git_usage_string);
diff --git a/t/t0056-git-C.sh b/t/t0056-git-C.sh
new file mode 100755
index 0000000..99c0377
--- /dev/null
+++ b/t/t0056-git-C.sh
@@ -0,0 +1,84 @@
+#!/bin/sh
+
+test_description='"-C <path>" option and its effects on other path-related options'
+
+. ./test-lib.sh
+
+test_expect_success '"git -C <path>" runs git from the directory <path>' '
+	test_create_repo dir1 &&
+	echo 1 >dir1/a.txt &&
+	msg="initial in dir1" &&
+	(cd dir1 && git add a.txt && git commit -m "$msg") &&
+	echo "$msg" >expected &&
+	git -C dir1 log --format=%s >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'Multiple -C options: "-C dir1 -C dir2" is equivalent to "-C dir1/dir2"' '
+	test_create_repo dir1/dir2 &&
+	echo 1 >dir1/dir2/b.txt &&
+	git -C dir1/dir2 add b.txt &&
+	msg="initial in dir1/dir2" &&
+	echo "$msg" >expected &&
+	git -C dir1/dir2 commit -m "$msg" &&
+	git -C dir1 -C dir2 log --format=%s >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'Effect on --git-dir option: "-C c --git-dir=a.git" is equivalent to "--git-dir c/a.git"' '
+	mkdir c &&
+	mkdir c/a &&
+	mkdir c/a.git &&
+	(cd c/a.git && git init --bare) &&
+	echo 1 >c/a/a.txt &&
+	git --git-dir c/a.git --work-tree=c/a add a.txt &&
+	git --git-dir c/a.git --work-tree=c/a commit -m "initial" &&
+	git --git-dir=c/a.git log -1 --format=%s >expected &&
+	git -C c --git-dir=a.git log -1 --format=%s >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'Order should not matter: "--git-dir=a.git -C c" is equivalent to "-C c --git-dir=a.git"' '
+	git -C c --git-dir=a.git log -1 --format=%s >expected &&
+	git --git-dir=a.git -C c log -1 --format=%s >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'Effect on --work-tree option: "-C c/a.git --work-tree=../a"  is equivalent to "--work-tree=c/a --git-dir=c/a.git"' '
+	rm c/a/a.txt &&
+	git --git-dir=c/a.git --work-tree=c/a status >expected &&
+	git -C c/a.git --work-tree=../a status >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'Order should not matter: "--work-tree=../a -C c/a.git" is equivalent to "-C c/a.git --work-tree=../a"' '
+	git -C c/a.git --work-tree=../a status >expected &&
+	git --work-tree=../a -C c/a.git status >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'Effect on --git-dir and --work-tree options - "-C c --git-dir=a.git --work-tree=a" is equivalent to "--git-dir=c/a.git --work-tree=c/a"' '
+	git --git-dir=c/a.git --work-tree=c/a status >expected &&
+	git -C c --git-dir=a.git --work-tree=a status >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'Order should not matter: "-C c --git-dir=a.git --work-tree=a" is equivalent to "--git-dir=a.git -C c --work-tree=a"' '
+	git -C c --git-dir=a.git --work-tree=a status >expected &&
+	git --git-dir=a.git -C c --work-tree=a status >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'Order should not matter: "-C c --git-dir=a.git --work-tree=a" is equivalent to "--git-dir=a.git --work-tree=a -C c"' '
+	git -C c --git-dir=a.git --work-tree=a status >expected &&
+	git --git-dir=a.git --work-tree=a -C c status >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'Relative followed by fullpath: "-C ./here -C /there" is equivalent to "-C /there"' '
+	echo "initial in dir1/dir2" >expected &&
+	git -C dir1 -C "$(pwd)/dir1/dir2" log --format=%s >actual &&
+	test_cmp expected actual
+'
+
+test_done
-- 
1.8.4.411.g6835a8c
