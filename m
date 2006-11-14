X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/5] allow cloning a repository "shallowly"
Date: Tue, 14 Nov 2006 11:49:55 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0611141145390.13772@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0610302009160.26682@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v4pt21oe9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Tue, 14 Nov 2006 10:50:37 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7v4pt21oe9.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31343>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gjvs8-0006yP-CO for gcvg-git@gmane.org; Tue, 14 Nov
 2006 11:50:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S933400AbWKNKt6 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 14 Nov 2006
 05:49:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933401AbWKNKt6
 (ORCPT <rfc822;git-outgoing>); Tue, 14 Nov 2006 05:49:58 -0500
Received: from mail.gmx.net ([213.165.64.20]:63901 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S933400AbWKNKt5 (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 14 Nov 2006 05:49:57 -0500
Received: (qmail invoked by alias); 14 Nov 2006 10:49:55 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp040) with SMTP; 14 Nov 2006 11:49:55 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Hi,

On Mon, 13 Nov 2006, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > By specifying a depth, you can now clone a repository such that
> > all fetched ancestor-chains' length is at most "depth". For example,
> > if the upstream repository has only 2 branches ("A" and "B"), which
> > are linear, and you specify depth 3, you will get A, A~1, A~2, A~3,
> > B, B~1, B~2, and B~3. The ends are automatically made shallow
> > commits.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  fetch-pack.c  |   61 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
> >  git-clone.sh  |   19 +++++++++++++++--
> >  upload-pack.c |   21 ++++++++++++++++++-
> >  3 files changed, 96 insertions(+), 5 deletions(-)
> >
> > diff --git a/fetch-pack.c b/fetch-pack.c
> > index 488adc9..9619d6e 100644
> > --- a/fetch-pack.c
> > +++ b/fetch-pack.c
> >...
> > +		while ((len = packet_read_line(fd[0], line, sizeof(line)))) {
> > +			if (!strncmp("shallow ", line, 8)) {
> > +				if (get_sha1_hex(line + 8, sha1))
> > +					die("invalid shallow line: %s", line);
> > +				/* no need making it shallow if we have it already */
> > +				if (lookup_object(sha1))
> > +					continue;
> > +				register_shallow(sha1);
> > +			}
> > +		}
> > +	}
> 
> I understand "no need making it shallow", but I am not sure if a
> non-NULL return from lookup_object() tells us that.

You are probably right, how about has_sha1_file()?

> I think register_shallow() can take commits that are already shallow() 
> so maybe we can remove this "if() continue"?

Yes, it can, but that is not necessarily correct: since .git/shallow is 
constructed from the registered shallow commits, we would make a commit 
shallow which is really not shallow.

So, how about

> > +				if (lookup_object(sha1) || has_sha1_file(sha1))
> > +					continue;

Ciao,
Dscho
