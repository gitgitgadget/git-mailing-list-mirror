From: Johan Herland <johan@herland.net>
Subject: [PATCH/RFC 0/7] Restricting repository access (Was: [BUG?] How to make
 a shared/restricted repo?)
Date: Wed, 25 Mar 2009 22:36:02 +0100
Message-ID: <200903252236.03010.johan@herland.net>
References: <200903250105.05808.johan@herland.net>
 <200903250311.56300.johan@herland.net>
 <7v63hybaqd.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 25 22:37:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmanF-0005QZ-23
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 22:37:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752098AbZCYVgM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2009 17:36:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751889AbZCYVgK
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 17:36:10 -0400
Received: from mx.getmail.no ([84.208.15.66]:37677 "EHLO
	get-mta-out02.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751601AbZCYVgI (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Mar 2009 17:36:08 -0400
Content-disposition: inline
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KH300M7B004LI00@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Wed, 25 Mar 2009 22:36:05 +0100 (MET)
Received: from alpha.localnet ([84.215.102.95])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KH300034003F4G0@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Wed, 25 Mar 2009 22:36:04 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.3.25.212528
User-Agent: KMail/1.11.1 (Linux/2.6.28-ARCH; KDE/4.2.1; x86_64; ; )
In-reply-to: <7v63hybaqd.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114671>

On Wednesday 25 March 2009, Junio C Hamano wrote:
> Johan Herland <johan@herland.net> writes:
> > On Wednesday 25 March 2009, Junio C Hamano wrote:
> >> You might like to try a patch like this (untested).
> >>
> >>  path.c |   17 +++++------------
> >>  1 files changed, 5 insertions(+), 12 deletions(-)
> >
> > Thanks!
> >
> > This works much better :)
> >
> > However, there are still some questions/issues:
> >
> > - t1301-shared-repo.sh fails:
> >     Oops, .git/HEAD is not 0664 but -rw-rw---- [...]
> >     * FAIL 3: shared=1 does not clear bits preset by umask 022
> >   (I guess this is expected, as your patch changes the assumptions)
>
> I'd rather say the patch breaks people's expectations.

I thought some more about the current semantics, and came up with this
patch series, which replaces your original suggestion.

In short, I leave the core.sharedRepository semantics as is (i.e. it is
only used to _loosen_ repository permissions), and introduce a new
variable - core.restrictedRepository - that takes care of _tightening_
repository permissions. Its value is a permission mask that is applied
to the file mode in adjust_shared_perm()

The patch series is based on recent 'next', and the testsuite passes
after each individual patch.

Here is a short rundown of the individual patches:

1. Clarify existing documentation to reflect the current semantics of
   core.sharedRepository and "git init --shared". Even if the rest of
   the series is rejected, I hope this can make it in some form.

2. Minor cleanup in path.c:adjust_shared_perm(). This is pretty much
   your original patch with any functional changes removed.

3. Introduce core.restrictedRepository. Adds git_config_perm_mask()
   for parsing the config value, and changes adjust_shared_perm() to
   apply the permission mask. Includes documentation of the new config
   variable.

4. Add "--restricted" to "git init". Heavily modeled on the existing
   "--shared" option. Includes documentation of the new option.

5. Add tests for the functionality introduced in #3 and #4.

6. Apply adjusted repository permissions in "git init" when copying
   templates into the new repo.

7. Apply restricted permissions to loose objects and pack files. This
   ensures that loose objects and pack files do not get permissions
   that are more liberal than the rest of the repository.


Have fun!

...Johan


Johan Herland (7):
  Clarify documentation on permissions in shared repositories
  Cleanup: Remove unnecessary if-else clause
  Introduce core.restrictedRepository for restricting repository
    permissions
  git-init: Introduce --restricted for restricting repository access
  Add tests for "core.restrictedRepository" and "git init --restricted"
  git-init: Apply correct mode bits to template files in
    shared/restricted repo
  Apply restricted permissions to loose objects and pack files

 Documentation/config.txt   |   41 ++++++++++++-
 Documentation/git-init.txt |   50 +++++++++++++++--
 builtin-init-db.c          |   31 +++++++++-
 cache.h                    |    8 +++
 environment.c              |    1 +
 fast-import.c              |    4 +-
 http-push.c                |    2 +-
 http-walker.c              |    2 +-
 index-pack.c               |    4 +-
 path.c                     |   22 +++----
 setup.c                    |   36 ++++++++++++
 sha1_file.c                |    2 +-
 t/t0001-init.sh            |   24 +++++++-
 t/t1304-restricted-repo.sh |  132 ++++++++++++++++++++++++++++++++++++++++++++
 14 files changed, 323 insertions(+), 36 deletions(-)
 create mode 100755 t/t1304-restricted-repo.sh
