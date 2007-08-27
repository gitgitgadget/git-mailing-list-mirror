From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [BUG] gitweb on repo.or.cz shows buggy commitdiff
Date: Mon, 27 Aug 2007 02:30:04 +0200
Message-ID: <200708270230.04537.jnareb@gmail.com>
References: <20070729094645.GU23229@nan92-1-81-57-214-146.fbx.proxad.net> <20070825202530.GB1219@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Yann Dirson <ydirson@altern.org>
To: Petr Baudis <pasky@suse.cz>, GIT list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 27 02:30:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPSVD-0003fM-2Y
	for gcvg-git@gmane.org; Mon, 27 Aug 2007 02:30:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751060AbXH0AaN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Aug 2007 20:30:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750877AbXH0AaN
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Aug 2007 20:30:13 -0400
Received: from fk-out-0910.google.com ([209.85.128.189]:43343 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750795AbXH0AaM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Aug 2007 20:30:12 -0400
Received: by fk-out-0910.google.com with SMTP id z23so1283164fkz
        for <git@vger.kernel.org>; Sun, 26 Aug 2007 17:30:10 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=sMrzCz54aE+dYYqpc572NnFy2p8E4vNlBUZmsjAmt8+qse+JKhKmFNQc8lvYo1vzQIVia6AMo0eGmGWrCgv/iLect/109FAMuintYmehJZANCfWRsFOm4dn6JZG478KHlxr38Z77VxSEy1BTmPWj2TB1GyWMp0CeVMCKIOjuf6A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=eVt24F8gadK5kwmJX9TkHvaAmJ+WaYwqiQWH146MzqLLuDPA7DFvpQDskklsSj4dAlTMODEps8PLwduOeug3krFctxensNMFZGSC1u6KgqluiRCTTrIZhW31ORYOcHyEqt1u6exBCun7dOOyUmUBchBg/0pug2zEgqn+2KRVaTA=
Received: by 10.86.89.4 with SMTP id m4mr4435343fgb.1188174610258;
        Sun, 26 Aug 2007 17:30:10 -0700 (PDT)
Received: from host-89-229-8-65.torun.mm.pl ( [89.229.8.65])
        by mx.google.com with ESMTPS id 31sm2584397fkt.2007.08.26.17.30.05
        (version=SSLv3 cipher=OTHER);
        Sun, 26 Aug 2007 17:30:07 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20070825202530.GB1219@pasky.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56749>

On Sat, Aug 25, 2007, Petr "Pasky" Baudis wrote:
> On Sun, Jul 29, 2007 at 11:46:45AM CEST, Yann Dirson wrote:

>> Looking at [1] one can see that the diff, instead of showing the
>> changes to the various .gitignore files touched by the commit,
>> displays again and again the data/.gitignore one, but even confuses a
>> Makefile modified by the commit for the .gitignore file to diff.
>> 
>> 
>> |diff --git a/data/pics/.gitignore b/data/pics/.gitignore
>> |index c5ec666af7db2d53e7ed86090c88f62ab8ec25a4..912bca74cbee222936f08e421230fd9dde903ecb 100644 (file)
>> |--- a/lua/Makefile
>> |+++ b/data/pics/.gitignore
>> 
>> Also, despite "+++ b/data/pics/.gitignore" being displayed in the diff
>> header, it is indeed showing the diffs to "b/lua/Makefile".
>> 
>> [1] http://repo.or.cz/w/tagua/ydirson.git?a=commitdiff;h=1f285b312fa526293164548d88e8403dfb354eb4
> 
> Looks funny. This is because the target object id of all the patches is
> the same as all the .gitignore files are identical, and this triggers
> "split patch detection" - I guess that triggers when diff thinks that a
> file was replaced, and injects full deletion and full creation diff
> inside. Due to this trigger, file diffs and raw diff records get out of
> sync and that results in Makefile diff misattribution.

Thanks a lot, Pasky, for identifying the cause of this problem. It does
indeed look like a bug in the split/continued patch detection.

See below.

> Jakub, any idea how to fix this? Maybe to check if filename matches
> either from_file or to_file?

There are two possible solutions. The generic one, and the simplyfying one.

1. We could parse from_file and to_file from the "git diff header" in the
patch, i.e. from the "^diff" line in patchset, and consider patch "split"
or "continued" if not only pre-image and post-image (from_id and to_id)
matches, but only when also from_name and to_name matches. Note that for
combined diff there is no to_file.

The problem lies in the fact that to_name and/or from_name can be quoted,
and gitweb would need some complicated regular expression to take this into
consideration (Text::Balanced module provides regexp for extracting quoted
part: 
  (?:\"(?:[^\\\"]*(?:\\.[^\\\"]*)*)\")
by the way of gen_delimited_pat(q{"})), i.e. to separate from_name from
to_name in "git diff header".

This is very generic solution, and should work against possible future
changes in git-diff patch output.


2. Alternate solution is to note that we have split patch only in the case
of 'T' (type change) status, and for typechange we always split patch in
two, so there are two patches corresponding to single raw diff-tree line.

So it would be enough to introduce $continued_patch variable, unset it
after writing that patch is continued if it is true, set it to true if
there was typechange, i.e. if status (one of status) is 'T'.

And we can get rid of buffering extended diff header and parsing it,
I think. This would simplify git_patchset_body, making it easier to
understand and maintain.

But this depends on my understanding on "git diff-tree --patch-with-raw"
output, and that it would not change in the future WRT split patches.

> But that would probably need a bit of code 
> refactoring in git_patchset_body(), which is something I'm not really
> into. :-)

I tried to make git_patchset_body easier to understand, but it looks like
I have failed... :-)

-- 
Jakub Narebski
Poland
