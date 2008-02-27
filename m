From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix premature call to git_config() causing
 t1020-subdirectory to fail
Date: Tue, 26 Feb 2008 17:34:12 -0800
Message-ID: <7vy79718tn.fsf@gitster.siamese.dyndns.org>
References: <alpine.LNX.1.00.0802251604460.19024@iabervon.org>
 <200802260321.14038.johan@herland.net> <200802261640.48770.johan@herland.net>
 <alpine.LNX.1.00.0802261709180.19665@iabervon.org>
 <alpine.LSU.1.00.0802262239200.22527@racer.site>
 <alpine.LNX.1.00.0802261742260.19665@iabervon.org>
 <7vzltn2qsd.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.00.0802261933551.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Kristian =?utf-8?Q?H=C3=B8gsb?= =?utf-8?Q?erg?= 
	<krh@redhat.com>, Santi =?utf-8?Q?B=C3=A9jar?= <sbejar@gmail.com>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Feb 27 02:35:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUBCT-0000aG-8i
	for gcvg-git-2@gmane.org; Wed, 27 Feb 2008 02:35:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758296AbYB0Beg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Feb 2008 20:34:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758763AbYB0Beg
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Feb 2008 20:34:36 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:61601 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754266AbYB0Beg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Feb 2008 20:34:36 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id D4C9426A9;
	Tue, 26 Feb 2008 20:34:30 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 82CE626A8; Tue, 26 Feb 2008 20:34:19 -0500 (EST)
In-Reply-To: <alpine.LNX.1.00.0802261933551.19665@iabervon.org> (Daniel
 Barkalow's message of "Tue, 26 Feb 2008 19:53:57 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75198>

Daniel Barkalow <barkalow@iabervon.org> writes:

> There's nothing in the documentation to suggest that you can use 
> GIT_CONFIG to affect how the old repository is read, or that GIT_CONFIG 
> doesn't affect the new repository. Actually, as far as I can tell, the 
> configuration of a repository you're cloning (local or remote) doesn't 
> matter at all. Note that GIT_DIR and GIT_WORK_TREE refer to the new repo, 
> so it would be surprising for GIT_CONFIG to refer to the old one.

There was a bit of confusion in this discussion.

GIT_DIR the user may have in the environment may refer to the
old reopsitory before "git clone" is invoked, but it should not
matter at all, as the origin of the cloning comes from the
command line and that is where we will read from.  The scripted
version sets GIT_DIR for our own use to point at the new
repository upfront and exports it, so we are safe from bogus
GIT_DIR value the user may have in the environment.

GIT_WORK_TREE naming the new repository feels Ok, as you do not
care about the work tree of the original tree when cloning, and
you may want to have a say in where the work tree associated
with the new repository should go.

GIT_CONFIG the user may have will refer to the old repository
before "git clone" is invoked, as there is no new repository
built yet.  But clone does not read from the old config, so "you
can use GIT_CONFIG to read from old repository" may be true, but
it does not matter.  We won't use it (we do _not_ want to use
it) to read from the old configuration file.

We would however want to make sure that we write to the correct
configuration file of the new repository and not some random
other place, and that's where the environment variable in the
scripted version comes into the picture.

In the scripted version, the only way to make sure which exact
configuration file is updated is to set and export GIT_CONFIG
when running "git config", so there are a few places that does
exactly that (e.g. call to git-init and setting of core.bare).
Unfortunately many codepaths in the scripted version are utterly
careless (e.g. setting of remote."$origin".fetch); they should
make sure that they protect themselves against GIT_CONFIG the
user may have in the environment that point at random places.

> My current design is to collect some initial information, create 
> directories, and then set the work tree and git dir. Then we run fetch, 
> configure things, etc., in the new context.

That sounds like a clean design to me.
