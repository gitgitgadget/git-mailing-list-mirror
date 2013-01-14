From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [PATCH v2] Make git selectively and conditionally ignore
 certain stat fields
Date: Tue, 15 Jan 2013 00:43:34 +0100 (CET)
Message-ID: <1815551092.2039693.1358207014937.JavaMail.root@dewire.com>
References: <7vmwwb8m25.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, j sixt <j.sixt@viscovery.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 15 00:44:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tuth8-0008FU-1d
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jan 2013 00:43:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757241Ab3ANXnh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2013 18:43:37 -0500
Received: from zimbra.dewire.com ([83.140.172.131]:34620 "EHLO
	zimbra.dewire.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757089Ab3ANXnh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2013 18:43:37 -0500
Received: from localhost (localhost [127.0.0.1])
	by zimbra.dewire.com (Postfix) with ESMTP id 49C37826D8;
	Tue, 15 Jan 2013 00:43:36 +0100 (CET)
X-Virus-Scanned: amavisd-new at dewire.se
Received: from zimbra.dewire.com ([127.0.0.1])
	by localhost (zimbra.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id E+puGanBKQWZ; Tue, 15 Jan 2013 00:43:35 +0100 (CET)
Received: from zimbra.dewire.com (zimbra.dewire.com [10.1.2.96])
	by zimbra.dewire.com (Postfix) with ESMTP id 0087A82688;
	Tue, 15 Jan 2013 00:43:34 +0100 (CET)
In-Reply-To: <7vmwwb8m25.fsf@alter.siamese.dyndns.org>
X-Originating-IP: [213.67.12.15]
X-Mailer: Zimbra 7.2.0_GA_2681 (ZimbraWebClient - FF3.0 (Mac)/7.2.0_GA_2681)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213543>



----- Ursprungligt meddelande -----
> Robin Rosenberg <robin.rosenberg@dewire.com> writes:
> 
> > diff --git a/read-cache.c b/read-cache.c
> > index fda78bc..f7fe15d 100644
> > --- a/read-cache.c
> > +++ b/read-cache.c
> > @@ -197,8 +197,9 @@ static int ce_match_stat_basic(struct
> > cache_entry *ce, struct stat *st)
> >  	}
> >  	if (ce->ce_mtime.sec != (unsigned int)st->st_mtime)
> >  		changed |= MTIME_CHANGED;
> > -	if (trust_ctime && ce->ce_ctime.sec != (unsigned
> > int)st->st_ctime)
> > -		changed |= CTIME_CHANGED;
> > +	if ((trust_ctime ||
> > ((check_nonzero_stat&CHECK_NONZERO_STAT_CTIME) &&
> > ce->ce_ctime.sec)))
> 
> One SP is required on each side of a binary operator; please have
> one after check_nonzero_stat and after the & after it.
> 
> I wonder if we should lose the trust_ctime variable and use this
> check_nonzero_stat bitset exclusively, provided that this were a
> good direction to go?

Semantically they're somewhat different. My flags are for ignoring
a value when it's not used as indicated by the value zero, while
trustctime is for ignoring untrustworthy, non-zero, values.

>From 1ce4790bf5e:
    A new configuration variable 'core.trustctime' is introduced to
    allow ignoring st_ctime information when checking if paths
    in the working tree has changed, because there are situations where
    it produces too much false positives.  Like when file system crawlers
    keep changing it when scanning and using the ctime for marking scanned
    files.

(your second mail)
>Also I am getting these:
>
>config.c: In function 'git_default_core_config':
>config.c:571: error: passing argument 1 of 'git_config_string' from incompatible pointer type
>config.c:540: note: expected 'const char **' but argument is of type 'char **'
>config.c:573: error: passing argument 1 of 'strtok' discards qualifiers from pointer target type

Different compilers have different defaults. I'm on OS X (mountain lion), or am I missing
something? I do get a warning. Am I allowed to modify the value, like strtok does? Seems I
missed the opportunity to use the copy rather then the original value.

Another thing that I noticed, is that I probably wanto to be able to filter on the precision
of timestamps. Again, this i JGit-related. Current JGit has milliseconds precision (max), whereas
Git has down to nanosecond precision in timestamps. Newer JGits may get nanoseconds timestamps too,
but on current Linux versions JGit gets only integral seconds regardless of file system. 

Would the names, milli, micro, nano be good for ignoring the tail when zero, or n1..n9 (obviously
n2 would be ok too). nN = ignore all but first N nsec digits if they are zero)?

-- robin
