From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] sh updates for 2.6.25
Date: Wed, 16 Apr 2008 13:17:42 -0700 (PDT)
Message-ID: <alpine.LFD.1.00.0804161312330.2879@woody.linux-foundation.org>
References: <20080415172333.GA29489@linux-sh.org> <alpine.LFD.1.00.0804151048060.2879@woody.linux-foundation.org> <20080415183023.GA23098@linux-sh.org> <alpine.LFD.1.00.0804151222350.2879@woody.linux-foundation.org>
 <7vve2hpnz1.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junio@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 16 22:27:28 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JmE5o-000549-N1
	for gcvg-git-2@gmane.org; Wed, 16 Apr 2008 22:18:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753591AbYDPUSL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Apr 2008 16:18:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756525AbYDPUSL
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Apr 2008 16:18:11 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:54328 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753591AbYDPUSJ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Apr 2008 16:18:09 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m3GKHh53028788
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 16 Apr 2008 13:17:44 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m3GKHguD004920;
	Wed, 16 Apr 2008 13:17:43 -0700
In-Reply-To: <7vve2hpnz1.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-3.983 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79743>



On Wed, 16 Apr 2008, Junio C Hamano wrote:
> 
> > @@ -388,6 +383,7 @@ do
> >  			;;
> >  		esac
> >  	esac
> > +	FIRSTLINE=$(head -1 "$dotest/final-commit")
> >  
> >  	resume=
> >  	if test "$interactive" = t
> > @@ -408,7 +404,6 @@ do
> >  		[aA]*) action=yes interactive= ;;
> >  		[nN]*) action=skip ;;
> >  		[eE]*) git_editor "$dotest/final-commit"
> > -		       SUBJECT=$(reread_subject "$dotest/final-commit")
> 
> This needs to be replaced with re-assignment to FIRSTLINE, as the user may
> have fixed the title in the editor; otherwise...

Hmm. I think we could just have moved the assignment of FIRSTLINE it down, 
and had it in just one place. I see you already fixed it up, but maybe a 
patch like this is still a worthy cleanup.

That said - I didn't check that there isn't some subtle intermediate user 
or a break out of the loop or something. So while this patch _looks_ 
obvious and passes the tests, I'm not going to guarantee that there isn't 
some special case. I doubt any of the tests really check things like the 
reflog comments after git-am etc..

		Linus

---
 git-am.sh |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index 245e1db..9a865cc 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -383,7 +383,6 @@ do
 			;;
 		esac
 	esac
-	FIRSTLINE=$(head -1 "$dotest/final-commit")
 
 	resume=
 	if test "$interactive" = t
@@ -404,7 +403,6 @@ do
 		[aA]*) action=yes interactive= ;;
 		[nN]*) action=skip ;;
 		[eE]*) git_editor "$dotest/final-commit"
-		       FIRSTLINE=$(head -1 "$dotest/final-commit")
 		       action=again ;;
 		[vV]*) action=again
 		       LESS=-S ${PAGER:-less} "$dotest/patch" ;;
@@ -427,6 +425,7 @@ do
 		stop_here $this
 	fi
 
+	FIRSTLINE=$(head -1 "$dotest/final-commit")
 	printf 'Applying %s\n' "$FIRSTLINE"
 
 	case "$resolved" in
