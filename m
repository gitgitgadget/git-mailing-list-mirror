From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: wishlist: git gui not listing untracked files in unstaged list
Date: Wed, 10 Mar 2010 12:07:28 -0800
Message-ID: <20100310200728.GD21994@spearce.org>
References: <loom.20100310T203316-38@post.gmane.org> <7vaaugrlqs.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: MALAISE Pascal <malaise@magic.fr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 10 21:07:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NpSC6-0004XV-0N
	for gcvg-git-2@lo.gmane.org; Wed, 10 Mar 2010 21:07:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756962Ab0CJUHf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Mar 2010 15:07:35 -0500
Received: from mail-yx0-f200.google.com ([209.85.210.200]:49254 "EHLO
	mail-yx0-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755714Ab0CJUHf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Mar 2010 15:07:35 -0500
Received: by yxe38 with SMTP id 38so1823413yxe.22
        for <git@vger.kernel.org>; Wed, 10 Mar 2010 12:07:34 -0800 (PST)
Received: by 10.90.10.38 with SMTP id 38mr2164648agj.74.1268251652300;
        Wed, 10 Mar 2010 12:07:32 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 23sm7021046iwn.2.2010.03.10.12.07.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 10 Mar 2010 12:07:30 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vaaugrlqs.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141917>

Junio C Hamano <gitster@pobox.com> wrote:
> MALAISE Pascal <malaise@magic.fr> writes:
> 
> > Many projects are organized so that the result of compilation is mixed with
> > sources.
> > It would be very useful to configure git gui so that untracked files are not
> > listed in the un-staged list.
> > I have patched git gui, function rescan_stage2, line 1414 to do so:
> >   # set fd_lo [eval git_read ls-files --others -z $ls_others]
> >   set fd_lo [eval git_read ls-files -z $ls_others]
> 
> Shouldn't this line instead be running this:
> 
>     ls-files --others --exclude-standard -z $ls_others
> 
> so that it would use the usual .gitignore mechanism?

Uh.  It does use the normal ignore systems.  Above on
line 1400 we add into the argument list for $ls_others
--exclude-per-directory=.gitignore,
--exclude-from=[gitdir info exclude], and
--exclude-from=[get_config core.excludesfile].

But this code all predates --exclude-standard.  Today we could just
use --exclude-standard and bypass all of that.

I have no idea why the original poster isn't getting his ignore
list(s) to work.  I also have no idea why dropping the --others
flag from the ls-files command gets him a useful result.

Maybe the problem is, the build artifacts are in a single
subdirectory (e.g. "out/"), and git status shows only "out/"
as untracked.  But git-gui shows all of the files (potentially
thousands) because ls-files --others exploded the directory
contents recursively?

By dropping --others we hide that directory's contents by listing
only files that are already tracked.  I'm surprised that didn't
confuse git-gui further, since a file was claimed to be both tracked
and untracked at the same time during the rescan.

-- 
Shawn.
