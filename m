From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [BUG] git show <remote>: bad information: Local branch|ref
 configured
Date: Fri, 12 Nov 2010 19:09:34 -0600
Message-ID: <20101113010934.GA4017@burratino>
References: <201011130041.oAD0fdmM017083@no.baka.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Seth Robertson <in-gitvger@baka.org>
X-From: git-owner@vger.kernel.org Sat Nov 13 02:10:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PH4dB-0006Jg-TL
	for gcvg-git-2@lo.gmane.org; Sat, 13 Nov 2010 02:10:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753644Ab0KMBKG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Nov 2010 20:10:06 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:45534 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752474Ab0KMBKE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Nov 2010 20:10:04 -0500
Received: by yxn35 with SMTP id 35so363045yxn.19
        for <git@vger.kernel.org>; Fri, 12 Nov 2010 17:10:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=0sqGpucXMo/hfRJ9UWZ5CxqCI7EU1g6LzJW3O1kcJhs=;
        b=uDsNh5y6WkBEuW38W1XBB7xPIzFkQmZpgKhC3xKL+6TRPKt41J8hST50HsJUP4/9JP
         3BP9yjDN5dWWMxH26m4oHNj7JbNpRLjgik+a4oqNvJWRLWOElIbou6qCU/+OOo+oxbws
         /XVTo0YnJd+kmyXjNtKNpi2FLuaI1PfXtoBJ8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=GorZphi61KJKM/GYQwoZ37mTwlA14Mzc15AlPiyiBDqbMsQhQ6ouWL5DBG73vDHt9w
         m3K4ojsZikXBh1zRV8zzfXHzhoN2qqDuRzhk8eSMwkPpGdw73hZJJcLRgMYv3rAYCPdm
         VqZJT9QpBajfDrs/JxlPKEdaqq66LSiIbQYuc=
Received: by 10.150.203.19 with SMTP id a19mr5102634ybg.220.1289610603895;
        Fri, 12 Nov 2010 17:10:03 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id w5sm1293663ybe.10.2010.11.12.17.10.02
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 12 Nov 2010 17:10:03 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <201011130041.oAD0fdmM017083@no.baka.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161377>

On Fri, Nov 12, 2010 at 07:41:39PM -0500, Seth Robertson wrote:

> Not having inspected the code, it certainly appears as if the "Local
> branch configured" and "Local ref configured" information is only
> accidentally correct, but since the normal configuration is the case
> in which it is accurate, no-one noticed the problem.

Funny. :)  But no, lots of people set up local branches as downstream
to no branch or to some distinct remote branch.  So first I guess it
might be useful to explain the "push matching" behavior.

Background: suppose the upstream repository has three branches:

	master
	next
	topic/better-frotz

Now I have an idea for a new feature, so I do

	git checkout -b topic/xyzzy origin/master

which forks a new branch set up to pull from master.

Now I go about usual work, making changes to master, next,
topic/better-frotz, and so on, and at the end I am on my private
topic/xyzzy branch.  Everything looks good, so it is time to push:

	git push origin

This is a shortcut for

	git push origin :

which pushes all local branches for which an upstream branch with the
same name exists.

"Wait!" you might ask.  "Why push all branches?"

It is partly historical.  A lot of people have public repositories
with multiple branches, and this is a behavior that has been found to
be very convenient for that.

"Why only branches for which an upstream branch exists?"

Some work might be private.  If you actually want to push everything,
use "git push --mirror".

"Why branches with the same name?  Why not to the branch each branch
pulls from?"

Each branch forked from master does not necessarily contain changes
that are suitable for inclusion in master immediately.  In general,
the upstream for each branch is often more stable rather than
equally stable to it, so automatic pushing upstream does not always
make sense.

However, if you want the push-to-where-you-pull-from behavior,
just add

	[push]
		default = tracking

to your ~/.gitconfig.

See the documentation for branch.<name>.merge in git-config(1) for
details on that.

For your test example: rather than sample output, could you describe
next to each command what you expect to happen and how that differs
from what happens instead?  This would make it easier to find the
lurking bugs.

Hope that helps,
Jonathan
