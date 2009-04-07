From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH v2 14/14] difftool/mergetool: refactor commands to use
	git-mergetool--lib
Date: Tue, 7 Apr 2009 00:07:46 -0700
Message-ID: <20090407070745.GA3684@gmail.com>
References: <1239010228-21315-1-git-send-email-davvid@gmail.com> <200904070137.17716.markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org, benji@silverinsanity.com,
	charles@hashpling.org
To: Markus Heidelberg <markus.heidelberg@web.de>
X-From: git-owner@vger.kernel.org Tue Apr 07 09:09:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lr5RJ-0003Ap-Su
	for gcvg-git-2@gmane.org; Tue, 07 Apr 2009 09:09:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753059AbZDGHIM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Apr 2009 03:08:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751720AbZDGHIK
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Apr 2009 03:08:10 -0400
Received: from rv-out-0506.google.com ([209.85.198.228]:57298 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751323AbZDGHII (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Apr 2009 03:08:08 -0400
Received: by rv-out-0506.google.com with SMTP id f9so2592724rvb.1
        for <git@vger.kernel.org>; Tue, 07 Apr 2009 00:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=7TDis1+Wl+L8+3ej/+QkK1YwG24pBc/i79Gz2yGaF+E=;
        b=Nc31yP1AzRUN0gVAKKfcbN9HEtEPlvmkEoH1Y5mgI+z5jgW/K193BOGMx+8KwGq8K5
         EwDH/yGq6A6n36bd+9OtffE3CsqtwJ17uc218IpApMDOJ4BvfJzMAEdNlC6AiVwX0oqc
         SaoYtfOPihqxAdb0uAEUYDhAJF/Qhaq0OvFiU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=N2PytNEzz+wmizu3/AGTozYWJJMCjauHwsLPR1DEMFgiFi/l4HTuv1RIwCfvdAKj7I
         wgvru5T5oZKeWyWrW0nXTkvqd0GA0C49De/pvjihoU6DaV/EUZ7G9da/N7nEfy1vuuyz
         uiJaryyxtyHeOzl23khtN18R42oh66xAkovfg=
Received: by 10.114.125.18 with SMTP id x18mr2743554wac.220.1239088084351;
        Tue, 07 Apr 2009 00:08:04 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id m17sm6532481waf.66.2009.04.07.00.08.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 07 Apr 2009 00:08:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <200904070137.17716.markus.heidelberg@web.de>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115911>

On  0, Markus Heidelberg <markus.heidelberg@web.de> wrote:
> David Aguilar, 06.04.2009:
> > diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
> 
> > +run_merge_tool () {
> > +	base_present="$2"
> > +	if diff_mode; then
> > +		base_present="false"
> > +	fi
> > +	if test -z "$base_present"; then
> > +		base_present="true"
> > +	fi
> 
> The second if is never true, so isn't necessary. run_merge_tool() is
> called with $2 = true or false in mergetool and $2 = "" in difftool.
> 
> But I wonder, if it would be better to change the proceeding in the
> case-esac in the next hunk below:
> 
> Currently it is:
>     if $base_present
>         mergetool with base
>     else
>         if $merge_mode
>             mergetool without base
>         else
>             difftool
>         fi
>     fi
> 
> Maybe better:
>     if $merge_mode
>         if $base_present
>             mergetool with base
>         else
>             mergetool without base
>         fi
>     else
>         difftool
>     fi
> 
> Then the first if can vanish as well and $base_present doesn't have to
> be set to false in diff_mode.
> 
> And check_unchanged() doesn't have to be called in diff_mode any more,
> $status could be set to 0 by default and doesn't have to be touched when
> in diff_mode. Only in merge_mode git-mergetool has to know, whether the
> merge went fine.
> 
> Then it will be:
>     if $merge_mode
>         touch $BACKUP
>         if $base_present
>             mergetool with base
>         else
>             mergetool without base
>         fi
> 	check_unchanged
>     else
>         difftool
>     fi
> 
> or:
>     if $merge_mode
>         if $base_present
>             mergetool with base
>         else
>             mergetool without base
>         fi
> 	status=$?
>     else
>         difftool
>     fi
> 
> Sorry for coming so late with this.
> 

Nah, I like your suggestion much better.


> > +	if echo "${VISUAL:-$EDITOR}" | grep emacs > /dev/null 2>&1; then
> > +		# $EDITOR is emacs so add emerge as a candidate
> > +		tools="$tools emerge opendiff vimdiff"
> > +	elif echo "${VISUAL:-$EDITOR}" | grep vim > /dev/null 2>&1; then
> > +		# $EDITOR is vim so add vimdiff as a candidate
> > +		tools="$tools vimdiff opendiff emerge"
> > +	else
> > +		tools="$tools opendiff emerge vimdiff"
> > +	fi
> 
> Why is opendiff here? I thought the graphical tools should go above.
> Doesn't have Mac OS $DISPLAY set?

Good catch..
Ahh.. shoot I broke the foo.<tool>.path test on Mac OS
(no tkdiff to override there).
I'll have to redo that to use test-tool.


-- 

	David
