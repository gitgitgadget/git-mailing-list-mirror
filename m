From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Bad git status performance
Date: Fri, 21 Nov 2008 16:19:50 +0100
Message-ID: <4926D196.3000301@drmicha.warpmail.net>
References: <4926009E.4040203@gmx.ch> <c9e534200811201711y887ddd2t33013ec4a7db3c9a@mail.gmail.com> <4926ADB8.5000307@gmx.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Glenn Griffin <ggriffin.kernel@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jean-Luc Herren <jlh@gmx.ch>
X-From: git-owner@vger.kernel.org Fri Nov 21 16:21:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L3Xol-0005Ci-El
	for gcvg-git-2@gmane.org; Fri, 21 Nov 2008 16:21:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753867AbYKUPT4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Nov 2008 10:19:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753859AbYKUPT4
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Nov 2008 10:19:56 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:40268 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753487AbYKUPTz (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Nov 2008 10:19:55 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 817361C650B;
	Fri, 21 Nov 2008 10:19:54 -0500 (EST)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Fri, 21 Nov 2008 10:19:54 -0500
X-Sasl-enc: ubFgbopLziwhpjPNKy2eH2AcHhoFKc61T1IbIfWlzWVT 1227280794
Received: from [139.174.44.12] (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 9ADF85788;
	Fri, 21 Nov 2008 10:19:53 -0500 (EST)
User-Agent: Thunderbird 2.0.0.18 (X11/20081105)
In-Reply-To: <4926ADB8.5000307@gmx.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101533>

Jean-Luc Herren venit, vidit, dixit 21.11.2008 13:46:
> Glenn Griffin wrote:
>> On Thu, Nov 20, 2008 at 4:28 PM, Jean-Luc Herren <jlh@gmx.ch> wrote:
>>> The first 'git status' shows the same difference as the second,
>>> just the second time it's staged instead of unstaged.  Why does it
>>> take 16 seconds the second time when it's instant the first time?
>> I believe the two runs of git status need to do very different things.
>>  When run the first time, git knows the files in your working
>> directory are not in the index so it can easily say those files are
>> 'Changed but not updated' just from their existence.
> 
> I might be mistaken about how the index works, but those paths
> *are* in the index at that time.  They just have the old content,
> i.e. the same content as in HEAD.  When HEAD == index, then
> nothing is staged.
> 
> But the presence of those files alone doesn't tell you that they
> have changed.  You have to look at the content and compare it to
> the index (== HEAD in this situation) to see whether they have
> changed or not and for some reason git can do this very quickly.
> 
>> The second run
>> those files do exist in both the index and the working directory, so
>> git status first shows the files that are 'Changes to be committed'
>> and that should be fast, but additionally git status will check to see
>> if those files in your working directory have changed since you added
>> them to the index.
> 
> Which is basically the same comparision as above, just it turns
> out that they have not changed.  But even then, we're talking
> about comparing a 1 byte file in the index to a 1 byte file in the
> work tree.  That doesn't take 16 seconds, even for 100 files.
> 
> So this makes me believe it's the first step (comparing HEAD to
> the index to show staged changes) that is slow.  And when you
> compare a 1MB file to a 1 byte file, you don't need to read all of
> the big file, you can tell they're not the same right after the
> first byte.  (Even an doing stat() is enough, since the size is
> not the same.)
> 
> Another thing that came to my mind is maybe rename detection kicks
> in, even though no path vanished and none is new.  I believe
> rename detection doesn't happen for unstaged changes, which might
> explain the difference in speed.
> 
> btw, I forgot to mention that I get this with branches maint,
> master, next and pu.

Interestingly, all of

git diff --stat
git diff --stat --cached
git diff --stat HEAD

are "fast" (0.2s or so), i.e. diffing index-wtree, HEAD-index,
HEAD-wtree. Linus' threaded stat doesn't help either for status, btw (20s).

Experimenting further: Using 10 files with 10MB each (rather than 100
times 1MB) brings down the time by a factor 10 roughly - and so does
using 100 files with 100k each. Huh? Latter may be expected (10MB
total), but former (100MB total)?

Now it's getting funny: Changing your "echo >" to "echo ">>" (in your
100 files 1MB case) makes things "almost fast" again (1.3s).

OK, it's "use the source, Luke" time... Actually the part you don't see
takes the most time:
wt_status_print_updated()

And in fact I can confirm your suspicion: wt_status_print_updated()
enforces rename detection (ignoring any config). Forcing it off
(rev.diffopt.detect_rename = 0;) cuts down the 20s to 0.75s.

How about a config option status.renames (or something like -M) for status?

Michael
