From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Add specialized object allocator
Date: Mon, 19 Jun 2006 11:10:58 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606191101380.5498@g5.osdl.org>
References: <Pine.LNX.4.64.0606191028540.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Mon Jun 19 20:11:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FsODN-0007qR-FF
	for gcvg-git@gmane.org; Mon, 19 Jun 2006 20:11:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751276AbWFSSLG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Jun 2006 14:11:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751277AbWFSSLG
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jun 2006 14:11:06 -0400
Received: from smtp.osdl.org ([65.172.181.4]:41947 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751276AbWFSSLF (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Jun 2006 14:11:05 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k5JIAxgt031927
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 19 Jun 2006 11:11:00 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k5JIAxkc005918;
	Mon, 19 Jun 2006 11:10:59 -0700
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0606191028540.5498@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.76__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22132>



On Mon, 19 Jun 2006, Linus Torvalds wrote:
> 
> It also allows us to track some basic statistics about object
> allocations. For example, for the mozilla import, it shows
> object usage as follows:
> 
>      blobs:   627629 (14710 kB)
>      trees:  1119035 (34969 kB)
>    commits:   196423  (8440 kB)
>       tags:     1336    (46 kB)

Btw, this is the trivial additional patch to allow you to say

	git --report rev-list --all --objects > /dev/null

and have it report object allocation usage after the op.

Useful? Probably not. It was useful for me to verify that everything 
looked ok (and while I knew we had more trees than blobs, it's actually 
interesting to see how projects differ.

The "git" tree, for example, has more blobs than trees: because it's a 
fairly flat development tree, a commit that changes more than one file 
will generate more new blobs than it generates trees.

In contrast, the kernel has about 30% more trees than blobs (but since 
trees have the extra data/size fields, 30% extra trees take 75% more space 
than blobs).

The mozilla import has a _lot_ more trees than blobs (80% more trees, and 
they use up more than twice as much memory). It's probably a pretty deep 
tree structure and/or they often commit changes to single files deep into 
the tree).

		Linus

----
diff --git a/git.c b/git.c
index 329ebec..6149499 100644
--- a/git.c
+++ b/git.c
@@ -271,6 +271,10 @@ int main(int argc, const char **argv, ch
 			puts(git_exec_path());
 			exit(0);
 		}
+		if (!strcmp(cmd, "report")) {
+			atexit(alloc_report);
+			continue;
+		}
 		cmd_usage(0, NULL, NULL);
 	}
 	argv[0] = cmd;
