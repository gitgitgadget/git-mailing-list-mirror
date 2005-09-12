From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Add "git grep" helper
Date: Mon, 12 Sep 2005 15:12:32 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509121500400.3266@g5.osdl.org>
References: <Pine.LNX.4.58.0509121203210.4098@g5.osdl.org>
 <7vbr2y7yfd.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 13 00:14:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEwXl-00023e-7M
	for gcvg-git@gmane.org; Tue, 13 Sep 2005 00:12:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932294AbVILWMn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Sep 2005 18:12:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932299AbVILWMn
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Sep 2005 18:12:43 -0400
Received: from smtp.osdl.org ([65.172.181.4]:35467 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932294AbVILWMl (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Sep 2005 18:12:41 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8CMCaBo025403
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 12 Sep 2005 15:12:37 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8CMCXOT023488;
	Mon, 12 Sep 2005 15:12:35 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vbr2y7yfd.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.115 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8442>



On Mon, 12 Sep 2005, Junio C Hamano wrote:
> 
> I do not much care about other grep flags but I think you forgot
> to special case '-e', so what is in the "master" branch has one
> extra commit on top of it for that (it does not seem to have
> percolated down yet).

Actually, the more I think about it, the more I think Morten was right, 
and the git-grep case statement should just put all flags in "$flags", and 
any git-ls-files flags can be handled specially before.

We also need special casing for grep flags that take an argument.  So the
end result might be something like the following..

  ...
  case "$pattern" in

    # git-ls-file specific flags
    --others|--exclude=*|--exclude-from=*|--exclude-per-directory=*)
	git_flags="$git_flags $pattern"
	shift
	;;

    # grep flags with an argument
    -B|-C|-m)
	flags="$flags $pattern $2"
	shift
	shift
	;;

    # grep 'pattern' argument
    -e)
	pattern="$2"
	shift
	break
	;;

    # We assume everything else is a regular grep pattern
    -*)
	flags="$flags $pattern"
	shift
	;;
  ...

instead. And it's entirely possible that we'd never want to even bother 
with things like --others and --exclude* at all.

		Linus
