From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-am failed, what's next ?
Date: Thu, 22 Feb 2007 12:02:23 -0800
Message-ID: <7v3b4yezao.fsf@assigned-by-dhcp.cox.net>
References: <38b2ab8a0702220022wab25519hbb57629934e7f104@mail.gmail.com>
	<7v8xeqh6bj.fsf@assigned-by-dhcp.cox.net>
	<200702221113.44338.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Francis Moreau" <francis.moro@gmail.com>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 22 21:02:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKK97-0008MO-7z
	for gcvg-git@gmane.org; Thu, 22 Feb 2007 21:02:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751810AbXBVUCZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Feb 2007 15:02:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751815AbXBVUCZ
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Feb 2007 15:02:25 -0500
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:46832 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751810AbXBVUCY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Feb 2007 15:02:24 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070222200224.HTDR3546.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Thu, 22 Feb 2007 15:02:24 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Sk2P1W00B1kojtg0000000; Thu, 22 Feb 2007 15:02:23 -0500
In-Reply-To: <200702221113.44338.andyparkins@gmail.com> (Andy Parkins's
	message of "Thu, 22 Feb 2007 11:13:42 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40376>

Andy Parkins <andyparkins@gmail.com> writes:

> On Thursday 2007 February 22 09:47, Junio C Hamano wrote:
>
>> If you have the pre-image blobs the patch was created against,
>> and the patch was created with git and records "index" lines
>> like these correctly:
>>
>>         diff --git a/builtin-config.c b/builtin-config.c
>>         index 0f9051d..f1433a4 100644
>>
>> then you can tell git to fall back on 3-way merge to apply the
>> patch.  After seeing "git am ./mbox" fail, you could try
>
> Magic.  I had no idea about this.  Could it be made even more
> magical by doing this for you?

You can start with --3way from the beginning, not just after
seeing it fail.

In the earlier description, I made it sound as if "-3" is an
option for recovery, but that is not the case.

Running "git am" without mbox parameter and an existing .dotest/
is the instruction for "git am" to continue, and the first thing
it does when told to continue is different depending on if
either --skip or --resolved is given.  --skip makes it skip the
patch.  --resolved takes the index, uses the metainfo to make a
commit.  Lack of these options makes it re-try the one recorded
in .dotest/next file.  After that, if it fails (and --skip would
not fail), it stops.  Otherwise it goes on to the next patch.

The example you referred to as "magic" is just a normal "retry it"
codepath but running with the "--3way" option.

The 3-way fallback is not enabled by default.  A minor reason
for this is that it did not exist in the original and is an
optional feature that was added later on.

But the real reason is that as a principle, git tools err on the
safe side by default, just like our use of "git-apply" in
"git-am" does not allow fuzz in the patch nor reducing context
by default for strictness.  That way, the patch application
process is stopped and gives the non-interactive user a chance
to inspect _why_ the patch does not apply, before deciding to
continue, either with fuzz'ed patch application, fixing the
patch text, or falling back on 3-way.

But these days, I almost always run:

	$ git am -3 -s ./mbox

and inspect the ones that actually used 3-way fallback after the
fact.  It _might_ make sense to add a configuration option to
default to -3 (or -s for that matter), like:

	[am]
		signoff
                threeway

and do something like this:

---
 git-am.sh |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index 6db9cb5..c0395f5 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -109,6 +109,7 @@ prec=4
 dotest=.dotest sign= utf8=t keep= skip= interactive= resolved= binary= resolvemsg=
 git_apply_opt=
 
+has_opt=
 while case "$#" in 0) break;; esac
 do
 	case "$1" in
@@ -155,8 +156,21 @@ do
 	*)
 	break ;;
 	esac
+	has_opt=t
 done
 
+if test -z "$has_opt"
+then
+	if test true = "$(git config --bool am.signoff)"
+	then
+		sign=t
+	fi
+	if test true = "$(git config --bool am.threeway)"
+	then
+		threeway=t
+	fi
+fi
+
 # If the dotest directory exists, but we have finished applying all the
 # patches in them, clear it out.
 if test -d "$dotest" &&
