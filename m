From: Michal Sojka <sojkam1@fel.cvut.cz>
Subject: Re: [PATCH] filter-branch fix and tests
Date: Thu, 28 Jan 2010 00:41:23 +0100
Message-ID: <201001280041.23182.sojkam1@fel.cvut.cz>
References: <1264424786-26231-1-git-send-email-sojkam1@fel.cvut.cz> <201001271649.19287.sojkam1@fel.cvut.cz> <4B606748.2050209@viscovery.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jan 28 00:41:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NaHW1-0001pV-Vj
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jan 2010 00:41:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932164Ab0A0Xlg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2010 18:41:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754696Ab0A0Xlf
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jan 2010 18:41:35 -0500
Received: from max.feld.cvut.cz ([147.32.192.36]:55267 "EHLO max.feld.cvut.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754636Ab0A0Xle (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2010 18:41:34 -0500
Received: from localhost (unknown [192.168.200.4])
	by max.feld.cvut.cz (Postfix) with ESMTP id 7272819F33A4;
	Thu, 28 Jan 2010 00:41:33 +0100 (CET)
X-Virus-Scanned: IMAP AMAVIS
Received: from max.feld.cvut.cz ([192.168.200.1])
	by localhost (styx.feld.cvut.cz [192.168.200.4]) (amavisd-new, port 10044)
	with ESMTP id XTAiA8py4cJV; Thu, 28 Jan 2010 00:41:29 +0100 (CET)
Received: from imap.feld.cvut.cz (imap.feld.cvut.cz [147.32.192.34])
	by max.feld.cvut.cz (Postfix) with ESMTP id 5192419F33B4;
	Thu, 28 Jan 2010 00:41:29 +0100 (CET)
Received: from resox.localnet (unknown [213.29.198.144])
	(Authenticated sender: sojkam1)
	by imap.feld.cvut.cz (Postfix) with ESMTPSA id 3256815C052;
	Thu, 28 Jan 2010 00:41:24 +0100 (CET)
User-Agent: KMail/1.12.4 (Linux/2.6.31-1-686; KDE/4.3.4; i686; ; )
In-Reply-To: <4B606748.2050209@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138207>

On Wednesday 27 of January 2010 17:18:16 Johannes Sixt wrote:
> Michal Sojka schrieb:
> > +orig_head=`git show-ref --hash HEAD`
> > +export orig_head
> 
> You place the tree filter in double-quotes. Hence, orig_head will be
> interpolated on the filter-branch command line. You don't need to export
>  it.

You're right. Fixed.
 
> > +test_expect_success 'rewrite submodule with another content' '
> > +	git filter-branch --tree-filter "test -d submod && {
> > +					 rm -rf submod &&
> > +					 git rm -rf --quiet submod &&
> > +					 mkdir submod &&
> > +					 : > submod/file
> > +					 } || : &&
> > +					 test $orig_head != `git show-ref --hash HEAD`"
> 
> What is the purpose of the check in the last line?

It should check that something was rewritten, but it was incorrectly put into 
the filed. Fixed.
 
> As long as you have another command after the "} || : &&", you can just
> write "}" instead.

OK.

> > +test_expect_failure 'checkout submodule during rewrite' '
> > +	git reset --hard original &&
> > +	git filter-branch -f --tree-filter \
> > +	    "git submodule update --init &&
> > +	     cd submod &&
> > +	     git reset --hard origin/master" HEAD
> 
> You must not change the directory without changing back. Use a sub-shell.
> 
> I'm not sure whether it's worth catering for this use-case anyway.
> Replacing a submodule commit should really be done only in the
> --index-filter. The tree that --tree-filter checks out is intended only as
> a temporary scratch area. It is not intended as a full worktree. In
> particular, since 'submodule update --init' changes the configuration, it
> is extremly dangerous to call from a filter.

I fully agree. I don't plan to put this test in the final version of the 
patch. I wrote this test because I didn't exactly know which issue has Dscho 
in mind. If it was this one, I wanted to show that this is not relevant.

I'm sending corrected version of the patch with tests.

Thanks
Michal
