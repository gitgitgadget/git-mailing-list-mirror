From: Andreas Gruenbacher <agruen@suse.de>
Subject: [RFC][PATCH 0/3] Different views on a repository
Date: Wed, 24 Feb 2010 17:41:20 +0100
Message-ID: <cover.1267029680.git.agruen@suse.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 24 18:10:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkKkq-0001b5-Uy
	for gcvg-git-2@lo.gmane.org; Wed, 24 Feb 2010 18:10:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757359Ab0BXRK1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2010 12:10:27 -0500
Received: from cantor2.suse.de ([195.135.220.15]:49405 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757350Ab0BXRK0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2010 12:10:26 -0500
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.221.2])
	by mx2.suse.de (Postfix) with ESMTP id 712208D167
	for <git@vger.kernel.org>; Wed, 24 Feb 2010 18:10:25 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140957>

Hello,

we have a use case with groups of repositories which share lots of
objects, but which are logically independent.  There is no strict
hierarchy between the repositories, the development modl is arbitrary.
The alternates mechanism for sharig objects between repositories won't
work.

The best idea I came up with so far to solve this was to keep everything
in the same repository on the server.  Then, to keep the logically
independent repositories separate, directories are used below refs/heads
and refs/tags.  Receive-pack and upload-pack are modified to hide this
directory structure from clients so that repositories will continue to
look "normal" to users.  For example, the following structure on the
server:

	refs/heads/one/master
	refs/tags/one/tag1
	refs/heads/two/master
	refs/heads/two/branch2

would appear as two independent repositories to different clients:

	refs/heads/master
	refs/tags/tag1

and:

	refs/heads/master
	refs/heads/branch2

The following three patches implement this.  What do you guys think --
does the basic idea and implementation look sensible, or am I
overlooking a way to solve this kind of problem with other means?

Thanks!


  receive-pack: Two small code cleanups
  Different views on a repository
  Different views on a repository: HEAD mapping

 Documentation/git-receive-pack.txt |    9 ++++-
 Documentation/git-upload-pack.txt  |   10 +++++-
 builtin-receive-pack.c             |   32 ++++++++++++++---
 refs.c                             |   65 ++++++++++++++++++++++++++++++++++--
 refs.h                             |    4 ++
 upload-pack.c                      |   20 ++++++++++-
 6 files changed, 127 insertions(+), 13 deletions(-)
