From: Jason Sewall <jasonsewall@gmail.com>
Subject: Multi-target software repo, plus toolchain tracking
Date: Thu, 14 Oct 2010 10:21:42 -0700
Message-ID: <AANLkTineMhWPAMKondq9N26w3p6djaJ_xDyhj+yeawFv@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 14 19:27:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6Rak-00089O-9S
	for gcvg-git-2@lo.gmane.org; Thu, 14 Oct 2010 19:27:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755354Ab0JNR1k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Oct 2010 13:27:40 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:61883 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753515Ab0JNR1k (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Oct 2010 13:27:40 -0400
Received: by wwj40 with SMTP id 40so8238307wwj.1
        for <git@vger.kernel.org>; Thu, 14 Oct 2010 10:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:from:date
         :message-id:subject:to:content-type;
        bh=GoVHctGr5TxKn25W3xuxb+gmBg+NPtr6+gqbFevR2+o=;
        b=MoJloEGmJM6/xvGPQWvNLDJbXudToIh3+Q8VnPJDExXIBUwTypJxJli728EFS7BZZf
         lkH9t2olJHkR0HnpNbvimtAE97EzUBkZ3d5UJU/AuZmDo0BIxgOVRXeO4ULSei6PWMiB
         SBhGtYglXlkdeEgh6zSEx2c0F3U6TKG0qCufs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=yF/8cMZGemxnWYtTTkUb7cglB9PuU+j5fiKq2El2PIn/gqL+D+fQpTEJt7bGram8xI
         i7wN4+4xbgHitK4Sh92yQVebKFAsAwvOiehKG6TeZgjvg57u+AtPuRsZweFlL3RCWR9G
         BDjuC6x5BmeoMvdrv+wqz/b0W5XgM1N9+5N7k=
Received: by 10.216.71.66 with SMTP id q44mr10230626wed.44.1287076923089; Thu,
 14 Oct 2010 10:22:03 -0700 (PDT)
Received: by 10.216.230.90 with HTTP; Thu, 14 Oct 2010 10:21:42 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159061>

At $WORK, we're trying to figure out how to handle a combinatorial
explosion of research projects, backends, and big binary toolchains
and I'm looking into leverage git for the problem. I'd appreciate the
list's advice; here's the basics (I've tried to make it as succinct as
possible):

We have a suite composed of multiple sub-projects; each of these
projects supports some subset of a bunch of backend targets:

repo/
      project1/
		targetA/
		targetB/
		targetD/
		...
      project2/
		targetC/
		targetD/
		...
      project3/
		targetB/
		...
      ...

The complication is that most of these targets depend on some
(possibly experimental) toolchain for compilation, and even execution
in some cases.  We get these tools from upstream as big binary blobs
with timestamps.

We are very interested in tracking how performance changes with
updates in our code as well as changes in the toolchain, so it makes
sense to collect some performance numbers with some code and package
those numbers along with info about which version of a given tool was
used to compile/execute.  Naively, we could just put the tool right in
the repository like so:

repo/
      project1/
		targetA/
			targetA-toolchain/
		targetB/
			targetB-toolchain/
		...
      project3/
		targetB/
			targetB-toolchain/
		...
      ...

The duplication of tools alone is pretty wasteful in disk space, but
worse still, as we update tools and commit them, the size of the repo
--- with all of these giant binary toolchains in it --- is likely to
get pretty huge, and become a burden those who want to clone the repo
and just work on the tip of some branch.

So what we really want is to have git make sure to grab the right
version of each toolchain whenever we move HEAD; I haven't got tons of
experience with submodules, but I think that they are well-suited to
handle this problem.

This is where I'd like to leverage the list's knowledge; there are a
few ways to handle this, and I'm not sure which is the best.  Again,
what we want is:

1. For a given checkout of repo/ to have each targetXXX-toolchain/
directory populated, keeping in mind that different projects may not
all be using the same version of a toolchain
2. For end-users of the repo/ (cloners) to avoid having to lug around
every version of every toolchain; we don't want to 'pollute' the repo
with the large (>100mb) toolchain blobs we get from upstream.
3. If possible, further minimize disk usage by using some sort of
indirection (soft or hard linking, for example) when multiple projects
*are* using the same version of a given toolchain.
4. Minimize maintenance overhead

Here are a few ideas I've had on the subject

I. We could make a separate repo for each tool:

targetA-toolchain-repo/
targetB-toolchain-repo/

and each targetXXX/ directory in the main repo's toolchain
subdirectory treats this as a submodule. This satisfies #1, #2, and
possibly #4, but not #3.

II. Make a separate repo for each tool, but instead of having multiple
submodule checkouts, just have a tools directory with checkouts of all
currently-needed tools, with symlinks from the
projectXXX/targetXXX/targetXXX-toolchain to these top-level
submodules.

i.e.

repo/
      tools/
            targetA-toolchain-ver-c0ffee/      <- submodule checkout
of targetA-toolchain
            targetB-toolchain-ver-deadbeef/ <- submodule checkout of
targetB-toolchain
            targetB-toolchain-ver-b00b1e5/  <- submodule checkout of
targetB-toolchain
      project1/
		targetA/
			targetA-toolchain/  <- symlink to ../../tools/targetA-toolchain-ver-c0ffee/
		targetB/
			targetB-toolchain/  <- symlink to ../../tools/targetB-toolchain-ver-deadbeef/
		...
      project3/
		targetB/
			targetB-toolchain/  <- symlink to ../../tools/targetB-toolchain-ver-b00b1e5/
		...
      ...

This is good on #1, #2, and #3, but has the complication that there's
a bit of maintenance involved - setting up symlinks, deleting unused
submodules in tools/ etc.

I'd really appreciate any comments/advice the list might have on this.
I know my way around most of git pretty well, but I haven't really
used submodules before.

Jason
