X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Problem with git-push
Date: Wed, 01 Nov 2006 13:43:22 -0800
Message-ID: <7v8xiu3ksl.fsf@assigned-by-dhcp.cox.net>
References: <1162306098.41547.4.camel@mayday.esat.net>
	<7v64e0qclo.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0611011205340.1670@wbgn013.biozentrum.uni-wuerzburg.de>
	<7v4ptj5ghj.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 1 Nov 2006 21:43:47 +0000 (UTC)
Cc: git@vger.kernel.org, Florent Thoumie <flz@xbsd.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <7v4ptj5ghj.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Wed, 01 Nov 2006 07:33:28 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30660>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfNrr-00019f-Fq for gcvg-git@gmane.org; Wed, 01 Nov
 2006 22:43:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752479AbWKAVnY (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 1 Nov 2006
 16:43:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752485AbWKAVnY
 (ORCPT <rfc822;git-outgoing>); Wed, 1 Nov 2006 16:43:24 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:10901 "EHLO
 fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP id S1752479AbWKAVnX
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 1 Nov 2006 16:43:23 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao05.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061101214323.SHIR12909.fed1rmmtao05.cox.net@fed1rmimpo02.cox.net>; Wed, 1
 Nov 2006 16:43:23 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id hZjT1V0011kojtg0000000 Wed, 01 Nov 2006
 16:43:27 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

Junio C Hamano <junkio@cox.net> writes:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
>>> but more importantly, if the directory in question was created by 
>>> somebody else, I do not think this chmod() would succeed even if you are 
>>> in the same group as the owner (i.e. previous creator) of the directory.
>>
>> But if somebody else created it, it should already have the correct 
>> permissions in the first place (unless the user played around with them, 
>> which is not a pilot error, but a willfull pointing of the barrel in the 
>> general direction of your knee).
>
> True; I think the yesterday's analysis is still incomplete.  I
> haven't reached the point where I can explain "is a directory".
> If the directory was there and mkdir() failed (but we do not
> check its return value), it would have set errno to EEXIST not
> to EISDIR.  There is something else going on.

Actually, Florent's said the directory permission was screwed up
to begin with, so after following the code a bit more I can see
why it said "is a directory".

mkdir() may have failed because somebody else had a directory
there, perhaps with wrong permission; link_temp_to_file()
correctly fails from adjust_shared_perm() (because the directory
had incorrect permission that it cannot fix), returns -2 with
truncated filename "object/2d", back to move_temp_to_file(), and
-2 is not EEXIST so it tries to rename the temporary file to
that directory, which would also fail and sets ret to errno
(which now is EISDIR).  After unlinking the temporary file, we
notice that ret is EISDIR and reports the failure.

So there is not much more to explain, other than why mkdir()
failed in the first place.  Previous driver error?

I think idempotent chmod() on somebody else's file or directory
would fail, so this may be a safer addition to the codepath in
question.

diff --git a/path.c b/path.c
index bb89fb0..b82f194 100644
--- a/path.c
+++ b/path.c
@@ -279,7 +279,7 @@ int adjust_shared_perm(const char *path)
 			    : 0));
 	if (S_ISDIR(mode))
 		mode |= S_ISGID;
-	if (chmod(path, mode) < 0)
+	if (mode != st.st_mode && chmod(path, mode) < 0)
 		return -2;
 	return 0;
 }

