From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: allow disabling expensive broken symlink
	checks
Date: Mon, 2 Feb 2009 20:45:49 -0800
Message-ID: <20090203044549.GA2483@dcvr.yhbt.net>
References: <200901311414.58205.markus.heidelberg@web.de> <20090201021844.GB18855@dcvr.yhbt.net> <7vbptlo7zg.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Markus Heidelberg <markus.heidelberg@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 03 05:47:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUDBt-00088M-0d
	for gcvg-git-2@gmane.org; Tue, 03 Feb 2009 05:47:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751641AbZBCEpv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Feb 2009 23:45:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751500AbZBCEpv
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Feb 2009 23:45:51 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:37802 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751384AbZBCEpu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Feb 2009 23:45:50 -0500
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id E25AD1F5F3;
	Tue,  3 Feb 2009 04:45:49 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7vbptlo7zg.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108144>

Junio C Hamano <gitster@pobox.com> wrote:
> Eric Wong <normalperson@yhbt.net> writes:
> 
> > Since dbc6c74d0858d77e61e092a48d467e725211f8e9, git-svn has had
> > an expensive check for broken symlinks that exist in some
> > repositories.  This leads to a heavy performance hit on
> > repositories with many empty blobs that are not supposed to be
> > symlinks.
> >
> > The workaround is enabled by default; and may be disabled via:
> >
> >   git config svn.brokenSymlinkWorkaround false
> >
> > Reported by Markus Heidelberg.
> >
> > Signed-off-by: Eric Wong <normalperson@yhbt.net>
> 
> How common is this breakage in people's subversion repositories that
> dbc6c74d (git-svn: handle empty files marked as symlinks in SVN,
> 2009-01-11) works around?

It's not common at all.  Some broken Windows clients were able to
create it.

> What's the way to recover from a broken import, when the subversion
> repository does have such a breakage, and the user used git-svn that
> predates dbc6c74?  Is it very involved, and it is much better to have the
> safety by default than to force everybody else who interacts with
> non-broken subversion repository suffer from this performance penalty?

Previously, git-svn would just stop importing and refuse to continue.
So allowing the user to enable it would be a problem; too.  I don't
recall the error being easy to distinguish from other errors.

> Because the fix (that is broken from the performance angle) is relatively
> recent, I am wondering if it makes more sense to turn it off by default,
> and allow people with such a broken history to optionally turn it on.

I'm considering disabling it by default, too.  It only gets triggered if
there are any empty blobs at all in the repository (which are fairly
rare, but not as rare as broken symlinks in SVN).  So for a "normal"
repository it would just be the (low) overhead of calling ls-files for
every revision we fetch (and the hash-object </dev/null, which could
even be hard-coded).

Perhaps just having a "try enabling this ..." type option on any
fetch failure would be better...

-- 
Eric Wong
