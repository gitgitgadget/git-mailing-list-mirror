From: Charles Bailey <charles@hashpling.org>
Subject: Re: [PATCH 1/8] mergetool: use tabs consistently
Date: Mon, 30 Mar 2009 22:35:30 +0100
Message-ID: <20090330213530.GA7091@hashpling.org>
References: <1238389428-69328-1-git-send-email-davvid@gmail.com> <1238389428-69328-2-git-send-email-davvid@gmail.com> <7vzlf3flim.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Aguilar <davvid@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 30 23:37:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoPAL-00085M-Nd
	for gcvg-git-2@gmane.org; Mon, 30 Mar 2009 23:37:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759404AbZC3Vfj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2009 17:35:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758545AbZC3Vfi
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Mar 2009 17:35:38 -0400
Received: from relay.ptn-ipout01.plus.net ([212.159.7.35]:34088 "EHLO
	relay.ptn-ipout01.plus.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757047AbZC3Vfh (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Mar 2009 17:35:37 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ApoEAFrY0EnUnw6S/2dsb2JhbADLeIN6Bg
Received: from ptb-relay02.plus.net ([212.159.14.146])
  by relay.ptn-ipout01.plus.net with ESMTP; 30 Mar 2009 22:35:31 +0100
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by ptb-relay02.plus.net with esmtp (Exim) id 1LoP8l-0000hl-4p; Mon, 30 Mar 2009 22:35:31 +0100
Received: from cayley.hashpling.org (cayley.hashpling.org [192.168.76.254])
	by hashpling.plus.com (8.14.2/8.14.2) with ESMTP id n2ULZUFS008020
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 30 Mar 2009 22:35:30 +0100
Received: (from charles@localhost)
	by cayley.hashpling.org (8.14.2/8.14.2/Submit) id n2ULZUr4008019;
	Mon, 30 Mar 2009 22:35:30 +0100
Content-Disposition: inline
In-Reply-To: <7vzlf3flim.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Plusnet-Relay: b25bd3ab70e847cdb9f03bff8fcc361f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115192>

On Mon, Mar 30, 2009 at 01:44:01AM -0700, Junio C Hamano wrote:
> Thanks.
> 
> Even though this [1/8] is obviously regression free, and I think the
> overall direction in which the series is going is good, I'll wait until I
> hear Acks from Charles Bailey for the parts that involve mergetool.  I do
> not use either mergetool nor difftool myself, and going over every single
> line of this series to spot potential regression is beyond my bandwidth
> right now.
> 
> I do not think bits only common between mergetool and difftool should be
> called with a very generic name "sh-tools".  We didn't call the result of
> a similar refactoring for launching web browser from help and instaweb
> context with such a generic name (it is called git-web--browse).

OK, I've just had a very quick review of the patch series and, in
general, I like it.

I don't much like [1/8] though. I'm all in favour of consistency, but
this patch touches most of the lines in git-mergetool and tries to go
the opposite way to the consistency drive that we were trying to
introduce gradually (i.e. only through lines materially affected by
subsequent patches) in:

commit 0eea345111a9b9fea4dd2841b80bc7d62964e812
Author: Charles Bailey <charles@hashpling.org>
Date:   Thu Nov 13 12:41:13 2008 +0000

    Fix some tab/space inconsistencies in git-mergetool.sh

If you'd gone the other way the patch to consistency would only affect
23 lines rather than 347 lines and all bar 3 of these lines you
subsequently remove from git-mergetool.sh in later patches anyway.

[2/8] - looks good.

[3/8] - no mergetool impact.

[4/8] - Hmmm, OK. Even so at this point, I'm getting slightly iffy
feelings about the whole init_merge_tool_path sets a variable needed
by the calling script. I know it's only scripting and not programming,
but it seemed less bad to set (global) variables in sh functions when
they were all in the same sh script.

[5/8] - no mergtool impact.

[6/8] - ditto

[7/8] - OK, here's where my uneasiness about global script variables
vs. parameters really gets going. Why is merge_tool a parameter when
it's setup once and doesn't change in the invocation of a script, yet
base_present is a script global but can vary between sets of paths to
be merged?

I fully appreciate that this is just inheriting the way things are
and that they weren't beautiful before, but it somehow seems even
worse when the variables are set in one script and used from a
function in a separate sourced script. We're definitely setting up a
very strong coupling between the two scripts which will make it harder
to change either in the future.

[8/8] - no mergetool impact here.

On the plus side, I really like the introduction and function of the
run_mergetool function. It's exactly the split that will make
extending mergetool resolves of file vs. symlink vs. directory easier
in the future. I have a similar split in some slow brewing patches
myself.

I think that [1/8] is the only patch that I'd relucatant to ack, as it
seems like unnecessary churn and change of direction. Here's a sample
patch for consistency 'the other way'. As I mentioned before, the
first to hunks are made redundant by your subsequent changes anyway,
so I only counted 3 lines that are currently inconsistent in
git-mergetool as it stands at the moment.

Sample patch fixing consistent whitespace 'the other way'.
---
 git-mergetool.sh |   46 +++++++++++++++++++++++-----------------------
 1 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/git-mergetool.sh b/git-mergetool.sh
index 87fa88a..1588b5f 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -344,29 +344,29 @@ valid_custom_tool()
 }
 
 valid_tool() {
-	case "$1" in
-		kdiff3 | tkdiff | xxdiff | meld | opendiff | emerge | vimdiff | gvimdiff | ecmerge)
-			;; # happy
-		*)
-			if ! valid_custom_tool "$1"; then
-				return 1
-			fi
-			;;
-	esac
+    case "$1" in
+	kdiff3 | tkdiff | xxdiff | meld | opendiff | emerge | vimdiff | gvimdiff | ecmerge)
+	    ;; # happy
+	*)
+	    if ! valid_custom_tool "$1"; then
+		return 1
+	    fi
+	    ;;
+    esac
 }
 
 init_merge_tool_path() {
-	merge_tool_path=`git config mergetool.$1.path`
-	if test -z "$merge_tool_path" ; then
-		case "$1" in
-			emerge)
-				merge_tool_path=emacs
-				;;
-			*)
-				merge_tool_path=$1
-				;;
-		esac
-	fi
+    merge_tool_path=`git config mergetool.$1.path`
+    if test -z "$merge_tool_path" ; then
+	case "$1" in
+	    emerge)
+		merge_tool_path=emacs
+		;;
+	    *)
+		merge_tool_path=$1
+		;;
+	esac
+    fi
 }
 
 prompt_after_failed_merge() {
@@ -389,9 +389,9 @@ prompt_after_failed_merge() {
 if test -z "$merge_tool"; then
     merge_tool=`git config merge.tool`
     if test -n "$merge_tool" && ! valid_tool "$merge_tool"; then
-	    echo >&2 "git config option merge.tool set to unknown tool: $merge_tool"
-	    echo >&2 "Resetting to default..."
-	    unset merge_tool
+	echo >&2 "git config option merge.tool set to unknown tool: $merge_tool"
+	echo >&2 "Resetting to default..."
+	unset merge_tool
     fi
 fi
 
-- 
1.6.2.323.geaf6e

-- 
Charles Bailey
http://ccgi.hashpling.plus.com/blog/
