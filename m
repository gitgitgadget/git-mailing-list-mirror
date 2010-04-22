From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] Documentation/Makefile: fix interrupted builds of
 user-manual.xml
Date: Wed, 21 Apr 2010 20:18:21 -0500
Message-ID: <20100422011820.GA30355@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Chris Johnsen <chris_johnsen@pobox.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 22 03:18:29 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4l3l-00087u-Fv
	for gcvg-git-2@lo.gmane.org; Thu, 22 Apr 2010 03:18:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754195Ab0DVBSX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Apr 2010 21:18:23 -0400
Received: from mail-yw0-f187.google.com ([209.85.211.187]:36049 "EHLO
	mail-yw0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753304Ab0DVBSW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Apr 2010 21:18:22 -0400
Received: by ywh17 with SMTP id 17so2222700ywh.22
        for <git@vger.kernel.org>; Wed, 21 Apr 2010 18:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mime-version:content-type:content-disposition:user-agent;
        bh=6gZFQNIAvAbLEVeJWCfGQS25+q/bpuEwc7RTcJqBZSM=;
        b=ONZHlbRp2RE/HCGZjvpTU2psppgFkSlhIEufgddYio6viaojdIeJk4Bju6ohX+FtmB
         wWGlE6OB1FfAa8cThWHxgD6lyhPstNHKgvjwgWRNGRuTPP/pd/AbCEkEj7UQsqqhziFC
         tACXeGA9tEYk8sj5PbdSNVsr9DIVgdCN91UjM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=xkTsg2TGEs/YT6rcrwyo0F4cht1a9tyBl/pIF2CxBfrz1RfhUCR0rVUo0uiIE4nyZR
         Sg2r4m2qD+2bHQJe/k0yhqWAX4itVxmrCv2WW4/NW/96jW8TwiYQ9VIC8i8/wEQTiKj8
         BU2AWkw1X/iWWl/TjLdWv43Nw1Y1SFCUrJUcA=
Received: by 10.100.233.2 with SMTP id f2mr22210306anh.43.1271899098195;
        Wed, 21 Apr 2010 18:18:18 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 21sm6946281iwn.15.2010.04.21.18.18.16
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 21 Apr 2010 18:18:17 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145489>

Unlike gcc, asciidoc does not atomically write its output file or
delete it when interrupted.  If it is interrupted in the middle of
writing an XML file, the result will be truncated input for xsltproc.

	XSLTPROC user-manual.html
	user-manual.xml:998: parser error : Premature end of data in t

Take care of this case by writing to a temporary and renaming it when
finished.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Based on a true story.

 Documentation/Makefile |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 8a8a395..04f69cf 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -264,7 +264,9 @@ manpage-base-url.xsl: manpage-base-url.xsl.in
 	mv $@+ $@
 
 user-manual.xml: user-manual.txt user-manual.conf
-	$(QUIET_ASCIIDOC)$(ASCIIDOC) $(ASCIIDOC_EXTRA) -b docbook -d book $<
+	$(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
+	$(ASCIIDOC) $(ASCIIDOC_EXTRA) -b docbook -d book -o $@+ $< && \
+	mv $@+ $@
 
 technical/api-index.txt: technical/api-index-skel.txt \
 	technical/api-index.sh $(patsubst %,%.txt,$(API_DOCS))
@@ -278,7 +280,9 @@ XSLT = docbook.xsl
 XSLTOPTS = --xinclude --stringparam html.stylesheet docbook-xsl.css
 
 user-manual.html: user-manual.xml
-	$(QUIET_XSLTPROC)xsltproc $(XSLTOPTS) -o $@ $(XSLT) $<
+	$(QUIET_XSLTPROC)$(RM) $@+ $@ && \
+	xsltproc $(XSLTOPTS) -o $@+ $(XSLT) $< && \
+	mv $@+ $@
 
 git.info: user-manual.texi
 	$(QUIET_MAKEINFO)$(MAKEINFO) --no-split -o $@ user-manual.texi
-- 
1.7.1.rc1
