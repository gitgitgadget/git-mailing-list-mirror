From: Pavel Roskin <proski@gnu.org>
Subject: Re: New script: cg-clean
Date: Thu, 11 Aug 2005 20:54:13 -0400
Message-ID: <1123808053.4248.47.camel@dv>
References: <1120862084.17812.6.camel@dv>
	 <20050710154618.GF24249@pasky.ji.cz>
	 <1123312443.17959.34.camel@dv.roinet.com>
	 <20050811232925.GK25280@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 12 02:55:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E3Noh-00038w-M4
	for gcvg-git@gmane.org; Fri, 12 Aug 2005 02:54:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932339AbVHLAyd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 Aug 2005 20:54:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932350AbVHLAyd
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Aug 2005 20:54:33 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:10939 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S932339AbVHLAyc
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2005 20:54:32 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1E3NmC-0005Zk-SV
	for git@vger.kernel.org; Thu, 11 Aug 2005 20:52:10 -0400
Received: from [127.0.0.1] (helo=dv.roinet.com)
	by dv.roinet.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.52)
	id 1E3NoP-0001AA-Rl; Thu, 11 Aug 2005 20:54:17 -0400
Received: (from proski@localhost)
	by dv.roinet.com (8.13.4/8.13.4/Submit) id j7C0sDqa004471;
	Thu, 11 Aug 2005 20:54:13 -0400
X-Authentication-Warning: dv.roinet.com: proski set sender to proski@gnu.org using -f
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20050811232925.GK25280@pasky.ji.cz>
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi, Petr!

Unfortunately, my latest revision of cg-clean has "committed suicide"
just when I was about to post it.  Anyway, I would prefer to wait until
you apply my patch to cg-status to ignore all ignores.  That would allow
me to reuse cg-status.

On Fri, 2005-08-12 at 01:29 +0200, Petr Baudis wrote:
> > Here's the simplified cg-clean script.  Note that the "-d" option is not
> > working with the current version of git of a bug in git-ls-files.  I can
> > work it around by scanning all directories in bash, but I think it's
> > easier to fix git (remove "continue" before DT_REG in ls-files.c).
> 
> Is that fixed already?

It turn out it's quite tricky.  git-ls-files doesn't distinguish between
known and unknown directories.  One way to do it would be to check all
cached files and find all directories they are in.  Another approach
would involve "git-ls-tree -r", but I don't think it would be right
because we work with cache and current files, not with committed data
(but my knowledge is limited to make a call - I still need to read the
documentation about git).

What I did was following:

"git-ls-files --cached" is run, directories are extracted, sorted but
"sort -u" and put to a temporary file dirlist1.  "find -type d" is run,
".git" is filtered out, the list is merged with dirlist1, sorted by
"sort -u", and put to dirlist2.  dirlist1 and dirlist2 are compared by
diff, the entries in dirlist2 are unknown directories.  (That's the kind
of task where Perl hashes would be great).  A technical detail - both
lists are limited to $_git_relpath if it's defined.

> > Processing of .gitignore was taken from cg-status, and I don't really
> > understand it.  But I think it's important to keep that code in sync.
> > It could later go to cg-Xlib.
> 
> It became much simpler a short while later, thankfully. Judging from
> your another patch, I suppose you are going to update this script
> accordingly?

Yes, I'm going to use "cg-status -w" for files.

> > # -d::
> > #	Also clean directories.
> 
> Perhaps add "and their contents" to prevent bad surprises.

Too late :-)

> > filelist=$(mktemp -t gitlsfiles.XXXXXX)
> > git-ls-files --others $EXCLUDE >"$filelist"
> > save_IFS="$IFS"
> > IFS=$'\n'
> > for file in $(cat "$filelist"); do
> 
> Why can't you use git-ls-files | IFS=$'\n' while ?

Good idea.

> > 	IFS="$save_IFS"
> > 	if [ -d "$file" ]; then
> > 		if [ "$cleandir" ]; then
> > 			# Try really hard by changing permissions
> > 			chmod -R 700 "$file"
> > 			rm -rf "$file"
> > 		fi
> 
> An error message would be in order otherwise, I guess.

You mean, list directories if "-d" is not specified?  Good idea.  Also,
the latest revision included the "-v" option for "verbose" - it would
show everything that gets deleted.

> > 		return
> 
> I suppose you mean continue? I'm not really sure what does return do
> here, if it jumps out of the do block or what, and continue is nicely
> explicit. :-)

My error, it was fixed soon after I posted the script.

-- 
Regards,
Pavel Roskin
