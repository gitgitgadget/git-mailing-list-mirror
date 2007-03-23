From: arjen@yaph.org (Arjen Laarhoven)
Subject: Re: [PATCH] Teach git-mergetool about Apple's opendiff/FileMerge
Date: Fri, 23 Mar 2007 09:25:01 +0100
Message-ID: <20070323082501.GF3854@regex.yaph.org>
References: <20070322213728.GD3854@regex.yaph.org> <7vbqiksh4a.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: tytso@mit.edu, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Mar 23 09:25:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUf5G-0001Om-Nz
	for gcvg-git@gmane.org; Fri, 23 Mar 2007 09:25:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422708AbXCWIZH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Mar 2007 04:25:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422715AbXCWIZH
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Mar 2007 04:25:07 -0400
Received: from regex.yaph.org ([193.202.115.201]:52915 "EHLO regex.yaph.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422708AbXCWIZD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Mar 2007 04:25:03 -0400
Received: by regex.yaph.org (Postfix, from userid 1000)
	id ED5475B7CA; Fri, 23 Mar 2007 09:25:01 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7vbqiksh4a.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42911>

Hi,

> I cannot comment on the calling interface of opendiff, as I do
> not have access to an Apple.  Here are my first impressions.
> 
> > diff --git a/git-mergetool.sh b/git-mergetool.sh
> > index 7942fd0..58ae201 100755
> > --- a/git-mergetool.sh
> > +++ b/git-mergetool.sh
> > @@ -248,6 +248,30 @@ merge_file () {
> >  		mv -- "$BACKUP" "$path.orig"
> >  	    fi
> >  	    ;;
> > +	opendiff)
> > +	    touch "$BACKUP"
> > +	    if base_present; then
> > +		opendiff $LOCAL $REMOTE -ancestor $BASE -merge $path | cat
> > +            else
> > +                opendiff $LOCAL $REMOTE -merge $path | cat
> > +            fi
> 
> I sense inconsistent tabbing here.

Somehow I missed this.

> More seriously, all of the above $variable references must be
> dq'ed; see other case arms for good examples.

I don't use shell scripting  much, some reading up on quoting
enlightened me :-)

> What's the purpose of this cat anyway?  It looks like an
> expensive no-op to me.

opendiff is a wrapper for the FileMerge.app application.  It launches the
FileMerge binary with the expanded filenames and returns immediately,
which is confusing, as git-mergetool immediately continues.  When the
output of opendiff is piped somewhere, it'll wait until FileMerge is
exited (and the user has had a chance to save the merged file).

I think there is another solution, I'll look into this.

> > +	    if test "$path" -nt "$BACKUP" ; then
> > +		status=0;
> > +	    else
> > +		while true; do
> > +		    echo "$path seems unchanged."
> > +		    echo -n "Was the merge successful? [y/n] "
> > +		    read answer < /dev/tty
> > +		    case "$answer" in
> > +			y*|Y*) status=0; break ;;
> > +			n*|N*) status=1; break ;;
> > +		    esac
> > +		done
> > +	    fi
> > +	    if test "$status" -eq 0; then
> > +		mv -- "$BACKUP" "$path.orig"
> > +	    fi
> > +	    ;;
> >      esac
> 
> This part is duplicated across meld|vimdiff and xxdiff arms; you
> probably would want to have a patch that makes a shell function
> to factor this out, and then another patch to add this opendiff
> support.

Will do.

Arjen
