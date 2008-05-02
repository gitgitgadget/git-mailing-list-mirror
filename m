From: Michele Ballabio <barra_cuda@katamail.com>
Subject: [PATCH] gitk: disable "Reset %s branch to here" when on a detached head
Date: Fri, 2 May 2008 17:46:20 +0200
Message-ID: <200805021746.20883.barra_cuda@katamail.com>
References: <200803181535.53635.barra_cuda@katamail.com> <18459.3700.934377.597975@cargo.ozlabs.ibm.com> <200805021656.57929.barra_cuda@katamail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Fri May 02 17:44:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JrxQz-0003uF-Aw
	for gcvg-git-2@gmane.org; Fri, 02 May 2008 17:44:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935700AbYEBPnm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2008 11:43:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760729AbYEBPnm
	(ORCPT <rfc822;git-outgoing>); Fri, 2 May 2008 11:43:42 -0400
Received: from smtp.katamail.com ([62.149.157.154]:38543 "HELO
	smtp1.pc.aruba.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S932512AbYEBPnl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2008 11:43:41 -0400
Received: (qmail 19498 invoked by uid 89); 2 May 2008 15:38:34 -0000
X-Spam-Checker-Version: SpamAssassin 3.2.3 (2007-08-08) on smtp2-pc
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=5.0 tests=RDNS_NONE autolearn=disabled
	version=3.2.3
Received: from unknown (HELO host101-57-static.104-80-b.business.telecomitalia.it) (barra?cuda@katamail.com@80.104.57.101)
  by smtp2-pc with SMTP; 2 May 2008 15:38:30 -0000
User-Agent: KMail/1.9.7
In-Reply-To: <200805021656.57929.barra_cuda@katamail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81008>

When we are on a detached head - since gitk does not display where
we are - reset has no sense, so disable the relevant line on the
context menu, and point out to the user that we are on a detached head.

Otherwise, a reset from gitk when on a detached head returns the
error:

can't read "headids()": no such element in array
can't read "headids()": no such element in array
    while executing
"removehead $headids($name) $name"
    (procedure "movehead" line 4)
    invoked from within
"movehead $newhead $mainhead"
    (procedure "readresetstat" line 20)
    invoked from within
"readresetstat file4"
    ("eval" body line 1)
    invoked from within
"eval $script"
    (procedure "dorunq" line 9)
    invoked from within
"dorunq"
    ("after" script)

Signed-off-by: Michele Ballabio <barra_cuda@katamail.com>
---

On Friday 02 May 2008, Michele Ballabio wrote:
> On Friday 02 May 2008, Paul Mackerras wrote:
> > I wonder if we can make this message something more appropriate than
> > "Reset  branch to here" (since $mainhead has to be the empty string
> > here)?  Not sure what I would suggest though. :)
> 
> Oh, you're right. I'd say either "Reset detached head to here" greyed out
> (i.e. change the words as little as possible), or something more
> explicative like "Detached head: reset not possible". I'd go for the first,

Here's the updated patch.

 gitk |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/gitk b/gitk
index da685aa..23247ff 100755
--- a/gitk
+++ b/gitk
@@ -6016,7 +6016,11 @@ proc rowmenu {x y id} {
     }
     if {$id ne $nullid && $id ne $nullid2} {
 	set menu $rowctxmenu
-	$menu entryconfigure 7 -label [mc "Reset %s branch to here" $mainhead]
+	if {$mainhead ne {}} {
+	    $menu entryconfigure 7 -label [mc "Reset %s branch to here" $mainhead]
+	} else {
+	    $menu entryconfigure 7 -label [mc "Reset detached head to here" $mainhead] -state disabled
+	}
     } else {
 	set menu $fakerowmenu
     }
-- 
1.5.5.1
