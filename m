From: Jeff King <peff@peff.net>
Subject: Re: Super long branch names corrupt `.git/config`
Date: Thu, 4 Oct 2012 14:29:46 -0400
Message-ID: <20121004182946.GC2623@sigill.intra.peff.net>
References: <CAAmo=1BU5N8nbonEb1aZEx=-e8VexwsE74pjm_56dXmCDK+K6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ben Walton <bdwalton@gmail.com>, git@vger.kernel.org
To: Ben Olive <sionide21@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 05 00:56:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJtfn-00033L-Ml
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 00:13:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751943Ab2JDS3t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2012 14:29:49 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:40871 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750828Ab2JDS3s (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2012 14:29:48 -0400
Received: (qmail 22893 invoked by uid 107); 4 Oct 2012 18:30:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 04 Oct 2012 14:30:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 04 Oct 2012 14:29:46 -0400
Content-Disposition: inline
In-Reply-To: <CAAmo=1BU5N8nbonEb1aZEx=-e8VexwsE74pjm_56dXmCDK+K6g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207037>

On Thu, Oct 04, 2012 at 01:15:25PM -0400, Ben Olive wrote:

> My `.git/config` can be corrupted if I try to get a local branch with
> an extremely long name to track a remote branch.
> 
> Here is a (contrived) example to reproduce the issue:
> 
> 
>     $ cd /tmp
>     $ mkdir buggyrepo otherrepo
>     $ cd buggyrepo/ && git init && cd -
>     $ cd otherrepo/ && git init && cd -
>     $ cd buggyrepo/
>     $ echo foo > MYFILE
>     $ git add MYFILE && git commit -m "Initial"
>     $ git remote add otherrepo ../otherrepo/
>     $ git checkout -b `ruby -e "puts 'a'*200"`
>     $ git push -u otherrepo `ruby -e "puts 'a'*200"`
>     fatal: bad config file line 11 in .git/config
>     $ git status
>     fatal: bad config file line 11 in .git/config
> 
> Workaround available: Just delete the offending entry.
> 
> I tested this with 1.7.12.2

This is fixed by Ben Walton's 0971e99 (Remove the hard coded length
limit on variable names in config files, 2012-09-30). Not sure yet
whether it will make it into v1.8.0 or not.

However, note that the tracking config is only one limit to branch name
length. On many filesystems, you are limited to 256 bytes (or some other
number) per path component, and writing to "refs/heads/aaa{256}.lock"
will fail.

-Peff
