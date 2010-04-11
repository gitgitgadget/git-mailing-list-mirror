From: Jeff King <peff@peff.net>
Subject: Re: [BUG] - git rebase -i performs rebase when it shouldn't?
Date: Sun, 11 Apr 2010 06:22:55 -0400
Message-ID: <20100411102255.GB20484@coredump.intra.peff.net>
References: <z2q76c5b8581004091235ucd9b2a52i223b3191b288c42a@mail.gmail.com>
 <20100410042609.GA24295@coredump.intra.peff.net>
 <h2x76c5b8581004101510hc1d15f42u7e48dafbc275c998@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 11 12:23:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0uKF-00088d-2i
	for gcvg-git-2@lo.gmane.org; Sun, 11 Apr 2010 12:23:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751509Ab0DKKXV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Apr 2010 06:23:21 -0400
Received: from peff.net ([208.65.91.99]:40553 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750770Ab0DKKXU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Apr 2010 06:23:20 -0400
Received: (qmail 2925 invoked by uid 107); 11 Apr 2010 10:23:22 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 11 Apr 2010 06:23:22 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 11 Apr 2010 06:22:55 -0400
Content-Disposition: inline
In-Reply-To: <h2x76c5b8581004101510hc1d15f42u7e48dafbc275c998@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144635>

On Sat, Apr 10, 2010 at 06:10:53PM -0400, Eugene Sajine wrote:

> Actually no, i was not thinking about what you think i was;). What i
> was trying to understand with this command (git rebase --onto master
> topic) is the behavior of the system when the topic branch is indirect
> descendant of the master and the direct parent of topic (next) is
> omitted, skipped.

But in "git rebase --onto master topic", the relationship between master
and topic is irrelevant. It is the same as:

  git rebase --onto master topic HEAD

which will consider the range between topic and HEAD as the set of
commits to rebase.

Did you want to do:

  git rebase --onto master next topic

? That would take the commits between next and topic (i.e., just "topic"
in your example), and rebuild them on top of master.

> Now the problem i have is that:
> 
> git rebase -i --onto master topic
> 
> actually worked and did something, what i would not expect it to do.
> 
> So, the problem is: non-interactive rebase DOES NOT execute the
> command, interactive DOES execute.

That's not the result I get. The non-interactive rebase _does_ do the
same thing. Try this:

  mkdir repo
  cd repo
  git init

  echo content >>file && git add file && git commit -m one
  git checkout -b next
  echo content >>file && git add file && git commit -m two
  git checkout -b topic
  echo content >>file && git add file && git commit -m three

  git rebase --onto master topic

You will see that "topic" has been reset back to commit one, the same as
master.

If that was not happening before, it was likely because you were not
actually on the "topic" branch before. So who knows what the implicit
"HEAD" argument referred to.

> The bug is in the fact that rebase works differently in interactive
> and non-interactive variants.

I don't think it does, as shown by my example above. If you still think
so, please create a short test case that demonstrates the difference.

-Peff
