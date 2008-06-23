From: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: git-rerere observations and feature suggestions
Date: Mon, 23 Jun 2008 16:19:55 +0200
Message-ID: <1214230796.3223.326.camel@lappy.programming.kicks-ass.net>
References: <20080616110113.GA22945@elte.hu>
	 <7vej6xb4lr.fsf@gitster.siamese.dyndns.org> <20080623094906.GA8284@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Chris Mason <chris.mason@oracle.com>,
	Thomas Gleixner <tglx@linutronix.de>
To: Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Mon Jun 23 16:22:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAmw5-0004kM-OV
	for gcvg-git-2@gmane.org; Mon, 23 Jun 2008 16:22:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753412AbYFWOVR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2008 10:21:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753316AbYFWOVR
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 10:21:17 -0400
Received: from casper.infradead.org ([85.118.1.10]:47057 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752610AbYFWOVQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2008 10:21:16 -0400
Received: from f237116.upc-f.chello.nl ([80.56.237.116] helo=lappy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.69 #1 (Red Hat Linux))
	id 1KAmu0-00054v-EK; Mon, 23 Jun 2008 14:20:16 +0000
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by lappy.programming.kicks-ass.net (Postfix) with ESMTP id CEDEA5C416E;
	Mon, 23 Jun 2008 16:20:21 +0200 (CEST)
In-Reply-To: <20080623094906.GA8284@elte.hu>
X-Mailer: Evolution 2.22.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85865>

On Mon, 2008-06-23 at 11:49 +0200, Ingo Molnar wrote:
> another git-rerere observation: occasionally it happens that i 
> accidentally commit a merge marker into the source code.
> 
> That's obviously stupid, and it normally gets found by testing quickly, 
> but still it would be a really useful avoid-shoot-self-in-foot feature 
> if git-commit could warn about such stupidities of mine.
> 
> ( and if i could configure git-commit to outright reject a commit like 
>   that - i never want to commit lines with <<<<<< or >>>>> markers)
> 
> Another merge conflict observation is that Git is much worse at figuring 
> out the right merge resolution than our previous Quilt based workflow 
> was. I eventually found it to be mainly due to the following detail: 
> sometimes it's more useful to first apply the merged branch and then 
> attempt to merge HEAD, as a patch.
> 
> I've got a script for that which also combines it with the "rej" tool, 
> and in about 70%-80% of the cases where Git is unable to resolve a merge 
> automatically it figures things out. ('rej' is obviously a more relaxed 
> merge utility, but it's fairly robust in my experience, with a very low 
> false positive rate.)
> 
> The ad-hoc "tip-mergetool" script we are using is attached below. It's 
> really just for demonstration purposes - it doesnt work when there's a 
> rename related conflict, etc.
> 
> Peter Zijstra also wrote a git-mergetool extension for the 'rej' tool 
> btw., he might want to post that patch. I've attached Chris Mason's rej 
> tool too.

This is what I run with.

I added the cp to the 3-way merge tools because I think its stupid to
see the messed up merge markers instead of the original file.

The rej target basically takes the local version and takes the diff
between base and remote and applies that as a patch, upon failure it
invokes rej to fix up the mess.

--- /usr/bin/git-mergetool	2008-04-08 19:01:37.000000000 +0200
+++ git-mergetool	2008-06-02 19:00:55.000000000 +0200
@@ -214,12 +214,14 @@ merge_file () {
 	    ;;
 	meld|vimdiff)
 	    touch "$BACKUP"
+	    cp -- "$BASE" "$path"
 	    "$merge_tool_path" -- "$LOCAL" "$path" "$REMOTE"
 	    check_unchanged
 	    save_backup
 	    ;;
 	gvimdiff)
 		touch "$BACKUP"
+		cp -- "$BASE" "$path"
 		"$merge_tool_path" -f -- "$LOCAL" "$path" "$REMOTE"
 		check_unchanged
 		save_backup
@@ -271,6 +273,13 @@ merge_file () {
 	    status=$?
 	    save_backup
 	    ;;
+        rej)
+	    touch "$BACKUP"
+	    cp -- "$LOCAL" "$path"
+	    diff -up "$BASE" "$REMOTE" | patch "$path" || rej "$path"
+	    check_unchanged
+	    save_backup
+	    ;;
     esac
     if test "$status" -ne 0; then
 	echo "merge of $path failed" 1>&2
@@ -311,7 +320,7 @@ done
 
 valid_tool() {
 	case "$1" in
-		kdiff3 | tkdiff | xxdiff | meld | opendiff | emerge | vimdiff | gvimdiff | ecmerge)
+		kdiff3 | tkdiff | xxdiff | meld | opendiff | emerge | vimdiff | gvimdiff | ecmerge | rej)
 			;; # happy
 		*)
 			return 1
