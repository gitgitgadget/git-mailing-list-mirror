From: Pavel Roskin <proski@gnu.org>
Subject: Re: [PATCH] Add git-clean command
Date: Wed, 05 Apr 2006 02:00:44 -0400
Message-ID: <1144216844.3793.10.camel@dv>
References: <20060403221841.25097.18242.stgit@dv.roinet.com>
	 <7vzmj2b3w3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 05 08:00:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FR14X-0006dW-0M
	for gcvg-git@gmane.org; Wed, 05 Apr 2006 08:00:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751105AbWDEGAu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Apr 2006 02:00:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751106AbWDEGAu
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Apr 2006 02:00:50 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:62110 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1751105AbWDEGAu
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 5 Apr 2006 02:00:50 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1FR14S-00066T-3i
	for git@vger.kernel.org; Wed, 05 Apr 2006 02:00:48 -0400
Received: from proski by dv.roinet.com with local (Exim 4.60)
	(envelope-from <proski@dv.roinet.com>)
	id 1FR14O-0001jg-BS; Wed, 05 Apr 2006 02:00:44 -0400
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vzmj2b3w3.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Evolution 2.6.0 (2.6.0-1) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18414>

On Mon, 2006-04-03 at 17:06 -0700, Junio C Hamano wrote:
> > diff --git a/git-clean.sh b/git-clean.sh
> >...
> > +for arg in "$@"; do
> 
> 	for arg
>         do
>         	...

I checked other git shell scripts and copied the "while" construct from
one of them - if it's good for other commands, it's good for git-clean.

> > +	if [ "$arg" = "-d" ]; then
> 
> 	case "$arg" in -d)...
> 
> > +excl1=
> > +excl2=
> > +if [ -z "$noexclude" ]; then
> > +	excl1="--exclude-per-directory=.gitignore"
> > +	if [ -f "$GIT_DIR/info/exclude" ]; then
> > +		excl2="--exclude-from=$GIT_DIR/info/exclude"
> > +	fi
> > +fi
> > +
> > +git-ls-files --others --directory "$excl1" "$excl2" |
> > +while read -r file; do
> > ...
> 
> The $noexclude case passes two empty strings to git-ls-files,
> which may happen to be harmless with the current implementation,
> but does not feel quite right.

Good catch.  This is needed since $GIT_DIR can contain spaces.  I
believe ${excl2:+"$excl2"} would do the trick.

> Maybe better to read ls-files -z to be really pathname safe, I
> dunno.

I think "xargs -0" has its own problems (argument length limitations),
and the other solution is to use perl.  While at that, I'd rather
rewrite the whole script in Perl, or maybe in even C.

I think this should eventually happen to all git scripts, but I have no
intention to do it right now unless you really want me to.

> > +		$echo1 "Removing $file"
> > +		[ "$cleandirhard" ] && chmod -R 700 "$file"
> 
> I am not quite sure this chmod -R is a good idea.  If we are
> trying really hard would we need to also make sure we can rmdir
> the "$file" by chmod'ing its parent directory?  But once we
> start doing that where would we stop?

OK, I was undecided on that.  I'm dropping this option.

-- 
Regards,
Pavel Roskin
