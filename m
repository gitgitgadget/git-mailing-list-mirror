From: Francis Daly <francis@daoine.org>
Subject: [PATCH] Tweak asciidoc output to work with broken docbook-xsl
Date: Sun, 5 Mar 2006 23:13:36 +0000
Message-ID: <20060305231336.GA21797@craic.sysops.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Mar 06 00:21:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FG2XH-0005wO-03
	for gcvg-git@gmane.org; Mon, 06 Mar 2006 00:21:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751281AbWCEXUg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Mar 2006 18:20:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751901AbWCEXUg
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Mar 2006 18:20:36 -0500
Received: from craic.sysops.org ([217.75.2.2]:7822 "EHLO craic.sysops.org")
	by vger.kernel.org with ESMTP id S1751281AbWCEXUf (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Mar 2006 18:20:35 -0500
Received: from craic.sysops.org (craic.sysops.org [127.0.0.1])
	by craic.sysops.org (8.12.11/8.12.11) with SMTP id k25NDajj021804
	for <git@vger.kernel.org>; Sun, 5 Mar 2006 23:13:36 GMT
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-Virus-Scanned: ClamAV 0.87.1/1314/Sat Mar  4 13:39:05 2006 on craic.sysops.org
X-Virus-Status: Clean
X-Spam-Status: No, hits=-1.2 required=2.0
	tests=HTML_00_10,HTML_MESSAGE,USER_AGENT_MUTT
	version=2.55
X-Spam-Checker-Version: SpamAssassin 2.55 (1.174.2.19-2003-05-19-exp)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17250>

docbook-xsl v1.68 incorrectly converts "<screen>" from docbook to
manpage by not rendering it verbatim. v1.69 handles it correctly, but
not many current popular distributions ship with it.

asciidoc by default converts "listingblock" to "<screen>". This change
causes asciidoc in git to convert "listingblock" to "<literallayout>", which
both old and new docbook-xsl handle correctly.

The difference can be seen in any manpage which includes a multi-line
example, such as git-branch.

---
This one may want some consideration, because it involves changing how
git interacts with asciidoc in order to make up for how an older version
of docbook-xsl is broken. Clear?

What version of docbook-xsl are people who make git manpages using? If
it's not 1.69, the manpages (at least, those with multi-line examples)
display incorrectly. Many current popular distributions seem to be using
version 1.68.

http://www.kernel.org/pub/software/scm/git/RPMS/x86_64/git-core-1.2.4-1.x86_64.rpm

ftp://ftp.kddlabs.co.jp/pub/Linux/packages/fedora/extras/4/i386/git-core-1.2.4-1.fc4.i386.rpm

(found on pbone, with "redhat/" removed from url; for Fedora 4)

The 1.2.1 packages linked from http://packages.debian.org/unstable/devel/git-core

all show the errors.

ftp://ftp.kddlabs.co.jp/pub/Linux/packages/fedora/extras/development/i386/git-core-1.2.4-1.fc5.i386.rpm

(found on pbone, with "redhat/" removed from the url; for Fedora Other,
presumably 5)

is correct.

Clearly the *right* solution is for binary builders to update their
toolchains. Maybe leaving this as-is will be an impetus for them to do so.

Below is a not-right workaround which allows the git manpages render
correctly when built by someone with an old docbook-xsl package.

If this is acceptable, all well and good. If not, I'll contact the package
builders and invite them to upgrade or patch before building new packages.


 Documentation/asciidoc.conf |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

1885a1ac69eabd6fa882f4464d3c66303d707566
diff --git a/Documentation/asciidoc.conf b/Documentation/asciidoc.conf
index fa0877d..37e9ada 100644
--- a/Documentation/asciidoc.conf
+++ b/Documentation/asciidoc.conf
@@ -23,4 +23,11 @@ ifdef::backend-xhtml11[]
 <a href="{target}.html">{target}{0?({0})}</a>
 endif::backend-xhtml11[]
 
+# "unbreak" docbook-xsl v1.68 for manpages. v1.69 works with or without this.
+[listingblock]
+<example><title>{title}</title>
+<literallayout>
+|
+</literallayout>
+{title#}</example>
 
-- 
1.2.GIT

-- 
Francis Daly        francis@daoine.org
