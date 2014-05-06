From: Jeff Sipek <jeffpc@josefsipek.net>
Subject: Re: [GUILT 06/28] Fix and simplify the do_get_patch function.
Date: Tue, 6 May 2014 15:08:30 -0400
Message-ID: <20140506190830.GJ1655@meili.valhalla.31bits.net>
References: <1395387126-13681-1-git-send-email-cederp@opera.com>
 <1395387126-13681-7-git-send-email-cederp@opera.com>
 <20140323170932.GH1661@meili.valhalla.31bits.net>
 <CAP=KgsQtJb3t1c7qK8reO6nzMJppoV-zooK16ZZcWmCirAr3ew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Per Cederqvist <cederp@opera.com>
X-From: git-owner@vger.kernel.org Tue May 06 22:09:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Whkj9-0006DA-UB
	for gcvg-git-2@plane.gmane.org; Tue, 06 May 2014 21:08:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751486AbaEFTI2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 May 2014 15:08:28 -0400
Received: from josefsipek.net ([64.9.206.49]:1547 "EHLO josefsipek.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751444AbaEFTI1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 May 2014 15:08:27 -0400
Received: from meili.valhalla.31bits.net (c-98-209-117-250.hsd1.mi.comcast.net [98.209.117.250])
	by josefsipek.net (Postfix) with ESMTPSA id 7769955654;
	Tue,  6 May 2014 15:08:26 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <CAP=KgsQtJb3t1c7qK8reO6nzMJppoV-zooK16ZZcWmCirAr3ew@mail.gmail.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248232>

On Sun, Mar 23, 2014 at 10:03:48PM +0100, Per Cederqvist wrote:
> On Sun, Mar 23, 2014 at 6:09 PM, Jeff Sipek <jeffpc@josefsipek.net> wrote:
> 
> > On Fri, Mar 21, 2014 at 08:31:44AM +0100, Per Cederqvist wrote:
> >> When extracting the patch, we only want the actual patches.  We don't
> >> want the "---" delimiter.  Simplify the extraction by simply deleting
> >> everything before the first "diff " line.  (Use sed instead of awk to
> >> simplify the code.)
> >>
> >> Without this patch, "guilt fold" and "guilt push" sometimes fails if
> >> guilt.diffstat is true.

Hrm, I just did a test and guilt-push seems to work with a patch such as:

aoeuaoeu
this is
---
not a patch!
---
 foo |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/foo b/foo
index e69de29..203a557 100644
--- a/foo
+++ b/foo
@@ -0,0 +1 @@
+aoue

What sort of thing breaks fold/push?

...
> >> diff --git a/guilt b/guilt
> >> index 8701481..c59cd0f 100755
> >> --- a/guilt
> >> +++ b/guilt
> >> @@ -332,12 +332,7 @@ do_make_header()
> >>  # usage: do_get_patch patchfile
> >>  do_get_patch()
> >>  {
> >> -     awk '
> >> -BEGIN{}
> >> -/^(diff |---$|--- )/ {patch = 1}
> >> -patch == 1 {print $0}
> >> -END{}
> >> -' < "$1"
> >> +     sed -n '/^diff /,$p' < "$1"
> >
> > So, the thought behind this mess was to allow minimal patches to work.  The
> > 'diff' line is *not* required by patch(1)!
> 
> I see. I can see that this is sometimes useful, even though I think
> it is more important that guilt actually works with the patches itself
> creates.

Fair enough.  I'm convinced that we should assume that all patches start
with 'diff '.

...
> I had to solve a similar problem when I wrote my utility for diffing two
> diff files (https://git.lysator.liu.se/pdiffdiff). Based on the experience
> I got doing that, I propose this new do_get_patch function:
...
> 
> The idea is to collect lines that *might* start the patch in
> patchheader. Once we detect the start of the patch (via a
> line that matches "--- " or any of the mode change lines)
> we print the patcheader and the current line. If we get a
> line that neither looks like a patchheader nor starts a patch,
> we discard the patcheader. This is the case of a commit
> message with a line that starts with "diff ".
> 
> The function above solves the issue with lines that
> start with "diff " in the commit message.  On the other
> hand, it introduces the same issue for lines that start
> with for instance "old mode ".

Hrm.  I'm open to revisiting the get-patch/get-header functions to address
the ambiguity issues in the future.

> Actually, a smaller change that probably fixes the
> issue with diffstat is to replace
> 
> /^(diff |---$|--- )/ {patch = 1}
> 
> witih
> 
> /^(diff |--- )/ {patch = 1}
> 
> as the problem with the original implementation is that
> the "---\n" line that starts the diffstat should not start
> the patch.

(Thinking out loud...) I suppose there are three portions to a patch file...

(1) the description
(2) optional diffstat
(3) the patch

You just convinced me that the patch should start with '^diff '.  Currently,
the diffstat begins with '^---$'.  Sadly, the description can contain what
looks like the beginning of a diffstat or a patch.  In the case of
do_get_patch, we're only interested in the patch, so we can just look for
'^diff ' (because garbage before the diff itself seems to be ignored by
git).  (If we wanted to allow patches without the 'diff ' line, we'd need
'^(diff |--- )'.)

I feel like I'm missing something.

Jeff.

-- 
I'm somewhere between geek and normal.
		- Linus Torvalds
