From: Brad King <brad.king@kitware.com>
Subject: [PATCH v2 0/2] Support relative .git file in a submodule
Date: Fri,  8 Jan 2010 22:36:39 -0500
Message-ID: <1263008201-27429-1-git-send-email-brad.king@kitware.com>
References: <32541b131001081524g43d54a44i582dd286c1dfe7a5@mail.gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Lars Hjemli <hjemli@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 09 04:36:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTS8C-0008Ik-49
	for gcvg-git-2@lo.gmane.org; Sat, 09 Jan 2010 04:36:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754506Ab0AIDgu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jan 2010 22:36:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753683Ab0AIDgt
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jan 2010 22:36:49 -0500
Received: from public.kitware.com ([66.194.253.19]:39435 "EHLO
	public.kitware.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753497Ab0AIDgq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jan 2010 22:36:46 -0500
Received: by public.kitware.com (Postfix, from userid 5001)
	id 857A017EA6; Fri,  8 Jan 2010 22:27:33 -0500 (EST)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on public.kitware.com
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,AWL,BAYES_00,
	FH_DATE_PAST_20XX autolearn=no version=3.2.5
Received: from hythloth (hythloth.kitwarein.com [192.168.30.5])
	by public.kitware.com (Postfix) with ESMTP id D69EA17EA5;
	Fri,  8 Jan 2010 22:27:31 -0500 (EST)
Received: by hythloth (Postfix, from userid 1000)
	id 289177D425; Fri,  8 Jan 2010 22:36:41 -0500 (EST)
X-Mailer: git-send-email 1.6.5
In-Reply-To: <32541b131001081524g43d54a44i582dd286c1dfe7a5@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136512>

Junio C Hamano wrote:
> then I've always thought that is simply a misconfiguration (t0002
> seems to use full path for this exact reason).

Everything in that test works with REAL=.real except the line

  test "$REAL" = "$(git rev-parse --git-dir)"

because --git-dir returns an absolute path.

> Is there a reason why relative path should be used/usable here, other
> than "being able to is better than not being able to"???

Similar configurations already work:

 - A .git file with a relative path works inside its work tree
 - A .git symlink with a relative path works inside its work tree
 - A submodule whose .git is a real symlink with a relative path works

My patch just fixes an intuitive combination of these cases.

> I don't like my process randomly chdir'ing around assuming they can
> chdir back safely very much, and would prefer not to add such
> codepaths unless absolutely necessary.

Here is a new patch series.  Patch 1/2 is unchanged.  Patch 2/2 has been
re-written to avoid chdir.

Avery Pennarun wrote:
> This problem seems especially true with submodules.  If the
> submodule's repo is something like supermodule/.git/submodule.git, a
> relative path would almost always be a appropriate, no?

Exactly.  In fact the experiment I was doing involved creating submodule
repos inside the main .git and linking to them from the work tree
subdirectories.  I'm looking into combining the approach with that of
git-new-workdir to keep submodules in the same object database.

Brad King (2):
  Test update-index for a gitlink to a .git file
  Handle relative paths in submodule .git files

 setup.c                         |   22 +++++++++++++++++++---
 t/t2104-update-index-gitfile.sh |   38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+), 3 deletions(-)
 create mode 100755 t/t2104-update-index-gitfile.sh
