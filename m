From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH 7/7] mergetool--lib: Improve show_tool_help() output
Date: Fri, 25 Jan 2013 20:08:07 +0000
Message-ID: <20130125200807.GB7498@serenity.lan>
References: <1359107034-14606-1-git-send-email-davvid@gmail.com>
 <1359107034-14606-8-git-send-email-davvid@gmail.com>
 <20130125195446.GA7498@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 25 21:08:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TypZn-0007hX-98
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jan 2013 21:08:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751278Ab3AYUIS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2013 15:08:18 -0500
Received: from jackal.aluminati.org ([72.9.247.210]:60581 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751056Ab3AYUIR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2013 15:08:17 -0500
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 71407CDA610;
	Fri, 25 Jan 2013 20:08:16 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9] autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aJ-TuDR63xby; Fri, 25 Jan 2013 20:08:15 +0000 (GMT)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by jackal.aluminati.org (Postfix) with ESMTP id 69B9DCDA60E;
	Fri, 25 Jan 2013 20:08:14 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 5E474161E4FB;
	Fri, 25 Jan 2013 20:08:14 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9a4L3hu0YttR; Fri, 25 Jan 2013 20:08:14 +0000 (GMT)
Received: from serenity.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id DE7E8161E20D;
	Fri, 25 Jan 2013 20:08:09 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <20130125195446.GA7498@serenity.lan>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214575>

On Fri, Jan 25, 2013 at 07:54:46PM +0000, John Keeping wrote:
> On Fri, Jan 25, 2013 at 01:43:54AM -0800, David Aguilar wrote:
> > Check the can_diff and can_merge functions before deciding whether to
> > add the tool to the available/unavailable lists.  This makes --tool-help context-
> > sensitive so that "git mergetool --tool-help" displays merge tools only
> > and "git difftool --tool-help" displays diff tools only.
> 
> This log message is misleading - the existing code in
> list_merge_tool_candidates already filters the tools like this, so the
> change is more:
> 
>     mergetool--lib: don't use a hardcoded list for "--tool-help"
> 
>     Instead of using a list of tools in list_merge_tool_candidates, list
>     the available scriptlets and query each of those to know whether it
>     applies to diff mode and/or merge mode.
> 
>     guess_merge_tool still relies on list_merge_tool_candidates so we
>     can't remove that function now.
> 
> 
> The patch seems to do the right thing, although I have a couple of minor
> nits...
> 
> > Signed-off-by: David Aguilar <davvid@gmail.com>
> > ---
> >  git-mergetool--lib.sh | 26 +++++++++++++++++++++-----
> >  1 file changed, 21 insertions(+), 5 deletions(-)
> > 
> > diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
> > index db8218a..c547c59 100644
> > --- a/git-mergetool--lib.sh
> > +++ b/git-mergetool--lib.sh
> > @@ -168,17 +168,33 @@ list_merge_tool_candidates () {
> >  }
> >  
> >  show_tool_help () {
> > -	list_merge_tool_candidates
> >  	unavailable= available= LF='
> >  '
> > -	for i in $tools
> > +
> > +	scriptlets="$(git --exec-path)"/mergetools
> > +	for i in "$scriptlets"/*
> >  	do
> > -		merge_tool_path=$(translate_merge_tool_path "$i")
> > +		. "$scriptlets"/defaults
> > +		. "$i"
> > +
> > +		tool="$(basename "$i")"
> 
> Quotes are unnecessary here.
> 
> > +		if test "$tool" = "defaults"
> > +		then
> > +			continue
> > +		elif merge_mode && ! can_merge
> > +		then
> > +			continue
> > +		elif diff_mode && ! can_diff
> > +		then
> > +			continue
> > +		fi
> 
> Would this be better as:
> 
>     test "$tool" = "defaults" && continue
> 
>     can_merge || ! merge_mode || continue
>     can_diff || ! diff_mode || continue
> 
> or is that a bit too concise?
> 
> I'd prefer to see two separate if statements either way since the "test
> $tool = defaults" case is different from the "does it apply to the
> current mode?" case.  The "$tool = defaults" case could even move to the
> top of the loop.
> 
> > +		merge_tool_path=$(translate_merge_tool_path "$tool")

Actually, can we just change all of the above part of the loop to:

	test "$tool" = defaults && continue

	merge_tool_path=$(
		setup_tool "$tool" >/dev/null 2>&1 &&
		translate_merge_tool_path "$tool"
	) || continue

> >  		if type "$merge_tool_path" >/dev/null 2>&1
> >  		then
> > -			available="$available$i$LF"
> > +			available="$available$tool$LF"
> >  		else
> > -			unavailable="$unavailable$i$LF"
> > +			unavailable="$unavailable$tool$LF"
> >  		fi
> >  	done
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
