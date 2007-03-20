From: Andy Parkins <andyparkins@gmail.com>
Subject: [PATCH 2/4] update-hook: show the contents of the tag message for annotated tags
Date: Tue, 20 Mar 2007 10:58:38 +0000
Message-ID: <200703201058.38519.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 20 11:59:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTc3b-0002Za-I2
	for gcvg-git@gmane.org; Tue, 20 Mar 2007 11:59:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753670AbXCTK6o (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Mar 2007 06:58:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753677AbXCTK6o
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Mar 2007 06:58:44 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:10871 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753670AbXCTK6m (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Mar 2007 06:58:42 -0400
Received: by nf-out-0910.google.com with SMTP id o25so299723nfa
        for <git@vger.kernel.org>; Tue, 20 Mar 2007 03:58:41 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:date:subject:to:x-tuid:x-uid:x-length:mime-version:content-transfer-encoding:content-disposition:message-id;
        b=Q3kGZA3y028+zJ3htGxrSe+33K6MEeHkyDE/Hs1NF9M6LtZhj8hQlG1U61AZFI6gMM0WJJb8mhQ27Dwd/v0rW1YQkHJINzpr7nd55Ga+V+NZbyRde+r5YA6cSxvl1zh00va4oesqIhSS1JnCuwb2u1D+jIWNAnJmks2IHRbxQIc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:date:subject:to:x-tuid:x-uid:x-length:mime-version:content-transfer-encoding:content-disposition:message-id;
        b=Wl5WN/1EQfcvylt94mhSz+ZC9oj3PwZPyhoyOeO8KPOPx1l0bGG/zTPsxC/gElq8h/9nk6mvezodmKXvxTxvYdzX5na/67a5B9u3fgQAGgpJJS6LZ+ne91QWRyrBcg6T0rWAXMs/oE6wJRn8v618498cYDSQU3d+51dtSFPFFh4=
Received: by 10.78.193.19 with SMTP id q19mr1811175huf.1174388320989;
        Tue, 20 Mar 2007 03:58:40 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTP id o45sm1541495nfa.2007.03.20.03.58.39;
        Tue, 20 Mar 2007 03:58:40 -0700 (PDT)
X-TUID: aaae46035a53852a
X-UID: 293
X-Length: 1624
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42737>

The annotated tag points at a commit, for which we show the short log.
However, the tag itself contains a message, possibly release notes or
hand-written change log - whatever it contains is worth showing.  The
tag message is extracted with

  git cat-file tag $newrev | tail -q -n +5

Which is dangerously reliant on the format of the tag object being four
header lines then the message.  I don't like it, but I don't know of any
other way of extracting the message.  It's also missing any kind of
support for the GPG signature.

Signed-off-by: Andy Parkins <andyparkins@gmail.com>
---
 templates/hooks--update |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/templates/hooks--update b/templates/hooks--update
index 1a60773..31e72ca 100644
--- a/templates/hooks--update
+++ b/templates/hooks--update
@@ -231,8 +231,14 @@ case "$refname_type" in
 
 		echo ""
 		echo $LOGBEGIN
-		echo ""
 
+		# Show the content of the tag message; this might contain a change log
+		# or release notes so is worth displaying.  "tail -n +5" is there to
+		# remove the first 4 lines of the tag object, those details have
+		# already been summarised above
+		git cat-file tag $newrev | tail -q -n +5
+
+		echo ""
 		if [ -n "$prevtag" ]; then
 			git rev-list --pretty=short "$prevtag..$newrev" | git shortlog
 		else
-- 
1.5.0.3.402.g0c48
