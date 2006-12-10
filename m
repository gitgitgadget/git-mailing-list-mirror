X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 2/3] merge-recursive: make empty tree a known object
Date: Sun, 10 Dec 2006 10:37:57 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0612101030390.12500@woody.osdl.org>
References: <20061207101707.GA19139@spearce.org>
 <Pine.LNX.4.63.0612100055390.28348@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Sun, 10 Dec 2006 18:38:20 +0000 (UTC)
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.63.0612100055390.28348@wbgn013.biozentrum.uni-wuerzburg.de>
X-MIMEDefang-Filter: osdl$Revision: 1.162 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33915>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtTYz-0003fN-Fx for gcvg-git@gmane.org; Sun, 10 Dec
 2006 19:38:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1762292AbWLJSiK (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 10 Dec 2006
 13:38:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762335AbWLJSiK
 (ORCPT <rfc822;git-outgoing>); Sun, 10 Dec 2006 13:38:10 -0500
Received: from smtp.osdl.org ([65.172.181.25]:47624 "EHLO smtp.osdl.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1762292AbWLJSiJ
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 10 Dec 2006 13:38:09 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kBAIbwID011951
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Sun, 10
 Dec 2006 10:38:01 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kBAIbv6N031715; Sun, 10 Dec
 2006 10:37:58 -0800
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org



On Sun, 10 Dec 2006, Johannes Schindelin wrote:
> 
> To use it in diff_tree_sha1(), a tree has to be hashed in the
> global object collection. This actually moves the empty tree (if
> it is needed) into the global object hash.

I think you should do this more generically.

If we create this kind of "default fake object" that we know about whether 
the object _really_ exists or not (and I agree it makes sense for the 
empty tree), we should probably use it for "diff_root_tree_sha1()" too, 
rather than the special case we have now.

In other words, right now we have that very special 
"diff_root_tree_sha1()" function, but if you create a generic fake "empty 
tree" SHA1 that git knows about implicitly, we could entirely replace it 
with just using

	diff_tree_sha1(EMPTY_TREE_SHA1, tree, base, opt);

instead, and get rid of that special case code (which is efficient, but we 
don't really _need_ the efficiency).

So you could make "read_sha1_file()" just have a special case for known 
objects at the end. If the pack entry fails, the loose file case fails, 
then rather than returning NULL at the end, you could have a list of known 
fixed objects..

Hmm?

