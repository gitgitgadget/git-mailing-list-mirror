From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 0/3] symref rename/delete fixes
Date: Sun, 26 Oct 2008 03:33:55 +0100
Message-ID: <cover.1224987944.git.vmiklos@frugalware.org>
References: <7v8wsca5ne.fsf@gitster.siamese.dyndns.org>
Cc: Jeff King <peff@peff.net>, Brandon Casey <casey@nrlssc.navy.mil>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 26 03:34:46 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KtvSm-0001cv-9B
	for gcvg-git-2@gmane.org; Sun, 26 Oct 2008 03:34:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751792AbYJZCdU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Oct 2008 22:33:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751871AbYJZCdS
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Oct 2008 22:33:18 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:53273 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751376AbYJZCdQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Oct 2008 22:33:16 -0400
Received: from vmobile.example.net (catv-80-98-230-81.catv.broadband.hu [80.98.230.81])
	by yugo.frugalware.org (Postfix) with ESMTPA id D0DE2446CCF;
	Sun, 26 Oct 2008 03:33:13 +0100 (CET)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 7148214E35; Sun, 26 Oct 2008 03:33:59 +0100 (CET)
X-Mailer: git-send-email 1.6.0.2
In-Reply-To: <7v8wsca5ne.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99137>

On Sat, Oct 25, 2008 at 11:31:01AM -0700, Junio C Hamano <gitster@pobox.com> wrote:
> > +int delete_ref(const char *refname, const unsigned char *sha1, int
> > flags)
> >  {
> >     struct ref_lock *lock;
> > -   int err, i, ret = 0, flag = 0;
> > +   int err, i = 0, ret = 0, flag = 0;
> > +   char *path;

> Two variables flag vs flags is a bit confusing, isn't it?  How about
> naming the new one "delopt" or something?

Renamed.

> The new variable "char *path" at the toplevel can be confined in the
> scope
> of this if () {} block and probably can become "const char *", right?

Yes - moved.

> >     int log = !lstat(git_path("logs/%s", oldref), &loginfo);
> > +   const char *symref = NULL;
> > +   int is_symref = 0;
> >
> >     if (S_ISLNK(loginfo.st_mode))
> >             return error("reflog for %s is a symlink", oldref);
>
> Possible bug in the context.  When there is no reflog for the ref
> being
> renamed, lstat would fail; it doesn't feel right to have this
> S_ISLNK()
> before checking the result of the lstat which is in "log".

OK, this went to a separate patch.

> > +   symref = resolve_ref(oldref, orig_sha1, 0, &flag);
> > +   if (flag & REF_ISSYMREF)
> > +           is_symref = 1;
> >     if (!resolve_ref(oldref, orig_sha1, 1, &flag))
> >             return error("refname %s not found", oldref);
>
> Do we really need two calls to resolve_ref()?  Your new call calls it
> without must-exist bit --- why?  Immediately after that, the existing
> call
> will barf if it does not exist anyway.

Just having

        if (!symref)
                return error("refname %s not found", oldref);

first looks weird, given that the error message is not "refname %s is
not a symref", but you are right, changed.

> I agree it is good to have symref aware delete_ref(), but I am not
> sure
> supporting symref in rename_ref() is either needed or necessarily a
> good
> idea.  You also need to worry about a symref pointing at a branch yet
> to
> be born.

That is currently not supported and the error message of 'git branch -m'
is (in case foo points to refs/heads/bar and bar is not yet born):

error: refname refs/heads/foo not found
fatal: Branch rename failed

which is quite acceptable, IMHO[1].

> In the meantime, I think we should just check (flag & REF_ISSYMREF)
> after
> the existing resolve_ref() we can see in the context above, and error
> out
> saying you cannot rename a symref, and do nothing else.

A symref-aware rename_ref() is needed by git remove rename, since it
typically does origin/HEAD -> upstream/HEAD symref renames there.

Of course you can say that this should be handled by git-remote itself,
without using rename_ref() but that not seem to be a good solution to
me. (Workaround in the wrong layer, instead of a solution in a good
one.)

[1] I mean, I have a real-world scenario (git remove rename) for "why
renaming a symref is a good idea", but I don't think renaming a ref
pointing to a yet-to-be-born ref has any real world users.

Miklos Vajna (3):
  Fix git branch -m for symrefs.
  rename_ref(): handle the case when the reflog of a ref does not exist
  Fix git update-ref --no-deref -d.

 builtin-branch.c       |    2 +-
 builtin-receive-pack.c |    2 +-
 builtin-remote.c       |    4 +-
 builtin-reset.c        |    2 +-
 builtin-send-pack.c    |    2 +-
 builtin-tag.c          |    2 +-
 builtin-update-ref.c   |    8 ++++--
 cache.h                |    2 +-
 refs.c                 |   61 +++++++++++++++++++++++++++++------------------
 t/t1400-update-ref.sh  |    7 +++++
 t/t3200-branch.sh      |    9 +++++++
 11 files changed, 67 insertions(+), 34 deletions(-)

Also available in the 'symref-mv' branch of 'git://repo.or.cz/git/vmiklos.git'.
