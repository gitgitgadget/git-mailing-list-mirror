From: "Medve Emilian-EMMEDVE1" <Emilian.Medve@freescale.com>
Subject: RE: [PATCH] git-submodule: Instead of using only annotated tags, use any tag found in .git/refs/tags
Date: Wed, 27 Jun 2007 05:20:02 -0700
Message-ID: <598D5675D34BE349929AF5EDE9B03E27011CFD8F@az33exm24.fsl.freescale.net>
References: <11829012583562-git-send-email-Emilian.Medve@Freescale.com> <7vabulrki3.fsf@assigned-by-dhcp.pobox.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 27 14:20:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3WW2-0007tD-5T
	for gcvg-git@gmane.org; Wed, 27 Jun 2007 14:20:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759384AbXF0MUP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Jun 2007 08:20:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757704AbXF0MUO
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jun 2007 08:20:14 -0400
Received: from de01egw02.freescale.net ([192.88.165.103]:64089 "EHLO
	de01egw02.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759732AbXF0MUH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Jun 2007 08:20:07 -0400
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id l5RCK3PJ018325
	for <git@vger.kernel.org>; Wed, 27 Jun 2007 05:20:03 -0700 (MST)
Received: from az33exm24.fsl.freescale.net (az33exm24.am.freescale.net [10.64.32.14])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l5RCK2GG019959
	for <git@vger.kernel.org>; Wed, 27 Jun 2007 07:20:03 -0500 (CDT)
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
In-Reply-To: <7vabulrki3.fsf@assigned-by-dhcp.pobox.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] git-submodule: Instead of using only annotated tags, use any tag found in .git/refs/tags
Thread-Index: Ace4goqFHq+56ZpbRt2KKnEbUVYNOAAMQChQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51033>

Hello Junio,


You're right and there might be no tag at all, thus --contains might
return an undefined. In the spirit of best effort maybe we should try
--all (which I don't think that can fail and it will return something
more relevant then undefined, i.e. the branch of the commit) if
--contains returns undefined. I'll submit a patch to reflect this.
Opinions?

While playing with git-describe I noticed that the --all option is maybe
not trying first to find a tag as the man page suggests but it goes
directly for .git/refs. Here is some output from my git repo clone with
yesterday's head on the master branch:

$ git-describe aeb59328453cd4f438345ea79ff04c96bccbbbb8
v1.5.2.2-549-gaeb5932

$ git-describe --all aeb59328453cd4f438345ea79ff04c96bccbbbb8
heads/master

Do you think we want to fix that? If yes, I could look into it and
submit a patch.



Cheers,
Emil.


This e-mail, and any associated attachments have been classified as:
--------------------------------------------------------------------
[x] Public
[ ] Freescale Semiconductor Internal Use Only
[ ] Freescale Semiconductor Confidential Proprietary


-----Original Message-----
From: Junio C Hamano [mailto:gitster@pobox.com] 
Sent: Wednesday, June 27, 2007 1:15 AM
To: Medve Emilian-EMMEDVE1
Cc: git@vger.kernel.org
Subject: Re: [PATCH] git-submodule: Instead of using only annotated
tags, use any tag found in .git/refs/tags

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
 		revname=$(unset GIT_DIR && cd "$path" && git-describe
--tags $sha1)
+		set_name_rev "$path" $"sha1"
 		if git diff-files --quiet -- "$path"
 		then
-			say " $sha1 $path ($revname)"
+			say " $sha1 $path$revname"
 		else
 			if test -z "$cached"
 			then
 				sha1=$(unset GIT_DIR && cd "$path" &&
git-rev-parse --verify HEAD)
-				revname=$(unset GIT_DIR && cd "$path" &&
git-describe --tags $sha1)
+				set_name_rev "$path" $"sha1"
 			fi
-			say "+$sha1 $path ($revname)"
+			say "+$sha1 $path$revname"
 		fi
 	done
 }
