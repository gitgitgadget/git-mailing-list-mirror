From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 6/8] revert: Introduce head, todo, done files to persist state
Date: Fri, 13 May 2011 15:51:30 +0530
Message-ID: <20110513102127.GH14272@ramkum.desktop.amazon.com>
References: <1305100822-20470-1-git-send-email-artagnon@gmail.com> <1305100822-20470-7-git-send-email-artagnon@gmail.com> <20110511124657.GG2676@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 13 12:21:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKpVF-0006LS-2I
	for gcvg-git-2@lo.gmane.org; Fri, 13 May 2011 12:21:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758523Ab1EMKVl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 May 2011 06:21:41 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:56183 "EHLO
	smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758492Ab1EMKVj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2011 06:21:39 -0400
X-IronPort-AV: E=Sophos;i="4.64,363,1301875200"; 
   d="scan'208";a="699847018"
Received: from smtp-in-0102.sea3.amazon.com ([10.224.19.46])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 13 May 2011 10:21:37 +0000
Received: from ramkum.desktop.amazon.com (ramkum.desktop.amazon.com [172.25.205.64])
	by smtp-in-0102.sea3.amazon.com (8.13.8/8.13.8) with ESMTP id p4DALZID015514;
	Fri, 13 May 2011 10:21:36 GMT
Received: by ramkum.desktop.amazon.com (Postfix, from userid 272482)
	id 3EFED75483F; Fri, 13 May 2011 15:51:30 +0530 (IST)
Content-Disposition: inline
In-Reply-To: <20110511124657.GG2676@elie>
User-Agent: Mutt/1.4.2.2i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173523>

Hi,

Jonathan Nieder writes:
> Ramkumar Ramachandra wrote:
>=20
> > A cherry-pick/ revert operation consists of several smaller steps.
> > Later in the series, we would like to be able to resume a failed
> > operation.
>=20
> When introducing jargon, it is hard to make the intent perfectly
> clear.  I suppose what this means is:
>=20
>  Ever since v1.7.2-rc1~4^2~7 (revert: allow cherry-picking more than
>  one commit, 2010-06-02), a single invocation of "git cherry-pick"
>  or "git revert" can perform picks of several individual commits.  To
>  allow "git cherry-pick --abort" to cancel and "git cherry-pick
>  --continue" to resume the entire command, we will need to store some
>  information about the state and the plan at the beginning.

Thanks for digging that up for me.  I'll try to reword it in the next
iteration without introducing more jargon, if that's preferred.

> > Introduce a "head" file to make note of the HEAD when
> > the operation stated (so that the operation can be aborted), a "tod=
o"
> > file to keep the list of the steps to be performed, and a "done" fi=
le
> > to keep a list of steps that have completed successfully.  The form=
at
> > of these files is similar to the one used by the "rebase -i" proces=
s.
>=20
> s/stated/started/ :)  Makes some sense, aside from that.
>=20
> It would be more conventional to use all-caps symref-like names, like
> MULTIPLE_CHERRY_PICK_ORIG_HEAD, CHERRY_PICK_TODO, and
> CHERRY_PICK_DONE, or to put these files in a subdirectory (oh, they'r=
e
> already in a subdirectory?  Why didn't you mention that? :)).

I'll mention that in the commit message next time.

> By the way, what is .git/sequencer/done used for?

I don't know :p
I just added it because "rebase -i" uses it too, although I can't find
a definite usecase for it.

> > --- a/builtin/revert.c
> > +++ b/builtin/revert.c
> > @@ -25,6 +26,13 @@
> >   * Copyright (c) 2005 Junio C Hamano
> >   */
> > =20
> > +#define SEQ_DIR "sequencer"
> > +
> > +#define SEQ_PATH	git_path(SEQ_DIR)
> > +#define HEAD_FILE	git_path(SEQ_DIR "/head")
> > +#define TODO_FILE	git_path(SEQ_DIR "/todo")
> > +#define DONE_FILE	git_path(SEQ_DIR "/done")
>=20
> These seeming constants that call a function are kind of scary.

Uh, you'd prefer seeing it literally spelt out over and over again?

> > @@ -629,21 +637,118 @@ static int read_and_refresh_cache(struct rep=
lay_opts *opts)
> >  	return 0;
> >  }
> > =20
> > +static int format_todo(struct strbuf *buf, struct commit_list *lis=
t,
> > +			struct replay_opts *opts)
> > +{
> > +	struct commit_list *cur =3D NULL;
> > +	struct commit_message msg =3D { NULL, NULL, NULL, NULL, NULL };
> > +	const char *sha1 =3D NULL;
> > +	const char *action;
> > +
> > +	action =3D (opts->action =3D=3D REVERT ? "revert" : "pick");
> > +	for (cur =3D list; cur; cur =3D cur->next) {
> > +		sha1 =3D find_unique_abbrev(cur->item->object.sha1, DEFAULT_ABBR=
EV);
> > +		if (get_message(cur->item, cur->item->buffer, &msg))
> > +			return error(_("Cannot get commit message for %s"), sha1);
> > +		strbuf_addf(buf, "%s %s %s\n", action, sha1, msg.subject);
>=20
> Is this internal state or for the user?  If it is internal state, I'd
> na=EFvely have expected a sequence of 40-character hexadecimal lines,
> perhaps with human-readable names like "topic~3" for the sake of
> error messages if git knows about them.

=46or the user.  This is the instruction sheet that the user will be
able to edit at a later stage, when we develop something like
"sequencer -i".

> > +static int persist_initialize(unsigned char *head)
> > +{
> > +	struct strbuf buf =3D STRBUF_INIT;
> > +	int fd;
> > +
> > +	if (!file_exists(SEQ_PATH) && mkdir(SEQ_PATH, 0777)) {
>=20
> What if .git/sequencer exists and is a file?  How does this interact
> with "[core] sharedrepository" configuration?  What happens if
> .git/sequencer contains some stale files --- if the power fails while
> git is writing new files in .git/sequencer/, will the state be
> confusing?

Ah, thanks for pointing these out -- I hadn't thought about them earlie=
r.

> > +		int err =3D errno;
> > +		strbuf_release(&buf);
> > +		error(_("Could not create sequencer directory '%s': %s"),
> > +			SEQ_PATH, strerror(err));
> > +		return -err;
>=20
> Why does the caller care about which errno, and what is it going to
> do with that information?

Hm, error_errno seems that consistently returns -1 seems like a good
idea now.  I'll get it back into the series next time.

> > +	}
> > +
> > +	if ((fd =3D open(HEAD_FILE, O_WRONLY | O_CREAT | O_TRUNC, 0666)) =
< 0) {
>=20
> More idiomatic in the git codebase to write:
>=20
> 	fd =3D open(...);
> 	if (fd < 0) {

Ok.

> > +		int err =3D errno;
> > +		strbuf_release(&buf);
> > +		error(_("Could not open '%s' for writing: %s"),
> > +			HEAD_FILE, strerror(err));
> > +		return -err;
>=20
> As above.  Why does the caller care about errno?  If backing out afte=
r
> an error, I suppose it might make sense to rmdir .git/sequencer while
> at it.

Ok.

> > +	}
> > +
> > +	strbuf_addf(&buf, "%s", find_unique_abbrev(head, DEFAULT_ABBREV))=
;
>=20
> Why abbreviate?
>=20
> > +	write_or_whine(fd, buf.buf, buf.len, HEAD_FILE);
>=20
> What happens and should happen on error?



> [...]
> > +static int persist_todo_done(int res, struct commit_list *todo_lis=
t,
> > +			struct commit_list *done_list, struct replay_opts *opts)
>=20
> This is about recording what has been done and what remains to
> be done?  What does the res argument represent?

Exit status? I have to think back to figure out why I chose to pass it
around like this.

> > +{
> > +	struct strbuf buf =3D STRBUF_INIT;
> > +	int fd, res2;
> > +
> > +	if (!res)
> > +		return 0;
> > +
> > +	/* TODO file */
> > +	if ((fd =3D open(TODO_FILE, O_WRONLY | O_CREAT | O_TRUNC, 0666)) =
< 0) {
>=20
> What happens if we are interrupted in the middle of writing this?

I'll use the lockfile API if I have time before the next iteration.

> > +		int err =3D errno;
> > +		strbuf_release(&buf);
> > +		error(_("Could not open '%s' for writing: %s"),
> > +			TODO_FILE, strerror(err));
> > +		return -err;
>=20
> I don't think the caller should care which errno. :)

Right :)

> [...]
> >  static int pick_commits(struct replay_opts *opts)
> >  {
> > +	struct commit_list *done_list =3D NULL;
> >  	struct rev_info revs;
> >  	struct commit *commit;
> > +	unsigned char head[20];
> >  	int res;
> > =20
> > +	if (get_sha1("HEAD", head))
> > +		return error(_("You do not have a valid HEAD"));
>=20
> What should happen if I try to cherry-pick onto an unborn branch?  I
> haven't checked what happens.

fatal: You do not have a valid HEAD
I just tried it :)

> > +
> >  	if ((res =3D read_and_refresh_cache(opts)) ||
> > -		(res =3D prepare_revs(&revs, opts)))
> > +		(res =3D prepare_revs(&revs, opts)) ||
> > +		(res =3D persist_initialize(head)))
> >  		return res;
> > =20
> > -	while ((commit =3D get_revision(&revs)) &&
> > -		!(res =3D do_pick_commit(commit, opts)))
> > -		;
> > -
> > -	return res;
> > +	while ((commit =3D get_revision(&revs))) {
> > +		if (!(res =3D do_pick_commit(commit, opts)))
> > +			commit_list_insert(commit, &done_list);
>=20
> This puts done_list in the reverse order that the commits were
> cherry-picked.  Is that the intent?

Yes, although I'm not sure what to do with the done file now (you
pointed that out earlier).

> > +		else {
> > +			commit_list_insert(commit, &revs.commits);
> > +			break;
> > +		}
> > +	}
> > +	return persist_todo_done(res, revs.commits, done_list, opts);
>=20
> A few potential trade-offs:
>=20
>  - should cherry-pick record the state after every commit?  This woul=
d
>    be safe against stray die() calls or segfaults but requires hittin=
g
>    the filesystem which might not be wanted if doing a run of
>    cherry-picks in memory (though git is far from supporting such a
>    "many cherry picks in core followed by checkout and packed
>    collection of objects written to disk all at once" optimization
>    anyway).

Agreed, but I don't think this kind of optimization will be in the
scope of this series.  It's nice to think about though.

>  - should we use O_TRUNC or O_APPEND to modify the state in-place or
>    use separate files and rename them into place?  The latter is
>    safer against sudden exit.

The latter, definitely.  I don't want to have to deal with malformed
instruction sheets.

>  - should we (perhaps optionally) fsync the state when commiting to i=
t?
>    I think no, but someone performing a rebase and running a test sui=
te
>    with the potential to crash the system between commits might appre=
ciate
>    the effort.

Yes, yes! I'd love this feature.

Thanks.

-- Ram
