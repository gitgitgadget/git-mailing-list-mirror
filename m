X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Petr Baudis <pasky@ucw.cz>
Subject: Re: Git hosting techniques
Date: Sat, 4 Nov 2006 13:08:45 +0100
Message-ID: <20061104120845.GA18879@pasky.or.cz>
References: <20061029175446.GE12285@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 4 Nov 2006 12:09:03 +0000 (UTC)
Cc: savannah-hackers-public@gnu.org, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <20061029175446.GE12285@localhost.localdomain>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30924>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GgKKQ-0002OJ-Uj for gcvg-git@gmane.org; Sat, 04 Nov
 2006 13:08:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965351AbWKDMIs (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 4 Nov 2006
 07:08:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965354AbWKDMIs
 (ORCPT <rfc822;git-outgoing>); Sat, 4 Nov 2006 07:08:48 -0500
Received: from w241.dkm.cz ([62.24.88.241]:48261 "EHLO machine.or.cz") by
 vger.kernel.org with ESMTP id S965351AbWKDMIr (ORCPT
 <rfc822;git@vger.kernel.org>); Sat, 4 Nov 2006 07:08:47 -0500
Received: (qmail 16682 invoked by uid 2001); 4 Nov 2006 13:08:45 +0100
To: Sylvain Beucler <beuc@gnu.org>
Sender: git-owner@vger.kernel.org

  Hi,

  cc'ing git@vger.kernel.org since this might be interesting for other
Git people as well.

On Sun, Oct 29, 2006 at 06:54:46PM CET, Sylvain Beucler wrote:
> We're currently setting up something similar at
> http://cvs.sv.gnu.org/gitweb/,

  That's great!

> I would like to know if you considered the ability to autopack
> repositories to optimize space and disk i/o. For example, we're
> experimenting with the coreutils repository which weighs 1.1GB. Since
> you mirror the glibc repository, maybe you have similar issues?

  currently I do it in a rather silly way and when I do an "all-repo
check" every hour (which updates mirrors of external repositories etc.)
- I also check for unpacked objects and if there are any, I will repack
the repository; see

	http://repo.or.cz/w/repo.git?a=blob;f=updatecheck.sh;hb=HEAD

  This is not an optimal behaviour, for two reasons:

  (i) Full repack can be a lot of work on large repositories, so we
shouldn't *always* repack but more importantly, we should only rarely do
a full repack - see below.

  (ii) This is very unfriendly to those who fetch over HTTP, because
after you do a full repack, they will need to download the whole new
packfile instead of just the missing objects.

  The best solution would be to have a more intelligent repacking
strategy, where you have "archival" packs with very old history and an
active pack with just the new changes, and when you pack the loose
objects they just get appended to the "current" pack. Alternatively,
a slightly more complicated but even more flexible "logarithmic"
repacking strategy could be implemented, see

	http://news.gmane.org/find-root.php?message_id=<20051112135947.GC30496@pasky.or.cz>

  Even with the dumb packing strategy though, I think it pays off if you
have at least a bit of CPU power to spare. The packing saving are
really immense. For example with the glibc repository, an incremental
CVS import worth of few days of changes _doubled_ the size of the
repository (from 100M to 200M), while repacking brought it back to the
original size (100M) + epsilon.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
