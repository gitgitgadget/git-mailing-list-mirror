From: karsten.blees@dcon.de
Subject: [PATCH] fix deletion of .git/objects sub-directories in git-prune/repack
Date: Tue, 6 Mar 2012 10:18:41 +0100
Message-ID: <OF93114E93.E64C1F7D-ONC12579B9.0032A592-C12579B9.00332D78@dcon.de>
References: <CABPQNSbo5yEosEid_SKoiCS4c8eYAaOHy4skSOBJsef+E6H6Sw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	msysGit <msysgit@googlegroups.com>,
	Pat Thoyts <patthoyts@gmail.com>,
	Stefan Naewe <stefan.naewe@gmail.com>
To: kusmabite@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 06 10:19:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4qY5-00080D-EY
	for gcvg-git-2@plane.gmane.org; Tue, 06 Mar 2012 10:19:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757258Ab2CFJTE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Mar 2012 04:19:04 -0500
Received: from mail.dcon.de ([77.244.111.98]:8548 "EHLO MAIL.DCON.DE"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754964Ab2CFJTB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2012 04:19:01 -0500
In-Reply-To: <CABPQNSbo5yEosEid_SKoiCS4c8eYAaOHy4skSOBJsef+E6H6Sw@mail.gmail.com>
X-Mailer: Lotus Notes Release 7.0.3 September 26, 2007
X-MIMETrack: Serialize by Router on DCON14/DCon(Release 7.0.3FP1|February 24, 2008) at
 06.03.2012 10:18:44,
	Serialize complete at 06.03.2012 10:18:44
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192322>

On some systems (e.g. Windows XP), directories cannot be deleted while
they're open. Both git-prune and git-repack (and thus, git-gc) try to
rmdir while holding a DIR* handle on the directory, leaving dangling
empty directories in the .git/objects store.

Fix it by swapping the rmdir / closedir calls.

Reported-by: John Chen <john0312@gmail.com>
Reported-by: Stefan Naewe <stefan.naewe@gmail.com>
Signed-off-by: Karsten Blees <blees@dcon.de>
---

Erik Faye-Lund <kusmabite@gmail.com> wrote on 05.03.2012 11:26:08:
> On Mon, Mar 5, 2012 at 10:57 AM,  <karsten.blees@dcon.de> wrote:
[...]
> > I thought the delete / rename problems were a Windows illness (at
> > least the retry-ask-user-yes-no logic is exclusive to mingw.c)?
> 
> POSIX allows for this behavior:
> 
> http://pubs.opengroup.org/onlinepubs/009695399/functions/rmdir.html
> 
> (EBUSY: "The directory to be removed is currently in use by the system
> or some process and the implementation considers this to be an
> error.")
> 
> I've found traces of similar issues on exotic unices, so I don't think
> it's completely hypothetical either...
> 
> > And as all mingw stuff
> > is eventually sent upstream (I hope :-)), I don't see a particular
> > reason to rush this one.
> >
> 
> There's no automatic system for this. I tend to send all my patches
> that cleanly fix problems present in git.git directly upstream, so
> people on Windows who doesn't use our branch can benefit from them as
> well.

So what about this one? It applies cleanly to git master, and when
merged / cherry-picked to msysgit devel, the prune-packed.c fix we
already have in b4cb824d is silently ignored.

Note: the is_dir_empty() function in mingw.c is broken in upstream git
as well, but I'm reluctant to backport this as it will clash with the
Unicode patches.

The upstream patch can be pulled from here:
https://github.com/kblees/git/commit/56e1bc62

And cherry-picked to msysgit devel from here:
https://github.com/kblees/git/commit/b07bfd51

Regards,
Karsten


 builtin/prune-packed.c |    2 +-
 builtin/prune.c        |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/prune-packed.c b/builtin/prune-packed.c
index f9463de..a834417 100644
--- a/builtin/prune-packed.c
+++ b/builtin/prune-packed.c
@@ -36,7 +36,6 @@ static void prune_dir(int i, DIR *dir, char *pathname, 
int len, int opts)
                display_progress(progress, i + 1);
        }
        pathname[len] = 0;
-       rmdir(pathname);
 }
 
 void prune_packed_objects(int opts)
@@ -65,6 +64,7 @@ void prune_packed_objects(int opts)
                        continue;
                prune_dir(i, d, pathname, len + 3, opts);
                closedir(d);
+               rmdir(pathname);
        }
        stop_progress(&progress);
 }
diff --git a/builtin/prune.c b/builtin/prune.c
index 58d7cb8..b99b635 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -85,9 +85,9 @@ static int prune_dir(int i, char *path)
                }
                fprintf(stderr, "bad sha1 file: %s/%s\n", path, 
de->d_name);
        }
+       closedir(dir);
        if (!show_only)
                rmdir(path);
-       closedir(dir);
        return 0;
 }
 
-- 
1.7.9.msysgit.1.364.g3e2096
