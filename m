X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [BUG] daemon.c blows up on OSX
Date: Wed, 20 Dec 2006 15:41:32 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0612201524230.3576@woody.osdl.org>
References: <7vmz5ib8eu.fsf@assigned-by-dhcp.cox.net> <86vek6z0k2.fsf@blue.stonehenge.com>
 <Pine.LNX.4.64.0612201412250.3576@woody.osdl.org> <86irg6yzt1.fsf_-_@blue.stonehenge.com>
 <7vr6uu6w8e.fsf@assigned-by-dhcp.cox.net> <86ejquyz4v.fsf@blue.stonehenge.com>
 <86ac1iyyla.fsf@blue.stonehenge.com> <Pine.LNX.4.64.0612201502090.3576@woody.osdl.org>
 <86wt4mximh.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Wed, 20 Dec 2006 23:41:45 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	linux-kernel@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <86wt4mximh.fsf@blue.stonehenge.com>
X-MIMEDefang-Filter: osdl$Revision: 1.163 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34985>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GxB4B-0000qJ-FL for gcvg-git@gmane.org; Thu, 21 Dec
 2006 00:41:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S964931AbWLTXlk (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 20 Dec 2006
 18:41:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965160AbWLTXlj
 (ORCPT <rfc822;git-outgoing>); Wed, 20 Dec 2006 18:41:39 -0500
Received: from smtp.osdl.org ([65.172.181.25]:49098 "EHLO smtp.osdl.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S964931AbWLTXli
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 20 Dec 2006 18:41:38 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kBKNfX2J014163
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Wed, 20
 Dec 2006 15:41:33 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kBKNfWB4009984; Wed, 20 Dec
 2006 15:41:33 -0800
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
Sender: git-owner@vger.kernel.org



On Wed, 20 Dec 2006, Randal L. Schwartz wrote:
> 
> What I do know is (a) it worked before the header changes and (b)
> the patch I just gave you works.  If the patch doesn't break others,
> can we just leave it in?

Well, at some point it probably _will_ break on other systems, exactly 
because other systems want to have the extended declarations.

It would be much better to have all the weird system dependencies solved 
in ONE place, rather than have each file (depending on just what they 
happen to need) have their own hacks for each weird system header file 
situation.

So it really would be a hell of a lot better to figure out _why_ strings.h 
doesn't "just work" when _XOPEN_SOURCE_EXTENDED is set. Or if there are 
better alternatives that work on HP-UX.. 

Does adding a

	#define _SVID_SOURCE 1

help? Also, we should probably make the _GNU_SOURCE and _BSD_SOURCE 
defines define to 1 (which is the way they'd be if we used -D_GNU_SOURCE 
on the compiler command line)

IOW, the appended ...

The really sad part is that this seems to be an OS X _bug_. 
"strncasecmp()" is part of the standard Open UNIX definitions, it's not 
something that should be shut off by _XOPEN_SOURCE, afaik.

There were apparently some OS X developers on the git list, mind 
commenting on this?

		Linus

---
diff --git a/git-compat-util.h b/git-compat-util.h
index bc296b3..1400905 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -13,8 +13,9 @@
 
 #define _XOPEN_SOURCE 600 /* glibc2 and AIX 5.3L need 500, OpenBSD needs 600 for S_ISLNK() */
 #define _XOPEN_SOURCE_EXTENDED 1 /* AIX 5.3L needs this */
-#define _GNU_SOURCE
-#define _BSD_SOURCE
+#define _GNU_SOURCE 1
+#define _BSD_SOURCE 1
+#define _SVID_SOURCE 1
 
 #include <unistd.h>
