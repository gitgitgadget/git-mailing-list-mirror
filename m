From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] send-email: more meaningful Message-ID
Date: Tue, 5 Apr 2016 21:36:07 +0000
Message-ID: <20160405213607.GA15023@dcvr.yhbt.net>
References: <20160405193952.5849-1-normalperson@yhbt.net>
 <xmqqinzv224x.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 05 23:36:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anYe5-0007qG-L2
	for gcvg-git-2@plane.gmane.org; Tue, 05 Apr 2016 23:36:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760291AbcDEVgL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Apr 2016 17:36:11 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:43565 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760156AbcDEVgK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Apr 2016 17:36:10 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1FC4920437;
	Tue,  5 Apr 2016 21:36:07 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <xmqqinzv224x.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290813>

Junio C Hamano <gitster@pobox.com> wrote:
> Eric Wong <normalperson@yhbt.net> writes:
> 
> > Using a YYYYmmddHHMMSS date representation is more meaningful to
> > humans, especially when used for lookups on NNTP servers or linking
> > to archive sites via Message-ID (e.g. mid.gmane.org or
> > mid.mail-archive.com).  This timestamp format more easily gives a
> > reader of the URL itself a rough date of a linked message compared
> > to having them calculate the seconds since the Unix epoch.
> >
> > Furthermore, having the MUA name in the Message-ID seems to be a
> > rare oddity I haven't noticed outside of git-send-email.  We
> > already have an optional X-Mailer header field to advertise for
> > us, so extending the Message-ID by 15 characters can make for
> > unpleasant Message-ID-based URLs to archive sites.
> >
> > Signed-off-by: Eric Wong <normalperson@yhbt.net>
> > ---
> 
> Sounds like a sensible goal.  Just a few comments.
> 
>  - Is it safe to assume that we always can use POSIX::strftime(), or
>    do we need some fallback?  I am guessing that this is safe, as
>    POSIX has been part of the core modules for a long time, and the
>    script does "use 5.008" upfront.

I'm hoping so :)  And none of the format specifiers used here
should be subject to locale-dependent weirdness, at least.

+Cc both Johannes for Windows knowledge.

>  - It is my understanding that, as "use" is a compilation-time
>    thing, hiding it inside a block does not help reducing the
>    start-up overhead (people can use "require" if they want to do a
>    lazy loading and optionally a fallback).  Is my Perl5 outdated?
>    Otherwise, let's have it near the beginning of the script, close
>    to where we use Term::ReadLine and others.

You're correct, I'll move the "use" to the top in v2.

I could call "require" and call the sub as "POSIX::strftime",
but this code path is likely enough that any startup time
improvement for uncommon cases wouldn't be worth it.

Will wait a bit for strftime portability comments before v2.

> > --- a/git-send-email.perl
> > +++ b/git-send-email.perl
> > @@ -949,7 +949,8 @@ my ($message_id_stamp, $message_id_serial);
> >  sub make_message_id {
> >  	my $uniq;
> >  	if (!defined $message_id_stamp) {
> > -		$message_id_stamp = sprintf("%s-%s", time, $$);
> > +		use POSIX qw/strftime/;
> > +		$message_id_stamp = strftime("%Y%m%d%H%M%S.$$", gmtime(time));
> >  		$message_id_serial = 0;
> >  	}
> >  	$message_id_serial++;
