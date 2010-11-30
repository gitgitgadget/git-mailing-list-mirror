From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 11/15] vcs-svn: More dump format sanity checks
Date: Tue, 30 Nov 2010 13:48:33 -0600
Message-ID: <20101130194833.GA9064@burratino>
References: <20101118050023.GA14861@burratino>
 <20101120004525.GA17445@burratino>
 <20101120005334.GL17445@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	David Barr <david.barr@cordelta.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 30 20:49:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNWCE-0000YQ-O1
	for gcvg-git-2@lo.gmane.org; Tue, 30 Nov 2010 20:49:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756574Ab0K3Tsn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Nov 2010 14:48:43 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:37561 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756521Ab0K3Tsl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Nov 2010 14:48:41 -0500
Received: by fxm8 with SMTP id 8so1512613fxm.19
        for <git@vger.kernel.org>; Tue, 30 Nov 2010 11:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=fzucSNRPruHPbTmJqc1V9JI0OHi3iqIWikgklSkFJTo=;
        b=ABRbdBw3Uub44zGEw4zmbGU9Z4QmVUIz61oacfJEV9YZKjbwVGVv594WzGrFlu+Wj8
         RDNhju78JDOSK7TBRufjlmODstIpVDn3HiyGISoFcTPopwjLg3enBwGiqdCPUC6CF+ix
         3FTJS/LSgbw4sGKTLQO8LvnWQEWjyG2cgWgTY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=L4eas0/W+WLS7LPNbgnwxQeycRqHhz97l4F3OGt+K9WMzgfFo4cG9XZ4ZnoGvRPVU4
         R/1SlkYXyPK5qCJOvygGhQZ7ubyrmtwFaHDJjkYy/sKH9CT4roAz+l01VIy0B4ZOL3Uw
         niwRi0NfFxV5MheHrjYp3A+Ap8SX0QVQytvAo=
Received: by 10.223.83.196 with SMTP id g4mr7307293fal.63.1291146520390;
        Tue, 30 Nov 2010 11:48:40 -0800 (PST)
Received: from burratino (adsl-68-255-109-73.dsl.chcgil.ameritech.net [68.255.109.73])
        by mx.google.com with ESMTPS id n1sm1785354fam.16.2010.11.30.11.48.38
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 30 Nov 2010 11:48:39 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101120005334.GL17445@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162488>

Jonathan Nieder wrote:

> --- a/vcs-svn/svndump.c
> +++ b/vcs-svn/svndump.c
> @@ -181,12 +181,22 @@ static void handle_node(void)
[...]
> +		if (mode == REPO_MODE_DIR && type != REPO_MODE_DIR)
> +			die("invalid dump: cannot modify a directory into a file");

This is tripping for me in a revision like so:

 Revision-number: 692
 Prop-content-length: 110
 Content-length: 110

 [revprops snipped]

 Node-path: lxanew/DCNsnetwork.cpp
 Node-kind: file
 Node-action: add
 Node-copyfrom-rev: 691
 Node-copyfrom-path: DCNsnetwork.cpp


 Node-path: DCNsnetwork.cpp
 Node-action: delete

The import up to and including rev 691 works fine.  Rev 691:

 Revision-number: 691
 Prop-content-length: 110
 Content-length: 110

[props snipped]

 Node-path: lxanew/CorpusWordCollection.cpp
 Node-kind: file
 Node-action: add
 Node-copyfrom-rev: 690
 Node-copyfrom-path: CorpusWordCollection.cpp


 Node-path: CorpusWordCollection.cpp
 Node-action: delete

Pretty similar, right?  In the target repository:

 $ git ls-tree HEAD -- DCNsnetwork.cpp
 100644 blob f92d77cc88cc50e9ca333604d22db83f0668828a    DCNsnetwork.cpp

DCNsnetwork.cpp was added in r688, which looks like so:

 Revision-number: 688
 Prop-content-length: 186
 Content-length: 186

[props and many new files snipped]

 Node-path: DCNsnetwork.cpp
 Node-kind: file
 Node-action: add
 Prop-delta: true
 Prop-content-length: 10
 Text-delta: true
 Text-content-length: 2999
 Text-content-md5: 48fd4d31d16f90ab449b4d223fc3d7f8
 Content-length: 3009

 PROPS-END
 SVN^@^@^@<97>)^C<97>)<80><97>)// snetwork.cpp: implementation of the snetwork class.
 [...]

So apparently repo_add failed.  Hints?

Here's an unrelated simplification, noticed while debugging.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
index d0d3de6..d1ec9a5 100644
--- a/vcs-svn/svndump.c
+++ b/vcs-svn/svndump.c
@@ -219,6 +219,7 @@ static void handle_node(void)
 			die("invalid dump: adds node without text");
 		repo_add(node_ctx.dst, type, mark);
 		old_mark = 0;
+		node_ctx.type = type;
 	} else {
 		die("invalid dump: Node-path block lacks Node-action");
 	}
