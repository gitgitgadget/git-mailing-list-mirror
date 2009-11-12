From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] gitk: Add ability to define an alternate temporary
 directory
Date: Thu, 12 Nov 2009 04:56:20 -0500
Message-ID: <20091112095620.GA7847@coredump.intra.peff.net>
References: <1257904149-44381-1-git-send-email-davvid@gmail.com>
 <4AFA368F.207@vilain.net>
 <20091111040715.GA44672@gmail.com>
 <7vr5s5y8n8.fsf@alter.siamese.dyndns.org>
 <20091111164451.GA45475@gmail.com>
 <20091112083559.GB17552@coredump.intra.peff.net>
 <20091112093611.GA47285@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Sam Vilain <sam@vilain.net>,
	paulus@samba.org, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 12 10:58:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8WPz-0002bu-B4
	for gcvg-git-2@lo.gmane.org; Thu, 12 Nov 2009 10:56:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750957AbZKLJ4a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Nov 2009 04:56:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751312AbZKLJ4a
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Nov 2009 04:56:30 -0500
Received: from peff.net ([208.65.91.99]:59036 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750902AbZKLJ43 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Nov 2009 04:56:29 -0500
Received: (qmail 20742 invoked by uid 107); 12 Nov 2009 10:00:21 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 12 Nov 2009 05:00:21 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 12 Nov 2009 04:56:20 -0500
Content-Disposition: inline
In-Reply-To: <20091112093611.GA47285@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132758>

On Thu, Nov 12, 2009 at 01:36:13AM -0800, David Aguilar wrote:

> When I have more time I can switch gitk over to git-difftool
> which I know is /tmp safe.  I only dabble in tcl but the
> docs say that mkdir does not error out when given
> directories that already exist.  It does error out when
> given a file.

OK, then I think we would be vulnerable, as I can make a .gitk-tmp.$PID
directory owned by me that your gitk will happily use.

> The /tmp trick would require them knowing the SHA-1 that
> we're diffing and symlinking the names to paths they want
> us to destroy.  It seems paranoid to worry about it ;)

But the SHA-1 is not hard to guess[1], as you have a finite,
easily-enumerable list of them in your repository. :) One thing that
does make it harder is that gitk actually checks to see if a file is
already there before creating it (presumably not for security, but for
efficiency). Which means I can't just pre-seed a trap and wait for you
to run gitk; I have to actually race you and create the file between
your "file exists" check and the eventual "git show $filename >$output"
which will hose it.

Probably I can win that race given a sufficient number of attempts, but
attempts are made at a human pace. So in practice it's probably pretty
hard to exploit. Still, I'd rather see it done properly on principle.
Then we _know_ we're not missing some trick, and there's no chance of a
later code change increasing an attacker's probability of success.

-Peff

[1] I was also going to suggest a social-engineering attack, like "hey,
I screwed up my repository. Can you take a look?" Then you don't need to
guess the SHA-1, as you convince the victim to look at a specific one.
But that attack is already much, much worse: we respect items in
.git/config regardless of whether it is owned by the running user. So it
is not actually safe to "cd ~other_user/project && git diff".
