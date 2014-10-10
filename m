From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH] mergetool: use more conservative temporary filenames
Date: Fri, 10 Oct 2014 01:10:36 -0700
Message-ID: <20141010081034.GA44749@gmail.com>
References: <1412758562-25402-1-git-send-email-davvid@gmail.com>
 <xmqq8ukp6qgf.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Sergio Ferrero <sferrero@ensoftcorp.com>,
	Charles Bailey <charles@hashpling.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 10 10:10:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XcVHu-0005fm-4i
	for gcvg-git-2@plane.gmane.org; Fri, 10 Oct 2014 10:10:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751779AbaJJIKq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Oct 2014 04:10:46 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:53617 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751694AbaJJIKg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Oct 2014 04:10:36 -0400
Received: by mail-pa0-f45.google.com with SMTP id rd3so1303104pab.32
        for <git@vger.kernel.org>; Fri, 10 Oct 2014 01:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=hDqZ0pR4qw3G2dS7IXb+YmpeZWmvYHg9gaFXgSSe4PQ=;
        b=LpJ1SImQrGaJeg4pF/A8TJBDfOOsb9S7MMvurhu06SfFrLpHJM3rZLJk2zN+JjmiOF
         MIUBcD5AKa5I5XVkqoiRTc/WYksCtWW2k5F+iEdWbNyGvKcXdUYEGF+xRiZrSkW3Y1h2
         FHURNIjy18CHv3z1Zyu6S3pWLqHASAcV4PkGRTqUX7RG1hsnxbUKn3sGQdef9kMaztip
         RXHyQeLsS+qS5SyAkrfSQCuzCkIdcsWWMITV/0hoKirh1ranjT+Eb4gaT9O1BPboJRM/
         gssadEOEmMAXU8XJyZhSdzgzLDzd4id81htVujfqA5DhUjQwUXfx2tSmGxe9BBM8caMe
         qY6g==
X-Received: by 10.67.14.69 with SMTP id fe5mr3358105pad.73.1412928634755;
        Fri, 10 Oct 2014 01:10:34 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPSA id sb2sm2659563pbc.24.2014.10.10.01.10.33
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 10 Oct 2014 01:10:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <xmqq8ukp6qgf.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 09, 2014 at 11:36:00AM -0700, Junio C Hamano wrote:
> David Aguilar <davvid@gmail.com> writes:
> 
> > Avoid filenames with multiple dots so that overly-picky tools do
> > not misinterpret their extension.
> >
> > Previously, foo/bar.ext in the worktree would result in e.g.
> >
> > 	foo/bar.ext.BASE.1234.ext
> >
> > This can be improved by having only a single .ext and using
> > underscore instead of dot so that the extension cannot be
> > misinterpreted.  The resulting path becomes:
> >
> > 	foo/bar_BASE_1234.ext
> >
> > Suggested-by: Sergio Ferrero <sferrero@ensoftcorp.com>
> > Signed-off-by: David Aguilar <davvid@gmail.com>
> > ---
> >  git-mergetool.sh | 14 +++++++++-----
> >  1 file changed, 9 insertions(+), 5 deletions(-)
> >
> > diff --git a/git-mergetool.sh b/git-mergetool.sh
> > index 9a046b7..1f33051 100755
> > --- a/git-mergetool.sh
> > +++ b/git-mergetool.sh
> > @@ -228,11 +228,15 @@ merge_file () {
> >  		return 1
> >  	fi
> >  
> > -	ext="$$$(expr "$MERGED" : '.*\(\.[^/]*\)$')"
> > -	BACKUP="./$MERGED.BACKUP.$ext"
> > -	LOCAL="./$MERGED.LOCAL.$ext"
> > -	REMOTE="./$MERGED.REMOTE.$ext"
> > -	BASE="./$MERGED.BASE.$ext"
> > +	ext=$(expr "$MERGED" : '.*\(\.[^/]*\)$')
> > +	base=$(basename "$MERGED" "$ext")
> > +	dir=$(dirname "$MERGED")
> > +	suffix="$$""$ext"
> > +
> > +	BACKUP="$dir/$base"_BACKUP_"$suffix"
> > +	BASE="$dir/$base"_BASE_"$suffix"
> > +	LOCAL="$dir/$base"_LOCAL_"$suffix"
> > +	REMOTE="$dir/$base"_REMOTE_"$suffix"
> 
> We used to feed "./foo/bar.ext.BASE.1234.ext"; with this patch we
> feed "foo/bar_BASE_1234.ext".  
> 
> It does make this particular example look prettier, but is the
> droppage of "./" intentional and is free of unintended ill side
> effects?
> 
> We avoid "local" and bash-isms, so I'd prefer to see us not to
> introduce new temporary variables unnecessarily.  I think we can at
> least do without basename/dirname in this case, perhaps like so:
> 
> 	if BASE=$(expr "$MERGED" : '\(.*\)\.[^/]*$')
>         then
>         	ext=$(expr "$MERGED" : '.*\(\.[^/]*\)$')
> 	else
>         	ext= BASE=$MERGED
> 	fi
>         BACKUP="${BASE}_BACKUP_$$$ext"
>         LOCAL="${BASE}_LOCAL_$$$ext"
>         REMOTE="${BASE}_REMOTE_$$$ext"
>         BASE="${BASE}_BASE_$$$ext"

Clever ;-)

> But I do not have very strong opinion either way.  I just didn't
> want to have to think about the leading "./" ;-)

When I first wrote this I thought, "$(dirname foo) == '.', so it should
be okay", but it slipped my mind that $(dirname foo/bar) != "./foo" --
I like this new version better.

The leading ./ shoudln't make a difference but I also don't want
to have to think about it either.  I'll have a v2 patch shortly.
-- 
David
