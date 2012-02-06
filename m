From: Steven Michalske <smichalske@gmail.com>
Subject: Re: [RFD] Rewriting safety - warn before/when rewriting published history
Date: Sun, 5 Feb 2012 16:57:21 -0800
Message-ID: <EAF9D593-4E0C-4C95-A048-3F6AC8ADD866@gmail.com>
References: <201202042045.54114.jnareb@gmail.com>
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 06 01:57:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuCtf-0002oQ-8O
	for gcvg-git-2@plane.gmane.org; Mon, 06 Feb 2012 01:57:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754639Ab2BFA50 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Feb 2012 19:57:26 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:39420 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753995Ab2BFA5Z convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Feb 2012 19:57:25 -0500
Received: by daed14 with SMTP id d14so14139dae.19
        for <git@vger.kernel.org>; Sun, 05 Feb 2012 16:57:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        bh=23uttk8PSn/rreQft4P5e1Bm+w+WM8qPfjXYKdnEuOA=;
        b=bzD5KXZOAROQVoiz+/Z1J8+3m4MU7CmAtEvqeUumW07BLcID+s9I3a3XIro1g1p9/V
         vThelIR3HIBxrPiCBLAb6IsNdkkKBXAyEeP/L2JkvUyUf/zPvtGmqLFfJbiwyTNB/uL+
         WQ1CAoTG0Vb1YpY+UxtQ2cHe2fkX5qctSodog=
Received: by 10.68.74.132 with SMTP id t4mr42880853pbv.22.1328489844885;
        Sun, 05 Feb 2012 16:57:24 -0800 (PST)
Received: from [192.168.1.114] (c-67-161-24-30.hsd1.ca.comcast.net. [67.161.24.30])
        by mx.google.com with ESMTPS id x4sm35318246pbx.16.2012.02.05.16.57.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 05 Feb 2012 16:57:23 -0800 (PST)
In-Reply-To: <201202042045.54114.jnareb@gmail.com>
X-Mailer: Apple Mail (2.1251.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189992>

See inlined responses below.

On Feb 4, 2012, at 11:45 AM, Jakub Narebski wrote:

> So people would like for git to warn them about rewriting history before 
> they attempt a push and it turns out to not fast-forward.
> 

I like this idea and I encounter this issue with my co-workers new to git.
It scares them thinking they broke the repository.

> In Mercurial 2.1 there are three available phases: 'public' for
> published commits, 'draft' for local un-published commits and
> 'secret' for local un-published commits which are not meant to
> be published.
> 
> The phase of a changeset is always equal to or higher than the phase
> of it's descendants, according to the following order:
> 
>      public < draft < secret

Let's not limit ourselves to just three levels.  They are a great start but I propose the following.

published - The commits that are on a public repository that if are rewritten will invoke uprisings.
	general rule here would be to revert or patch, no rewrites.
based - The commits that the core developers have work based upon. (not just the commits in their repo.)
	general rule is notify your fellow developers before a rewrite.
shared - The commits that are known to your fellow core developers.
	These commits are known, but have not had work based off of them.  Minimal risk to rewrite.
local - The commits that are local only, no one else has a copy.
	Commits your willing to share, but have not been yet shared, either from actions of you, or a fetch from others.
restricted or private - The commits that you do not want shared.
	Manually added, think of a branch tip marked as restricted automatically promotes commits to the branch as restricted.

Maybe make these like nice levels, but as two components, publicity 0-100 and rewritability 0-100
	Published is publicity 100 and rewritability 0
	Restricted is publicity 0 and rewritability 100
	Based publicity 75 and rewritability 25
	Shared publicity 50 and rewritability 50
	Local publicity 25 and rewritability 75
	Restricted publicity 0 and rewritability 100

Other option are flags stating if the commit is published, based, shared, or restricted.
You could have a published and based commit that is more opposed to rewrite than a public commit.

Call security on a published restricted commit ;-)

Commits are by default local.

Commits are published when they are pushed or fetched and merged to a publishing branch of a repository.
	On fetch/merge a post merge hook should send back a note to the remote repository that the commits were published.

Restricted commits/branches/tags should not be made public, error out and require clearing of the attribute or a --force-restricted option that automatically removes the restricted attribute.  They are at least promoted to shared, if not published.

Based is only used in situations where you have developers sharing amongst their repositories, and you want a rule that is less restrictive than no rewrites.

Shared is what we have now when a commit is in a remote repository without the no rewrite options. e.g. receive.denyNonFastForwards.

As it stands now we can infer local and shared,  we need metadata to know when a commit is made based, published, or restricted.


Using the nomenclature from Mercurial 
>      public < draft < secret

public -> publicity 100, rewritability 0
draft -> publicity ?, rewritability 50
secret -> publicity 0, rewritability 100

Steve