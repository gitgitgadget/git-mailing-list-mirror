From: Gerrit Pape <pape@smarden.org>
Subject: Re: [PATCH] git-merge: do up-to-date check also for strategies ours, subtree.
Date: Fri, 10 Aug 2007 13:58:15 +0000
Message-ID: <20070810135815.15682.qmail@16a33814590a07.315fe32.mid.smarden.org>
References: <20070809120831.19319.qmail@a61af064a2a242.315fe32.mid.smarden.org> <7v3aysxvk3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 10 15:58:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJV07-0002dv-6e
	for gcvg-git@gmane.org; Fri, 10 Aug 2007 15:58:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764937AbXHJN55 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Aug 2007 09:57:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764598AbXHJN55
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Aug 2007 09:57:57 -0400
Received: from a.ns.smarden.org ([212.42.242.37]:59258 "HELO a.mx.smarden.org"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with SMTP
	id S1760810AbXHJN54 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Aug 2007 09:57:56 -0400
Received: (qmail 15683 invoked by uid 1000); 10 Aug 2007 13:58:15 -0000
Mail-Followup-To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Disposition: inline
In-Reply-To: <7v3aysxvk3.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55540>

On Thu, Aug 09, 2007 at 02:11:24PM -0700, Junio C Hamano wrote:
> Right now I do not have time to dig mailing list archive around
> mid March 2006, and I do not recall the requestor's original
> rationale, but I have a vague recollection that we added this
> "no fast-forward check" specifically in response to a user
> request.

Hmm, I don't think my patch affects fast-forwards at all, it checks for
no_trivial_merge_strategies whether the remote, that should be merged,
has any commits that are not in the current head.  If not, no merge
strategy should have to do anything.

The patch moves the first case switch at the third position.  If, with
the patch, the first switch matches, it doesn't change behavior as it
does the same as the third; if the second switch matches, git-merge will
report 'Already up-to-date.' and exit.

This is with the patch:

 $ (git init && touch foo && git add foo && git commit -m foo) >/dev/null
 $ git checkout -b b
 Switched to a new branch "b"
 $ (touch bar && git add bar && git commit -m bar) >/dev/null
 $ git checkout master
 Switched to branch "master"
 $ git merge b
 Updating 769e777..8a03d99
 Fast forward
  0 files changed, 0 insertions(+), 0 deletions(-)
  create mode 100644 bar
 $ git reset --hard HEAD^
 HEAD is now at 769e777... foo
 $ git merge -s ours b
 Merge made by ours.
 $ git show
 commit f0dc487c15e502bc7ee823b6907468eb78668dbb
 Author: Gerrit Pape <pape@smarden.org>
 Date:   Fri Aug 10 13:44:10 2007 +0000
 
     Merge branch 'b'
 
 diff --git a/bar b/bar
 deleted file mode 100644
 index e69de29..0000000
 $ git merge -s ours b
 Already up-to-date.
 $ 

Without the patch, the last command results in

 $ git merge -s ours b
 Merge made by ours.
 $ git show
 commit 21154261ff23f64fc38e8a2ae79c7a1cccaeacd4
 Author: Gerrit Pape <pape@smarden.org>
 Date:   Fri Aug 10 13:48:54 2007 +0000
 
     Merge branch 'b'
 $ 

Regards, Gerrit.
