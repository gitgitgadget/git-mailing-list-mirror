From: Jeff King <peff@peff.net>
Subject: Re: Gnome chose Git
Date: Fri, 20 Mar 2009 01:28:02 -0400
Message-ID: <20090320052802.GA27714@coredump.intra.peff.net>
References: <877i2lbvt7.fsf@iki.fi> <49C249B9.7010001@drmicha.warpmail.net> <1cd1989b0903190643p19a40718yc4fd2730aab0a9a0@mail.gmail.com> <49C24D9B.1060301@drmicha.warpmail.net> <1cd1989b0903190701uac4602dl1d2c3cace45a9938@mail.gmail.com> <20090319151610.GO23521@spearce.org> <1cd1989b0903190850p1a08991y754904e7799c7879@mail.gmail.com> <20090319201405.GD17028@coredump.intra.peff.net> <9b18b3110903191440w20ca9801pfb218cc4b10ea769@mail.gmail.com> <20090319214317.GU23521@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: demerphq <demerphq@gmail.com>, Git <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Mar 20 06:29:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkXIe-0002Rj-Fz
	for gcvg-git-2@gmane.org; Fri, 20 Mar 2009 06:29:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754995AbZCTF2O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2009 01:28:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754024AbZCTF2N
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Mar 2009 01:28:13 -0400
Received: from peff.net ([208.65.91.99]:35344 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753439AbZCTF2M (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2009 01:28:12 -0400
Received: (qmail 6723 invoked by uid 107); 20 Mar 2009 05:28:20 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 20 Mar 2009 01:28:20 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 20 Mar 2009 01:28:02 -0400
Content-Disposition: inline
In-Reply-To: <20090319214317.GU23521@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113896>

On Thu, Mar 19, 2009 at 02:43:17PM -0700, Shawn O. Pearce wrote:

> demerphq <demerphq@gmail.com> wrote:
> > Outside of parsing the reflog directly, (which feels wrong and dirty
> > to me), how does one find out the times that a reflog entry was
> > created?
> > 
> > The closest thing i could find was git log -g, but that shows the time
> 
>   git reflog -g branch@{now}
> 
> the @{now} suffix is the magic to make it show the time.

Yuck. It would be nice to just have a "Reflog date" header that you
could depend on, like:

diff --git a/reflog-walk.c b/reflog-walk.c
index f751fdc..cb7c66b 100644
--- a/reflog-walk.c
+++ b/reflog-walk.c
@@ -269,6 +269,8 @@ void show_reflog_message(struct reflog_walk_info* info, int oneline,
 				       - 2 - commit_reflog->recno);
 			printf("} (%s)\nReflog message: %s",
 			       info->email, info->message);
+			printf("Reflog date: %s\n",
+				show_date(info->timestamp, info->tz, relative_date));
 		}
 	}
 }

Then you could just do:

  $ git log --date=raw -g

Looking at making this trivial patch, though, it seems there is a bug
with the relative_date parameter. It is really a date_mode enum. In the
multi-line format, we feed it to show_date. But in the oneline mode, we
use it to decide whether to show the date, but then always pass the
"relative" date mode. So you get:

  $ git log --oneline -g origin/master | head -n 1
  e986ceb refs/remotes/origin/master@{0}: fetch origin: fast forward
  $ git log --oneline -g --date=relative origin/master | head -n 1
  e986ceb refs/remotes/origin/master@{2 days ago}: fetch origin: fast forward
  $ git log --oneline -g --date=raw origin/master | head -n 1
  e986ceb refs/remotes/origin/master@{2 days ago}: fetch origin: fast forward

Hmm. It seems to drop the TZ, too. I'll whip up a patch.

I guess my original "extra reflog header" isn't terribly useful, then:
you can always just pass --date=raw and parse it from the branch@{}
syntax.

-Peff
