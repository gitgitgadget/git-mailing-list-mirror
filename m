From: "Luke-Jr" <luke@dashjr.org>
Subject: Re: [PATCH 1/5] port --ignore-unmatch to "git add"
Date: Thu, 13 Aug 2009 15:40:47 -0500
Message-ID: <200908131540.49701.luke@dashjr.org>
References: <200908121726.52121.luke-jr@utopios.org> <1250133624-2272-1-git-send-email-luke-jr+git@utopios.org> <7vy6pna4lu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Luke Dashjr <luke-jr+git@utopios.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 13 22:49:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbhEj-0001hW-UK
	for gcvg-git-2@gmane.org; Thu, 13 Aug 2009 22:49:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754952AbZHMUtB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Aug 2009 16:49:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754912AbZHMUtB
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Aug 2009 16:49:01 -0400
Received: from unused ([66.216.20.21]:47940 "EHLO zinan.dashjr.org"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1753249AbZHMUtA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Aug 2009 16:49:00 -0400
X-Greylist: delayed 480 seconds by postgrey-1.27 at vger.kernel.org; Thu, 13 Aug 2009 16:49:00 EDT
Received: from tsuruki.localnet (ip70-187-26-118.om.om.cox.net [70.187.26.118])
	(Authenticated sender: luke-jr)
	by zinan.dashjr.org (Postfix) with ESMTPSA id EFB31B9DB46;
	Thu, 13 Aug 2009 20:40:53 +0000 (UTC)
User-Agent: KMail/1.12.0 (Linux/2.6.27-gentoo-r7; KDE/4.3.0; x86_64; ; )
In-Reply-To: <7vy6pna4lu.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125871>

On Thursday 13 August 2009 02:36:13 pm Junio C Hamano wrote:
> Luke Dashjr <luke-jr+git@utopios.org> writes:
> > "git rm" has a --ignore-unmatch option that is also applicable to "git
> > add" and may be useful for persons wanting to ignore unmatched arguments,
> > but not all errors.
>
> Chould you refresh my memory a bit?
>
> In what circumstance is "rm --ignore-unmatch" useful to begin with?
> A similar question for "add --ignore-unmatch".

Not sure on its purpose for "rm", but for "add"...
Avoiding a race condition in automation. In particular, if the file is deleted 
between the time the argument list is built until git scans for matches.

> Now the obligatory design level question is behind us, let's take a brief
> look at the codde.
>
> > +static int ignore_unmatch = 0;
>
> Drop " = 0" and let the language initialize this to zero.

Does C define a default initialisation of zero? My understanding was that 
uninitialised variables are always undefined until explicitly assigned a 
value.

> >  static void fill_pathspec_matches(const char **pathspec, char *seen, int
> > specs) {
> > @@ -63,7 +64,7 @@ static void prune_directory(struct dir_struct *dir,
> > const char **pathspec, int p fill_pathspec_matches(pathspec, seen,
> > specs);
> >
> >  	for (i = 0; i < specs; i++) {
> > -		if (!seen[i] && pathspec[i][0] && !file_exists(pathspec[i]))
> > +		if (!seen[i] && pathspec[i][0] && !file_exists(pathspec[i]) &&
> > !ignore_unmatch) die("pathspec '%s' did not match any files",
> >  					pathspec[i]);
> >  	}
> > @@ -108,7 +109,7 @@ static void refresh(int verbose, const char
> > **pathspec) refresh_index(&the_index, verbose ? REFRESH_SAY_CHANGED :
> > REFRESH_QUIET, pathspec, seen);
> >  	for (i = 0; i < specs; i++) {
> > -		if (!seen[i])
> > +		if (!seen[i] && !ignore_unmatch)
> >  			die("pathspec '%s' did not match any files", pathspec[i]);
> >  	}
> >          free(seen);
>
> What's the point of these two loops if under ignore_unmatch everything
> becomes no-op?
>
> That is, wouldn't it be much more clear if you wrote like this?

I'm not overly familiar with the git codebase, but wouldn't a null 'seen' 
variable break the refresh_index call? The loops themselves can be avoided, I 
suppose. I'll submit a new patch to optimise the changes (and rebase)...
