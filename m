X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Cleaning up git user-interface warts
Date: Thu, 16 Nov 2006 09:57:29 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0611160932340.3349@woody.osdl.org>
References: <87k61yt1x2.wl%cworth@cworth.org> <455A1137.8030301@shadowen.org>
 <87hcx1u934.wl%cworth@cworth.org> <Pine.LNX.4.64.0611141518590.2591@xanadu.home>
 <87bqn9u43s.wl%cworth@cworth.org> <ejdcg5$4fl$1@sea.gmane.org>
 <Pine.LNX.4.64.0611141633430.2591@xanadu.home> <7vbqn9y6w6.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0611142007010.2591@xanadu.home> <7v3b8ltq7r.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0611142306090.2591@xanadu.home> <Pine.LNX.4.64.0611150950170.3349@woody.osdl.org>
 <455BBCE9.4050503@xs4all.nl> <Pine.LNX.4.64.0611151908130.3349@woody.osdl.org>
 <455C412D.1030408@xs4all.nl> <Pine.LNX.4.64.0611160814560.3349@woody.osdl.org>
 <455C94FA.3050903@xs4all.nl> <Pine.LNX.4.64.0611160904010.3349@woody.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Thu, 16 Nov 2006 17:58:32 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.64.0611160904010.3349@woody.osdl.org>
X-MIMEDefang-Filter: osdl$Revision: 1.156 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31607>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GklUy-00073C-G8 for gcvg-git@gmane.org; Thu, 16 Nov
 2006 18:58:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1162063AbWKPR5g (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 16 Nov 2006
 12:57:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162021AbWKPR5f
 (ORCPT <rfc822;git-outgoing>); Thu, 16 Nov 2006 12:57:35 -0500
Received: from smtp.osdl.org ([65.172.181.4]:36065 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S1162063AbWKPR5e (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 16 Nov 2006 12:57:34 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kAGHvUoZ017445
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Thu, 16
 Nov 2006 09:57:30 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kAGHvTEK032448; Thu, 16 Nov
 2006 09:57:29 -0800
To: Han-Wen Nienhuys <hanwen@xs4all.nl>
Sender: git-owner@vger.kernel.org



On Thu, 16 Nov 2006, Linus Torvalds wrote:
> 
> (And the real reason for that is simple: "git pull" simply wants to have 
> something to _start_ with. It's not hugely fundamental, it's just how it 
> was written).

Here's a very lightly tested patch that allows you to use "git pull" to 
populate an empty repository.

I'm not at all sure this is necessarily the nicest way to do it, but it's 
fairly straightforward.

Junio, what do you think?

		Linus

---
diff --git a/git-pull.sh b/git-pull.sh
index ed04e7d..7e5cee2 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -44,10 +44,10 @@ do
 	shift
 done
 
-orig_head=$(git-rev-parse --verify HEAD) || die "Pulling into a black hole?"
+orig_head=$(git-rev-parse --verify HEAD 2> /dev/null)
 git-fetch --update-head-ok --reflog-action=pull "$@" || exit 1
 
-curr_head=$(git-rev-parse --verify HEAD)
+curr_head=$(git-rev-parse --verify HEAD 2> /dev/null)
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
@@ -95,6 +100,12 @@ case "$merge_head" in
 	;;
 esac
 
+if test -z "$orig_head"
+then
+	git-update-ref -m "initial pull" HEAD $merge_head "" || exit 1
+	exit
+fi
+
 case "$strategy_args" in
 '')
