From: David Kastrup <dak@gnu.org>
Subject: Re: Shell script cleanups/style changes?
Date: Thu, 02 Aug 2007 22:57:31 +0200
Message-ID: <85odhpzmbo.fsf@lola.goethe.zz>
References: <86bqdqkygp.fsf@lola.quinscape.zz>
	<7vlkctvfk9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 02 22:57:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGhjq-0003iq-EN
	for gcvg-git@gmane.org; Thu, 02 Aug 2007 22:57:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754056AbXHBU5j (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Aug 2007 16:57:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753647AbXHBU5j
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Aug 2007 16:57:39 -0400
Received: from mail-in-13.arcor-online.net ([151.189.21.53]:54729 "EHLO
	mail-in-13.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752591AbXHBU5i (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Aug 2007 16:57:38 -0400
Received: from mail-in-01-z2.arcor-online.net (mail-in-01-z2.arcor-online.net [151.189.8.13])
	by mail-in-13.arcor-online.net (Postfix) with ESMTP id E98BB1E50C6;
	Thu,  2 Aug 2007 22:57:36 +0200 (CEST)
Received: from mail-in-10.arcor-online.net (mail-in-10.arcor-online.net [151.189.21.50])
	by mail-in-01-z2.arcor-online.net (Postfix) with ESMTP id D9B0312DE74;
	Thu,  2 Aug 2007 22:57:36 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-024-023.pools.arcor-ip.net [84.61.24.23])
	by mail-in-10.arcor-online.net (Postfix) with ESMTP id 90A6924E2F5;
	Thu,  2 Aug 2007 22:57:36 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id B21E11D0344E; Thu,  2 Aug 2007 22:57:31 +0200 (CEST)
In-Reply-To: <7vlkctvfk9.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's message of "Thu\, 02 Aug 2007 13\:37\:10 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/3848/Thu Aug  2 22:22:06 2007 on mail-in-10.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54609>

Junio C Hamano <gitster@pobox.com> writes:

> David Kastrup <dak@gnu.org> writes:
>
>> Hi, I wanted to ask what the general stance towards shell script
>> cleanups and simplifications would be.  For example, I find the
>> expr usage quite inscrutable in commit, and there is no necessity
>> of putting "shift" in every case branch instead of once behind it,
>> and a lot of conditionals and other manipulations can be made much
>> easier on the eye by using parameter expansion patterns that are,
>> as far as I can see, available with every reasonable Bourne Shell
>> and clones.
>
> As to Bourne-ness of the shell script, please realize that your
> maintainer is very old fashioned ;-), but is willing to be taught
> new tricks within reason.

Most of the "new tricks" I try on bash, dash and ash.

> We try to limit ourselves to -, =, ?, + (and their colon "if
> empty" variants when it really make sense) in parameter
> expansion of shell variables.  We also use % and # (and their
> "match largest" variants).

You do?

Indeed:

-*- mode: grep; default-directory: "/home/tmp/git/" -*-
Grep started at Thu Aug  2 22:47:30

grep -nH -e '\${[a-zA-Z0-9_]*[#%]' *.sh
git-am.sh:146:	resolvemsg=${1#--resolvemsg=}; shift ;;
git-clone.sh:358:			destname="refs/$branch_top/${name#refs/heads/}" ;;
git-clone.sh:360:			destname="refs/$tag_top/${name#refs/tags/}" ;;
git-filter-branch.sh:361:		ref="${ref#refs/tags/}"
git-pull.sh:98:	curr_branch=${curr_branch#refs/heads/}
git-rebase.sh:93:	eval GITHEAD_$cmt='"${cmt_name##refs/heads/}~$(($end - $msgnum))"'
git-stash.sh:52:		branch=${branch#refs/heads/}

Grep finished (matches found) at Thu Aug  2 22:47:31

I am confused now: a different poster adamantly stated that /bin/sh on
Solaris did not support those constructs, and that every functionality
of git was working fine for him.

> Non POSIX substitions such as ${parameter/pattern/string} and
> ${parameter:offset} are not to be used.  We do not want to
> depend on bash.

Sure.  What about the git-rebase line using $(($end - $msgnum)) ?
That's even more risque than ##.

> After 1.5.3 git-commit.sh will hopefully become built-in, so I would
> rather not touch the script.

Too bad: this should mean that $EDITOR can get called from C...  I've
been glad to see that so far this could be avoided.

> Certainly, the kind of change that is "intended to be style-only but
> somebody needs to make sure it does not introduce regression to
> everybody's shell" is very unwelcome at this point.

Understood.  But using ${...#...} and ${...:+...} does not exactly
seem to be news in the git code base.  Even though we have the claim
that Solaris' sh won't deal with the former.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
