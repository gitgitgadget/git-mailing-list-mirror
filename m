From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 6/8] revert: Introduce head, todo, done files to persist
 state
Date: Wed, 11 May 2011 07:47:18 -0500
Message-ID: <20110511124657.GG2676@elie>
References: <1305100822-20470-1-git-send-email-artagnon@gmail.com>
 <1305100822-20470-7-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 11 17:38:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKBUP-0005kj-FK
	for gcvg-git-2@lo.gmane.org; Wed, 11 May 2011 17:38:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752658Ab1EKPhg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 May 2011 11:37:36 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:52421 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752415Ab1EKPhd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 May 2011 11:37:33 -0400
Received: by iyb14 with SMTP id 14so430740iyb.19
        for <git@vger.kernel.org>; Wed, 11 May 2011 08:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=Lsnh7dw12OsAIC0fGMl5UlWz6axGkisd3Ya5s+6R9Ro=;
        b=fNhkZNJ9jbCF1Tc3on1e8ZC9u7VXpHuknEP4DOugnfRqdT68UWYAPvtJpxaFW1iR5W
         t0e7RwzMxua3970knib0FsTu3CMMEM7muio028luv6V2hTTR6GhSuJk+gwho5Otxmdvw
         Rp5j2eTX8sRTF0ZsSBH6muVik3RyjfnMkIiDA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=fvM76YatwEDl8VdC7IcsdxxMX6gYBBW/QAiMrLq+ug5clOus4UT39w5AdLkjEe3JWK
         jgY9p0KM3BLYi/9fMMipaYB76HsV8hBCfu7TR0F2eLSXLqzrerxHQ5D5wYyoQ3hHoBca
         uxNdmqgmVth5Up/VSgDqXpDGFWi8Ux8Z1AJNg=
Received: by 10.42.213.132 with SMTP id gw4mr9960942icb.59.1305118043532;
        Wed, 11 May 2011 05:47:23 -0700 (PDT)
Received: from elie (adsl-69-209-56-134.dsl.chcgil.ameritech.net [69.209.56.134])
        by mx.google.com with ESMTPS id uh10sm32557icb.18.2011.05.11.05.47.21
        (version=SSLv3 cipher=OTHER);
        Wed, 11 May 2011 05:47:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1305100822-20470-7-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173390>

Ramkumar Ramachandra wrote:

> A cherry-pick/ revert operation consists of several smaller steps.
> Later in the series, we would like to be able to resume a failed
> operation.

When introducing jargon, it is hard to make the intent perfectly
clear.  I suppose what this means is:

 Ever since v1.7.2-rc1~4^2~7 (revert: allow cherry-picking more than
 one commit, 2010-06-02), a single invocation of "git cherry-pick"
 or "git revert" can perform picks of several individual commits.  To
 allow "git cherry-pick --abort" to cancel and "git cherry-pick
 --continue" to resume the entire command, we will need to store some
 information about the state and the plan at the beginning.

> Introduce a "head" file to make note of the HEAD when
> the operation stated (so that the operation can be aborted), a "todo"
> file to keep the list of the steps to be performed, and a "done" file
> to keep a list of steps that have completed successfully.  The format
> of these files is similar to the one used by the "rebase -i" process.

s/stated/started/ :)  Makes some sense, aside from that.

It would be more conventional to use all-caps symref-like names, like
MULTIPLE_CHERRY_PICK_ORIG_HEAD, CHERRY_PICK_TODO, and
CHERRY_PICK_DONE, or to put these files in a subdirectory (oh, they're
already in a subdirectory?  Why didn't you mention that? :)).

By the way, what is .git/sequencer/done used for?

> --- a/builtin/revert.c
> +++ b/builtin/revert.c
> @@ -25,6 +26,13 @@
>   * Copyright (c) 2005 Junio C Hamano
>   */
> =20
> +#define SEQ_DIR "sequencer"
> +
> +#define SEQ_PATH	git_path(SEQ_DIR)
> +#define HEAD_FILE	git_path(SEQ_DIR "/head")
> +#define TODO_FILE	git_path(SEQ_DIR "/todo")
> +#define DONE_FILE	git_path(SEQ_DIR "/done")

These seeming constants that call a function are kind of scary.

> @@ -629,21 +637,118 @@ static int read_and_refresh_cache(struct repla=
y_opts *opts)
>  	return 0;
>  }
> =20
> +static int format_todo(struct strbuf *buf, struct commit_list *list,
> +			struct replay_opts *opts)
> +{
> +	struct commit_list *cur =3D NULL;
> +	struct commit_message msg =3D { NULL, NULL, NULL, NULL, NULL };
> +	const char *sha1 =3D NULL;
> +	const char *action;
> +
> +	action =3D (opts->action =3D=3D REVERT ? "revert" : "pick");
> +	for (cur =3D list; cur; cur =3D cur->next) {
> +		sha1 =3D find_unique_abbrev(cur->item->object.sha1, DEFAULT_ABBREV=
);
> +		if (get_message(cur->item, cur->item->buffer, &msg))
> +			return error(_("Cannot get commit message for %s"), sha1);
> +		strbuf_addf(buf, "%s %s %s\n", action, sha1, msg.subject);

Is this internal state or for the user?  If it is internal state, I'd
na=C3=AFvely have expected a sequence of 40-character hexadecimal lines=
,
perhaps with human-readable names like "topic~3" for the sake of
error messages if git knows about them.

> +static int persist_initialize(unsigned char *head)
> +{
> +	struct strbuf buf =3D STRBUF_INIT;
> +	int fd;
> +
> +	if (!file_exists(SEQ_PATH) && mkdir(SEQ_PATH, 0777)) {

What if .git/sequencer exists and is a file?  How does this interact
with "[core] sharedrepository" configuration?  What happens if
=2Egit/sequencer contains some stale files --- if the power fails while
git is writing new files in .git/sequencer/, will the state be
confusing?

> +		int err =3D errno;
> +		strbuf_release(&buf);
> +		error(_("Could not create sequencer directory '%s': %s"),
> +			SEQ_PATH, strerror(err));
> +		return -err;

Why does the caller care about which errno, and what is it going to
do with that information?

> +	}
> +
> +	if ((fd =3D open(HEAD_FILE, O_WRONLY | O_CREAT | O_TRUNC, 0666)) < =
0) {

More idiomatic in the git codebase to write:

	fd =3D open(...);
	if (fd < 0) {

> +		int err =3D errno;
> +		strbuf_release(&buf);
> +		error(_("Could not open '%s' for writing: %s"),
> +			HEAD_FILE, strerror(err));
> +		return -err;

As above.  Why does the caller care about errno?  If backing out after
an error, I suppose it might make sense to rmdir .git/sequencer while
at it.

> +	}
> +
> +	strbuf_addf(&buf, "%s", find_unique_abbrev(head, DEFAULT_ABBREV));

Why abbreviate?

> +	write_or_whine(fd, buf.buf, buf.len, HEAD_FILE);

What happens and should happen on error?

[...]
> +static int persist_todo_done(int res, struct commit_list *todo_list,
> +			struct commit_list *done_list, struct replay_opts *opts)

This is about recording what has been done and what remains to
be done?  What does the res argument represent?

> +{
> +	struct strbuf buf =3D STRBUF_INIT;
> +	int fd, res2;
> +
> +	if (!res)
> +		return 0;
> +
> +	/* TODO file */
> +	if ((fd =3D open(TODO_FILE, O_WRONLY | O_CREAT | O_TRUNC, 0666)) < =
0) {

What happens if we are interrupted in the middle of writing this?

> +		int err =3D errno;
> +		strbuf_release(&buf);
> +		error(_("Could not open '%s' for writing: %s"),
> +			TODO_FILE, strerror(err));
> +		return -err;

I don't think the caller should care which errno. :)

[...]
>  static int pick_commits(struct replay_opts *opts)
>  {
> +	struct commit_list *done_list =3D NULL;
>  	struct rev_info revs;
>  	struct commit *commit;
> +	unsigned char head[20];
>  	int res;
> =20
> +	if (get_sha1("HEAD", head))
> +		return error(_("You do not have a valid HEAD"));

What should happen if I try to cherry-pick onto an unborn branch?  I
haven't checked what happens.

> +
>  	if ((res =3D read_and_refresh_cache(opts)) ||
> -		(res =3D prepare_revs(&revs, opts)))
> +		(res =3D prepare_revs(&revs, opts)) ||
> +		(res =3D persist_initialize(head)))
>  		return res;
> =20
> -	while ((commit =3D get_revision(&revs)) &&
> -		!(res =3D do_pick_commit(commit, opts)))
> -		;
> -
> -	return res;
> +	while ((commit =3D get_revision(&revs))) {
> +		if (!(res =3D do_pick_commit(commit, opts)))
> +			commit_list_insert(commit, &done_list);

This puts done_list in the reverse order that the commits were
cherry-picked.  Is that the intent?

> +		else {
> +			commit_list_insert(commit, &revs.commits);
> +			break;
> +		}
> +	}
> +	return persist_todo_done(res, revs.commits, done_list, opts);

A few potential trade-offs:

 - should cherry-pick record the state after every commit?  This would
   be safe against stray die() calls or segfaults but requires hitting
   the filesystem which might not be wanted if doing a run of
   cherry-picks in memory (though git is far from supporting such a
   "many cherry picks in core followed by checkout and packed
   collection of objects written to disk all at once" optimization
   anyway).

 - should we use O_TRUNC or O_APPEND to modify the state in-place or
   use separate files and rename them into place?  The latter is
   safer against sudden exit.

 - should we (perhaps optionally) fsync the state when commiting to it?
   I think no, but someone performing a rebase and running a test suite
   with the potential to crash the system between commits might appreci=
ate
   the effort.
