From: Jeff King <peff@peff.net>
Subject: Re: git-status segmentation fault in master / OS X
Date: Tue, 19 Jan 2010 19:41:46 -0500
Message-ID: <20100120004146.GB16824@coredump.intra.peff.net>
References: <57518fd11001190959n355a0f22p7caa7251b705efaf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Jonathan del Strother <maillist@steelskies.com>
X-From: git-owner@vger.kernel.org Wed Jan 20 01:41:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXOdu-0007EC-MW
	for gcvg-git-2@lo.gmane.org; Wed, 20 Jan 2010 01:41:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754824Ab0ATAlt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2010 19:41:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754736Ab0ATAlt
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jan 2010 19:41:49 -0500
Received: from peff.net ([208.65.91.99]:56440 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754343Ab0ATAls (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2010 19:41:48 -0500
Received: (qmail 28262 invoked by uid 107); 20 Jan 2010 00:46:41 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 19 Jan 2010 19:46:41 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 19 Jan 2010 19:41:46 -0500
Content-Disposition: inline
In-Reply-To: <57518fd11001190959n355a0f22p7caa7251b705efaf@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137509>

On Tue, Jan 19, 2010 at 05:59:51PM +0000, Jonathan del Strother wrote:

> I've been running into a segmentation fault on running git status in
> my repository while there are staged changes.

I can't reproduce it here. Is there anything else interesting about the
repo you can tell us besides that it has staged changes?

> Bisecting suggests it was introduced in:
> 
> commit 73d66323ac78c750ba42fef23b1cb8fd2110e023
> Merge: 054d2fa 8740773
> Author: Junio C Hamano <gitster@pobox.com>
> Date:   Wed Jan 13 11:58:34 2010 -0800
> 
>     Merge branch 'nd/sparse'
> 
> 
> The last commit from nd/sparse (8740773) is fine, so I guess it's a
> bad merge...?

Could be a bad interaction between commits on nd/sparse and whatever was
done since it had branched. You can try rebasing nd/sparse and bisecting
a linearised version, like this:

  bad_merge=73d66323
  # pretend we are on nd/sparse
  git checkout -b test $bad_merge^2
  # rebase onto what we merged onto
  git rebase $bad_merge^1
  # now bisect. what we have now is presumably
  # bad (though you should probably double check)
  # and from the previous bisect we know that
  # everything pre-merge is good
  git bisect start
  git bisect good $bad_merge^1
  git bisect bad

-Peff
