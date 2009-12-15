From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: the 100 mb push
Date: Tue, 15 Dec 2009 11:42:12 -0800
Message-ID: <20091215194212.GC18319@spearce.org>
References: <20091215192338.GA16654@gnu.kitenet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Joey Hess <joey@kitenet.net>
X-From: git-owner@vger.kernel.org Tue Dec 15 20:42:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NKdHq-0003rN-LJ
	for gcvg-git-2@lo.gmane.org; Tue, 15 Dec 2009 20:42:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752345AbZLOTmR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Dec 2009 14:42:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751644AbZLOTmR
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Dec 2009 14:42:17 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:58445 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750850AbZLOTmQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Dec 2009 14:42:16 -0500
Received: by yxe17 with SMTP id 17so222413yxe.33
        for <git@vger.kernel.org>; Tue, 15 Dec 2009 11:42:15 -0800 (PST)
Received: by 10.150.174.10 with SMTP id w10mr115395ybe.259.1260906135104;
        Tue, 15 Dec 2009 11:42:15 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 7sm66166yxg.14.2009.12.15.11.42.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 15 Dec 2009 11:42:14 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20091215192338.GA16654@gnu.kitenet.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135295>

Joey Hess <joey@kitenet.net> wrote:
> Is it normal for git push to sometimes transfer much more data
> than seems necessary? Here is a case where that happens:

Yes.
 
> Meanwhile, the testsuite branch is a 100+ mb monster, containing a lot
> of big binaries. In it, a small change has been made in the origin
> repo. In the local repo, a *lot* of *big* files have been deleted from
> the same branch, about 20 mb of files were removed all told. But the diff
> for this change should be quite small.
> 
> So, testsuite needs to be merged before it can be pushed, but git push
> doesn't tell me that. Instead, it goes off and does this for 2+ hours:

The problem here is, unlike fetch, push does not do a common
ancestor negotiation.  The sending side (your push client)
just assumes the remote side has *only* what the remote side
advertised.

Since the remote side advertised a commit on the testsuite branch
that your client doesn't have, your client was forced to assume
there was no common ancestor and sent the entire thing.

This usually doesn't show up that badly because the delta tends to
be smaller (no huge binary files), tends to be a strict fast forward
(so your client contains what the remote advertised), and tags may
help to limit the upload size by being at fixed points in the history
(so at worst you upload since the last tag).

Junio wrote a patch series for git push over a year ago to make
it do common ancestor negotiation like git fetch does, but it had
a deadlock problem and the patch series got dropped.  Not enough
people were interested to help Junio carry it through to being
ready for inclusion.
 
-- 
Shawn.
