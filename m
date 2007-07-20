From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: [PATCH] Update listingblock monospace fix to support all docbook
	versions
Date: Fri, 20 Jul 2007 13:06:21 +0100
Message-ID: <20070720121153.23352.73276.julian@quantumfyre.co.uk>
References: <Pine.LNX.4.64.0707200806540.20056@beast.quantumfyre.co.uk>
Cc: Fredrik Tolf <fredrik@dolda2000.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 20 14:16:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBrPG-00062K-Lr
	for gcvg-git@gmane.org; Fri, 20 Jul 2007 14:16:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753664AbXGTMQV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Jul 2007 08:16:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754299AbXGTMQV
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jul 2007 08:16:21 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:51731 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753664AbXGTMQT (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Jul 2007 08:16:19 -0400
Received: from neutron.quantumfyre.co.uk (neutron.datavampyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id 69817C611C
	for <git@vger.kernel.org>; Fri, 20 Jul 2007 13:16:18 +0100 (BST)
Received: (qmail 6384 invoked by uid 103); 20 Jul 2007 13:16:18 +0100
Received: from 192.168.0.7 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.91/3701. spamassassin: 3.2.1. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.7):. 
 Processed in 0.025622 secs); 20 Jul 2007 12:16:18 -0000
Received: from beast.quantumfyre.co.uk (192.168.0.7)
  by neutron.datavampyre.co.uk with SMTP; 20 Jul 2007 13:16:17 +0100
X-git-sha1: 0776e7ff1bd8cf45bd19a93656b64745fdc079a3 
X-Mailer: git-mail-commits v0.1
In-Reply-To: <Pine.LNX.4.64.0707200806540.20056@beast.quantumfyre.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53088>

The previous fix to force the listingblock to be monospaced would not
work for docbook versions 1.72 or newer, as they now escape leading
'.'s and you have to use U+2302 instead.  However you can't use U+2302
in ealier versions ...

So this uses the string '#GIT#SET#MAN#FONT#', and then changes that to
.ft using a post-process perl script.

Not pretty, but it works.

Signed-off-by: Julian Phillips <julian@quantumfyre.co.uk>
---

On Fri, 20 Jul 2007, Julian Phillips wrote:

> On Fri, 20 Jul 2007, Junio C Hamano wrote:
>
>>  Julian Phillips <julian@quantumfyre.co.uk> writes:
>>
>> >  In order for these roff commands to get through to the manpage they
>> >  have to be element encoded to prevent quoting.  In particular with
>> >  docbook xsl 1.72.0 and newer we have to use U+2302 instead of . to
>> >  prevent the roff command being escaped.  We also add a small perl
>> >  script for docbook < 1.72.0.
>>
>>  This does not work at all for docbook 1.71.  I get "^<TAB>ft C"
>>  as output from xmlto.
>
> Oh, well ... that's handy? :S
>
> I've just checked, and I do have a machine with docbook < 1.72, so I'll see
> if I can get something working on both.  Probably early next week since I'm
> away this weekend.

This works ... but I'm not particularly proud of it.

I've done this a patch ontop of master, since you seem to have already pushed
out the tweaked version of my original patch.

 Documentation/Makefile                    |    3 +++
 Documentation/asciidoc.conf               |    4 ++--
 Documentation/insert_man_font_commands.pl |    6 ++++++
 3 files changed, 11 insertions(+), 2 deletions(-)
 create mode 100755 Documentation/insert_man_font_commands.pl

diff --git a/Documentation/Makefile b/Documentation/Makefile
index b062757..70f4b44 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -121,6 +121,9 @@ clean:
 
 %.1 %.5 %.7 : %.xml
 	xmlto -m callouts.xsl man $<
+	mv $@ $@.tmp
+	./insert_man_font_commands.pl < $@.tmp > $@
+	$(RM) $@.tmp
 
 %.xml : %.txt
 	$(RM) $@+ $@
diff --git a/Documentation/asciidoc.conf b/Documentation/asciidoc.conf
index af5b155..83fa03f 100644
--- a/Documentation/asciidoc.conf
+++ b/Documentation/asciidoc.conf
@@ -28,11 +28,11 @@ ifdef::backend-docbook[]
 <example><title>{title}</title>
 <literallayout>
 ifdef::doctype-manpage[]
-&#10;.ft C&#10;
+&#10;#GIT#SET#MAN#FONT# C&#10;
 endif::doctype-manpage[]
 |
 ifdef::doctype-manpage[]
-&#10;.ft&#10;
+&#10;#GIT#SET#MAN#FONT#&#10;
 endif::doctype-manpage[]
 </literallayout>
 {title#}</example>
diff --git a/Documentation/insert_man_font_commands.pl b/Documentation/insert_man_font_commands.pl
new file mode 100755
index 0000000..c100534
--- /dev/null
+++ b/Documentation/insert_man_font_commands.pl
@@ -0,0 +1,6 @@
+#!/usr/bin/perl -w
+
+while ($line = <>) {
+	$line =~ s/^#GIT#SET#MAN#FONT#/.ft/;
+	print $line;
+}
-- 
1.5.2.2
