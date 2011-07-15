From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Git commit generation numbers
Date: Fri, 15 Jul 2011 16:36:40 -0700
Message-ID: <CA+55aFwSgYYaQ8gTQmCw6SNMyr-bz5rJPr0o9xoog-1aCqb5rA@mail.gmail.com>
References: <20110714183710.GA26820@sigill.intra.peff.net> <CA+55aFwuK+krTA4OcnYhLXtKM5HQ1yuPK+J_vC-5R7AthrHWbg@mail.gmail.com>
 <20110714190844.GA26918@sigill.intra.peff.net> <CA+55aFx=ACnVBGU8_9wa=9xTbxVoOWKnsqfmBvzq7qzOeMGSNA@mail.gmail.com>
 <20110714200144.GE26918@sigill.intra.peff.net> <69e0ad24-32b7-4e14-9492-6d0c3d653adf@email.android.com>
 <20110714203141.GA28548@sigill.intra.peff.net> <CA+55aFyDzr+SfgSzWMr9pQuQUXTw9mcjZ-00NZof74PKZzbGPA@mail.gmail.com>
 <20110715074656.GA31301@sigill.intra.peff.net> <CA+55aFzS3KDNvKt-dXvYpuAQwFwD3+GCj8y8bRQCycPvrynT8Q@mail.gmail.com>
 <20110715194807.GA356@sigill.intra.peff.net> <CA+55aFx0KyAZRsy7gZ3Z4woWC-uWcLu11gcUrR+9MJR5NOSkrA@mail.gmail.com>
 <CA+55aFzE-okH9gaEyuSFdorK-7v3odpsk65ZTqCMHFz80n65ug@mail.gmail.com> <CA+55aFwpVoqK7TaG0R3JJO07eOyWQ9pR1sHUGBQt0kmM0vk2bw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jul 16 01:37:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QhrwV-0004SI-Cw
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jul 2011 01:37:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753899Ab1GOXhE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jul 2011 19:37:04 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:53263 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752051Ab1GOXhD (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Jul 2011 19:37:03 -0400
Received: from mail-ww0-f44.google.com (mail-ww0-f44.google.com [74.125.82.44])
	(authenticated bits=0)
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id p6FNb0pc004237
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=FAIL)
	for <git@vger.kernel.org>; Fri, 15 Jul 2011 16:37:02 -0700
Received: by wwe5 with SMTP id 5so1700424wwe.1
        for <git@vger.kernel.org>; Fri, 15 Jul 2011 16:37:00 -0700 (PDT)
Received: by 10.216.58.135 with SMTP id q7mr3510229wec.48.1310773020242; Fri,
 15 Jul 2011 16:37:00 -0700 (PDT)
Received: by 10.216.158.65 with HTTP; Fri, 15 Jul 2011 16:36:40 -0700 (PDT)
In-Reply-To: <CA+55aFwpVoqK7TaG0R3JJO07eOyWQ9pR1sHUGBQt0kmM0vk2bw@mail.gmail.com>
X-Spam-Status: No, hits=-102.886 required=5 tests=AWL,BAYES_00,USER_IN_WHITELIST
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177243>

And one last comment:

On Fri, Jul 15, 2011 at 4:16 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I have fewer branches than tags, but I get something similar for "git
> branch --contains":

The time-based heuristic does seem to be important. If I just remove
it, I get increasingly long times for things that aren't contained in
my branches.

And in fact, I think that is why the code used the merge-base helper
functions - not because it wanted merge bases, but because the merge
base stuff will work from either end until it decides things aren't
relevant any more. Because *without* the time-based heuristics, the
trivial "is this a descendant" algorithm ends up working very badly
for the case where the target doesn't exist in the branches. Examples
of NOT having a date-based cut-off, but just doing the straightforward
(non-merge-base) ancestry walk:

  time ~/git/git branch --contains v2.6.12
  real	0m0.113s

  [torvalds@i5 linux]$ time ~/git/git branch --contains v2.6.39
  real	0m3.691s

and what ends up happening is that in the latter case, every branch
walks all the way to the root and checks every commit (walking all the
merges too). While in the first case, it's very quick because it will
find that particular commit when it walk straight backwards (so it
doesn't even have to do a lot of recursion - the first branch that
hits that commit will be a success), so it won't have to look at all
the side ways of getting there.

Of course, the above particular difference happens to be due to the
"depth-first" implementation working well for the thing I am searching
for.  But it does show that the date-based cut-off matters due to
traversal issues like that.

                          Linus
