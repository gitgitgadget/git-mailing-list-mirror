From: Max Horn <max@quendi.de>
Subject: Re: [PATCH 00/13] remote-hg: general updates
Date: Wed, 3 Apr 2013 00:23:11 +0200
Message-ID: <2670C2C0-E30F-47DA-8901-899FEE11059E@quendi.de>
References: <1364929382-1399-1-git-send-email-felipe.contreras@gmail.com> <20130402200948.GF2222@serenity.lan>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Wed Apr 03 00:24:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UN9cg-00014U-Ch
	for gcvg-git-2@plane.gmane.org; Wed, 03 Apr 2013 00:24:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762313Ab3DBWXg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 18:23:36 -0400
Received: from merkurneu.hrz.uni-giessen.de ([134.176.2.3]:62399 "EHLO
	merkurneu.hrz.uni-giessen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1762117Ab3DBWXe convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 2 Apr 2013 18:23:34 -0400
Received: from mailgw52.hrz.uni-giessen.de by merkurneu.hrz.uni-giessen.de with ESMTP; Wed, 3 Apr 2013 00:23:17 +0200
Received: from merkurneu.hrz.uni-giessen.de (merkurneu.hrz.uni-giessen.de [134.176.2.3])
	by mailgw52.hrz.uni-giessen.de (Postfix) with ESMTP id 3A3621A0000A0;
	Wed,  3 Apr 2013 00:23:10 +0200 (CEST)
Received: from [134.176.2.3] by merkurneu.hrz.uni-giessen.de with ESMTP; Wed, 3 Apr 2013 00:23:10 +0200
In-Reply-To: <20130402200948.GF2222@serenity.lan>
X-Mailer: Apple Mail (2.1283)
X-HRZ-JLUG-MailScanner-Information: Passed JLUG virus check
X-HRZ-JLUG-MailScanner: No virus found
X-Envelope-From: max@quendi.de
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219893>


On 02.04.2013, at 22:09, John Keeping wrote:

> On Tue, Apr 02, 2013 at 01:02:49PM -0600, Felipe Contreras wrote:
>> Here is the next round of patches for remote-hg, some which have been
>> contributed through github.
>> 
>> Fortunately it seems to be working for the most part, but there are some
>> considerable issues while pushing branches and tags.
> 
> How does this compare to the current state of gitifyhg[1]?  That's built
> on top of this git-remote-hg script but seems to have been more actively
> developed recently.

Several bugs that were fixed in gitifyhg some time ago are now fixed in this remote-hg, too.

I'll try to list some of remaining differences, mostly (in my biased opinion) improvements on the gitifyhg side. Note that some of these might be outdated with felipe's recent changes, i.e. I have not yet had time to review and/or test them all. So please bear that in mind.

* added many new test cases, sadly still including some xfails. Several of these (both passing and xfailing) also apply to remote-hg (i.e. the issue is also present in contrib's remote-hg)

* improved handling of hg user names (remote-hg is not able to deal with some pathological cases, failing to import commits). Sadly, mercurial allows arbitrary strings as usernames, git doesn't...

* failed pushes to hg are cleanly rolled back (using mq.strip() from the mq extension), instead of resulting in inconsistent internal state. This is quite important in real life, and has bitten me several times with remote-hg (and was the initial reason why I switched to gitifyhg). A typical way to reproduce this is to push to a remote repository that has commits not yet in my local clone.

* git notes are used to associate to each git commit the sha1 of the corresponding hg commit, to help users figure out that mapping

* internally, the marks are using the hg sha1s instead of the hg rev ids. The latter are not necessarily invariant, and using the sha1s makes it much easier to recover from semi-broken states.

* Better handling of various hg errors, see e.g. [2]. More work is still needed there with both tools, though [3].

* Support for creating hg tags from git (i.e. pushing light git tags to heavy hg tags)

* The gitifyhg test suite is run after each push on Travis CI against several git / mercurial combinations [4].
In particular, unlike all other remote-hg implementations I know, we explicitly promise (and test) compatibility with a specific range of Mercurial versions (not just the one the dev happens to have installed right now). This has been a frequent issue for me with the msysgit remote-hg

* Renaming a gitifyhg remote just works [5]. Doing that with remote-hg triggers a re-clone of the remote repository (if it works at all, I don't remember). 


Sadly, while working on gitifyhg, we discovered various more design problems (from our perspective, at least) in Mercurial, e.g. the fact that commits are not necessarily normalized, in the sense that "equivalent" commits (same author, time, changed files / code) can have different hashs, with some nasty implications for import. This is potentially problematic because without extra care, these would be mapped to the same commit on the git side.

Unfortunately, we also stumbled into various problems with the git remote-helper system. We are currently using the fast-import remote-helper type, but are encountering more and more of its limitations. This affects remote-hg and gitifyhg equally, and probably other remote helpers. E.g. "git push --dry-run" seems to be impossible to support with such a remote-helper (but then I might be mistaken).

Thing is, for several of these I don't feel quite competent enough to come up with patches that I could submit here. And in my experience just reporting a perceived problem with the remote-helper API is not going to trigger a response here [6]. I guess that's why we stopped reporting them here for now, but if there is interest I could try to compile an overview.


[1] https://github.com/buchuki/gitifyhg
[2] https://github.com/buchuki/gitifyhg/commit/74b71f4
[3] https://github.com/buchuki/gitifyhg/issues/66
[4] https://travis-ci.org/buchuki/gitifyhg/builds
[5] https://github.com/buchuki/gitifyhg/commit/68ce89bb32
[6] http://thread.gmane.org/gmane.comp.version-control.git/214802