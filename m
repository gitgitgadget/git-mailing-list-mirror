From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 06/15] vcs-svn: handle_node: Handle deletion case early
Date: Fri, 19 Nov 2010 18:49:17 -0600
Message-ID: <20101120004917.GG17445@burratino>
References: <20101118050023.GA14861@burratino>
 <20101120004525.GA17445@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	David Barr <david.barr@cordelta.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 20 01:50:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJbee-0001Ez-Uy
	for gcvg-git-2@lo.gmane.org; Sat, 20 Nov 2010 01:50:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755610Ab0KTAuG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Nov 2010 19:50:06 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:35860 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754093Ab0KTAuF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Nov 2010 19:50:05 -0500
Received: by gxk23 with SMTP id 23so3102104gxk.19
        for <git@vger.kernel.org>; Fri, 19 Nov 2010 16:50:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=ZzM7V8FgSQiZgG8lHxnO7W+Rt93aqt4xPEYejHoyyO4=;
        b=XORlnMWt9Nh8jLV8RBSSznjPTqFPk+3RgqU0ioGpfmM2/XZgwTimizDB95+2X7p750
         evNuNNnxA2wV/hTxGhcxSAX2gJP5G7tiVQJ9y9PjduQ/9Cz7Mj5U9OnskyJiHmGIIbfZ
         cWrksTa00q+R4Lxfng9h1sgZxNdVhiydoEg54=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=pQAoivjKemxrT5WYfOY7/gAOYLm39IfwlAEjLCxX/FwBsCYIGqbIhYoHXg2zxZsk6b
         JBRwGg9q5H2FPp/Bwy7xBBBlnQmBfCH2T+Qr4qhZdyh1hXicTcVnLdSrIZFEmI2gHE9R
         eYefCPniT0ip33cQ2JHI/HtvDH1HJfCvnPcuA=
Received: by 10.150.192.9 with SMTP id p9mr4635330ybf.127.1290214204688;
        Fri, 19 Nov 2010 16:50:04 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id r6sm192804yba.11.2010.11.19.16.50.03
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 19 Nov 2010 16:50:04 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101120004525.GA17445@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161806>

Take care of "Node-action: delete" as soon as possible, so we can stop
worrying about that case in the rest of the function.

Functional change: catch deletion nodes with features that would not
apply to them (text, properties, or origin data) and error out for
those cases.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 vcs-svn/svndump.c |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
index 844076b..bc70023 100644
--- a/vcs-svn/svndump.c
+++ b/vcs-svn/svndump.c
@@ -159,6 +159,13 @@ static void handle_node(void)
 	if (node_ctx.textLength != LENGTH_UNKNOWN)
 		mark = next_blob_mark();
 
+	if (node_ctx.action == NODEACT_DELETE) {
+		if (mark || have_props || node_ctx.srcRev)
+			die("invalid dump: deletion node has "
+				"copyfrom info, text, or properties");
+		return repo_delete(node_ctx.dst);
+	}
+
 	if (have_props && node_ctx.propLength)
 		read_props();
 
@@ -168,9 +175,7 @@ static void handle_node(void)
 	if (mark && node_ctx.type == REPO_MODE_DIR)
 		die("invalid dump: directories cannot have text attached");
 
-	if (node_ctx.action == NODEACT_DELETE) {
-		repo_delete(node_ctx.dst);
-	} else if (node_ctx.action == NODEACT_CHANGE ||
+	if (node_ctx.action == NODEACT_CHANGE ||
 			   node_ctx.action == NODEACT_REPLACE) {
 		if (node_ctx.action == NODEACT_REPLACE &&
 		    node_ctx.type == REPO_MODE_DIR)
-- 
1.7.2.3
