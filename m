From: Johan Herland <johan@herland.net>
Subject: Re: [PATCHv4 06/10] send-pack/receive-pack: Allow server to refuse
 pushes with too many commits
Date: Tue, 24 May 2011 03:11:41 +0200
Message-ID: <201105240311.41440.johan@herland.net>
References: <1306111923-16859-1-git-send-email-johan@herland.net>
 <1306111923-16859-7-git-send-email-johan@herland.net>
 <7vpqn9rnpd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Shawn Pearce <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 24 03:11:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QOgA2-0003L7-Cl
	for gcvg-git-2@lo.gmane.org; Tue, 24 May 2011 03:11:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753776Ab1EXBLo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 May 2011 21:11:44 -0400
Received: from smtp.getmail.no ([84.208.15.66]:38668 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753383Ab1EXBLo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2011 21:11:44 -0400
Received: from get-mta-scan01.get.basefarm.net ([10.5.16.4])
 by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LLO008GBDZIGS30@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Tue, 24 May 2011 03:11:42 +0200 (MEST)
Received: from get-mta-scan01.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 3DA7D1799C9A_DDB05CEB	for <git@vger.kernel.org>; Tue,
 24 May 2011 01:11:42 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan01.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id E77E91796B28_DDB05CDF	for <git@vger.kernel.org>; Tue,
 24 May 2011 01:11:41 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LLO00K5JDZHF930@get-mta-in03.get.basefarm.net> for
 git@vger.kernel.org; Tue, 24 May 2011 03:11:41 +0200 (MEST)
User-Agent: KMail/1.13.7 (Linux/2.6.38-ARCH; KDE/4.6.3; x86_64; ; )
In-reply-to: <7vpqn9rnpd.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174306>

On Tuesday 24 May 2011, Junio C Hamano wrote:
> Johan Herland <johan@herland.net> writes:
> > However, older clients that do not understand the capability will not
> > check their pack against the limit, and will end up pushing the pack
> > to the server. Currently there is no extra check on the server to
> > detect a push that exceeds receive.commitCountLimit. However, such a
> > check could be done in a pre-receive or update hook.
> 
> I found the above a reasonable thing to do. In other words, this is an
> advisory configuration at this point (and from a cursory scanning of the
> rest of the series, throughout the series), and that is OK.
> 
> > diff --git a/Documentation/config.txt b/Documentation/config.txt
> > index 1a060ec..c18faac 100644
> > --- a/Documentation/config.txt
> > +++ b/Documentation/config.txt
> > 
> > @@ -1592,6 +1592,15 @@ receive.unpackLimit::
> >  	especially on slow filesystems.  If not set, the value of
> >  	`transfer.unpackLimit` is used instead.
> > 
> > +receive.commitCountLimit::
> > +	If the number of commits received in a push exceeds this limit,
> > +	then the entire push will be refused. This is meant to prevent
> > +	an unintended large push (typically a result of the user not
> > +	being aware of exactly what is being pushed, e.g. pushing a
> > +	large rewritten history) from entering the repo. If not set,
> > +	there is no upper limit on the number of commits transferred
> > +	in a single push.
> 
> But then it may probably be a good idea to reword this a bit, to clarify
> the refusal happens voluntarily by the pusher.  E.g.
> 
> 	Tell "git push" not to push more than this many commits at once
>         into this repository. This is meant to prevent ... in a single
>         push. Note that older versions of "git push" may ignore this
>         advisory, so if you really want to refuse such a push, you would
>         need to arrange to do so in either the pre-receive hook or the
>         update hook.

Agreed. Thanks for the rewording.

> > diff --git a/Documentation/technical/protocol-capabilities.txt
> > b/Documentation/technical/protocol-capabilities.txt index
> > 11849a3..0240967 100644
> > --- a/Documentation/technical/protocol-capabilities.txt
> > +++ b/Documentation/technical/protocol-capabilities.txt
> > @@ -205,5 +205,7 @@ the server. If the check fails, the client must
> > abort the upload, and
> > 
> >  report the reason for the aborted push back to the user.
> > 
> >  The following "limit-*" capabilites are recognized:
> > + - limit-commit-count=<num> (Maximum number of commits in a pack)
> > +
> 
> I think s/in a pack/to transfer/ is more appropriate.
> 
> It is a non-essential detail that the current implementation carries only
> one pack in a single session between send-pack and receive-pack.  When we
> update the protocol (with another capability) so that we can send more
> than one packs in a single session, we would want the maximum number of
> commits to be honored.

Agreed.

> Come to think of it, I do not necessarily agree with the earlier "max
> commit count can only be used with max pack size"; I can accept it if the
> statement is qualified with "for now", though.

I'll add the qualification.

> It is entirely reasonable to say that I want to split packs in 2GB
> chunks, and I want to keep the number of commits in the resulting packs
> (notice the plural) under this fixed ceiling to avoid mistakes, no?

I guess it depends on whether you interpret the commit count limit as a per-
pack threshold that triggers pack splitting (similar to how we interpret the 
pack size limit), or as an upper bound which aborts pack-objects if 
exceeded.

I initially found it more intuitive to interpret all of these as a fixed 
upper bound when paired with --stdout (since that implicitly limits us to a 
single pack), and as a pack splitting threshold when used without --stdout 
(except that triggering pack splits based on commit count is not useful).

> > @@ -112,6 +118,9 @@ static const char *capabilities()
> > 
> >  	int ret = snprintf(buf, sizeof(buf),
> >  	
> >  			   " report-status delete-refs side-band-64k%s",
> >  			   prefer_ofs_delta ? " ofs-delta" : "");
> > 
> > +	if (limit_commit_count > 0)
> > +		ret += snprintf(buf + ret, sizeof(buf) - ret,
> > +				" limit-commit-count=%lu", limit_commit_count);
> > 
> >  	assert(ret < sizeof(buf));
> 
> Hmm, at this point wouldn't it become attractive to stop using the static
> fixed sized buffer and instead start using a strbuf or something?

Yeah. Will fix in next iteration.

> > diff --git a/builtin/send-pack.c b/builtin/send-pack.c
> > index 5ba5262..f91924f 100644
> > --- a/builtin/send-pack.c
> > +++ b/builtin/send-pack.c
> > @@ -49,9 +49,11 @@ static int pack_objects(int fd, struct ref *refs,
> > struct extra_have_objects *ext
> > 
> >  		NULL,
> >  		NULL,
> >  		NULL,
> > 
> > +		NULL,
> > 
> >  	};
> >  	struct child_process po;
> >  	int i;
> > 
> > +	char buf[40];
> 
> 40 is 19 plus terminating NUL plus 20-decimal digits to hold the count?

Indeed. I will document this more clearly.

> > @@ -263,6 +271,8 @@ int send_pack(struct send_pack_args *args,
> > 
> >  		args->use_ofs_delta = 1;
> >  	
> >  	if (server_supports("side-band-64k"))
> >  	
> >  		use_sideband = 1;
> > 
> > +	if ((p = server_supports("limit-commit-count=")))
> > +		args->max_commit_count = strtoul(p, NULL, 10);
> 
> If we find garbage in *p, we would just run with a random limit, which
> may cause the pack-objects to abort, but that still is a controlled
> failure and is acceptable.

Agreed.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
