From: Chris Angelico <rosuav@gmail.com>
Subject: Re: Configuring a third-party git hook
Date: Fri, 21 Mar 2014 04:10:35 +1100
Message-ID: <CAPTjJmoDZRmFVnNmn_865Tcv6=GJucuKEo_Y-ezQ4s5vsHmguA@mail.gmail.com>
References: <CAPTjJmomAnrjjyfSvDJijBP2pUN_kqVCRr+UbZkQHQy295A85A@mail.gmail.com>
	<xmqqwqfozu9t.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 20 18:10:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQgUN-0001Et-VH
	for gcvg-git-2@plane.gmane.org; Thu, 20 Mar 2014 18:10:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758065AbaCTRKh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2014 13:10:37 -0400
Received: from mail-pb0-f44.google.com ([209.85.160.44]:35506 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756651AbaCTRKf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2014 13:10:35 -0400
Received: by mail-pb0-f44.google.com with SMTP id rp16so1223500pbb.31
        for <git@vger.kernel.org>; Thu, 20 Mar 2014 10:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=j+DCcJQt58lxoD6cQ0Y7vLvSuaqsU/OxU0OzZg4P2Lg=;
        b=KSjoOhnRcLU7fQ3f9+on1+M2zi8r7lw5RoX1b3uCtgE8CNqrmYH/gb8nbsTFiw9Lg8
         FSHqv8ocw2sglK4og++Wu3EeQGFcc+pcL7rSsV3B9XW5c7+gYxPk5CEHxlFZK8UnDOF9
         4+boeLIbBY/vKVryHwfYIlB/tXMxxtI9A3rUi2E2gEmpe61wQMHFpFPdUPvoAIqhZY+9
         W+4ehC0p2vn23H5WbmEa/DRlzLvxjrDd/7mBI4ZsyI9IBQCIyed03d8Ap5/PlQyUmleb
         tNyjSwZuqm+fkhvWJPBQpXk9+OkUQuUnosIoweHihqrJb5zTA34HrcLmWlpIlZ+Irpa6
         Y79Q==
X-Received: by 10.66.164.229 with SMTP id yt5mr49132157pab.67.1395335435168;
 Thu, 20 Mar 2014 10:10:35 -0700 (PDT)
Received: by 10.68.33.7 with HTTP; Thu, 20 Mar 2014 10:10:35 -0700 (PDT)
In-Reply-To: <xmqqwqfozu9t.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244560>

On Fri, Mar 21, 2014 at 3:53 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Chris Angelico <rosuav@gmail.com> writes:
>
>> file. It doesn't really care about the full history, and wants to be
>> reasonably fast (as the user is waiting for it). It's just a
>> convenience, so correctness isn't a huge issue. The easiest way to
>> keep it moving through quickly is to limit the search:
>>
>> $ git log ...other options... HEAD~100 some-file.pike
>>
>> The problem with this is that it doesn't work if HEAD doesn't have 100
>> great-great-...-grandparents
>
> Did you really mean that you are *not* interested in what happened
> to the most recent 100 commits?  Or is it a typo of "HEAD~100.."?

Oops, yes, HEAD~100.. is what I actually use in the source code. Same
difference; it doesn't work if there aren't that many commits.

> "git log -100" should traverse from the HEAD and stop after showing
> at most 100 items, even if you only had 20 in the history.

Yes, and I use that to limit the results (to 10, actually); but
there's one degenerate case left, and that's a new or moved/renamed
file in a long-standing repository. Let's say the repo has 760 commits
(which is currently the case for Gypsum; I'd say this is fairly small
as repos go), and a file was moved a little while ago and then not
edited much.

$ git log plugins-more/threshtime.pike

Four results, the oldest being "Move three plugins into -more" which
moved the file without any edits at all. If I edit that file now, the
prepare-commit-msg hook will execute the following (or would, if I
hadn't set the config option):

$ git log --shortstat --full-diff -10 --oneline plugins-more/threshtime.pike
fca89fe Threshtime: Drop a comment from the old C++ plugin
 1 file changed, 1 insertion(+), 1 deletion(-)
df8bcf0 Threshtime: Make use of statusevent
 1 file changed, 2 insertions(+), 11 deletions(-)
1207213 Threshtime: Use the tooltip to hint at the converter
 1 file changed, 1 insertion(+)
c22dfbc Move three plugins into -more so they're loaded by default but
unloadable
 6 files changed, 426 insertions(+), 426 deletions(-)

Since it says "-10" and hasn't found ten results yet, git log will
keep on searching back in history. I don't know of a way to say "give
up searching once you find the commit that creates this file",
although that would also do what I want. The end result is the same,
but it's very slow if the git log isn't in the OS/disk cache. On my
main development box, it is cached, but I just tried it on my Windows
box and it took about fifteen seconds to finish; and 760 commits is
not huge as repositories go - the Pike repo has over 30,000 commits,
and git's own repo is of similar size.

Bounding the search is potentially a huge improvement here, since the
user's waiting. But the exact limit depends on the repo itself, and
it'd be nice to be able to disable it ("huh, didn't find any
results... I'll de-limit the search and try again"). Hence the config
option, which I'm very happy to hear *is* a viable technique.

ChrisA
