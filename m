From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Problems with binary patches (pull) and spaces in filenames
 (gitk)
Date: Wed, 9 Nov 2005 14:10:19 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511091404000.4627@g5.osdl.org>
References: <20051109213730.GA23052@ebar091.ebar.dtu.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 09 23:14:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZy9I-0005hX-P3
	for gcvg-git@gmane.org; Wed, 09 Nov 2005 23:10:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030425AbVKIWKa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 Nov 2005 17:10:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030435AbVKIWKa
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Nov 2005 17:10:30 -0500
Received: from smtp.osdl.org ([65.172.181.4]:3541 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030425AbVKIWK3 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Nov 2005 17:10:29 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jA9MALnO032070
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 9 Nov 2005 14:10:22 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jA9MAJ6B017593;
	Wed, 9 Nov 2005 14:10:20 -0800
To: Peter Eriksen <s022018@student.dtu.dk>
In-Reply-To: <20051109213730.GA23052@ebar091.ebar.dtu.dk>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11422>



On Wed, 9 Nov 2005, Peter Eriksen wrote:
> 
> 1) When pulling an updated binary files, I guess it still tries to 
>    print this update summary by making and processing patches, and so
>    gives this error:
> 
>        Updating from ab1c4033ba98c043e13da3446e7f244ac7f79942 to
>        c164231f6b59fd80171e95f31d762a80d884c708.
>        Fast forward
>        fatal: patch with only garbage at line 3249

Yes, this is "git-apply --stat" being unhappy about an empty patch.

Maybe we should only be unhappy when actually trying to apply (or check) 
the patch.

So a patch like the appended may or may not be the right solution.

> 2) When there are spaces in filenames, gitk only shows the first part of
>    the name in the filelist at the buttom right.

Can't help you there, that's more tcl/tk than I know. Paul?

		Linus

---
diff --git a/apply.c b/apply.c
index 3e53b34..da1416a 100644
--- a/apply.c
+++ b/apply.c
@@ -890,7 +890,7 @@ static int parse_chunk(char *buffer, uns
 
 	patchsize = parse_single_patch(buffer + offset + hdrsize, size - offset - hdrsize, patch);
 
-	if (!patchsize && !metadata_changes(patch))
+	if ((check ||apply) && !patchsize && !metadata_changes(patch))
 		die("patch with only garbage at line %d", linenr);
 
 	return offset + hdrsize + patchsize;
