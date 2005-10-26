From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Avoid using dc in git-count-objects
Date: Wed, 26 Oct 2005 10:58:57 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0510261057560.26001@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0510260120260.28994@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vd5ltcf05.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0510261031400.7424@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 26 11:01:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EUh7f-0002Rj-Fe
	for gcvg-git@gmane.org; Wed, 26 Oct 2005 10:59:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932601AbVJZI67 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 26 Oct 2005 04:58:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932603AbVJZI67
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Oct 2005 04:58:59 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:51682 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932601AbVJZI67 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Oct 2005 04:58:59 -0400
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 156C113F307; Wed, 26 Oct 2005 10:58:58 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id EA8F7B0D88; Wed, 26 Oct 2005 10:58:57 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id C2674B0D5E; Wed, 26 Oct 2005 10:58:57 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id A631713F307; Wed, 26 Oct 2005 10:58:57 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <Pine.LNX.4.63.0510261031400.7424@wbgn013.biozentrum.uni-wuerzburg.de>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10657>

Hi,

On Wed, 26 Oct 2005, Johannes Schindelin wrote:

> On Tue, 25 Oct 2005, Junio C Hamano wrote:
> 
> > Sorry, but I am not very happy about this patch.  "local"
> > bashism aside, doesn't this spawn expr for every unpacked
> > object?
> 
> Aargh! I had the impression "expr" was a builtin... Just forget about 
> the patch, okay?

This patch should be better:

diff --git a/git-count-objects.sh b/git-count-objects.sh
index 843d2fd..ceb1ff2 100755
--- a/git-count-objects.sh
+++ b/git-count-objects.sh
@@ -2,6 +2,19 @@
 
 . git-sh-setup
 
+case $SHELL in
+*bash)
+	function dc () {
+		while read a b; do
+			case $a,$b in
+			0,) result=0;;
+			*,+) result=$(($result+$a));;
+			p,) echo $result
+			esac
+		done
+	}
+esac
+
 echo $(find "$GIT_DIR/objects"/?? -type f -print 2>/dev/null | wc -l) objects, \
 $({
     echo 0
