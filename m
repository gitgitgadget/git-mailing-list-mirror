From: Jeff King <peff@peff.net>
Subject: Re: git rev-list %an, %ae, %at bug in v1.7.10.1 and beyond
Date: Tue, 22 May 2012 01:58:11 -0400
Message-ID: <20120522055811.GA10597@sigill.intra.peff.net>
References: <CAGyf7-G3nNTTP1bKdd9HLKEn-8+LoxCeY2R08x9gKZwS0L_N6g@mail.gmail.com>
 <20120522043221.GA6859@sigill.intra.peff.net>
 <20120522043509.GB6859@sigill.intra.peff.net>
 <CAGyf7-Gj8YynENrnkZMT4WSEDtYpmUL5qaS4TEuvfaa_YcXxOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Bryan Turner <bturner@atlassian.com>
X-From: git-owner@vger.kernel.org Tue May 22 07:58:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWi6v-0000yO-O9
	for gcvg-git-2@plane.gmane.org; Tue, 22 May 2012 07:58:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754659Ab2EVF6Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 May 2012 01:58:16 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:51495
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754249Ab2EVF6P (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 May 2012 01:58:15 -0400
Received: (qmail 13094 invoked by uid 107); 22 May 2012 05:58:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 22 May 2012 01:58:40 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 22 May 2012 01:58:11 -0400
Content-Disposition: inline
In-Reply-To: <CAGyf7-Gj8YynENrnkZMT4WSEDtYpmUL5qaS4TEuvfaa_YcXxOw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198179>

On Tue, May 22, 2012 at 03:13:09PM +1000, Bryan Turner wrote:

> I went and spoke to the tester who made the original commit, and it
> sounds like what he did was open .git/config with a text editor and
> update the user.name directly. He then saved the file. His operating
> system's code page was UTF-16LE, so I believe the file was saved in
> that format. He then did the commit.

That doesn't make sense. Git will not read a config file in utf16
(again, because of the NULs). Nor can you store NULs with "git config
user.name ...". So I'm not sure how utf16 might have made it there.

> That sort of behavior is pretty far outside the scope of anything git
> can realistically be expected to handle (and I told the tester that as
> well). That said, I'm interested that it "suddenly" broke, and also
> that cat-file still appears to not think there's any problem.

Yeah, I'm worried that it's indicative of a bug that might affect other
cases.

> I piped the output through xxd, for cat-file and rev-list. The
> cat-file output is the same in both versions of git, and looks like
> this:
> auri:qa-resources.git bturner$ git cat-file -p
> 5c1ccdec5f84aa149a4978f729fdda70769f942f | xxd
> 0000000: 7472 6565 2064 6431 3733 6362 3730 6261  tree dd173cb70ba
> 0000010: 6161 6330 3762 6466 3430 3566 3465 3364  aac07bdf405f4e3d
> 0000020: 6231 3130 6537 6661 6664 3138 300a 7061  b110e7fafd180.pa
> 0000030: 7265 6e74 2030 3263 3738 6263 3339 6163  rent 02c78bc39ac
> 0000040: 3631 3932 3632 3362 6630 3830 6533 6532  6192623bf080e3e2
> 0000050: 6163 3839 3261 3466 3537 3634 630a 6175  ac892a4f5764c.au
> 0000060: 7468 6f72 2061 203c 6661 726d 6173 4061  thor a <farmas@a
> 0000070: 746c 6173 7369 616e 2e63 6f6d 3e20 3133  tlassian.com> 13
> 0000080: 3237 3837 3632 3232 202b 3131 3030 0a63  27876222 +1100.c
> 0000090: 6f6d 6d69 7474 6572 2061 203c 6661 726d  ommitter a <farm
> 00000a0: 6173 4061 746c 6173 7369 616e 2e63 6f6d  as@atlassian.com
> 00000b0: 3e20 3133 3237 3837 3632 3232 202b 3131  > 1327876222 +11
> 00000c0: 3030 0a0a 636f 6d6d 6974 2077 6974 6820  00..commit with
> 00000d0: 756e 6963 6f64 6520 6e61 6d65 0a         unicode name.

But I don't see any unicode at all here. The author and committer names
are just ascii 'a'. However, that seems to be the real problem. If I
create a commit with a single-letter name, I see some weirdness:

  $ git init
  $ echo content >foo && git add foo
  $ GIT_AUTHOR_NAME=a git commit -m msg
   Author:  <>
   1 file changed, 1 insertion(+)
   create mode 100644 foo

Uh oh, that's odd. And worse:

  $ git log -1 --format='|%an <%ae>|'
  | <>|

But in v1.7.10:

  $ git log -1 --format='|%an <%ae>|'
  |a <peff@peff.net>|

So there is definitely a bug. The unicode thing is a red herring, and if
there was any unicode at some point, git stripped it out when making the
commit. The real regression seems to be in single-character names.

I'll see if I can find the bug.

-Peff
