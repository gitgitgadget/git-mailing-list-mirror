From: Johan Herland <johan@herland.net>
Subject: [RFC/PATCH 0/6] Graceful handling of missing remote helpers
Date: Tue, 11 Aug 2009 12:10:20 +0200
Message-ID: <1249985426-13726-1-git-send-email-johan@herland.net>
References: <alpine.LNX.2.00.0908101205120.27553@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: Johan Herland <johan@herland.net>, barkalow@iabervon.org,
	gitster@pobox.com, benji@silverinsanity.com,
	Johannes.Schindelin@gmx.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 11 15:12:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mar95-0008GJ-NR
	for gcvg-git-2@gmane.org; Tue, 11 Aug 2009 15:12:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752944AbZHKNLD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2009 09:11:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751670AbZHKNLC
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Aug 2009 09:11:02 -0400
Received: from smtp.getmail.no ([84.208.15.66]:40825 "EHLO
	get-mta-out02.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752035AbZHKNLB (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Aug 2009 09:11:01 -0400
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KO700LDVIY8LEC0@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Tue, 11 Aug 2009 12:10:56 +0200 (MEST)
Received: from localhost.localdomain ([84.215.102.95])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KO7008QYIY6Z330@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Tue, 11 Aug 2009 12:10:56 +0200 (MEST)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.8.11.95426
X-Mailer: git-send-email 1.6.4.rc3.138.ga6b98.dirty
In-reply-to: <alpine.LNX.2.00.0908101205120.27553@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125551>

On Mon, 10 Aug 2009, Daniel Barkalow wrote:
> > > In order to support this, there just needs to be a call to check whether
> > > "remote-<something>" is an available git command (without running it or
> > > giving an error), and the helper code should be used if it is. This is
> > > actually required so that people with workstations whose domain is
> > > .kernel.org and who have cloned "master:/home/linus/something.git" don't
> > > start getting "remote-master isn't a git command" errors (that is,
> > > misinterpreting ssh-format location hostnames as helper names. Johan,
> > > perhaps you could write that for your CVS helper?
> >
> > Sorry, not following you here. Write exactly what?
> >
> > - The code in the transport layer for checking if "remote-<something>"
> >   is an available git command?
>
> That's what I was thinking.

Ok, I've spent way too much time on this, so if this doesn't cut it, I leave it
up to someone else to pick up the pieces.

The following patch series implements what I understand to be the current
consensus (or at least a good compromise) in this thread:

- There are two ways to indicate that a remote helper should be used:
  1. remote.foo.vcs = <something>
  2. remote.foo.url starts with "<something>:"
  If both are present, remote.foo.vcs is preferred.

- Teach transport_helper_init() to check if "remote-<something>" is an
  available git command. If so, use it. If not, gracefully abort the
  transport-helper setup, and fall back to the "native" transport code.

- Skip the transport-helper code is the remote is obviously "native" (i.e.
  URL starts with "git:"/"file:"/"ssh:"/"rsync:")

AFAICS this should make Daniel happy because his P4 setup will still work, and
it should also make Dscho happy, since he can tell people to
  "git clone cvs::pserver:anonymous@cool.haxx.se:/cvsroot/curl#curl"
(of course, this depends on the CVS helper supporting remote.foo.url, which it
will, in a future iteration)

The non-trivial part of the series is in patch #5.

Implementing the rsync handling as another remote helper program is left as an
exercise for the reader...


Have fun! :)

...Johan


Johan Herland (6):
  Minor unrelated fixes
  transport_get(): Don't SEGFAULT on missing url
  Move setup of curl remote helper from transport.c to transport-helper.c
  Add is_git_command_or_alias() for checking availability of a given git command
  Let transport_helper_init() decide if a remote helper program can be used
  Add testcase to verify handling of missing remote helper programs

 help.c                           |   23 ++++++++++++-
 help.h                           |    2 +
 t/t5590-remote-helper-missing.sh |   56 +++++++++++++++++++++++++++++++
 transport-helper.c               |   67 +++++++++++++++++++++++++++++++++++--
 transport.c                      |   56 ++++++-------------------------
 5 files changed, 154 insertions(+), 50 deletions(-)
 create mode 100755 t/t5590-remote-helper-missing.sh
