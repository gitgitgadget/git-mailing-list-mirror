From: Russ Brown <pickscrape@gmail.com>
Subject: Workflow question
Date: Tue, 25 Sep 2007 11:43:05 -0500
Message-ID: <46F93A99.5080707@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 25 18:43:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IaDVL-0002ga-7w
	for gcvg-git-2@gmane.org; Tue, 25 Sep 2007 18:43:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753241AbXIYQnQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Sep 2007 12:43:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753161AbXIYQnQ
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Sep 2007 12:43:16 -0400
Received: from an-out-0708.google.com ([209.85.132.247]:4858 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753133AbXIYQnP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Sep 2007 12:43:15 -0400
Received: by an-out-0708.google.com with SMTP id d31so293243and
        for <git@vger.kernel.org>; Tue, 25 Sep 2007 09:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        bh=bhq6IZybA8eleHhZpvXdECVHr82SP+bX6mtaAB5IbXE=;
        b=cIqn0qnqGjJ/is9CK6XhdfStyJP/7kmewLQqyfEo7VxEMWNeL1OAam7YrbF6FIOtIYkSNJbw8dNFLxiPFHLTsHaf6Gp609Xumk6FoRTjroxwYK1N1634/p7DRXifK8g6ZtcJyoJloGm1o50HntmzczUjnOwRMl39gR/mD8j7FSA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=FMBQM16EA+78wRdzHYIoKggu3YPA1M8etG8NIwm9RDBn/8cZl5PUmvwuyT5oKJMQ1xtMi30meIXhLl+avWXV6LKYgRDrHyQC9oS0xo/4+ViMQkRY7sy9yDg7ZqtxiFsXlNVhDY5kwtO8IKwMUjjIJfshdISul7iE/ttOWKXj9Iw=
Received: by 10.100.9.19 with SMTP id 19mr1127145ani.1190738594412;
        Tue, 25 Sep 2007 09:43:14 -0700 (PDT)
Received: from ?192.168.0.100? ( [71.252.196.170])
        by mx.google.com with ESMTPS id c16sm7092857anc.2007.09.25.09.43.11
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 25 Sep 2007 09:43:12 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.6 (X11/20070807)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59148>

Hi,

I've been trying to think of a git workflow that we could use to replace
our current svn/svk setup without simply using git in exactly the same
way that we use svn/svk.

Basically, we develop, maintain and enhance a website. On the central
repo is trunk which represents live, and any number of project branches.
Developers don't use local branches: they check out the project branches
they're working on and commit to those. Developers merge from trunk to
project branch from time to time to keep them current, and when a
project rolls out the branch is merged to trunk.

In addition to the obvious advantages that git would give us (such as
properly tracking that code author as opposed to the person who did the
merge), I'm wanting to gain the following benefits:

 * The repository is very large (multiple gigabytes) and mirroring using
svk obviously takes a lot of time and space, so I'm keen to bring that
down, most likely by the developer not needing to mirror branches he
doesn't care about, or by being able to throw away branches he's done with.
 * The repository is full of revisions that fail review (or break
things) and are fixed by subsequent revisions. We'd much rather be able
to have the developer fix his revisions before they get committed
'upstream' (whatever that ends up meaning).

I asked earlier about the email-based model that git itself uses, and
while it appears to work very well for a widely-dispersed open-source
project, I think it will be too cumbersome and slow for a fast-paced
internal development team who make a number of live releases every day.

So, I've been thinking and have come up with this, which I'd appreciate
comments about:

 1. On a server we stick a git repository which contains the master
branch, which represents what trunk did (i.e. the live platform). This
branch contains the full history for the live platform.
 2. On the same server we clone that repo to create a second repository
which is the developer area. In this we track master from the live repo,
and also create project branches.
 3. Developers clone this developer repo, but I'd like them to be able
to decide which branches they actually want to clone from that
repository rather than simply cloning them all. Is this possible?
 4. Developers create a local branch of the project they
are working on and commit to that.
 5. Once they think they're done, they publish their branch to the
development repo and request for comments.
 6. If all is not well, the developer creates a new local branch and
moves good revisions from his previous one to the new one, modifying
things as he goes, and republishes his new branch.
 7. If all is well, their works gets merged or rebased onto the main
project branch, and once that's ready it gets pushed to the master and
rolled to live. The developer's individual branches get deleted from the
dev repo since they're no longer required.
 8. From time to time the master branch gets merged to the project
branches. Developer's local branches can be rebased against the project
branch as they please.

Firstly, is all of this possible, and if so would it be considered a
good way of going about it?

Any comments appreciated.

-- 

Russ
