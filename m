From: "Alexey Mahotkin" <squadette@gmail.com>
Subject: [PATCH] handle Docbook XSL 1.72 (incompletely)
Date: Fri, 21 Sep 2007 01:26:21 +0400
Message-ID: <bb5b640b0709201426u6ab77d07n6039499eb8baf381@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 20 23:26:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYTXc-0005AD-1z
	for gcvg-git-2@gmane.org; Thu, 20 Sep 2007 23:26:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751248AbXITV00 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Sep 2007 17:26:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751249AbXITV0Z
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Sep 2007 17:26:25 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:44973 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751002AbXITV0Y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Sep 2007 17:26:24 -0400
Received: by nf-out-0910.google.com with SMTP id g13so585422nfb
        for <git@vger.kernel.org>; Thu, 20 Sep 2007 14:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=jBxS273/5Sm90jl+7LDcA/XquTLv741FwPhxMxcuDuo=;
        b=BsHEMKSG6NdSOKDRzlVbQrvHz/oogrX8+N4Dx8vgxdGVsZstW7CDODUxHFXAoDnAuS/ZCOS8/Q0KqWqWacV8batjT0SMK0zdb7nRB3S0fKEcj1z0j1Om/tmTXGZ5s7KhNDydA113Wi05ZVp5t61gimGGQjRGKP0eQALpN+3rlps=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=b1EBMNJXjELl4W6mMmreISYHo3LDdqxXDC7CaJoezmsU2XIG/NRBmp7ZpXSCtYAN2oN28RO/AlSPNdzble/i8FEyDcq82VLRD9rws1C6Yr04yIfPIGJjanRy29vnthjjHxhmrj1+VULTEI/pbqHYEevy9AYSdL+Gp9p9AtPA/Tw=
Received: by 10.86.80.5 with SMTP id d5mr1718815fgb.1190323581983;
        Thu, 20 Sep 2007 14:26:21 -0700 (PDT)
Received: by 10.86.66.18 with HTTP; Thu, 20 Sep 2007 14:26:21 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58805>

hi,

Fedora Core 7 has docbook-style-xsl-1.72.0-2.fc7

git-diff manpage (and couple of more, using callouts) is broken here:

EXAMPLES
       Various ways to check your working tree

               $ git diff            \fB(1)\fR
               $ git diff --cached   \fB(2)\fR
               $ git diff HEAD       \fB(3)\fR

           .sp \fB1. \fRChanges in the working tree not yet staged for
the next commit.


I have fixed this for 1.72 (and probably 1.7x in general), but it does
not work under older Docbook XSL, e.g. 1.6x. I guess we could check
for version number during build, but cannot provide complete patch, so
here is the interim solution:


diff --git a/Documentation/asciidoc.conf b/Documentation/asciidoc.conf
index af5b155..ec9060c 100644
--- a/Documentation/asciidoc.conf
+++ b/Documentation/asciidoc.conf
@@ -28,11 +28,11 @@ ifdef::backend-docbook[]
 <example><title>{title}</title>
 <literallayout>
 ifdef::doctype-manpage[]
-&#10;.ft C&#10;
+&#x2302;ft C&#10;
 endif::doctype-manpage[]
 |
 ifdef::doctype-manpage[]
-&#10;.ft&#10;
+&#10;&#x2302;ft &#10;
 endif::doctype-manpage[]
 </literallayout>
 {title#}</example>
diff --git a/Documentation/callouts.xsl b/Documentation/callouts.xsl
index 6a361a2..b1b6882 100644
--- a/Documentation/callouts.xsl
+++ b/Documentation/callouts.xsl
@@ -1,17 +1,17 @@
 <!-- callout.xsl: converts asciidoc callouts to man page format -->
 <xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
 <xsl:template match="co">
-       <xsl:value-of select="concat('\fB(',substring-after(@id,'-'),')\fR')"/>
+       <xsl:value-of
select="concat('&#x2593;fB(',substring-after(@id,'-'),')&#x2593;fR')"/>
 </xsl:template>
 <xsl:template match="calloutlist">
-       <xsl:text>.sp&#10;</xsl:text>
+       <xsl:text>&#10;.sp&#10;</xsl:text>
        <xsl:apply-templates/>
        <xsl:text>&#10;</xsl:text>
 </xsl:template>
 <xsl:template match="callout">
-       <xsl:value-of
select="concat('\fB',substring-after(@arearefs,'-'),'. \fR')"/>
+       <xsl:value-of
select="concat('&#x2593;fB',substring-after(@arearefs,'-'),'.
&#x2593;fR')"/>
        <xsl:apply-templates/>
-       <xsl:text>.br&#10;</xsl:text>
+       <xsl:text>&#x2302;br&#10;</xsl:text>
 </xsl:template>

 <!-- sorry, this is not about callouts, but attempts to work around

Someone more knowledgeable in this area should step in :)


Thank you,

-- 
Alexey Mahotkin
http://www.versioncontrolblog.com/
