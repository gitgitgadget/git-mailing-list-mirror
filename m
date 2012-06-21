From: Dmitry Ivankov <divanorama@gmail.com>
Subject: Re: [PATCH] fast-import: disallow empty branches as parents
Date: Thu, 21 Jun 2012 12:39:34 +0600
Message-ID: <CA+gfSn9+Wg9oA7q4=nWdNXuG98n-p8VHYaN_9nVeGUk8iHpeSA@mail.gmail.com>
References: <1340220841-753-1-git-send-email-divanorama@gmail.com>
	<1340220841-753-2-git-send-email-divanorama@gmail.com>
	<20120621035753.GA3842@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	David Barr <davidbarr@google.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 21 08:39:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Shb3M-0003vv-80
	for gcvg-git-2@plane.gmane.org; Thu, 21 Jun 2012 08:39:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754498Ab2FUGjg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 Jun 2012 02:39:36 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:35102 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752223Ab2FUGjf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Jun 2012 02:39:35 -0400
Received: by obbuo13 with SMTP id uo13so496466obb.19
        for <git@vger.kernel.org>; Wed, 20 Jun 2012 23:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=Xg6MSfoz0qxj0sK1jRZYq+IlU+cKrX7UbIv5zLunCrY=;
        b=Nu0tvVSYoPtbDRe82E70+bqDBUxcTzuIHiuSU+N5Z6yHS+8D95uNVtaa+RdSaNM2+A
         P1+uV5+WY83B2+k9hizdYPCVOqKr1HnQQVi2sQRnDMSowgfr5tT5rz7yp56ZIqZfrEh3
         p9sNVBXBczIVR5U0d5XR83AKAteCNKwcf1EqDaY3V3sSvnpU9U5DvcHmOoj838xYum+w
         0FfNZBMPIhNTMNq15Lc/ljXkPsh9tHrm54GjyQ8woWqm0caL6N/SvtDvRB/cMG6/4YWC
         l2XQ4pjPE63LGXPj2yZHNo9SV1xLvNUpne8+lAcqzO4oRcd8uvX6//OjfPq31BXhliqU
         dfug==
Received: by 10.60.27.134 with SMTP id t6mr26381995oeg.70.1340260774976; Wed,
 20 Jun 2012 23:39:34 -0700 (PDT)
Received: by 10.60.125.67 with HTTP; Wed, 20 Jun 2012 23:39:34 -0700 (PDT)
In-Reply-To: <20120621035753.GA3842@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200396>

On Thu, Jun 21, 2012 at 9:57 AM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Hi Dmitry,
>
> Dmitry Ivankov wrote:
>
>> Empty branches (either new or reset-ed) have null_sha1 in fast-impor=
t
>> internals. These null_sha1 heads can slip to the real commit objects=
=2E
> [... nice explanation snipped ...]
>
> Very nice, thanks much for this.
>
> Would it be possible to split this into multiple independent fixes?
> See [*] below for one way.
>
>> --- a/fast-import.c
>> +++ b/fast-import.c
>> @@ -2540,7 +2540,8 @@ static void file_change_deleteall(struct branc=
h *b)
>> =A0 =A0 =A0 b->num_notes =3D 0;
>> =A0}
>>
>> -static void parse_from_commit(struct branch *b, char *buf, unsigned=
 long size)
>> +static void parse_from_commit(struct branch *b, unsigned char *sha1=
,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 char *buf, unsigned long size)
>> =A0{
>
> What is happening here? =A0The new argument doesn't seem to be used.
Ow, sorry. In fact it is here for die() messages.
A bit like spaghetti code, maybe die()-s can be moved to the caller.

>
> [...]
>> @@ -2551,29 +2552,31 @@ static void parse_from_commit(struct branch =
*b, char *buf, unsigned long size)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 b->branch_tree.versions[1].sha1);
>> =A0}
>>
>> -static void parse_from_existing(struct branch *b)
>> +static void parse_from_existing(struct branch *b, unsigned char *sh=
a1)
>> =A0{
>> - =A0 =A0 if (is_null_sha1(b->sha1)) {
>> + =A0 =A0 if (is_null_sha1(sha1)) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 hashclr(b->branch_tree.versions[0].sha1)=
;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 hashclr(b->branch_tree.versions[1].sha1)=
;
>> =A0 =A0 =A0 } else {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned long size;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 char *buf;
>>
>> - =A0 =A0 =A0 =A0 =A0 =A0 buf =3D read_object_with_reference(b->sha1=
,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 commit_type, &size, b->sha=
1);
>> + =A0 =A0 =A0 =A0 =A0 =A0 buf =3D read_object_with_reference(sha1,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 commit_type, &size, sha1);
>
> This seems to be about delaying the effect of "from" so it doesn't
> interfere with a "merge" command referring to the same commit.

Kind of, parse_from_*() arrange b->sha1 and b->branch_tree to correspon=
d
the first parent of a new tip. With this patch b->sha1 is left alone
to avoid the
interference. Oh, yes, luckily parse_merge() doesn't need b->branch_tre=
e-s.


>
> [...]
>> -static int parse_from(struct branch *b)
>> +static int parse_from(struct branch *b, unsigned char *sha1out)
>> =A0{
>> =A0 =A0 =A0 const char *from;
>> =A0 =A0 =A0 struct branch *s;
>>
>> - =A0 =A0 if (prefixcmp(command_buf.buf, "from "))
>> + =A0 =A0 if (prefixcmp(command_buf.buf, "from ")) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 hashclr(sha1out);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> + =A0 =A0 }
>
> This code path handles the case where there is no "from" after a
> "reset" or "commit" command. =A0We clear sha1out to make the calling
> convention simple --- sha1out is always written to, and the caller
> does not have to worry about initializing it in advance.
>
> I guess this is part of the change that delays the effect of "from"?
>
> [...]
>> @@ -2586,7 +2589,10 @@ static int parse_from(struct branch *b)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 die("Can't create a branch from itself: =
%s", b->name);
>> =A0 =A0 =A0 else if (s) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned char *t =3D s->branch_tree.vers=
ions[1].sha1;
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (is_null_sha1(s->sha1))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 die("Can't create a branch=
 from an empty branch:"
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 " %s from =
%s", b->name, s->name);
>
> This seems to be about protecting against "from" with an unborn
> branch.
>
>> - =A0 =A0 =A0 =A0 =A0 =A0 hashcpy(b->sha1, s->sha1);
>> + =A0 =A0 =A0 =A0 =A0 =A0 hashcpy(sha1out, s->sha1);
>
> Delaying the effect of "from", maybe.
>
> [...]
>> @@ -2594,16 +2600,16 @@ static int parse_from(struct branch *b)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct object_entry *oe =3D find_mark(id=
num);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (oe->type !=3D OBJ_COMMIT)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 die("Mark :%" PRIuMAX " =
not a commit", idnum);
>> - =A0 =A0 =A0 =A0 =A0 =A0 hashcpy(b->sha1, oe->idx.sha1);
>> + =A0 =A0 =A0 =A0 =A0 =A0 hashcpy(sha1out, oe->idx.sha1);
>
> Delaying "from" effect?
>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (oe->pack_id !=3D MAX_PACK_ID) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned long size;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 char *buf =3D gfi_unpack=
_entry(oe, &size);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 parse_from_commit(b, buf, =
size);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 parse_from_commit(b, sha1o=
ut, buf, size);
>
> Likewise?
>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 free(buf);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 parse_from_existing(b);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 parse_from_existing(b, sha=
1out);
>> - =A0 =A0 } else if (!get_sha1(from, b->sha1))
>> + =A0 =A0 } else if (!get_sha1(from, sha1out))
>> - =A0 =A0 =A0 =A0 =A0 =A0 parse_from_existing(b);
>> + =A0 =A0 =A0 =A0 =A0 =A0 parse_from_existing(b, sha1out);
>
> Likewise?
>
> [...]
>> =A0 =A0 =A0 else
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 die("Invalid ref name or SHA1 expression=
: %s", from);
>>
>> @@ -2622,9 +2628,11 @@ static struct hash_list *parse_merge(unsigned=
 int *count)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 from =3D strchr(command_buf.buf, ' ') + =
1;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 n =3D xmalloc(sizeof(*n));
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 s =3D lookup_branch(from);
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (s)
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (s) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (is_null_sha1(s->sha1))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 die("Can't=
 merge empty branch: %s", s->name);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hashcpy(n->sha1, s->sha1=
);
>> - =A0 =A0 =A0 =A0 =A0 =A0 else if (*from =3D=3D ':') {
>> + =A0 =A0 =A0 =A0 =A0 =A0 } else if (*from =3D=3D ':') {
>
> Protecting against "merge" with unknown branch.
>
> [...]
>> @@ -2656,6 +2664,7 @@ static void parse_new_commit(void)
>> =A0{
>> =A0 =A0 =A0 static struct strbuf msg =3D STRBUF_INIT;
>> =A0 =A0 =A0 struct branch *b;
>> + =A0 =A0 unsigned char sha1[20];
>> =A0 =A0 =A0 char *sp;
>> =A0 =A0 =A0 char *author =3D NULL;
>> =A0 =A0 =A0 char *committer =3D NULL;
>> @@ -2683,7 +2692,7 @@ static void parse_new_commit(void)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 die("Expected committer but didn't get o=
ne");
>> =A0 =A0 =A0 parse_data(&msg, 0, NULL);
>> =A0 =A0 =A0 read_next_command();
>> - =A0 =A0 parse_from(b);
>> + =A0 =A0 parse_from(b, sha1);
>
> Delayed "from" effect?
>
> [...]
>> @@ -2730,7 +2739,9 @@ static void parse_new_commit(void)
>> =A0 =A0 =A0 strbuf_reset(&new_data);
>> =A0 =A0 =A0 strbuf_addf(&new_data, "tree %s\n",
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 sha1_to_hex(b->branch_tree.versions[1].s=
ha1));
>> - =A0 =A0 if (!is_null_sha1(b->sha1))
>> + =A0 =A0 if (!is_null_sha1(sha1))
>> + =A0 =A0 =A0 =A0 =A0 =A0 strbuf_addf(&new_data, "parent %s\n", sha1=
_to_hex(sha1));
>> + =A0 =A0 else if (!is_null_sha1(b->sha1))
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 strbuf_addf(&new_data, "parent %s\n", sh=
a1_to_hex(b->sha1));
>
> Delaying "from"?
>
> [...]
>> @@ -2855,7 +2866,7 @@ static void parse_reset_branch(void)
>> =A0 =A0 =A0 else
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 b =3D new_branch(sp);
>> =A0 =A0 =A0 read_next_command();
>> - =A0 =A0 parse_from(b);
>> + =A0 =A0 parse_from(b, b->sha1);
>
> Likewise?
>
> [*]
> So it looks like this would be easier to read as three patches:
>
> =A01. protecting against "from" of unborn branch
> =A02. protecting against "merge" of unborn branch
> =A03. delaying the effect of "from" to avoid it confusingly changing
> =A0 =A0the effect of a "merge" in the same commit
Thanks, will look into it. Without (3) we'll still have inputs asking
for (2) accepted, like:
    commit new_tip
    ...
    from old_tip
    merge new_tip
new_tip won't end up with null_sha1 parent written, so should be ok to
postpone this case to (3).

>
> (1) and (2) would be no-brainers, while (3) seems more subtle ---
> maybe it should be documented to help importers for other version
> control systems to know to make the same change?
Will add a note on this.

>
> [...]
>> --- a/t/t9300-fast-import.sh
>> +++ b/t/t9300-fast-import.sh
>> @@ -2895,6 +2895,54 @@ test_expect_success 'S: merge with garbage af=
ter mark must fail' '
>> =A0 =A0 =A0 test_i18ngrep "after mark" err
>> =A0'
>>
>> +test_expect_success 'S: empty branch as merge parent must fail' '
>> + =A0 =A0 test_must_fail git fast-import <<-EOF 2>err &&
>> + =A0 =A0 commit refs/heads/chicken
>> + =A0 =A0 committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_=
COMMITTER_DATE
>> + =A0 =A0 data <<COMMIT
>> + =A0 =A0 I am the chicken.
>> + =A0 =A0 COMMIT
>> + =A0 =A0 merge refs/heads/chicken
>> + =A0 =A0 EOF
>> + =A0 =A0 cat err &&
>> + =A0 =A0 test_must_fail git rev-parse --verify refs/heads/chicken^
>
> There would be no "chicken" branch after this import at all, right?
Oh, yes, these rev-parse are all to illustrate the reason why import mu=
st fail.
With this one we can add a positive test where chicken is a born branch=
 and
import succeeds.

>
> [...]
>> +test_expect_success 'S: empty branch as merge parent must fail (2)'=
 '
>> + =A0 =A0 test_must_fail git fast-import <<-EOF 2>err &&
>> + =A0 =A0 commit refs/heads/egg1
>> + =A0 =A0 committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_=
COMMITTER_DATE
>> + =A0 =A0 data <<COMMIT
>> + =A0 =A0 I am the egg N1.
>> + =A0 =A0 COMMIT
>> +
>> + =A0 =A0 commit refs/heads/egg2
>> + =A0 =A0 committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_=
COMMITTER_DATE
>> + =A0 =A0 data <<COMMIT
>> + =A0 =A0 I am the egg N2.
>> + =A0 =A0 COMMIT
>> + =A0 =A0 from refs/heads/egg1
>> + =A0 =A0 merge refs/heads/egg2
>> + =A0 =A0 EOF
>> + =A0 =A0 cat err &&
>> + =A0 =A0 test_must_fail git rev-parse --verify refs/heads/egg2^2
>
> Likewise for egg2.
Adding a positive one here too looks a good idea.

>
> [...]
>> +test_expect_success 'S: empty branch as a parent must fail ' '
>> + =A0 =A0 test_must_fail git fast-import <<-EOF 2>err &&
>> + =A0 =A0 reset refs/heads/egg3
>> +
>> + =A0 =A0 commit refs/heads/egg4
>> + =A0 =A0 committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_=
COMMITTER_DATE
>> + =A0 =A0 data <<COMMIT
>> + =A0 =A0 I am the egg N4.
>> + =A0 =A0 COMMIT
>> + =A0 =A0 from refs/heads/egg3
>> + =A0 =A0 EOF
>> + =A0 =A0 cat err &&
>> + =A0 =A0 test_must_fail git rev-parse --verify refs/heads/egg4^2
>
> Likewise for egg4.
There is a copy-paste typo "egg4^2" instead of "egg4". Will just drop
rev-parse here as there should be a positive merge test somewhere
already.

>
> If this were split up as described above, I imagine it would be much
> easier to read and most of it would move into the "obviously good"
> category (I'm still uncertain about some details of the "delayed from=
"
> implementation and haven't checked carefully whether it misses any
> spots). =A0What do you think?
Thanks, good idea indeed. Will rearrange and resend.

>
> Thanks for a pleasant read, and hope that helps,
> Jonathan
