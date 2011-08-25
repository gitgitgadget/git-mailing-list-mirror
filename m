From: Marat Radchenko <marat@slonopotamus.org>
Subject: One MMORPG git facts
Date: Thu, 25 Aug 2011 06:53:57 +0000 (UTC)
Message-ID: <loom.20110825T081519-218@post.gmane.org>
References: <416D1A48-9916-4E44-A200-3A13C39C4D70@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 25 08:54:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QwTpS-0007Bq-C9
	for gcvg-git-2@lo.gmane.org; Thu, 25 Aug 2011 08:54:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753001Ab1HYGyN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Aug 2011 02:54:13 -0400
Received: from lo.gmane.org ([80.91.229.12]:54159 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752605Ab1HYGyM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Aug 2011 02:54:12 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1QwTpL-0007AB-9w
	for git@vger.kernel.org; Thu, 25 Aug 2011 08:54:11 +0200
Received: from gprs-client-83.149.9.196.misp.ru ([gprs-client-83.149.9.196.misp.ru])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 25 Aug 2011 08:54:11 +0200
Received: from marat by gprs-client-83.149.9.196.misp.ru with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 25 Aug 2011 08:54:11 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 83.149.9.196 (Mozilla/5.0 (X11; U; Linux armv7l; ru-RU; rv:1.9.2.3pre) Gecko/20100723 Firefox/3.5 Maemo Browser 1.7.4.8 RX-51 N900)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180060>

Lawrence Brett <lcbrett <at> gmail.com> writes:

> 
> Hello,
> 
> I am very interested in using git for game development.  I will be working
> with a lot of binaries (textures, 3d assets, etc.) in addition to source
> files.  I'd like to be able to version these files, but I understand that
> big binaries aren't git's forte.

Define "big".

I have one MMORPG here under Git. 250k revisions, 500k files in working dir
(7Gb), 200 commits daily, 250Gb Git repo, SVN upstream repo of ~1Tb.

Some facts:
1. It is unusable on 32bit machine (here and there hits memory limit for a
single process
2. It is unusable on Windows (because there's no 64bit msysgit)
3. git status is 3s with hot disk caches (7mins with cold)
4. History traversal means really massive I/O.
5. Current setup: 120Gb 10k rpm disk for everything but .git/objects/pack,
separate 500Gb (will be upgraded to 1Tb soon) disk for packs
6. git gc is PAIN. I do it on weekends because it takes more than a day to run.
Also, limits for git pack-objects should be configured VERY carefully, it can
either run out of ram or take weeks to run if configured improperly.
7. With default gc settings, git wants to gc daily (but gc takes more than a
day, so if you follow its desire, you're in gc loop). I set objects limit to a
very high value and invoke gc manually.
8. svn users cannot sensibly do status on whole working copy (more than 10 mins)
9. svn users only update witha nightly script (40 mins)
10. git commit is several seconds because it writes 70Mb commit file.
11. It is a good idea to run git status often so that working copy info isn't
evicted from OS disk caches (remember, 3s vs 7min)
12. Cloning git repo is one more pain. 100mbps network here, so fetching 250Gb
takes some time. But worse, if cloning via git:// protocol, after fetching git
sits for several hours in "Resolving deltas" stage. So, for initial cloning
rsync is used.
13. Here and there i hit scalability issues in various git commands (which i
report to maillist and most [well, all, except the one i reported this week] of
which get fixed)

Hope this helps to get the idea of how git behaves on a large scale. Overall,
i'm happy with it and won't return to svn.
