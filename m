From: D Herring <dherring@tentpost.com>
Subject: idea: git "came from" tags
Date: Sun, 17 Jan 2010 23:22:02 -0500
Message-ID: <hj0nl9$uds$2@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 18 05:35:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWjKe-0002o8-BC
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jan 2010 05:35:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755673Ab0AREfK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jan 2010 23:35:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755660Ab0AREfJ
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jan 2010 23:35:09 -0500
Received: from lo.gmane.org ([80.91.229.12]:40827 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752207Ab0AREfI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jan 2010 23:35:08 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1NWjKT-0002kO-Iq
	for git@vger.kernel.org; Mon, 18 Jan 2010 05:35:05 +0100
Received: from c-71-232-15-233.hsd1.ma.comcast.net ([71.232.15.233])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 18 Jan 2010 05:35:05 +0100
Received: from dherring by c-71-232-15-233.hsd1.ma.comcast.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 18 Jan 2010 05:35:05 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: c-71-232-15-233.hsd1.ma.comcast.net
User-Agent: Thunderbird 2.0.0.21 (X11/20090329)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137368>

Actors:
- public "upstream" repository
- public "local" repository
- end users tracking both

Situation:
- local starts by tracking upstream
- local makes changes, commits, and sends upstream
- users now tracking local ahead of upstream
- upstream makes modified commits
- local satisfied, wants to reset master to upstream/master

Problem:
- A merge will perpetually leave two parallel branches.  Even though
there are no longer any diffs, local/master cannot use the same
objects as upstream/master.
- A hard reset lets local/master return to sharing objects with
upstream/master; but this may break pulls or cause other problems for
users.

Proposed solution:
- Local adds a "came from" tag to upstream/master, leaves a tag on the
head of local/master, and does a hard reset from local/master to
upstream/master.  When a user tracking local/master does a pull, their
client detects a non-fast-forward, finds the came-from tag, and treats
it as a fast-forward.

Basically, this is a protocol to glue a "strategy ours" merge onto an
existing tree.  This way local can cleanly track upstream, with no
added complexity in the nominal (no local changes) case.


Example:
Without this addition, local/master looks something like
u1 - u2 - u3 - u4 - u5 - u6 ...
   \- l1 - l2\+ m1 -   \+ m2\+ m3 ...

With this addition, local/master looks like
u1 - u2 - u3(tcf) - u4 - u5 - u6 ...
   \- l1 - l2 - t0
where
* u# = upstream changes
* l# = local changes
* m# = local merges (m1=u3, m2=u5, m3=u6, ...)
* the tcf tag points to t0, and t0 tags the end of the local mods


Pseudo-shell-code addition to git-pull:
fetch local/master
fast_forward=usual test whether local/master contains user/master
if test $fast_forward = no
then
   for tag in $fetched_tags # something like this or git-describe
   do
     if is_came_from($tag) && (came_from($tag) contains user/master)
     then
       fast_forward=yes
       break
     fi
   done
fi

Comments?  I think this is completely implementable (though I'm not
well-versed in git internals).  Since it only triggers during
non-fast-forward operations, it should have negligible performance impact.

Of course, it would be even better if somebody shows me how to do this
with the current tools.  Maybe I'm just doing it all wrong.

Thanks,
Daniel
