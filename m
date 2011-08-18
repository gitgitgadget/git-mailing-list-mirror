From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH 4/4] mergetools/meld: Use '--output' when available
Date: Thu, 18 Aug 2011 02:24:06 -0700
Message-ID: <20110818092403.GB15416@gmail.com>
References: <1313652227-48545-1-git-send-email-davvid@gmail.com>
 <1313652227-48545-5-git-send-email-davvid@gmail.com>
 <20110818081309.GP31888@elie.gateway.2wire.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Tanguy Ortolo <tanguy+debian@ortolo.eu>,
	Charles Bailey <charles@hashpling.org>,
	Sebastian Schuberth <sschuberth@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 18 11:24:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qtypm-0004ux-5N
	for gcvg-git-2@lo.gmane.org; Thu, 18 Aug 2011 11:24:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755379Ab1HRJYN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Aug 2011 05:24:13 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:63373 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755199Ab1HRJYM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2011 05:24:12 -0400
Received: by iye16 with SMTP id 16so3615939iye.1
        for <git@vger.kernel.org>; Thu, 18 Aug 2011 02:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Rvsb3r5lWdHsNH5TvJvFCY7vpk91qUYRGu6m6El0cEk=;
        b=KwgfyDetgU6VpiWZxWy12uH44YV/fwfomAaIZ9TuUd2D1XdiEv3OX6+E+uS0VNvZUF
         LLc6AgmQg9CwDYrj8+95nn1wZer+pakEGR+CCsypjBeiM7JvFZzOQSTOKf23jGbxv6Gj
         y+QlZ2/qpQVRf5gli99BpYUW3qjkYdJS/m9M0=
Received: by 10.231.24.195 with SMTP id w3mr1101258ibb.94.1313659451716;
        Thu, 18 Aug 2011 02:24:11 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id g21sm867865ibl.58.2011.08.18.02.24.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 18 Aug 2011 02:24:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110818081309.GP31888@elie.gateway.2wire.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179585>

On Thu, Aug 18, 2011 at 03:13:10AM -0500, Jonathan Nieder wrote:
> David Aguilar wrote:
> 
> > use the '--output' option when available.
> 
> Yay. :)
> 
> > --- a/mergetools/meld
> > +++ b/mergetools/meld
> > @@ -4,6 +4,37 @@ diff_cmd () {
> >  
> >  merge_cmd () {
> >  	touch "$BACKUP"
> > -	"$merge_tool_path" "$LOCAL" "$MERGED" "$REMOTE"
> > +	if test "$meld_has_output_option" = true
> > +	then
> > +		"$merge_tool_path" --output "$MERGED" \
> > +			"$BASE" "$LOCAL" "$REMOTE"
> 
> Shouldn't this be "$LOCAL" "$BASE" "$REMOTE"?

Yup, thanks.

> 
> > +	else
> > +		"$merge_tool_path" "$LOCAL" "$MERGED" "$REMOTE"
> > +	fi
> >  	check_unchanged
> 
> I wonder if the version test could be made a little simpler (perhaps
> to cope better if future versions use a different numbering system):
> 
> 	if "$merge_tool_path" --output /dev/null --help >/dev/null 2>&1
> 	then
> 		"$merge_tool_path" --output ...
> 	else
> 		"$merge_tool_path" "$LOCAL" ...
> 	fi
> 
> Forgive my ignorance: is this function likely to be called in a loop?
> If so, it makes sense to precompute or cache the result of detection,
> like you already do.

Yes, it is called in a loop...


> 	check_meld_for_output_option () {
> 		if ...
> 		then
> 			meld_has_output_option=true
> 		else
> 			meld_has_output_option=false
> 		fi
> 	}
> 
> 	merge_cmd () {
> 		if test -z "${meld_has_output_option:+set}"
> 		then
> 			check_meld_for_output_option
> 		fi
> 
> 		if test "$meld_has_output_option" = true
> 		then
> 			...
> 
> 
> [...]
> > +	# Filter meld --version to contain numbers and dots only
> > +	meld="$(meld --version 2>/dev/null | sed -e 's/[^0-9.]\+//g')"
> 
> \+ is not a BRE.  If parsing version numbers seems like the right
> thing to do, maybe "tr -cd 0-9."?
> 
> > +	meld="${meld:-0.0.0}"
> > +
> > +	meld_major="$(expr "$meld" : '\([0-9]\{1,\}\)' || echo 0)"
> > +	meld_minor="$(expr "$meld" : '[0-9]\{1,\}\.\([0-9]\{1,\}\)' || echo 0)"
> 
> I think git avoids \{m,n\} ranges where possible (for portability).
> This could be:
> 
> 	meld_major=${meld%%.*}
> 	meld_nonmajor=${meld#${meld_major}.}
> 	meld_minor=${meld_nonmajor%%.*}
> 
> or:
> 
> 	case $meld in
> 	[2-9].* | [1-9][0-9]* | 1.[5-9]* | 1.[1-9][0-9]*)	# >= 1.5.0
> 		meld_has_output_option=true ;;
> 	*)
> 		meld_has_output_option=false ;;
> 	esac
> 
> It's nice how self-contained this can be now that it's in its own
> file.  Thanks.

Right, I was using \{1,\} since that's what CodingStyle said to
use instead of \+ (which I forgot to fixup above as you saw).

The case statement is nice and simple enough to understand.
By doing meld --output /dev/null --help we're relying on
older versions blowing up with --output and --help returning
exit status 0.  That seems pretty reasonable.
The case statement does seem sufficient but just trying
--output and seeing what happens is even simpler.
Your example also uses $merge_tool_path, which I forgot to do,
so I'll be sure to include that too.

I'll wait until tomorrow to see if there are any more comments
and reroll.

Thanks,
-- 
					David
