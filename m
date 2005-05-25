From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: change of git-diff-tree and symlinks
Date: Wed, 25 May 2005 11:08:54 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505251054110.2307@ppc970.osdl.org>
References: <20050525111711.GA27492@vrfy.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 25 20:08:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Db0G8-0000zR-MQ
	for gcvg-git@gmane.org; Wed, 25 May 2005 20:05:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261889AbVEYSHK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 May 2005 14:07:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262368AbVEYSHK
	(ORCPT <rfc822;git-outgoing>); Wed, 25 May 2005 14:07:10 -0400
Received: from fire.osdl.org ([65.172.181.4]:7590 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261889AbVEYSG4 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 May 2005 14:06:56 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4PI6ojA012100
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 25 May 2005 11:06:50 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4PI6nW8007282;
	Wed, 25 May 2005 11:06:49 -0700
To: Kay Sievers <kay.sievers@vrfy.org>
In-Reply-To: <20050525111711.GA27492@vrfy.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Wed, 25 May 2005, Kay Sievers wrote:
>
> I'm catching up with gitweb.cgi to parse the changed output. Works fine
> so far and is really much easier to parse. Here is something that does
> not work anymore. See the difference between:
> 
>    http://www.kernel.org/git/?p=linux/hotplug/udev.git;a=commit;h=49cedafaf893bfe348eb7598227f1a11ae24bfd6
>    http://ehlo.org/~kay/gitweb.cgi?p=linux/hotplug/udev.git;a=commit;h=49cedafaf893bfe348eb7598227f1a11ae24bfd6

Yes, the new diff-tree thing doesn't show symlinks.

The problem seems to be that we just don't have a "status" flag for it. I 
think we should call it "T" for "Type change" or something, but in the 
meantime let's just have the rule that instead of ignoring unknown state 
changes, we always print them out as "?" instead.

Ie something like this..

(And I'd suggest you make gitweb flexible enough that it does something 
sane if it sees an unknown reason code - let's see what Junio thinks about 
what status code we should use for this).

		Linus

----
diff --git a/diff.c b/diff.c
--- a/diff.c
+++ b/diff.c
@@ -768,7 +768,7 @@ void diff_flush(int diff_output_style, i
 	for (i = 0; i < q->nr; i++) {
 		struct diff_filepair *p = q->queue[i];
 		if (p->status == 0)
-			continue;
+			p->status = '?';
 		switch (diff_output_style) {
 		case DIFF_FORMAT_PATCH:
 			diff_flush_patch(p);
