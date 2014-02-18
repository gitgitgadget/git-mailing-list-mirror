From: John Keeping <john@keeping.me.uk>
Subject: Re: error: src refspec refs/heads/master matches more than one.
Date: Tue, 18 Feb 2014 19:35:20 +0000
Message-ID: <20140218193520.GB1048@serenity.lan>
References: <20140214113136.GA17817@raven.inka.de>
 <87a9dt981o.fsf@igel.home>
 <CACsJy8BevKQaRLYMMv7bTjf_ZAOnkrimws519OyhGZz6_Vr_-A@mail.gmail.com>
 <xmqqy51dirjs.fsf@gitster.dls.corp.google.com>
 <20140215085355.GA15461@lanh>
 <xmqqha7wfdld.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Duy Nguyen <pclouds@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Josef Wolf <jw@raven.inka.de>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 18 20:35:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WFqS7-00060o-KF
	for gcvg-git-2@plane.gmane.org; Tue, 18 Feb 2014 20:35:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751784AbaBRTfb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Feb 2014 14:35:31 -0500
Received: from jackal.aluminati.org ([72.9.247.210]:57023 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751491AbaBRTfa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Feb 2014 14:35:30 -0500
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 4B166CDA330;
	Tue, 18 Feb 2014 19:35:30 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -1
X-Spam-Level: 
X-Spam-Status: No, score=-1 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1] autolearn=disabled
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1fVWicK9Rt4P; Tue, 18 Feb 2014 19:35:29 +0000 (GMT)
Received: from serenity.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id B7EEBCDA523;
	Tue, 18 Feb 2014 19:35:22 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <xmqqha7wfdld.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242342>

On Tue, Feb 18, 2014 at 11:03:10AM -0800, Junio C Hamano wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
> 
> > Prevent is a strong word. I meant we only do it if they force
> > it. Something like this..
> >
> > -- 8< --
> > diff --git a/branch.c b/branch.c
> > index 723a36b..3f0540f 100644
> > --- a/branch.c
> > +++ b/branch.c
> > @@ -251,6 +251,11 @@ void create_branch(const char *head,
> >  			forcing = 1;
> >  	}
> >  
> > +	if (!force && dwim_ref(name, strlen(name), sha1, &real_ref))
> > +		die(_("creating ref refs/heads/%s makes %s ambiguous.\n"
> > +		      "Use -f to create it anyway."),
> > +		    name, name);
> 
> Does this check still allow you to create a branch "refs/heads/next"
> and then later create a branch "next"?  The latter will introduce an
> ambiguity without any prevention, even though the prevention would
> trigger if the order in which these two branches are created is
> swapped--- the end result has ambiguity but the safety covers only
> one avenue to the confusing situation.
> 
> And the only way I can think of to avoid that kind of confusion is
> to forbid creation of a subset of possible names by reserving a set
> of known (but arbitrary) prefixes---which I am not sure is a good
> way to go.  At least not yet.

There's already the arbitrary set of prefixes in
refs.c::prettify_refname() and refs.c::ref_rev_parse_rules().  I can see
how a user might think that since "git log refs/heads/name" is
equivalent to "git log master" then "git branch refs/heads/name" should
be equivalent to "git branch name".

I don't think requiring "--force" for these branch names that overlap
with these special namespaces is a big leap from supporting them for
inspection commands.  Although I'm not sure how sensible it is to
examine every remote name to catch something like "git branch
origin/master".  Perhaps Duy's ambiguity check is the best thing for
that case.
