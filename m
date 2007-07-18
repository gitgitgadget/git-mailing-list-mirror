From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: [PATCH] Force listingblocks to be monospaced in manpages
Date: Wed, 18 Jul 2007 22:33:57 +0100
Message-ID: <20070719014852.4573.65336.julian@quantumfyre.co.uk>
References: <Pine.LNX.4.64.0707190157430.1964@beast.quantumfyre.co.uk>
Cc: Fredrik Tolf <fredrik@dolda2000.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 19 03:51:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBLBK-0005TN-06
	for gcvg-git@gmane.org; Thu, 19 Jul 2007 03:51:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760932AbXGSBvh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jul 2007 21:51:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760971AbXGSBvh
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jul 2007 21:51:37 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:45335 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760932AbXGSBvg (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Jul 2007 21:51:36 -0400
Received: from neutron.quantumfyre.co.uk (neutron.datavampyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id E1A9BD75C9
	for <git@vger.kernel.org>; Thu, 19 Jul 2007 02:51:34 +0100 (BST)
Received: (qmail 3843 invoked by uid 103); 19 Jul 2007 02:51:34 +0100
Received: from 192.168.0.7 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.91/3689. spamassassin: 3.2.1. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.7):. 
 Processed in 0.025399 secs); 19 Jul 2007 01:51:34 -0000
Received: from beast.quantumfyre.co.uk (192.168.0.7)
  by neutron.datavampyre.co.uk with SMTP; 19 Jul 2007 02:51:34 +0100
X-git-sha1: 17d0459ee87c277303d8e669640b85dcb314da0e 
X-Mailer: git-mail-commits v0.1
In-Reply-To: <Pine.LNX.4.64.0707190157430.1964@beast.quantumfyre.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52923>

For the html output we can use a stylesheet to make sure that the
listingblocks are presented in a monospaced font.  For the manpages do
it manually by inserting a ".ft C" before and ".ft" after the block in
question.  This makes the ascii-art diagrams readable in PS output.

In order for these roff commands to get through to the manpage they
have to be element encoded to prevent quoting.  In particular with
docbook xsl 1.72.0 and newer we have to use U+2302 instead of . to
prevent the roff command being escaped.  We also add a small perl
script for docbook < 1.72.0.

Signed-off-by: Julian Phillips <julian@quantumfyre.co.uk>
---

On Thu, 19 Jul 2007, Julian Phillips wrote:

> On Wed, 18 Jul 2007, Junio C Hamano wrote:
>
>>  I tried with your patch, both with asciidoc7 and asciidoc8.  Did
>>  you really mean "&#x2302;" above?  Replacing them with "."  gave
>>  me a series of these changes (diff between output before and
>>  after your patch with the "s/\&#x2302;/./g" fixup):
>
> I did mean it.  I originally just had .ft, but I was getting \&.ft in the
> manpage, which then just came out as .ft in the console.
>
> I got the &#x2302; from
> http://docbook.sourceforge.net/release/xsl/current/manpages/utility.xsl, so I
> assumed it was the "correct" thing to use ...
>
> This was with asciidoc 7 and docbook xsl stylesheet 1.72.0.
>
>
>>  whatever that 2302 is...
>
> &#x2302; (or U+2302) seems to be a character from the unicode "Misc.
> Technical" section ... looks a bit like a house.
>
> See sixth bullet from
> http://docbook.sourceforge.net/release/xsl/current/RELEASE-NOTES.html#V1.72.0$
>
> looks like it may need to depend on which docbook xsl version you are using
> ...
>
>

I couldn't find any way to detect the docbook version - perhaps someone more
with more knowledge of asciidoc might know?

Otherwise, something like this perhaps?

 Documentation/Makefile          |    3 +++
 Documentation/asciidoc.conf     |    6 ++++++
 Documentation/replace_U+2303.pl |    6 ++++++
 3 files changed, 15 insertions(+), 0 deletions(-)
 create mode 100755 Documentation/replace_U+2303.pl

diff --git a/Documentation/Makefile b/Documentation/Makefile
index b062757..e381b2e 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -121,6 +121,9 @@ clean:
 
 %.1 %.5 %.7 : %.xml
 	xmlto -m callouts.xsl man $<
+	mv $@ $@.tmp
+	./replace_U+2303.pl < $@.tmp > $@
+	$(RM) $@.tmp
 
 %.xml : %.txt
 	$(RM) $@+ $@
diff --git a/Documentation/asciidoc.conf b/Documentation/asciidoc.conf
index 6b6220d..d54fe29 100644
--- a/Documentation/asciidoc.conf
+++ b/Documentation/asciidoc.conf
@@ -27,7 +27,13 @@ ifdef::backend-docbook[]
 [listingblock]
 <example><title>{title}</title>
 <literallayout>
+ifdef::doctype-manpage[]
+&#10;&#x2302;ft C&#10;
+endif::doctype-manpage[]
 |
+ifdef::doctype-manpage[]
+&#10;&#x2302;ft&#10;
+endif::doctype-manpage[]
 </literallayout>
 {title#}</example>
 endif::backend-docbook[]
diff --git a/Documentation/replace_U+2303.pl b/Documentation/replace_U+2303.pl
new file mode 100755
index 0000000..b086949
--- /dev/null
+++ b/Documentation/replace_U+2303.pl
@@ -0,0 +1,6 @@
+#!/usr/bin/perl -w
+
+while ($line = <>) {
+	$line =~ s/^\x{2302}/./;
+	print $line;
+}
-- 
1.5.2.2
