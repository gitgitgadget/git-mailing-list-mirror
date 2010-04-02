From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: [PATCH 4/4] git status: refresh the index
Date: Fri, 2 Apr 2010 21:39:45 +0100
Message-ID: <201004022239.46139.markus.heidelberg@web.de>
References: <1270211241-10795-1-git-send-email-markus.heidelberg@web.de> <1270211241-10795-5-git-send-email-markus.heidelberg@web.de> <7v6349bs52.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 02 22:37:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nxncs-00007H-6A
	for gcvg-git-2@lo.gmane.org; Fri, 02 Apr 2010 22:37:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754093Ab0DBUhy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Apr 2010 16:37:54 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:47605 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753894Ab0DBUhx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Apr 2010 16:37:53 -0400
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate01.web.de (Postfix) with ESMTP id DB2A21541D831;
	Fri,  2 Apr 2010 22:37:51 +0200 (CEST)
Received: from [91.19.8.199] (helo=pluto.localnet)
	by smtp07.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #4)
	id 1Nxncl-0007fZ-00; Fri, 02 Apr 2010 22:37:51 +0200
User-Agent: KMail/1.12.4 (Linux/2.6.30-gentoo-r8; KDE/4.3.5; i686; ; )
In-Reply-To: <7v6349bs52.fsf@alter.siamese.dyndns.org>
Jabber-ID: markus.heidelberg@web.de
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX1+eCAyYX3Bhl+tGg7uTXds9o5jhf6YsJNoabMox
	ZzUs6LbnTotBCPg9Zm56F8NA5HaQDYW5aA/1C+OddykmIajnMl
	7lmVugfO2kJJOSQoeYWA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143848>

Junio C Hamano, 2010-04-02 20:56:
> Markus Heidelberg <markus.heidelberg@web.de> writes:
> 
> > This was already the case before commit 9e4b7ab6 (git status: not
> > "commit --dry-run" anymore, 2009-08-15) and got lost during the
> > conversion, which was meant to only change behaviour when invoked with
> > arguments.
> >
> > Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
> > ---
> >  builtin/commit.c  |    5 +++++
> >  t/t7508-status.sh |    2 +-
> >  2 files changed, 6 insertions(+), 1 deletions(-)
> >
> > diff --git a/builtin/commit.c b/builtin/commit.c
> > index c5ab683..2262734 100644
> > --- a/builtin/commit.c
> > +++ b/builtin/commit.c
> > @@ -1017,6 +1017,7 @@ static int git_status_config(const char *k, const char *v, void *cb)
> >  int cmd_status(int argc, const char **argv, const char *prefix)
> >  {
> >  	struct wt_status s;
> > +	int fd;
> >  	unsigned char sha1[20];
> >  	static struct option builtin_status_options[] = {
> >  		OPT__VERBOSE(&verbose),
> > @@ -1050,6 +1051,10 @@ int cmd_status(int argc, const char **argv, const char *prefix)
> >  
> >  	read_cache_preload(s.pathspec);
> >  	refresh_index(&the_index, REFRESH_QUIET|REFRESH_UNMERGED, s.pathspec, NULL, NULL);
> > +	fd = hold_locked_index(&index_lock, 1);
> > +	if (write_cache(fd, active_cache, active_nr) ||
> > +	    commit_locked_index(&index_lock))
> > +		die("unable to write new_index file");
> 
> This is a regression, I think.

A regressions in comparison with the current behaviour, but not with the
former "commit --dry-run".

I'll send a second attempt without regression.

Markus
