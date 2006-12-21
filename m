X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [BUG] daemon.c blows up on OSX
Date: Wed, 20 Dec 2006 16:44:09 -0800
Message-ID: <7vtzzq3wo6.fsf@assigned-by-dhcp.cox.net>
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
	<caf068570612201636g75180138r223aef7c42f69a50@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 21 Dec 2006 00:44:36 +0000 (UTC)
Cc: "Linus Torvalds" <torvalds@osdl.org>,
	"Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <caf068570612201636g75180138r223aef7c42f69a50@mail.gmail.com>
	(Terje Sten Bjerkseth's message of "Thu, 21 Dec 2006 01:36:44 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34990>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GxC2v-0002oa-Ji for gcvg-git@gmane.org; Thu, 21 Dec
 2006 01:44:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161024AbWLUAoN (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 20 Dec 2006
 19:44:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161054AbWLUAoN
 (ORCPT <rfc822;git-outgoing>); Wed, 20 Dec 2006 19:44:13 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:46964 "EHLO
 fed1rmmtao04.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1161024AbWLUAoL (ORCPT <rfc822;git@vger.kernel.org>); Wed, 20 Dec 2006
 19:44:11 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao04.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061221004410.VTPW7494.fed1rmmtao04.cox.net@fed1rmimpo01.cox.net>; Wed, 20
 Dec 2006 19:44:10 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id 1CjU1W00W1kojtg0000000; Wed, 20 Dec 2006
 19:43:29 -0500
To: "Terje Sten Bjerkseth" <terje@bjerkseth.org>
Sender: git-owner@vger.kernel.org

"Terje Sten Bjerkseth" <terje@bjerkseth.org> writes:

> On 12/21/06, Linus Torvalds <torvalds@osdl.org> wrote:
>> So it really would be a hell of a lot better to figure out _why_ strings.h
>> doesn't "just work" when _XOPEN_SOURCE_EXTENDED is set. Or if there are
>> better alternatives that work on HP-UX..
>>
>> Does adding a
>>
>>         #define _SVID_SOURCE 1
>>
>> help? Also, we should probably make the _GNU_SOURCE and _BSD_SOURCE
>> defines define to 1 (which is the way they'd be if we used -D_GNU_SOURCE
>> on the compiler command line)
>>
>> IOW, the appended ...
>
> For Mac OS X 10.4, _XOPEN_SOURCE seems to define _POSIX_C_SOURCE which
> causes the NI_MAXSERV problem in netdb.h. The appended seems to make
> it work.
>
> --
> diff --git a/git-compat-util.h b/git-compat-util.h
> index bc296b3..41fa7f6 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -11,8 +11,10 @@
>
> #define ARRAY_SIZE(x) (sizeof(x)/sizeof(x[0]))
>
> +#ifndef __APPLE_CC__
> #define _XOPEN_SOURCE 600 /* glibc2 and AIX 5.3L need 500, OpenBSD
> needs 600 for S_ISLNK() */
> #define _XOPEN_SOURCE_EXTENDED 1 /* AIX 5.3L needs this */
> +#endif
> #define _GNU_SOURCE
> #define _BSD_SOURCE

Thanks.  While this is in a better direction than randomly
including the headers in the source, it is still sad.

Does everybody use Apple CC on OSX?  Is the symbol defined even
with GCC?  Or Gcc fixes headers well enough and makes this a
non-issue?
