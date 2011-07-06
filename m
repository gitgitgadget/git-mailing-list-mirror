From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 10/14] revert: Persist data for continuation
Date: Wed, 6 Jul 2011 17:25:33 +0530
Message-ID: <CALkWK0kztvKjfEdx-FTAvU7rNBO2oke8b-Wp3u=yxE9K0WvOCA@mail.gmail.com>
References: <1309938868-2028-1-git-send-email-artagnon@gmail.com>
 <1309938868-2028-11-git-send-email-artagnon@gmail.com> <20110706100119.GG15682@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 06 13:56:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QeQi0-0005k5-Kh
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jul 2011 13:56:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753145Ab1GFLzz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Jul 2011 07:55:55 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:50335 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752661Ab1GFLzy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Jul 2011 07:55:54 -0400
Received: by wyg8 with SMTP id 8so4610493wyg.19
        for <git@vger.kernel.org>; Wed, 06 Jul 2011 04:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=AmSNTUVTyyYWWrQhpw37VbIG9mP50zlSn78/iolslSA=;
        b=pWCvhqRXLh3H1UgpNUvLeMrt17qnwAF+Az3pnmpuIcxUspA3bFSakRTQvtDwcdkAbd
         PxiczaNYChN0FQViYjMpXT1pppwB3B/Z4sNdrbwAVGJKQM3HiuKCdNipgNWFE1sPMGUp
         PDzT3/LhZ6bZ5rYJXwJTOVKE1RT+1wUh0UcEU=
Received: by 10.216.62.3 with SMTP id x3mr5346298wec.77.1309953353105; Wed, 06
 Jul 2011 04:55:53 -0700 (PDT)
Received: by 10.216.175.198 with HTTP; Wed, 6 Jul 2011 04:55:33 -0700 (PDT)
In-Reply-To: <20110706100119.GG15682@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176698>

Hi,

Jonathan Nieder writes:
> Ramkumar Ramachandra wrote:
>> Ever since v1.7.2-rc1~4^2~7 (revert: allow cherry-picking more than
>> one commit, 2010-06-02), a single invocation of "git cherry-pick" or
>> "git revert" can perform picks of several individual commits. =C2=A0=
To
>> implement features like "--continue" to continue the whole operation=
,
>> we will need to store some information about the state and the plan =
at
>> the beginning. =C2=A0Introduce a ".git/sequencer/head" file to store=
 this
>> state, and ".git/sequencer/todo" file to store the plan.
>
> I think I remember Junio being curious about which commit is stored i=
n
> "head"; this might be a good place to put a reminder so future reader=
s
> don't have to be confused.

Oops, I totally forgot -- sorry Junio.
He suggested that we store the corresponding ref also somewhere.  Have
to think about this some more before the next iteration.

>> --- a/builtin/revert.c
>> +++ b/builtin/revert.c
> [...]
>> @@ -25,6 +26,10 @@
>> =C2=A0 * Copyright (c) 2005 Junio C Hamano
>> =C2=A0 */
>>
>> +#define SEQ_DIR =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0"se=
quencer"
>> +#define SEQ_HEAD_FILE =C2=A0 =C2=A0 =C2=A0 =C2=A0"sequencer/head"
>> +#define SEQ_TODO_FILE =C2=A0 =C2=A0 =C2=A0 =C2=A0"sequencer/todo"
>
> Yay. :)

Sorry it took me so long to understand this.  Your elaborate
explanation last time drove the point home.

>> @@ -417,7 +422,7 @@ static int do_pick_commit(struct commit *commit,=
 struct replay_opts *opts)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 return error(_("Your index file is unmerged."));
>> =C2=A0 =C2=A0 =C2=A0 } else {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (get_sha1("HEAD"=
, head))
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 return error(_("You do not have a valid HEAD"));
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 return error(_("Can't %s on an unborn branch"), me);
>
> Remember that "me" is an untranslated command name, and see also
> http://thread.gmane.org/gmane.comp.version-control.git/153026
>
> Perhaps it would make sense to do something like
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (get_sha1("HEAD", head)) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (opts->acti=
on =3D=3D REVERT)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0return error(_("can't revert as initial commit"));
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return error(_=
("cherry-pick into empty head not supported yet"));
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> In a way they feel like different operations, anyway. =C2=A0On the ot=
her
> hand, there's no reason I can think of not to allow reverting a patch
> that only removes files as the initial commit other than not having
> implemented it.

Okay.  That would be unrelated to this patch though -- I'll make it a
separate patch and move it to the beginning of the series.

>> @@ -578,10 +583,106 @@ static void read_and_refresh_cache(const char=
 *me, struct replay_opts *opts)
>> =C2=A0 =C2=A0 =C2=A0 rollback_lock_file(&index_lock);
>> =C2=A0}
>>
>> -static int pick_commits(struct replay_opts *opts)
>> +static void format_todo(struct strbuf *buf, struct commit_list *tod=
o_list,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 struct replay_opts *opts)
>> +{
>> + =C2=A0 =C2=A0 struct commit_list *cur =3D NULL;
>> + =C2=A0 =C2=A0 struct commit_message msg =3D { NULL, NULL, NULL, NU=
LL, NULL };
>> + =C2=A0 =C2=A0 const char *sha1_abbrev =3D NULL;
>> + =C2=A0 =C2=A0 const char *action;
>> +
>> + =C2=A0 =C2=A0 action =3D (opts->action =3D=3D REVERT ? "revert" : =
"pick");
>> + =C2=A0 =C2=A0 for (cur =3D todo_list; cur; cur =3D cur->next) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sha1_abbrev =3D find_uni=
que_abbrev(cur->item->object.sha1, DEFAULT_ABBREV);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (get_message(cur->ite=
m, &msg))
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 die(_("Cannot get commit message for %s"), sha1_abbrev);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 strbuf_addf(buf, "%s %s =
%s\n", action, sha1_abbrev, msg.subject);
>
> Maybe some word like "command", "insn", or "keyword" would be more
> suggestive than "action". =C2=A0It also might be worth mentioning som=
ewhere
> (in the commit message?) that this format is inspired by
> rebase--interactive's insn sheet.

Okay, will do.

> The operation that could be exposed does not include get_revision,
> does it?
>
> =C2=A0/*
> =C2=A0* Example:
> =C2=A0*
> =C2=A0* =C2=A0 =C2=A0 struct commit_list *list;
> =C2=A0* =C2=A0 =C2=A0 struct commit_list **next =3D &list;
> =C2=A0*
> =C2=A0* =C2=A0 =C2=A0 next =3D commit_list_append(c1, next);
> =C2=A0* =C2=A0 =C2=A0 next =3D commit_list_append(c2, next);
> =C2=A0* =C2=A0 =C2=A0 *next =3D NULL;
> =C2=A0* =C2=A0 =C2=A0 assert(commit_list_count(list) =3D=3D 2);
> =C2=A0* =C2=A0 =C2=A0 return list;
> =C2=A0*
> =C2=A0* Don't forget to NULL-terminate!
> =C2=A0*/
> =C2=A0struct commit_list **commit_list_append(struct commit *commit,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s=
truct commit_list **next)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct commit_list *new =3D xmalloc(sizeof=
(*new_list));
> =C2=A0 =C2=A0 =C2=A0 =C2=A0new->item =3D commit;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0*next =3D new;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return &new->next;
> =C2=A0}

I would have done this, but I was worried about what the NULL
termination would mean API-wise.  In retrospect, a lot of APIs
described in Documentation/technical are pretty non-trivial, and it's
not obvious how to use it without the documentation.  Would it be okay
to expose this in commit.c and write some documentation?  I already
have two callers.

>> +static void create_seq_dir(void)
>> +{
>> + =C2=A0 =C2=A0 if (file_exists(git_path(SEQ_DIR))) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!is_directory(git_pa=
th(SEQ_DIR)) && remove_path(git_path(SEQ_DIR)) < 0)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 die(_("Could not remove %s"), git_path(SEQ_DIR));
>> + =C2=A0 =C2=A0 } else if (mkdir(git_path(SEQ_DIR), 0777) < 0)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 die_errno(_("Could not c=
reate sequencer directory '%s'."), git_path(SEQ_DIR));
>> +}
>
> A local variable to cache the git_path result would make this much
> easier to read.

Okay.

>> diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-s=
equence.sh
>> new file mode 100644
>
> Should "chmod +x" so the test can be run directly (I forget to do tha=
t
> all the time).

Good catch.

>> +test_expect_success 'cherry-pick cleans up sequencer directory upon=
 success' '
>> + =C2=A0 =C2=A0 pristine_detach initial &&
>> + =C2=A0 =C2=A0 git cherry-pick initial..picked &&
>> + =C2=A0 =C2=A0 test_path_is_missing .git/sequencer
>> +'
>
> Thanks for thinking about these things. =C2=A0Maybe another test
> demonstrating that the .git/sequencer directory is left behind on
> failure would help put this in context.

Good suggestion.

-- Ram
