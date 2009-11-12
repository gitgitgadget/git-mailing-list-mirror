From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH todo] dodoc: detect doctype-xsl version before making docs
Date: Wed, 11 Nov 2009 20:31:39 -0600
Message-ID: <20091112023139.GA1627@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Nov 12 03:21:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8PJW-0002k8-2I
	for gcvg-git-2@lo.gmane.org; Thu, 12 Nov 2009 03:21:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759959AbZKLCVX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2009 21:21:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759915AbZKLCVW
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Nov 2009 21:21:22 -0500
Received: from mail-yw0-f176.google.com ([209.85.211.176]:49403 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759588AbZKLCVW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2009 21:21:22 -0500
Received: by ywh6 with SMTP id 6so1562779ywh.4
        for <git@vger.kernel.org>; Wed, 11 Nov 2009 18:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mime-version:content-type:content-disposition:user-agent;
        bh=mLcdZv1MEdiaIZkF3PDPcQK6qVwxudlon06UUp4RzFo=;
        b=rUz/JTKs/kYEoeb+qpPriO6zbEgL73Bn3RH7FAgPQKQnW2purBOLYDd5CXKqPkrOai
         myhmerFxqWIF78Wmzdzp5u/cD/GLdUQSPvRL32SvZs+SMGgwm4JXVhffkjWqyj71blV8
         wFHLI2wp+2TAFKXQ/h2HL5EDGgMRrK06XSLTc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=C1BF2fh1oD2nYnQ08HbxZ0FqRJHKJ+k3BSxp6O3B5nxgTC1yJuIauqKTjf/39D1diI
         0bGUheNJTCRqelPl1ahkeNh8c5nYBgSei5bo2yyz3EtXkQj82rfQVYfo6/z3phJtQOnM
         J1khMKkL5rANiJtv6Kelcw+E/SZM8mckWl1Ic=
Received: by 10.150.167.18 with SMTP id p18mr3132190ybe.67.1257992486966;
        Wed, 11 Nov 2009 18:21:26 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 14sm1092732gxk.6.2009.11.11.18.21.25
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 11 Nov 2009 18:21:26 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132733>

The manpages in the man branch of git.git appear to have acquired
the dreaded escaped .ft disease when the docbook-xsl toolchain
was upgraded to v1.74.3.
---
It is hard work avoiding escaped nroff directives in output.  I am a
bit confused at what happened here, since docbook-xsl v1.73.2 should
have required the same settings.

These changes are untested, unfortunately.  I hope they can be of some
help nevertheless.

 dodoc.sh |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/dodoc.sh b/dodoc.sh
index 5cbc269..bf49710 100755
--- a/dodoc.sh
+++ b/dodoc.sh
@@ -77,6 +77,19 @@ asciidoc' 8'.*)
 	export ASCIIDOC8 ;;
 esac
 
+db_version_file=/usr/share/xml/docbook/stylesheet/nwalsh/VERSION
+case "$(grep "<fm:Version>" "$db_version_file" 2>/dev/null)" in
+*1.72*)
+	DOCBOOK_XSL_172=YesPlease
+	export DOCBOOK_XSL_172 ;;
+*1.69.[1-9]* | *1.70* | *1.71.0*)
+	DOCBOOK_SUPPRESS_SP=YesPlease
+	export DOCBOOK_SUPPRESS_SP ;;
+*1.7[3-9]* | *1.6[0-8]*)
+	ASCIIDOC_NO_ROFF=YesPlease
+	export ASCIIDOC_NO_ROFF ;;
+esac
+
 make >./:html.log 2>&1 \
 	-C Documentation -j 2 \
 	WEBDOC_DEST="$DOCREPO/doc-html-inst" install-webdoc || exit
-- 
1.6.5.2
