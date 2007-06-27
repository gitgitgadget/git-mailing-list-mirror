From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-submodule: Instead of using only annotated tags, use any tag found in .git/refs/tags
Date: Tue, 26 Jun 2007 23:15:16 -0700
Message-ID: <7vabulrki3.fsf@assigned-by-dhcp.pobox.com>
References: <11829012583562-git-send-email-Emilian.Medve@Freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Emil Medve <Emilian.Medve@Freescale.com>
X-From: git-owner@vger.kernel.org Wed Jun 27 08:15:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3QoD-0000bf-7g
	for gcvg-git@gmane.org; Wed, 27 Jun 2007 08:15:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757344AbXF0GPT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Jun 2007 02:15:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757314AbXF0GPS
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jun 2007 02:15:18 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:38420 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754853AbXF0GPR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jun 2007 02:15:17 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070627061516.EHBU3133.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Wed, 27 Jun 2007 02:15:16 -0400
Received: from assigned-by-dhcp.pobox.com ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id GWFG1X0021kojtg0000000; Wed, 27 Jun 2007 02:15:16 -0400
In-Reply-To: <11829012583562-git-send-email-Emilian.Medve@Freescale.com> (Emil
	Medve's message of "Tue, 26 Jun 2007 18:40:58 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51020>

Emil Medve <Emilian.Medve@Freescale.com> writes:

> Some repositories might not use/have annotated tags (for
> example repositories created with git-cvsimport) and
> git-submodule status might fail because git-describe might
> fail to find a tag.  This change allows the status of a
> submodule to be described/displayed relative to lightweight
> tags as well.

Certainly that is an improvement, as $revname is purely for
commenting and not being able to describe it is not an excuse to
fail the command.

But there may not be any tag at all.  How about something like
this on top?

diff --git a/git-submodule.sh b/git-submodule.sh
index 56ea935..7b6195b 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -133,6 +133,18 @@ modules_update()
 	done
 }
 
+set_name_rev () {
+	revname=$( (
+		unset GIT_DIR &&
+		cd "$1" && {
+			git-describe "$2" 2>/dev/null ||
+			git-describe --tags "$2" 2>/dev/null ||
+			git-describe --contains --tags "$2"
+		}
+	) )
+	test -z "$revname" || revname=" ($revname)"
+}
+
 #
 # List all submodules, prefixed with:
 #  - submodule not initialized
@@ -156,16 +168,17 @@ modules_list()
 			continue;
 		fi
 		revname=$(unset GIT_DIR && cd "$path" && git-describe --tags $sha1)
+		set_name_rev "$path" $"sha1"
 		if git diff-files --quiet -- "$path"
 		then
-			say " $sha1 $path ($revname)"
+			say " $sha1 $path$revname"
 		else
 			if test -z "$cached"
 			then
 				sha1=$(unset GIT_DIR && cd "$path" && git-rev-parse --verify HEAD)
-				revname=$(unset GIT_DIR && cd "$path" && git-describe --tags $sha1)
+				set_name_rev "$path" $"sha1"
 			fi
-			say "+$sha1 $path ($revname)"
+			say "+$sha1 $path$revname"
 		fi
 	done
 }
