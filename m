From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 11/17] revert: Save data for continuing after conflict resolution
Date: Sun, 17 Jul 2011 17:18:31 +0530
Message-ID: <CALkWK0nyu6W2Nd=qcrjZZwkAdFGqTqAe53FmecS_n2cK_4UWMg@mail.gmail.com>
References: <1310396048-24925-1-git-send-email-artagnon@gmail.com>
 <1310396048-24925-12-git-send-email-artagnon@gmail.com> <20110712193716.GB14909@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 17 13:49:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QiPqy-0000th-SN
	for gcvg-git-2@lo.gmane.org; Sun, 17 Jul 2011 13:49:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755684Ab1GQLsx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 17 Jul 2011 07:48:53 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:59487 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753796Ab1GQLsw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Jul 2011 07:48:52 -0400
Received: by wyg8 with SMTP id 8so1583292wyg.19
        for <git@vger.kernel.org>; Sun, 17 Jul 2011 04:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=kD14zcqzk/Z/Q9SGozlvVgqjwSUFS2Bzz3BZgX2EyJk=;
        b=wtJgLzSorFl2KMC6An1fAdsQ2ZgQRfqYky7kUoBVqz7iNOR/UYleMQosoCyAiLTG2Z
         AqaJUAaEbYQWiAqiGwgx3vRNx3Rfii2yOVJcpv7rBAW5Wc8sPMlyYqCMneE8XbH+06Ol
         ZjsLroUTi527l6SUkVu5RCWuwJjarYoGBnEiY=
Received: by 10.216.70.14 with SMTP id o14mr4978754wed.111.1310903331113; Sun,
 17 Jul 2011 04:48:51 -0700 (PDT)
Received: by 10.216.234.143 with HTTP; Sun, 17 Jul 2011 04:48:31 -0700 (PDT)
In-Reply-To: <20110712193716.GB14909@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177296>

Hi again,

Jonathan Nieder writes:
> Ramkumar Ramachandra wrote:
>
>> It is imperative to note that these two files alone are not enough t=
o
>> implement "--continue"; we will also need to persist the options tha=
t
>> were specified on the command-line, and this is done later in the
>> series.
>
> I think you could remove the phrase "It is imperative to note that"
> and this would say the same thing. :)
>
> By the way, those two files are enough to implement --continue in som=
e
> sense, no? =C2=A0One implementation of --continue would forget option=
s
> passed on the first run and require the user to specify them again; i=
t
> would just be less useful. =C2=A0The reminder that "head" and "todo" =
are
> not the only files in the .git/sequencer dir is useful, though; thank=
s
> for it.

New commit message:

revert: Save data for continuing after conflict resolution

Ever since v1.7.2-rc1~4^2~7 (revert: allow cherry-picking more than
one commit, 2010-06-02), a single invocation of "git cherry-pick" or
"git revert" can perform picks of several individual commits.  To
implement features like "--continue" to continue the whole operation,
we will need to store some information about the state and the plan at
the beginning.  Introduce a ".git/sequencer/head" file to store this
state, and ".git/sequencer/todo" file to store the plan.  The head
file contains the SHA-1 of the HEAD before the start of the operation,
and the todo file contains an instruction sheet whose format is
inspired by the format of the "rebase -i" instruction sheet.  As a
result, a typical todo file looks like:

pick 8537f0e submodule add: test failure when url is not configured
pick 4d68932 submodule add: allow relative repository path
pick f22a17e submodule add: clean up duplicated code
pick 59a5775 make copy_ref globally available

Since SHA-1 hex is abbreviated using an find_unique_abbrev(), it is
unambiguous.  This does not guarantee that there will be no ambiguity
when more objects are added to the repository.

That these two files alone are not enough to implement a "--continue"
that remembers the command-line options specified; later patches in
the series save them too.

These new files are unrelated to the existing .git/CHERRY_PICK_HEAD,
which will still be useful while committing after a conflict
resolution.

>> --- a/builtin/revert.c
>> +++ b/builtin/revert.c
> [...]
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
> This die() seems odd in the context of a series that starts by
> converting various die() calls to "return error()".

=46ixed.  I made format_todo return an int now.

>> +static struct commit *parse_insn_line(char *start, struct replay_op=
ts *opts)
>> +{
>> + =C2=A0 =C2=A0 unsigned char commit_sha1[20];
>> + =C2=A0 =C2=A0 char sha1_abbrev[40];
>> + =C2=A0 =C2=A0 struct commit *commit;
>> + =C2=A0 =C2=A0 enum replay_action action;
>> + =C2=A0 =C2=A0 int insn_len =3D 0;
>> + =C2=A0 =C2=A0 char *p;
>> +
>> + =C2=A0 =C2=A0 p =3D start;
>> + =C2=A0 =C2=A0 if (!(p =3D strchr(p, ' ')))
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;
>
> Style: it is much, much clearer to write
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0p =3D strchr(start, ' ');
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!p)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return NULL;
>
> In the git codebase, assignments in "if" conditionals are very rare, =
so
> code like the above sticks out.
>
>> + =C2=A0 =C2=A0 insn_len =3D p - start;
>> + =C2=A0 =C2=A0 if (!(p =3D strchr(p + 1, ' ')))
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;
>> + =C2=A0 =C2=A0 p +=3D 1;
>
> Likewise. =C2=A0This could say:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0insn_len =3D p - start;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0p =3D strchr(p + 1, ' ');
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!p)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return NULL;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0p++;

Right, got it.  Fixed.

>> + =C2=A0 =C2=A0 if (!strncmp(start, "pick", insn_len))
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 action =3D CHERRY_PICK;
>> + =C2=A0 =C2=A0 else if (!strncmp(start, "revert", insn_len))
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 action =3D REVERT;
>
> This code means that "p", "pi", and "pic" are accepted as
> abbreviations for "pick". =C2=A0 Maybe a comment would help to clarif=
y
> that. =C2=A0Are we okay with reserving these names, so "r" in a todo
> file means to "revert" and not to "reword" like it does in a
> rebase -i todo list?

That was the original intent, but I clearly hadn't thought about it
hard enough.  Changed this to accept only full words.

>> + =C2=A0 =C2=A0 /*
>> + =C2=A0 =C2=A0 =C2=A0* Verify that the action matches up with the o=
ne in
>> + =C2=A0 =C2=A0 =C2=A0* opts; we don't support arbitrary instruction=
s
>> + =C2=A0 =C2=A0 =C2=A0*/
>> + =C2=A0 =C2=A0 if (action !=3D opts->action)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;
>
> If I try "git cherry-pick foo..bar" and then "git revert --continue",
> what error message will I get?

fatal: Malformed instruction sheet: .git/sequencer/todo
Technically speaking, this is correct.  However, this may not be ideal
from an end-user's perspective.  Anyway, this is going to change soon
-- do you think this is worth correcting here and now?

>> +static void read_populate_todo(struct commit_list **todo_list,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 struct replay_opts *opts)
>> +{
> [...]
>> + =C2=A0 =C2=A0 for (p =3D buf.buf; *p; p =3D strchr(p, '\n') + 1) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!(commit =3D parse_i=
nsn_line(p, opts)))
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 goto error;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 new =3D xmalloc(sizeof(s=
truct commit_list));
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 new->item =3D commit;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *next =3D new;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 next =3D &new->next;
>
> commit_list_append()?

Ugh.  Fixed.

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
> As mentioned in [1], a local would make this more readable. =C2=A0And=
 it's
> not clear to me why one would want to delete a .git/sequencer file
> that the user carefully placed there (I don't think git itself ever
> writes such a thing).

Okay,  removed that hunk.

>> +static void save_head(const char *head)
>> +{
>> + =C2=A0 =C2=A0 static struct lock_file head_lock;
>> + =C2=A0 =C2=A0 struct strbuf buf =3D STRBUF_INIT;
>> + =C2=A0 =C2=A0 int fd;
>> +
>> + =C2=A0 =C2=A0 fd =3D hold_lock_file_for_update(&head_lock, git_pat=
h(SEQ_HEAD_FILE), LOCK_DIE_ON_ERROR);
>> + =C2=A0 =C2=A0 strbuf_addf(&buf, "%s\n", head);
>> + =C2=A0 =C2=A0 if (write_in_full(fd, buf.buf, buf.len) < 0)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 die_errno(_("Could not w=
rite to %s."), git_path(SEQ_HEAD_FILE));
>> + =C2=A0 =C2=A0 if (commit_lock_file(&head_lock) < 0)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 die(_("Error wrapping up=
 %s"), git_path(SEQ_HEAD_FILE));
>> +}
>
> A local would be helpful here, too.
>
>> +static void save_todo(struct commit_list *todo_list, struct replay_=
opts *opts)
>> +{
>> + =C2=A0 =C2=A0 static struct lock_file todo_lock;
>> + =C2=A0 =C2=A0 struct strbuf buf =3D STRBUF_INIT;
>> + =C2=A0 =C2=A0 int fd;
>> +
>> + =C2=A0 =C2=A0 fd =3D hold_lock_file_for_update(&todo_lock, git_pat=
h(SEQ_TODO_FILE), LOCK_DIE_ON_ERROR);
>> + =C2=A0 =C2=A0 format_todo(&buf, todo_list, opts);
>> + =C2=A0 =C2=A0 if (write_in_full(fd, buf.buf, buf.len) < 0) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 strbuf_release(&buf);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 die_errno(_("Could not w=
rite to %s."), git_path(SEQ_TODO_FILE));
>> + =C2=A0 =C2=A0 }
>> + =C2=A0 =C2=A0 if (commit_lock_file(&todo_lock) < 0) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 strbuf_release(&buf);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 die(_("Error wrapping up=
 %s"), git_path(SEQ_TODO_FILE));
>> + =C2=A0 =C2=A0 }
>> + =C2=A0 =C2=A0 strbuf_release(&buf);
>> +}
>
> Likewise here. =C2=A0As mentioned before, git_path() clobbers errno, =
so the
> above is likely to print a wrong error message on some systems (e.g.,
> "fatal: Cannot write to .git/sequencer/todo: Success").

=46ixed these.  Thanks.

>> +static int pick_commits(struct replay_opts *opts)
>> +{
>> + =C2=A0 =C2=A0 struct commit_list *todo_list =3D NULL;
>> + =C2=A0 =C2=A0 unsigned char sha1[20];
>> + =C2=A0 =C2=A0 struct commit_list *cur;
>> + =C2=A0 =C2=A0 int res;
>>
>> =C2=A0 =C2=A0 =C2=A0 setenv(GIT_REFLOG_ACTION, me, 0);
>> =C2=A0 =C2=A0 =C2=A0 if (opts->allow_ff)
>> @@ -580,14 +764,24 @@ static int pick_commits(struct replay_opts *op=
ts)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 opts->record_origin || opts->edit))=
;
>> =C2=A0 =C2=A0 =C2=A0 read_and_refresh_cache(me, opts);
>>
>> - =C2=A0 =C2=A0 prepare_revs(&revs, opts);
>> + =C2=A0 =C2=A0 walk_revs_populate_todo(&todo_list, opts);
>> + =C2=A0 =C2=A0 create_seq_dir();
>> + =C2=A0 =C2=A0 if (!get_sha1("HEAD", sha1))
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 save_head(sha1_to_hex(sh=
a1));
>
> What happens if the .git/sequencer dir already exists (e.g., we were
> in the middle of a multiple-cherry-pick)? =C2=A0What happens if I try=
 to
> cherry-pick onto an unborn branch, or get_sha1() fails for some other
> reason?

Oops.  I lost this somewhere along the way -- fixed now.  Thanks :)

-- Ram
