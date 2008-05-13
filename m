From: "Imre Deak" <imre.deak@gmail.com>
Subject: Re: [PATCH] builtin-apply: check for empty files when detecting creation patch
Date: Tue, 13 May 2008 23:16:11 +0300
Message-ID: <500f3d130805131316m59898392l46e0dbf7cb352981@mail.gmail.com>
References: <1210257579-30975-1-git-send-email-imre.deak@gmail.com>
	 <7vlk2h8t4d.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 13 22:17:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jw0vz-00019F-0u
	for gcvg-git-2@gmane.org; Tue, 13 May 2008 22:17:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932180AbYEMUQT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2008 16:16:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761905AbYEMUQS
	(ORCPT <rfc822;git-outgoing>); Tue, 13 May 2008 16:16:18 -0400
Received: from fk-out-0910.google.com ([209.85.128.189]:35216 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761253AbYEMUQQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2008 16:16:16 -0400
Received: by fk-out-0910.google.com with SMTP id 18so2432495fkq.5
        for <git@vger.kernel.org>; Tue, 13 May 2008 13:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=AiwihU5/qKzHt7gmpZOBiQMt8xdOjaI9l+GWhmrx9fA=;
        b=UnEzwbJUfVStt9HZdxl20QNxE15bwc4dzmj6uWsiRaE+/1SFrIjB7jetmQkrS/UqcD+TZu3SE2IHGC2Wa6WiqTHTcsX/c3lmFGlrRv155I5rPEjCZiuZ2hptz/GOVoQd9tNdPAgdEq6wDStveQjZEe1hBoRDE/mqOPPStRCwBlw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EukgpXBwDbIYQuU0dj4m3R2OMQm4Wde8cwFpk/UCiwN0Z7418W7mxKiLtpl50jIOklAL7XficBDGOz80XiGUCRjT+j1tgDl9TatCpsfx9jhCVXIOmwcWpfY9ayNyMGFNGQHIXcMdDlcmjTwZA2j9JcYzQxgLis2v1PUdZKe0lpk=
Received: by 10.82.153.12 with SMTP id a12mr16199bue.2.1210709771935;
        Tue, 13 May 2008 13:16:11 -0700 (PDT)
Received: by 10.82.150.11 with HTTP; Tue, 13 May 2008 13:16:11 -0700 (PDT)
In-Reply-To: <7vlk2h8t4d.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82039>

Hi,

thanks for your answer.

On Sun, May 11, 2008 at 5:36 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Imre Deak <imre.deak@gmail.com> writes:
>
>  > When we can only guess if we have a creation patch, we do
>  > this by treating the patch as such if there weren't any old
>  > lines. Zero length files can be patched without old lines
>  > though, so do an extra check for file size.
>
>  You described what your patch does, but you did not explain why it is a
>  good addition.  One way to do so is to illustrate in what occasion what
>  the existing code does is insufficient.

The patch makes it possible to apply foreign patches (not created with
git diff) to zero length files already existing in the index. The problem:

$ git init
Initialized empty Git repository in .git/
$ rm -rf a
$ touch a
$ git add a
$ git commit -madd
Created initial commit 818f2b7: add
 0 files changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 a
$ echo 123 > a.new
$ diff -u a a.new > patch
$ git apply patch
error: a: already exists in working directory

The error happens because git guesses that `patch` is a creation patch
and since `a` already exists in the index it will bail out. With the
modification
foreign patches won't be guessed to be a creation patch if the file to be
patch already exists in the index or the working directory.

>
>
>  > +static size_t existing_file_size(const char *file)
>  > +{
>  > +     size_t st_size = -1;
>  > +
>  > +     if (file == NULL)
>  > +             return -1;
>  > +     if (cached) {
>  > +             struct cache_entry *ce;
>  > +             int pos;
>  > +
>  > +             pos = cache_name_pos(file, strlen(file));
>  > +             if (pos < 0)
>  > +                     return -1;
>  > +             ce = active_cache[pos];
>  > +             st_size = ntohl(ce->ce_size);
>
>  ntohl()?  I thought ce->ce_* are host-native byte order these days...

Sorry, I actually created the patch against an older version. It should be
without ntohl().

>
>
>  > +     } else {
>  > +             struct stat st;
>  > +
>  > +             if (lstat(file, &st) < 0)
>  > +                     return -1;
>
>  Doesn't this break the use case where "git-apply --stat" is used as an
>  improved diffstat outside a git repository?

In that case we'll return error (file doesn't exist) which will leave
the possibility
open to guess the patch to be a creation patch. With the change when
doing --stat the patch might or might not be changed to a creation patch
based on the current working directory content. Though I think this doesn't
result in any difference in the --stat output one could argue that --stat's
operation shouldn't depend in any way on the working directory content
except when --check is specified in addition. So probably we should special
case --stat here...

>
>
>  > @@ -1143,13 +1170,18 @@ static int parse_single_patch(char *line, unsigned long size, struct patch *patc
>  >       if (patch->is_delete < 0 &&
>  >           (newlines || (patch->fragments && patch->fragments->next)))
>  >               patch->is_delete = 0;
>  > +     /* FIXME: How can be there context if it's a creation / deletion? */
>  >       if (!unidiff_zero || context) {
>  >               /* If the user says the patch is not generated with
>  >                * --unified=0, or if we have seen context lines,
>  >                * then not having oldlines means the patch is creation,
>  >                * and not having newlines means the patch is deletion.
>  > +              *
>  > +              * It's also possible that a zero length file is added
>  > +              * to.
>  >                */
>  > -             if (patch->is_new < 0 && !oldlines) {
>  > +             if (patch->is_new < 0 && !oldlines &&
>  > +                 existing_file_size(patch->old_name) != 0) {
>  >                       patch->is_new = 1;
>  >                       patch->old_name = NULL;
>  >               }
>
>  The user did not say the patch was produced without context, or we do have
>  context.  The latter cannot be a creation patch so the new logic is not
>  appropriate.  But let's forget that problem for now and look at the case
>  where the patch did _not_ have any context, i.e. only added and deleted
>  lines.
>
>  If the patch did not have context, and the user did not ask for -u0 patch
>  when it was produced, it could be a creation patch, but if there are
>  deleted lines it cannot be.  That is the original logic.

So as far as I understand creation or deletion patches cannot have any context
lines. If that's correct shouldn't the if clause

if (!unidiff_zero || context)

read instead

if (!unidiff_zero)

?

>
>  After your patch, the original logic is allowed to decide that the patch
>  is a creation _only if_ you happen to already have a file that is _to be
>  created_ in the work tree with some existing contents, or the file does
>  not exist.  I do not see a sane logic behind that.  If you were making
>  sure that the work tree does _not_ have the file, then I would understand,
>  even though I think it is wrong for "apply --stat" case.  If you see a
>  file in the work tree, and if you assume the patch would apply to the
>  work tree, then the patch cannot be creation!

You are right, that condition is wrong. The right one then should be:

existing_file_size(patch->old_name) < 0

>
>  In general, it is not right to look at the work tree to decide how to
>  interpret what the patch means to begin with, but maybe you are trying to
>  use work tree status as a hint to disambiguate a corner case that the
>  information in a patch we are reading is insufficient, in which case it
>  might be Ok.  But I cannot tell what that corner case is.

Hm, I agree with that if it's only a --stat, but if it's --check or
--apply I think
there is no other way to guess if we really have a creation patch or only an
add-to-a-zero-length-file patch.

--Imre

>
>  I am lost.  Please explain what you are trying to fix first before
>  explaining how you attempted to fix it.
