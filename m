From: Junio C Hamano <gitster@pobox.com>
Subject: Re* [GIT PULL] sh updates for 2.6.25
Date: Wed, 16 Apr 2008 12:58:54 -0700
Message-ID: <7v3aplr2pt.fsf_-_@gitster.siamese.dyndns.org>
References: <20080415172333.GA29489@linux-sh.org>
 <alpine.LFD.1.00.0804151048060.2879@woody.linux-foundation.org>
 <m3ej97rmc0.fsf@localhost.localdomain>
 <20080416003725.GF8387@genesis.frugalware.org>
 <7vd4oqwkev.fsf@gitster.siamese.dyndns.org>
 <20080416084435.GJ8387@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Wed Apr 16 22:10:35 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JmDnP-0007n3-JJ
	for gcvg-git-2@gmane.org; Wed, 16 Apr 2008 21:59:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752008AbYDPT7K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Apr 2008 15:59:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751871AbYDPT7J
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Apr 2008 15:59:09 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:35014 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751972AbYDPT7I (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Apr 2008 15:59:08 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 0D86B396A;
	Wed, 16 Apr 2008 15:59:05 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 5658B3968; Wed, 16 Apr 2008 15:58:57 -0400 (EDT)
In-Reply-To: <20080416084435.GJ8387@genesis.frugalware.org> (Miklos Vajna's
 message of "Wed, 16 Apr 2008 10:44:35 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79735>

Miklos Vajna <vmiklos@frugalware.org> writes:

> On Tue, Apr 15, 2008 at 08:25:28PM -0700, Junio C Hamano <gitster@pobox.com> wrote:
>> > If we are at it, I had a similar bugreport: If one doesn't use an empty
>> > line after the first line in the commit message, a git-format-patch +
>> > git-am combo will strip newlines from the commit message:
>> 
>> That's not a bug but an intended behaviour.  You are triggering "RFC 2822
>> line folding" of Subject: header.
>
> Hm, then is it git-am that would have to be fixed up to properly unfold
> such a subject? (I mean not stripping newlines.)

"Properly unfolding" by definition means remove LF before WSP at the
beginning of the continued lines, so it does not solve it.  "git am" is
primarily an email acceptance tool, and the mail pathway between the
sender and the recipient can splice the "Subject: " at any point, so the
receiver cannot assume that the lines were folded at the place the
originator intended them to be folded (often, the sender wanted a single
line).

But let's step back a bit.

First of all, if you are using git as "fast filesystem that lets you build
your own SCM on top of", aka "plumbing", you can have your commit log
message in any way you want.  "git-commit-tree" allows you to record
arbitrary commit log message without whitespace cleansing (it might eat
NUL, but that would be a bug if it did so), and "git-cat-file commit"
would give you what you recorded literally.

However, if you are using git as a full featured SCM, aka "Porcelain", you
have to work within the rules of how the world works, which were not set
arbitrarily but came from real world constraints.  "git-format-patch" and
"git-am" are two examples of such Porcelain programs.

Unlike olden days when people used CVS and recorded a two-week's worth of
work as a single huge commit, we encourage working with many small
commits, and we have tools to give you overview of the history without
drowning you in the sea of information.  "git reflog", "git branch -v",
"git-log --pretty=oneline", "git show-branch", "git fmt-merge-msg",
"gitk", and "git shortlog" all are built around the notion that the first
line of the commit is _special_ in that by reading only that line, there
should be enough information for the reader to tell what the commit is
about.  Also, emailed patch has the "Subject: " line to serve the same
purpose and by definition that is a single liner.

When one adopts the notion of "a single line at the top summarizes what
the commit is about", it is very natural to call that a "title", and
having a blank line between the title and the body to separate them also
becomes natural, and it matches how a patch is presented in email, as a
bonus, so it matches people's expectation.

So this format is merely a convention when viewed at the "plumbing" level,
but it is more important than just a convention if you are living at the
"Porcelain" level; if you deviate from that, "Porcelain" would not work
very well for you.

We can do two things about "would not work very well" part above when you
do have a commit whose first paragraph has more then one lines, and
dealing with such a commit gracefully is important.

People who are used to other systems without a good history summarization
tools can and do write such log messages.  People who make commits on such
systems whose commits are imported to git (perhaps even without them
knowing about it) do not have an incentive to use a short-and-clear single
line summary in each of their commits, as their system may not give a good
way to make use of the result of such a practice.

Very old git literally took "the first line is the summary" approach,
which meant that the first line of such a multi-line paragraph at the
beginning became "Subject: ", and the message body started in the mid
sentence.  "git log --pretty=oneline" appeared to chomp a sentence in the
middle (while in fact the guilty party who chomped the sentence in the
middle was the committer). People who migrated from CVS hated the loss of
information. Worse yet, because "rebase" is implemented in terms of
"format-patch piped to am" (which we can eventually change to use
git-sequencer), if you rebase such a commit, you will get an extra empty
line between the first line and the subsequent lines.

These days, format-patch was taught to use "the first paragraph" as the
summarizing first line to avoid chomping a sentence in the middle.  This
change did not hurt people who use git "Porcelain", as the commit log
message for them is always "a single line summary, a blank line, and the
body".  The first paragraph is the same as the first line for them.  But
for commits that have a multi-line paragraph at the beginning, information
lossage is avoided this way.  Now the first chunk of the message, even if
it is splattered over two physical lines, is used as the summary.

The tools that allocate only one display line for each commit (again,
format-patch is one of them because there is only one "Subject: " line)
still need to cope with this, as they have only one line to work with.
The way format-patch and friends do so is to take it as a logically single
line folded into multiple lines.  format-patch (and --pretty=email)
happens to know that the output medium (i.e. rfc 2822 messages) allows to
express the logically single line as multiple physical lines, so its
output "preserves" the original line breaks, but "git am" is in no
position to honor it, at least without an extra option to tell it that it
is safe and meaningful to do so.

So in short, when you use "am", it by design unfolds the "Subject: " line
and there is no bug there.  "rebase" being implemented in terms of
"format-patch piped to am" does mangle the message because of this, but
if anything that is a bug in rebase, and not "am".

And this is a potential fix to the issue, which was made possible only
because recently "rebase" started passing an extra option to "am".

-- >8 --
From: Junio C Hamano <gitster@pobox.com>
Date: Wed, 16 Apr 2008 12:50:48 -0700
Subject: [PATCH] rebase: do not munge commit log message

Traditionally git-rebase was implemented in terms of "format-patch" piped
to "am -3", to strike balance between speed (because it avoids a rather
expensive read-tree/merge-recursive machinery most of the time) and
flexibility (the magic "-3" allows it to fall back to 3-way merge as
necessary).  However, this combination has one flaw when dealing with a
nonstandard commit log message format that has more than one lines in the
first paragraph, because such a "first line" is formatted as logically a
single line, and unfolded at the applying end.

This teaches "git am --rebasing" to take advantage of the fact that the
mbox message "git rebase" prepares for it records the original commit
object name, and that such a commit _is_ available locally.  It reads the
log message from the original commit object instead.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-am.sh                    |   19 ++++++++++++++-----
 t/t3408-rebase-multi-line.sh |   41 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+), 5 deletions(-)
 create mode 100755 t/t3408-rebase-multi-line.sh

diff --git a/git-am.sh b/git-am.sh
index 245e1db..5a7695e 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -327,11 +327,20 @@ do
 			echo "Patch is empty.  Was it split wrong?"
 			stop_here $this
 		}
-		SUBJECT="$(sed -n '/^Subject/ s/Subject: //p' "$dotest/info")"
-		case "$keep_subject" in -k)  SUBJECT="[PATCH] $SUBJECT" ;; esac
-
-		(echo "$SUBJECT" ; echo ; cat "$dotest/msg") |
-			git stripspace > "$dotest/msg-clean"
+		if test -f "$dotest/rebasing" &&
+			commit=$(sed -e 's/^From \([0-9a-f]*\) .*/\1/' \
+				-e q "$dotest/$msgnum") &&
+			test "$(git cat-file -t "$commit")" = commit
+		then
+			git cat-file commit "$commit" |
+			sed -e '1,/^$/d' >"$dotest/msg-clean"
+		else
+			SUBJECT="$(sed -n '/^Subject/ s/Subject: //p' "$dotest/info")"
+			case "$keep_subject" in -k)  SUBJECT="[PATCH] $SUBJECT" ;; esac
+
+			(echo "$SUBJECT" ; echo ; cat "$dotest/msg") |
+				git stripspace > "$dotest/msg-clean"
+		fi
 		;;
 	esac
 
diff --git a/t/t3408-rebase-multi-line.sh b/t/t3408-rebase-multi-line.sh
new file mode 100755
index 0000000..e12cd57
--- /dev/null
+++ b/t/t3408-rebase-multi-line.sh
@@ -0,0 +1,41 @@
+#!/bin/sh
+
+test_description='rebasing a commit with multi-line first paragraph.'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+
+	>file &&
+	git add file &&
+	test_tick &&
+	git commit -m initial &&
+
+	echo hello >file &&
+	test_tick &&
+	git commit -a -m "A sample commit log message that has a long
+summary that spills over multiple lines.
+
+But otherwise with a sane description."
+
+	git branch side &&
+
+	git reset --hard HEAD^ &&
+	>elif &&
+	git add elif &&
+	test_tick &&
+	git commit -m second
+
+'
+
+test_expect_success rebase '
+
+	git checkout side &&
+	git rebase master &&
+	git cat-file commit HEAD | sed -e "1,/^$/d" >actual &&
+	git cat-file commit side@{1} | sed -e "1,/^$/d" >expect &&
+	test_cmp expect actual
+
+'
+
+test_done
-- 
1.5.5.120.gea9a0
