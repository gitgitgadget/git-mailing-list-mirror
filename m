X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Terje Sten Bjerkseth" <terje@bjerkseth.org>
Subject: Re: [BUG] daemon.c blows up on OSX
Date: Thu, 21 Dec 2006 01:36:44 +0100
Message-ID: <caf068570612201636g75180138r223aef7c42f69a50@mail.gmail.com>
References: <7vmz5ib8eu.fsf@assigned-by-dhcp.cox.net>
	 <86vek6z0k2.fsf@blue.stonehenge.com>
	 <Pine.LNX.4.64.0612201412250.3576@woody.osdl.org>
	 <86irg6yzt1.fsf_-_@blue.stonehenge.com>
	 <7vr6uu6w8e.fsf@assigned-by-dhcp.cox.net>
	 <86ejquyz4v.fsf@blue.stonehenge.com>
	 <86ac1iyyla.fsf@blue.stonehenge.com>
	 <Pine.LNX.4.64.0612201502090.3576@woody.osdl.org>
	 <86wt4mximh.fsf@blue.stonehenge.com>
	 <Pine.LNX.4.64.0612201524230.3576@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 21 Dec 2006 00:36:58 +0000 (UTC)
Cc: "Linus Torvalds" <torvalds@osdl.org>,
	"Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=HPC8LPEnH+dQ7xNcD+Cd4EK0OHv9JCTyckcNYzkw3Ezgb0kYqqwB1wk3YVBVkVS4BajlR/Qk+x3RIVKC3Tf5ghLo6NyKyMP8fJmQAYzdVyNhaC7cOJ5kpoyKY0aUOYivNhpllzxEKZzG6KXbxdaxtm0x784SaCbEbDLTRexAKqU=
In-Reply-To: <Pine.LNX.4.64.0612201524230.3576@woody.osdl.org>
Content-Disposition: inline
X-Google-Sender-Auth: f03f95cf76e88f2d
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34988>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GxBvZ-0001g7-GY for gcvg-git@gmane.org; Thu, 21 Dec
 2006 01:36:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161106AbWLUAgr (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 20 Dec 2006
 19:36:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161105AbWLUAgr
 (ORCPT <rfc822;git-outgoing>); Wed, 20 Dec 2006 19:36:47 -0500
Received: from wr-out-0506.google.com ([64.233.184.239]:62341 "EHLO
 wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1161106AbWLUAgp (ORCPT <rfc822;git@vger.kernel.org>); Wed, 20 Dec
 2006 19:36:45 -0500
Received: by wr-out-0506.google.com with SMTP id i7so1628953wra for
 <git@vger.kernel.org>; Wed, 20 Dec 2006 16:36:44 -0800 (PST)
Received: by 10.90.52.2 with SMTP id z2mr8132997agz.1166661404556; Wed, 20
 Dec 2006 16:36:44 -0800 (PST)
Received: by 10.90.36.7 with HTTP; Wed, 20 Dec 2006 16:36:44 -0800 (PST)
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
Sender: git-owner@vger.kernel.org

On 12/21/06, Linus Torvalds <torvalds@osdl.org> wrote:
> So it really would be a hell of a lot better to figure out _why_ strings.h
> doesn't "just work" when _XOPEN_SOURCE_EXTENDED is set. Or if there are
> better alternatives that work on HP-UX..
>
> Does adding a
>
>         #define _SVID_SOURCE 1
>
> help? Also, we should probably make the _GNU_SOURCE and _BSD_SOURCE
> defines define to 1 (which is the way they'd be if we used -D_GNU_SOURCE
> on the compiler command line)
>
> IOW, the appended ...

For Mac OS X 10.4, _XOPEN_SOURCE seems to define _POSIX_C_SOURCE which
causes the NI_MAXSERV problem in netdb.h. The appended seems to make
it work.

--
diff --git a/git-compat-util.h b/git-compat-util.h
index bc296b3..41fa7f6 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -11,8 +11,10 @@

 #define ARRAY_SIZE(x) (sizeof(x)/sizeof(x[0]))

+#ifndef __APPLE_CC__
 #define _XOPEN_SOURCE 600 /* glibc2 and AIX 5.3L need 500, OpenBSD
needs 600 for S_ISLNK() */
 #define _XOPEN_SOURCE_EXTENDED 1 /* AIX 5.3L needs this */
+#endif
 #define _GNU_SOURCE
