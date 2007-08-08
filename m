From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [install info (using perl) 1/2] Add support for an info version of the user manual
Date: Wed, 08 Aug 2007 16:18:48 -0700
Message-ID: <7v1wed1up3.fsf@assigned-by-dhcp.cox.net>
References: <591c5679ea79b76cd5db57443b1d691bde842351.1186484406.git.dak@gnu.org>
	<7vabt11vkj.fsf@assigned-by-dhcp.cox.net>
	<7v643p1vbr.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Thu Aug 09 01:19:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIuoI-0000Hx-4t
	for gcvg-git@gmane.org; Thu, 09 Aug 2007 01:19:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764234AbXHHXSw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Aug 2007 19:18:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763979AbXHHXSv
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Aug 2007 19:18:51 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:57567 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763941AbXHHXSu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2007 19:18:50 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070808231848.DGQV7956.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Wed, 8 Aug 2007 19:18:48 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id ZbJp1X00K1kojtg0000000; Wed, 08 Aug 2007 19:18:49 -0400
In-Reply-To: <7v643p1vbr.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Wed, 08 Aug 2007 16:05:12 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55394>

Junio C Hamano <gitster@pobox.com> writes:

>> This part worries me.
>
> Aside from possible portability issue of multi-line script,
> there is another slight problem I am not sure if it is worth
> fixing.  If you do not have docbook2x-texi installed, nobody
> notices that resulting $*.texi was a garbage and an almost empty
> git.info is generated.

How about doing something like this instead?

---

 Documentation/Makefile      |   13 ++++---------
 Documentation/fix-texi.perl |   15 +++++++++++++++
 2 files changed, 19 insertions(+), 9 deletions(-)
 create mode 100755 Documentation/fix-texi.perl

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 56d12aa..8c33729 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -154,16 +154,11 @@ user-manual.html: user-manual.xml
 	xsltproc $(XSLTOPTS) -o $@ $(XSLT) $<
 
 git.info: user-manual.xml
-	$(RM) $@ $*.texi
-	$(DOCBOOK2X_TEXI) user-manual.xml --to-stdout | \
-	perl -ne 'if (/^\@setfilename/) {$$_="\@setfilename git.info\
-"} elsif (/^\@direntry/) {print "\@dircategory Development\
-\@direntry\
-* Git: (git).           A fast distributed revision control system\
-\@end direntry\
-"} print unless (/^\@direntry/ .. /^\@end direntry/)' > $*.texi
+	$(RM) $@ $*.texi $*.texi+
+	$(DOCBOOK2X_TEXI) user-manual.xml --to-stdout >$*.texi+
+	perl fix-texi.perl <$*.texi+ >$*.texi
 	$(MAKEINFO) --no-split $*.texi
-	$(RM) $*.texi
+	$(RM) $*.texi $*.texi+
 
 howto-index.txt: howto-index.sh $(wildcard howto/*.txt)
 	$(RM) $@+ $@
diff --git a/Documentation/fix-texi.perl b/Documentation/fix-texi.perl
new file mode 100755
index 0000000..ff7d78f
--- /dev/null
+++ b/Documentation/fix-texi.perl
@@ -0,0 +1,15 @@
+#!/usr/bin/perl -w
+
+while (<>) {
+	if (/^\@setfilename/) {
+		$_ = "\@setfilename git.info\n";
+	} elsif (/^\@direntry/) {
+		print '@dircategory Development
+@direntry
+* Git: (git).           A fast distributed revision control system
+@end direntry
+';	}
+	unless (/^\@direntry/../^\@end direntry/) {
+		print;
+	}
+}
