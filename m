X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Cleaning up git user-interface warts
Date: Thu, 16 Nov 2006 11:47:22 -0800
Message-ID: <7virhf8985.fsf@assigned-by-dhcp.cox.net>
References: <87k61yt1x2.wl%cworth@cworth.org> <455A1137.8030301@shadowen.org>
	<87hcx1u934.wl%cworth@cworth.org>
	<Pine.LNX.4.64.0611141518590.2591@xanadu.home>
	<87bqn9u43s.wl%cworth@cworth.org> <ejdcg5$4fl$1@sea.gmane.org>
	<Pine.LNX.4.64.0611141633430.2591@xanadu.home>
	<7vbqn9y6w6.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0611142007010.2591@xanadu.home>
	<7v3b8ltq7r.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0611142306090.2591@xanadu.home>
	<Pine.LNX.4.64.0611150950170.3349@woody.osdl.org>
	<455BBCE9.4050503@xs4all.nl>
	<Pine.LNX.4.64.0611151908130.3349@woody.osdl.org>
	<455C412D.1030408@xs4all.nl>
	<Pine.LNX.4.64.0611160814560.3349@woody.osdl.org>
	<455C94FA.3050903@xs4all.nl>
	<Pine.LNX.4.64.0611160904010.3349@woody.osdl.org>
	<Pine.LNX.4.64.0611160932340.3349@woody.osdl.org>
	<Pine.LNX.4.64.0611161027020.3349@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 16 Nov 2006 19:47:38 +0000 (UTC)
Cc: Han-Wen Nienhuys <hanwen@xs4all.nl>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.64.0611161027020.3349@woody.osdl.org> (Linus
	Torvalds's message of "Thu, 16 Nov 2006 10:28:35 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31621>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GknCq-00078B-Nz for gcvg-git@gmane.org; Thu, 16 Nov
 2006 20:47:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1424417AbWKPTrY (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 16 Nov 2006
 14:47:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424433AbWKPTrY
 (ORCPT <rfc822;git-outgoing>); Thu, 16 Nov 2006 14:47:24 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:12271 "EHLO
 fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP id S1424417AbWKPTrY
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 16 Nov 2006 14:47:24 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao03.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061116194723.IKH4817.fed1rmmtao03.cox.net@fed1rmimpo02.cox.net>; Thu, 16
 Nov 2006 14:47:23 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id nXnV1V00P1kojtg0000000; Thu, 16 Nov 2006
 14:47:30 -0500
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> On Thu, 16 Nov 2006, Linus Torvalds wrote:
>> @@ -95,6 +100,12 @@ case "$merge_head" in
>>  	;;
>>  esac
>>  
>> +if test -z "$orig_head"
>> +then
>> +	git-update-ref -m "initial pull" HEAD $merge_head "" || exit 1
>> +	exit
>> +fi
>> +
>
> So this is the place that probably wants a "git-checkout" before the 
> exit, otherwise you'd (illogically) have to do it by hand for that 
> particular case.
>
> Of course, we should _not_ do it if the "--bare" flag has been set, so you 
> migth want to tweak the exact logic here.

As you said, pull inherently involve a merge which implies the
existence of associated working tree, so I do not think there is
any room for --bare to get in the picture.  We already do the
checkout when we recover from a fetch that is used incorrectly
and updated the current branch head underneath us.

To give the list a summary of the discussion so far, here is a
consolidated patch.

-- >8 --
From: Linus Torvalds <torvalds@osdl.org>
Subject: git-pull: allow pulling into an empty repository

We used to complain that we cannot merge anything we fetched
with a local branch that does not exist yet.  Just treat the
case as a natural extension of fast forwarding and make the
local branch'es tip point at the same commit we just fetched.
After all an empty repository without an initial commit is an
ancestor of any commit.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---
diff --git a/git-pull.sh b/git-pull.sh
index ed04e7d..e23beb6 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -44,10 +44,10 @@ do
 	shift
 done
 
-orig_head=$(git-rev-parse --verify HEAD) || die "Pulling into a black hole?"
+orig_head=$(git-rev-parse --verify HEAD 2>/dev/null)
 git-fetch --update-head-ok --reflog-action=pull "$@" || exit 1
 
-curr_head=$(git-rev-parse --verify HEAD)
+curr_head=$(git-rev-parse --verify HEAD 2>/dev/null)
 if test "$curr_head" != "$orig_head"
 then
 	# The fetch involved updating the current branch.
@@ -80,6 +80,11 @@ case "$merge_head" in
 	exit 0
 	;;
 ?*' '?*)
+	if test -z "$orig_head"
+	then
+		echo >&2 "Cannot merge multiple branches into empty head"
+		exit 1
+	fi
 	var=`git-repo-config --get pull.octopus`
 	if test -n "$var"
 	then
@@ -95,6 +100,13 @@ case "$merge_head" in
 	;;
 esac
 
+if test -z "$orig_head"
+then
+	git-update-ref -m "initial pull" HEAD $merge_head "" &&
+	git-read-tree --reset -u HEAD || exit 1
+	exit
+fi
+
 case "$strategy_args" in
 '')
 	strategy_args=$strategy_default_args
