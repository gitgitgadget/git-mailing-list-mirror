From: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
Subject: [PATCH 13/20] cvsserver: define a tag name character escape mechanism
Date: Sat, 13 Oct 2012 23:42:26 -0600
Message-ID: <1350193353-19210-14-git-send-email-mmogilvi_git@miniinfo.net>
References: <1350193353-19210-1-git-send-email-mmogilvi_git@miniinfo.net>
Cc: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 14 07:58:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNHDc-00073P-4K
	for gcvg-git-2@plane.gmane.org; Sun, 14 Oct 2012 07:58:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752154Ab2JNF6E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2012 01:58:04 -0400
Received: from qmta07.emeryville.ca.mail.comcast.net ([76.96.30.64]:48414 "EHLO
	qmta07.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751343Ab2JNF6D (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Oct 2012 01:58:03 -0400
Received: from omta03.emeryville.ca.mail.comcast.net ([76.96.30.27])
	by qmta07.emeryville.ca.mail.comcast.net with comcast
	id Aty21k0020b6N64A7ty2Kz; Sun, 14 Oct 2012 05:58:02 +0000
Received: from mmogilvi.homeip.net ([24.9.53.136])
	by omta03.emeryville.ca.mail.comcast.net with comcast
	id Att11k00B2wKXRC8Ptt1qp; Sun, 14 Oct 2012 05:53:02 +0000
Received: by mmogilvi.homeip.net (Postfix, from userid 501)
	id D67C51E96024; Sat, 13 Oct 2012 23:43:19 -0600 (MDT)
X-Mailer: git-send-email 1.7.10.2.484.gcd07cc5
In-Reply-To: <1350193353-19210-1-git-send-email-mmogilvi_git@miniinfo.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207632>

CVS tags are officially only allowed to use [-_0-9A-Za-f].  Git
refs commonly uses other characters, especially [./].  Such characters
need to be escaped from CVS in order to be referenced.

This just defines functions to escape/unescape names.  The functions
are not used yet.

Signed-off-by: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
---
 git-cvsserver.perl | 91 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 91 insertions(+)

diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index 1d929df..4eecc0b 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -3807,6 +3807,97 @@ sub gethistorydense
     return $result;
 }
 
+=head2 escapeRefName
+
+Apply an escape mechanism to compensate for characters that
+git ref names can have that CVS tags can not.
+
+=cut
+sub escapeRefName
+{
+    my($self,$refName)=@_;
+
+    # CVS officially only allows [-_A-Za-z0-9] in tag names (or in
+    # many contexts it can also be a CVS revision number).
+    #
+    # Git tags commonly use '/' and '.' as well, but also handle
+    # anything else just in case:
+    #
+    #   = "_-s-"  For '/'.
+    #   = "_-p-"  For '.'.
+    #   = "_-u-"  For underscore, in case someone wants a literal "_-" in
+    #     a tag name.
+    #   = "_-xx-" Where "xx" is the hexadecimal representation of the
+    #     desired ASCII character byte. (for anything else)
+
+    if(! $refName=~/^[1-9][0-9]*(\.[1-9][0-9]*)*$/)
+    {
+        $refName=~s/_-/_-u--/g;
+        $refName=~s/\./_-p-/g;
+        $refName=~s%/%_-s-%g;
+        $refName=~s/[^-_a-zA-Z0-9]/sprintf("_-%02x-",$1)/eg;
+    }
+}
+
+=head2 unescapeRefName
+
+Undo an escape mechanism to compensate for characters that
+git ref names can have that CVS tags can not.
+
+=cut
+sub unescapeRefName
+{
+    my($self,$refName)=@_;
+
+    # see escapeRefName() for description of escape mechanism.
+
+    $refName=~s/_-([spu]|[0-9a-f][0-9a-f])-/unescapeRefNameChar($1)/eg;
+
+    # allowed tag names
+    # TODO: Perhaps use git check-ref-format, with an in-process cache of
+    #  validated names?
+    if( !( $refName=~m%^[^-][-a-zA-Z0-9_/.]*$% ) ||
+        ( $refName=~m%[/.]$% ) ||
+        ( $refName=~/\.lock$/ ) ||
+        ( $refName=~m%\.\.|/\.|[[\\:?*~]|\@\{% ) )  # matching }
+    {
+        # Error:
+        $log->warn("illegal refName: $refName");
+        $refName=undef;
+    }
+    return $refName;
+}
+
+sub unescapeRefNameChar
+{
+    my($char)=@_;
+
+    if($char eq "s")
+    {
+        $char="/";
+    }
+    elsif($char eq "p")
+    {
+        $char=".";
+    }
+    elsif($char eq "u")
+    {
+        $char="_";
+    }
+    elsif($char=~/^[0-9a-f][0-9a-f]$/)
+    {
+        $char=chr(hex($char));
+    }
+    else
+    {
+        # Error case: Maybe it has come straight from user, and
+        # wasn't supposed to be escaped?  Restore it the way we got it:
+        $char="_-$char-";
+    }
+
+    return $char;
+}
+
 =head2 in_array()
 
 from Array::PAT - mimics the in_array() function
-- 
1.7.10.2.484.gcd07cc5
