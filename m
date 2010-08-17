From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 15/24] merge script: improve log message subject
Date: Tue, 17 Aug 2010 02:04:43 -0500
Message-ID: <20100817070443.GO22057@burratino>
References: <20100817065147.GA18293@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Lars Hjemli <hjemli@gmail.com>, Tay Ray Chuan <rctay89@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Clemens Buchacher <drizzd@aon.at>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 17 09:06:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlGFe-0000sk-45
	for gcvg-git-2@lo.gmane.org; Tue, 17 Aug 2010 09:06:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756976Ab0HQHGT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Aug 2010 03:06:19 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:64815 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756607Ab0HQHGS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Aug 2010 03:06:18 -0400
Received: by yxg6 with SMTP id 6so2286218yxg.19
        for <git@vger.kernel.org>; Tue, 17 Aug 2010 00:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=Ab98rW2tHl1hRfXLvZ8WzBHRdcemTJisWRxtGh6AH6w=;
        b=LsecWldJ4oWFSSzOKOYNkstOzN4bEff1Avzu37REIr0n4gQ4S5uKeHkrfwSmVenuFK
         aHEgLyxkpZ2xyzvnx/RgbiZbIFdT2w7TDphZNqMVFBbJsrgrN2VRaULLiR+j+4y1QgbP
         N1AyHjCis3ysxCGgRQRC6S68eZAorRNa2ihDU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=RI0x8StzftkYj/RXjiIsjxaak7QKrTL8nB9eOe7+3iSvZ6ujGMQKq1ZjRIdRRYlMJj
         4Kncqj96hhPvx0t1FMXdv50nNhS/5aKeBk3ghQvhlTWwbfJVjJ2u2udkYFl8PjLz6JmA
         8LoLHzb3+uRbsY8M/zfSEfcVOitB4vRZf3VhQ=
Received: by 10.151.79.11 with SMTP id g11mr2498008ybl.219.1282028778379;
        Tue, 17 Aug 2010 00:06:18 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id u41sm576219yba.1.2010.08.17.00.06.17
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 17 Aug 2010 00:06:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100817065147.GA18293@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153718>

 - point out remote-tracking branches as "remote branch
   'upstream/master'";
 - avoid misleading log messages when a tag and branch
   share a name.

This approximates the builtin merge command's behavior well
enough to pass the relevant tests.

Based roughly on v1.6.4.2~10^2 (merge: indicate remote tracking
branches in merge message, 2009-08-09) and v1.6.4.2~10^2~1 (merge: fix
incorrect merge message for ambiguous tag/branch, 2009-08-09).

Cc: Jeff King <peff@peff.net>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 contrib/examples/git-merge.sh |   27 +++++++++++++++++++--------
 1 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/contrib/examples/git-merge.sh b/contrib/examples/git-merge.sh
index 50042df..d491566 100755
--- a/contrib/examples/git-merge.sh
+++ b/contrib/examples/git-merge.sh
@@ -134,21 +134,32 @@ finish () {
 merge_name () {
 	remote="$1"
 	rh=$(git rev-parse --verify "$remote^0" 2>/dev/null) || return
-	bh=$(git show-ref -s --verify "refs/heads/$remote" 2>/dev/null)
-	if test "$rh" = "$bh"
-	then
-		echo "$rh		branch '$remote' of ."
-	elif truname=$(expr "$remote" : '\(.*\)~[1-9][0-9]*$') &&
+	if truname=$(expr "$remote" : '\(.*\)~[0-9]*$') &&
 		git show-ref -q --verify "refs/heads/$truname" 2>/dev/null
 	then
 		echo "$rh		branch '$truname' (early part) of ."
-	elif test "$remote" = "FETCH_HEAD" -a -r "$GIT_DIR/FETCH_HEAD"
+		return
+	fi
+	if found_ref=$(git rev-parse --symbolic-full-name --verify \
+							"$remote" 2>/dev/null)
+	then
+		if test "${found_ref#refs/heads/}" != "$found_ref"
+		then
+			echo "$rh		branch '$remote' of ."
+			return
+		elif test "${found_ref#refs/remotes/}" != "$found_ref"
+		then
+			echo "$rh		remote branch '$remote' of ."
+			return
+		fi
+	fi
+	if test "$remote" = "FETCH_HEAD" -a -r "$GIT_DIR/FETCH_HEAD"
 	then
 		sed -e 's/	not-for-merge	/		/' -e 1q \
 			"$GIT_DIR/FETCH_HEAD"
-	else
-		echo "$rh		commit '$remote'"
+		return
 	fi
+	echo "$rh		commit '$remote'"
 }
 
 parse_config () {
-- 
1.7.2.1.544.ga752d.dirty
