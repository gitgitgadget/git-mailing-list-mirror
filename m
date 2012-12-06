From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [PATCH] Perform minimal stat comparison when some stat fields
 are not set
Date: Thu, 6 Dec 2012 02:09:20 +0100 (CET)
Message-ID: <805916413.19333293.1354756160521.JavaMail.root@dewire.com>
References: <7vhao0jc98.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, spearce@spearce.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 06 02:09:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TgPy7-0006co-0b
	for gcvg-git-2@plane.gmane.org; Thu, 06 Dec 2012 02:09:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754086Ab2LFBJX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Dec 2012 20:09:23 -0500
Received: from zimbra.dewire.com ([83.140.172.131]:41207 "EHLO
	zimbra.dewire.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753543Ab2LFBJW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Dec 2012 20:09:22 -0500
Received: from localhost (localhost [127.0.0.1])
	by zimbra.dewire.com (Postfix) with ESMTP id 0EA38825EF;
	Thu,  6 Dec 2012 02:09:21 +0100 (CET)
X-Virus-Scanned: amavisd-new at dewire.se
Received: from zimbra.dewire.com ([127.0.0.1])
	by localhost (zimbra.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id paBETa5hbYW3; Thu,  6 Dec 2012 02:09:20 +0100 (CET)
Received: from zimbra.dewire.com (zimbra.dewire.com [10.1.2.96])
	by zimbra.dewire.com (Postfix) with ESMTP id 919EA82457;
	Thu,  6 Dec 2012 02:09:20 +0100 (CET)
In-Reply-To: <7vhao0jc98.fsf@alter.siamese.dyndns.org>
X-Originating-IP: [213.67.12.15]
X-Mailer: Zimbra 7.2.0_GA_2681 (ZimbraWebClient - FF3.0 (Mac)/7.2.0_GA_2681)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211151>



----- Ursprungligt meddelande -----
> Robin Rosenberg <robin.rosenberg@dewire.com> writes:
> 
> > At least JGit does sets uid, gid, ctime, ino and dev fields to zero
> > on update. To Git this looks like the stat data does not match and
> > a full file compare will be forced even it size and mtime match.
> > This
> > is in practice unnecessary. Sense JGit's presence by checking if
> > ino
> > and dev is zero.
> >
> > Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
> > ---
> >  read-cache.c | 21 +++++++++++++--------
> >  1 file changed, 13 insertions(+), 8 deletions(-)
> >
> > diff --git a/read-cache.c b/read-cache.c
> > index fda78bc..6f13a22 100644
> > --- a/read-cache.c
> > +++ b/read-cache.c
> > @@ -197,21 +197,26 @@ static int ce_match_stat_basic(struct
> > cache_entry *ce, struct stat *st)
> >  	}
> >  	if (ce->ce_mtime.sec != (unsigned int)st->st_mtime)
> >  		changed |= MTIME_CHANGED;
> > -	if (trust_ctime && ce->ce_ctime.sec != (unsigned
> > int)st->st_ctime)
> > +
> > +	int minimal_stat = (ce->ce_ino == 0 && ce->ce_dev == 0);
> 
> decl-after-stmt.

Ok, btw. Which C version do we adhere to? C99 is quite old by now.

> Besides, is it sane to do this unconditionally to affect people who
> do not use JGit?
> 

Would a config option like core.minstat be better? The name would imply no dynamic detection.

- robin
