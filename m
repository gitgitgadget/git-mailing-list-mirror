From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH 7/7] mergetool--lib: Improve show_tool_help() output
Date: Fri, 25 Jan 2013 21:16:01 +0000
Message-ID: <20130125211601.GD7498@serenity.lan>
References: <1359107034-14606-1-git-send-email-davvid@gmail.com>
 <1359107034-14606-8-git-send-email-davvid@gmail.com>
 <20130125195446.GA7498@serenity.lan>
 <20130125200807.GB7498@serenity.lan>
 <7vpq0t2f2t.fsf@alter.siamese.dyndns.org>
 <20130125204619.GC7498@serenity.lan>
 <7vlibh2d8a.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Aguilar <davvid@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 25 22:16:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TyqdT-0002kJ-Uc
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jan 2013 22:16:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752830Ab3AYVQK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2013 16:16:10 -0500
Received: from hyena.aluminati.org ([64.22.123.221]:55161 "EHLO
	hyena.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752332Ab3AYVQJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2013 16:16:09 -0500
Received: from localhost (localhost [127.0.0.1])
	by hyena.aluminati.org (Postfix) with ESMTP id F0CD923247;
	Fri, 25 Jan 2013 21:16:08 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at hyena.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from hyena.aluminati.org ([127.0.0.1])
	by localhost (hyena.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dyvHdWoRy49O; Fri, 25 Jan 2013 21:16:08 +0000 (GMT)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by hyena.aluminati.org (Postfix) with ESMTP id 4F61D22CF2;
	Fri, 25 Jan 2013 21:16:08 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 44A92161E4E3;
	Fri, 25 Jan 2013 21:16:08 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id O48EAWrmYsHJ; Fri, 25 Jan 2013 21:16:08 +0000 (GMT)
Received: from serenity.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id D32D0161E34E;
	Fri, 25 Jan 2013 21:16:03 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <7vlibh2d8a.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214584>

On Fri, Jan 25, 2013 at 12:56:37PM -0800, Junio C Hamano wrote:
> John Keeping <john@keeping.me.uk> writes:
> 
> > On Fri, Jan 25, 2013 at 12:16:42PM -0800, Junio C Hamano wrote:
> >> John Keeping <john@keeping.me.uk> writes:
> >> 
> >> > Actually, can we just change all of the above part of the loop to:
> >> >
> >> > 	test "$tool" = defaults && continue
> >> >
> >> > 	merge_tool_path=$(
> >> > 		setup_tool "$tool" >/dev/null 2>&1 &&
> >> > 		translate_merge_tool_path "$tool"
> >> > 	) || continue
> >> 
> >> Meaning "setup_tool ought to know which mode we are in and should
> >> fail if we are in merge mode and it does not support merging"?  That
> >> line of reasoning makes tons of sense to me, compared to this script
> >> implementing that logic for these scriptlets.
> >
> > Yes, that's part of what setup_tool does.  It actually calls "exit" if
> > the "mode? && can_mode" test fails, which is why we need to call it in
> > the subshell.
> >
> > I think this would get even better if we add a preparatory patch like
> > this, so we can just call setup_tool and then set merge_tool_path:
> >
> > -- >8 --
> >
> > diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
> > index 888ae3e..4644cbf 100644
> > --- a/git-mergetool--lib.sh
> > +++ b/git-mergetool--lib.sh
> > @@ -67,11 +67,11 @@ setup_tool () {
> >  	if merge_mode && ! can_merge
> >  	then
> >  		echo "error: '$tool' can not be used to resolve merges" >&2
> > -		exit 1
> > +		return 1
> >  	elif diff_mode && ! can_diff
> >  	then
> >  		echo "error: '$tool' can only be used to resolve merges" >&2
> > -		exit 1
> > +		return 1
> >  	fi
> >  	return 0
> >  }
> > @@ -100,7 +100,7 @@ run_merge_tool () {
> >  	status=0
> >  
> >  	# Bring tool-specific functions into scope
> > -	setup_tool "$1"
> > +	setup_tool "$1" || return
> >  
> >  	if merge_mode
> >  	then
> >
> > -- 8< --
> >  
> >> How/when does translate_merge_tool_path fail?
> >
> > It doesn't - the "|| continue" is to catch errors from setup_tool.
> 
> Ugh.

Is that targeted at my suggestion at the top of this email or calling
exit in setup_tool?

With the patch above, the block of code at the top becomes:

 	test "$tool" = defaults && continue

 	setup_tool "$tool" 2>/dev/null || continue
 	merge_tool_path=$(translate_merge_tool_path "$tool")

which IMHO is pretty readable.


John
