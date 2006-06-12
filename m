From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: git-applymbox broken?
Date: Mon, 12 Jun 2006 01:35:34 -0600
Message-ID: <m1fyia967t.fsf@ebiederm.dsl.xmission.com>
References: <Pine.LNX.4.64.0606111535310.5498@g5.osdl.org>
	<m1wtbn468o.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.64.0606111735440.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 12 09:36:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fpgxi-0004Ks-Lq
	for gcvg-git@gmane.org; Mon, 12 Jun 2006 09:35:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751076AbWFLHfs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Jun 2006 03:35:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751097AbWFLHfs
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jun 2006 03:35:48 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:27804 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751076AbWFLHfr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jun 2006 03:35:47 -0400
Received: from ebiederm.dsl.xmission.com (localhost [127.0.0.1])
	by ebiederm.dsl.xmission.com (8.13.6/8.13.6/Debian-1) with ESMTP id k5C7ZZZB019079;
	Mon, 12 Jun 2006 01:35:35 -0600
Received: (from eric@localhost)
	by ebiederm.dsl.xmission.com (8.13.6/8.13.6/Submit) id k5C7ZYCB019078;
	Mon, 12 Jun 2006 01:35:34 -0600
X-Authentication-Warning: ebiederm.dsl.xmission.com: eric set sender to ebiederm@xmission.com using -f
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606111735440.5498@g5.osdl.org> (Linus Torvalds's
	message of "Sun, 11 Jun 2006 17:37:47 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21693>

Linus Torvalds <torvalds@osdl.org> writes:

> On Sun, 11 Jun 2006, Eric W. Biederman wrote:
>> 
>> This doesn't look like the From: header was in the middle of the
>> message until it was imported into git so it is probably a small
>> logic error that is easily corrected.  But I need to see what
>> we are parsing so I can understand what is happening.
>
> No, it's at the top of the body, although there might have been an empty 
> line or two (ie whitespace only) before it.

Ok.  I'm not certain why we would not be ignoring blank lines that
we used to skip.  The untested patch below should ensure we always
skip those lines.


>> Even if the header lines are in the middle of the body?
>
> What do you mean by "middle"?
>
> No, it should only look at From: and Subject: lines if they are at the 
> very top, with no other non-whitespace lines above them. But when it looks 
> at them and uses the data from them, it should then remove them from the 
> body - they are "conceptually" just extended header lines that just 
> happened to technically (from an rfc822 standpoint) be in the body of the 
> email.

This is a separate conversation and once the problem of not ignoring leading
blank lines is fixed I will be happy to address it.

Eric

diff --git a/mailinfo.c b/mailinfo.c
index 5b6c215..72c5454 100644
--- a/mailinfo.c
+++ b/mailinfo.c
@@ -279,6 +279,14 @@ static void handle_inbody_header(int *se
                        return;
                }
        }
+       /* Ignore leading blank lines */
+       if (!(*seen & SEEN_PREFIX)) {
+               char *ch;
+               for (ch = line; isspace(*ch); ch++)
+                       ;
+               if (*ch == '\0')
+                       return;
+       }
        *seen |= SEEN_PREFIX;
 }
