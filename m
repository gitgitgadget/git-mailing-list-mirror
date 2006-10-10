From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] repack: allow simultaneous packing and pruning
Date: Tue, 10 Oct 2006 13:24:23 -0700
Message-ID: <7vk637zzpk.fsf@assigned-by-dhcp.cox.net>
References: <20061010102210.568341380D6@magnus.utsl.gen.nz>
	<Pine.LNX.4.64.0610100800490.3952@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sam Vilain <sam@vilain.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 10 22:24:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXO9M-0005oA-5I
	for gcvg-git@gmane.org; Tue, 10 Oct 2006 22:24:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030281AbWJJUYZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Oct 2006 16:24:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030282AbWJJUYZ
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Oct 2006 16:24:25 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:39083 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1030281AbWJJUYZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Oct 2006 16:24:25 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061010202424.ZNTK12581.fed1rmmtao02.cox.net@fed1rmimpo02.cox.net>;
          Tue, 10 Oct 2006 16:24:24 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id YkQT1V0051kojtg0000000
	Tue, 10 Oct 2006 16:24:27 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0610100800490.3952@g5.osdl.org> (Linus Torvalds's
	message of "Tue, 10 Oct 2006 08:03:54 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28662>

Linus Torvalds <torvalds@osdl.org> writes:

> On Tue, 10 Oct 2006, Sam Vilain wrote:
>>
>> If using git-repack -a, unreferenced objects are kept behind in the
>> pack.  This might be the best default, but there are no good ways
>> to clean up the packfiles if a lot of rebasing is happening, or
>> branches have been deleted.
>
> Don't do this.
>
> I understand why you want to do it, but the fact is, it's dangerous.

Sorry, I understand "it's dangerous" part, but I do not
understand "why you want to do it" part.

@@ -32,6 +33,11 @@ case ",$all_into_one," in
 ,,)
 	rev_list='--unpacked'
 	pack_objects='--incremental'
+	if [ -n "$prune" ]
+	then
+	    # prune junk first
+	    git-prune
+	fi
 	;;
 ,t,)
 	rev_list=

This shouldn't make any difference if the repository is
quiescent (and is dangerous if it isn't).  pack-objects will
not get fed things that are not reachable.

@@ -40,8 +46,14 @@ case ",$all_into_one," in
 	# Redundancy check in all-into-one case is trivial.
 	existing=`cd "$PACKDIR" && \
 	    find . -type f \( -name '*.pack' -o -name '*.idx' \) -print`
+
+	if [ -n "$prune" ]
+	then
+	    rev_list=`cd "$GIT_DIR" && find refs -type f -print`
+	fi
 	;;
 esac
+

We give --all to rev-list so this should not have any effect
either; other than that the code introduced by this hunk is
broken with packed-refs.

Isn't "repack -a -d" what Sam wants?
