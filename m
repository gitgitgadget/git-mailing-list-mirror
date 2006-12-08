X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: cygwin, 44k files: how to commit only index?
Date: Fri, 8 Dec 2006 09:43:49 +0100
Message-ID: <81b0412b0612080043y6ff3462ev5f8b4c4cf40182f5@mail.gmail.com>
References: <81b0412b0612070627r3ff0b394s124d95fbf8084f16@mail.gmail.com>
	 <7vd56vtt2g.fsf@assigned-by-dhcp.cox.net>
	 <20061207221503.GA4990@steel.home>
	 <7vr6vbqqzh.fsf@assigned-by-dhcp.cox.net>
	 <20061208052705.GA4318@steel.home>
	 <7vzm9ynahc.fsf@assigned-by-dhcp.cox.net>
	 <81b0412b0612072327x77477584jb9131b26b0854f2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 8 Dec 2006 08:43:58 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IgfQ8STTIN5YYpOZoO698zYYDpL+c0h/bX1k3cSBUs+mty7z2hZmR6sObJMWWyM/jStZEZZKAwR8cu0kDzbCUDMjBuFas5LzVqFkriOg+SBhwtXosrsUPhyMSlNTUrMYr7s0j3hEy0g3+A/odOOQOc7t9qmd5GYhI98Clzi/BkM=
In-Reply-To: <81b0412b0612072327x77477584jb9131b26b0854f2@mail.gmail.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33671>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsbKm-00065q-1U for gcvg-git@gmane.org; Fri, 08 Dec
 2006 09:43:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1425185AbWLHInw (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 8 Dec 2006
 03:43:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1425191AbWLHInw
 (ORCPT <rfc822;git-outgoing>); Fri, 8 Dec 2006 03:43:52 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:14580 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1425185AbWLHInv (ORCPT <rfc822;git@vger.kernel.org>); Fri, 8 Dec
 2006 03:43:51 -0500
Received: by ug-out-1314.google.com with SMTP id 44so703770uga for
 <git@vger.kernel.org>; Fri, 08 Dec 2006 00:43:50 -0800 (PST)
Received: by 10.78.204.20 with SMTP id b20mr1719787hug.1165567429621; Fri, 08
 Dec 2006 00:43:49 -0800 (PST)
Received: by 10.78.139.7 with HTTP; Fri, 8 Dec 2006 00:43:49 -0800 (PST)
To: "Junio C Hamano" <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On 12/8/06, Alex Riesen <raa.lkml@gmail.com> wrote:
> On 12/8/06, Junio C Hamano <junkio@cox.net> wrote:
> > In 'pu' (jc/diff topic), I have a very generic code to walk the
> > index, working tree and zero or more trees in parallel, taking
> > advantage of cache-tree.  If somebody is interested to learn the
> > internals of git, some of the code could be lifted from there
> > and simplified to walk just the index and a single tree, and I
> > think that would optimize "diff-index --cached" quite a bit.
>
> Will try to look at it.
>

And now I'm playing with that (against test-para.c from pu).
I expect it to be broken by that webGmail, so it may not
apply to anything, but you'll get the idea. More clearly than
from me trying to explain.

commit 83642cdaca6dc1a2f94aa41923bc9e8f02d0e12f
Author: Alex Riesen <raa.lkml@gmail.com>
Date:   Fri Dec 8 09:38:18 2006 +0100

    add --quiet to test-para: stop at the first difference

diff --git a/test-para.c b/test-para.c
index bce5f0c..99d3792 100644
--- a/test-para.c
+++ b/test-para.c
@@ -21,6 +21,7 @@ int main(int ac, const char **av)
 	unsigned char trees[64][20];
 	int num_tree = 0, i, using_head, show_all = 0;
 	int index_wanted = 1, work_wanted = 1, tree_wanted = 0;
+	int quiet = 0;
 	const char *prefix;
 	const char **pathspec;

@@ -43,6 +44,8 @@ int main(int ac, const char **av)
 			work_wanted = 0;
 		else if (!strcmp(av[1] + 2, "no-index"))
 			index_wanted = 0;
+		else if (!strcmp(av[1] + 2, "quiet"))
+			quiet = 1;
 		else if (!av[1][2])
 			break;
 		else
@@ -118,7 +121,9 @@ int main(int ac, const char **av)
 				show_one(z, e->name, e->namelen,
 					 e->hash, e->mode);
 			}
-			else
+			else {
+				if (quiet)
+					exit(1);
 				for (i = 0; i < w.num_trees + 2; i++) {
 					char numbuf[10];

@@ -149,6 +154,7 @@ int main(int ac, const char **av)
 					show_one(z, e->name, e->namelen,
 						 e->hash, e->mode);
 				}
+			}
 		}

