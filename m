From: Albert Yale <surfingalbert@gmail.com>
Subject: Re: [PATCH/RFC] grep: Add the option '--exclude'
Date: Fri, 27 Jan 2012 21:40:55 -0500
Message-ID: <CALEc4zGCrW1WLm9NC5N7Dsdk9qdVBOO3h2mkFwh+v-a=RM57yA@mail.gmail.com>
References: <1327716370-40705-1-git-send-email-surfingalbert@gmail.com> <CAPc5daW+pcO-HLoo9THLgt4Ow2BHZ-fWgXL=zPgyunvt1mf9ZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: rene.scharfe@lsrfire.ath.cx, tfransosi@gmail.com,
	git@vger.kernel.org, pclouds@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 28 03:41:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RqyEb-000055-43
	for gcvg-git-2@lo.gmane.org; Sat, 28 Jan 2012 03:41:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753491Ab2A1Clj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 Jan 2012 21:41:39 -0500
Received: from mail-wi0-f174.google.com ([209.85.212.174]:40776 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753328Ab2A1Cli convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Jan 2012 21:41:38 -0500
Received: by wics10 with SMTP id s10so1817173wic.19
        for <git@vger.kernel.org>; Fri, 27 Jan 2012 18:41:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=+ql++PWB8UZ5wKt5Ut2tGUXzENbNZKyNgV9w9i4IxsQ=;
        b=azVqEBeVpY3pMsEhDYvQAYBXOYDL3BG2i13b46DGClRctqM0xo+sCYEL392jykGxkG
         2un0PRQW7c1MUxZR39sRUv4i9Uhc0XDIDVV9HDCodB3E+i8+yf6s2A63UvKjpx/ZMgcb
         Znb2cIT8gy//2SjJ9uwpKsQqiToUyc84sqHlc=
Received: by 10.180.96.3 with SMTP id do3mr15664640wib.1.1327718495181; Fri,
 27 Jan 2012 18:41:35 -0800 (PST)
Received: by 10.223.61.67 with HTTP; Fri, 27 Jan 2012 18:40:55 -0800 (PST)
In-Reply-To: <CAPc5daW+pcO-HLoo9THLgt4Ow2BHZ-fWgXL=zPgyunvt1mf9ZQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189248>

I think you're correct. That would be a better way to implement this.

I'll look into it this weekend.

Albert Yale

On Fri, Jan 27, 2012 at 9:19 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> I'd prefer to see this done not by introducing a separate pathspec, b=
ut
> instead by adding exclusion-related fields to struct pathspec. That w=
ay, the
> existing callsites to=A0 match_pathspec() do not have to change, and =
only the
> program start-up needs to learn to stuff these negative pathspecs, no=
?
>
> On Jan 27, 2012 6:06 PM, "Albert Yale" <surfingalbert@gmail.com> wrot=
e:
>>
>> grep: Add the option '--exclude'
>>
>> Signed-off-by: Albert Yale <surfingalbert@gmail.com>
>> ---
>> This is a work-in-progress. It's functional,
>> but it hasn't been thoroughly tested.
>>
>> I'd like some feedback. Particularly for
>> init_pathspec_string_list() in dir.c.
>>
>> Thank you,
>>
>> Albert Yale
>>
>> =A0Documentation/git-grep.txt | =A0 =A07 ++++++
>> =A0builtin/grep.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0 50
>> ++++++++++++++++++++++++++++++++++++-------
>> =A0cache.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A01 +
>> =A0dir.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 32 +++++++=
+++++++++++++++++++++
>> =A04 files changed, 82 insertions(+), 8 deletions(-)
>>
>> diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
>> index 6a8b1e3..8cbb161 100644
>> --- a/Documentation/git-grep.txt
>> +++ b/Documentation/git-grep.txt
>> @@ -22,6 +22,7 @@ SYNOPSIS
>> =A0 =A0 =A0 =A0 =A0 [--color[=3D<when>] | --no-color]
>> =A0 =A0 =A0 =A0 =A0 [-A <post-context>] [-B <pre-context>] [-C <cont=
ext>]
>> =A0 =A0 =A0 =A0 =A0 [-f <file>] [-e] <pattern>
>> + =A0 =A0 =A0 =A0 =A0[-x <pattern>|--exclude=3D<pattern>]
>> =A0 =A0 =A0 =A0 =A0 [--and|--or|--not|(|)|-e <pattern>...]
>> =A0 =A0 =A0 =A0 =A0 [ [--exclude-standard] [--cached | --no-index | =
--untracked] |
>> <tree>...]
>> =A0 =A0 =A0 =A0 =A0 [--] [<pathspec>...]
>> @@ -124,6 +125,12 @@ OPTIONS
>> =A0 =A0 =A0 =A0Use fixed strings for patterns (don't interpret patte=
rn
>> =A0 =A0 =A0 =A0as a regex).
>>
>> +-x <pattern>::
>> +--exclude=3D<pattern>::
>> + =A0 =A0 =A0 In addition to those found in .gitignore (per director=
y) and
>> + =A0 =A0 =A0 $GIT_DIR/info/exclude, also consider these patterns to=
 be in the
>> + =A0 =A0 =A0 set of the ignore rules in effect.
>> +
>> =A0-n::
>> =A0--line-number::
>> =A0 =A0 =A0 =A0Prefix the line number to matching lines.
>> diff --git a/builtin/grep.c b/builtin/grep.c
>> index 9ce064a..106810f 100644
>> --- a/builtin/grep.c
>> +++ b/builtin/grep.c
>> @@ -518,7 +518,8 @@ static void run_pager(struct grep_opt *opt, cons=
t char
>> *prefix)
>> =A0 =A0 =A0 =A0free(argv);
>> =A0}
>>
>> -static int grep_cache(struct grep_opt *opt, const struct pathspec
>> *pathspec, int cached)
>> +static int grep_cache(struct grep_opt *opt, const struct pathspec
>> *pathspec,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int cached, const =
struct pathspec
>> *exclude_pathspec)
>> =A0{
>> =A0 =A0 =A0 =A0int hit =3D 0;
>> =A0 =A0 =A0 =A0int nr;
>> @@ -530,6 +531,9 @@ static int grep_cache(struct grep_opt *opt, cons=
t
>> struct pathspec *pathspec, int
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0continue;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!match_pathspec_depth(pathspec, c=
e->name,
>> ce_namelen(ce), 0, NULL))
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0continue;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (exclude_pathspec->nr &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 match_pathspec_depth(e=
xclude_pathspec, ce->name,
>> ce_namelen(ce), 0, NULL))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/*
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * If CE_VALID is on, we assume workt=
ree file and its cache
>> entry
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * are identical, even if worktree fi=
le has been modified,
>> so use
>> @@ -639,16 +643,23 @@ static int grep_object(struct grep_opt *opt, c=
onst
>> struct pathspec *pathspec,
>> =A0}
>>
>> =A0static int grep_objects(struct grep_opt *opt, const struct pathsp=
ec
>> *pathspec,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 const struct object_ar=
ray *list)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 const struct object_ar=
ray *list, const struct
>> pathspec *exclude_pathspec)
>> =A0{
>> =A0 =A0 =A0 =A0unsigned int i;
>> =A0 =A0 =A0 =A0int hit =3D 0;
>> =A0 =A0 =A0 =A0const unsigned int nr =3D list->nr;
>>
>> =A0 =A0 =A0 =A0for (i =3D 0; i < nr; i++) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 const char *name =3D list->objects[i].=
name;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int namelen =3D strlen(name);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct object *real_obj;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0real_obj =3D deref_tag(list->objects[=
i].item, NULL, 0);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (grep_object(opt, pathspec, real_ob=
j,
>> list->objects[i].name)) {
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (exclude_pathspec->nr &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 match_pathspec_depth(e=
xclude_pathspec, name,
>> namelen, 0, NULL))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (grep_object(opt, pathspec, real_ob=
j, name)) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0hit =3D 1;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (opt->status_only)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break=
;
>> @@ -658,7 +669,7 @@ static int grep_objects(struct grep_opt *opt, co=
nst
>> struct pathspec *pathspec,
>> =A0}
>>
>> =A0static int grep_directory(struct grep_opt *opt, const struct path=
spec
>> *pathspec,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int exc_std)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int exc_std, struc=
t string_list *exclude_list)
>> =A0{
>> =A0 =A0 =A0 =A0struct dir_struct dir;
>> =A0 =A0 =A0 =A0int i, hit =3D 0;
>> @@ -667,6 +678,10 @@ static int grep_directory(struct grep_opt *opt,=
 const
>> struct pathspec *pathspec,
>> =A0 =A0 =A0 =A0if (exc_std)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0setup_standard_excludes(&dir);
>>
>> + =A0 =A0 =A0 for (i =3D 0; i < exclude_list->nr; i++)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 add_exclude(exclude_list->items[i].str=
ing, "", 0,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &dir.exclude_l=
ist[EXC_CMDL]);
>> +
>> =A0 =A0 =A0 =A0fill_directory(&dir, pathspec->raw);
>> =A0 =A0 =A0 =A0for (i =3D 0; i < dir.nr; i++) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0const char *name =3D dir.entries[i]->=
name;
>> @@ -764,6 +779,14 @@ static int pattern_callback(const struct option=
 *opt,
>> const char *arg,
>> =A0 =A0 =A0 =A0return 0;
>> =A0}
>>
>> +static int exclude_cb(const struct option *opt, const char *arg,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int unset)
>> +{
>> + =A0 =A0 =A0 struct string_list *exclude_list =3D opt->value;
>> + =A0 =A0 =A0 string_list_append(exclude_list, arg);
>> + =A0 =A0 =A0 return 0;
>> +}
>> +
>> =A0static int help_callback(const struct option *opt, const char *ar=
g, int
>> unset)
>> =A0{
>> =A0 =A0 =A0 =A0return -1;
>> @@ -780,6 +803,7 @@ int cmd_grep(int argc, const char **argv, const =
char
>> *prefix)
>> =A0 =A0 =A0 =A0struct object_array list =3D OBJECT_ARRAY_INIT;
>> =A0 =A0 =A0 =A0const char **paths =3D NULL;
>> =A0 =A0 =A0 =A0struct pathspec pathspec;
>> + =A0 =A0 =A0 struct pathspec exclude_pathspec;
>> =A0 =A0 =A0 =A0struct string_list path_list =3D STRING_LIST_INIT_NOD=
UP;
>> =A0 =A0 =A0 =A0int i;
>> =A0 =A0 =A0 =A0int dummy;
>> @@ -792,7 +816,7 @@ int cmd_grep(int argc, const char **argv, const =
char
>> *prefix)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pattern_type_pcre,
>> =A0 =A0 =A0 =A0};
>> =A0 =A0 =A0 =A0int pattern_type =3D pattern_type_unspecified;
>> -
>> + =A0 =A0 =A0 struct string_list exclude_list =3D STRING_LIST_INIT_N=
ODUP;
>> =A0 =A0 =A0 =A0struct option options[] =3D {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0OPT_BOOLEAN(0, "cached", &cached,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"search in index inst=
ead of in the work tree"),
>> @@ -872,6 +896,8 @@ int cmd_grep(int argc, const char **argv, const =
char
>> *prefix)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"read patterns from f=
ile", file_callback),
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0{ OPTION_CALLBACK, 'e', NULL, &opt, "=
pattern",
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"match <pattern>", PA=
RSE_OPT_NONEG,
>> pattern_callback },
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 { OPTION_CALLBACK, 'x', "exclude", &ex=
clude_list,
>> "pattern",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "add <pattern> to ignore rules", P=
ARSE_OPT_NONEG,
>> exclude_cb },
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0{ OPTION_CALLBACK, 0, "and", &opt, NU=
LL,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"combine patterns specified with =
-e",
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0PARSE_OPT_NOARG | PARSE_OPT_NONEG=
, and_callback },
>> @@ -1053,6 +1079,10 @@ int cmd_grep(int argc, const char **argv, con=
st
>> char *prefix)
>> =A0 =A0 =A0 =A0pathspec.max_depth =3D opt.max_depth;
>> =A0 =A0 =A0 =A0pathspec.recursive =3D 1;
>>
>> + =A0 =A0 =A0 init_pathspec_string_list(&exclude_pathspec, &exclude_=
list);
>> + =A0 =A0 =A0 exclude_pathspec.max_depth =3D opt.max_depth;
>> + =A0 =A0 =A0 exclude_pathspec.recursive =3D 1;
>> +
>> =A0 =A0 =A0 =A0if (show_in_pager && (cached || list.nr))
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0die(_("--open-files-in-pager only wor=
ks on the worktree"));
>>
>> @@ -1083,18 +1113,19 @@ int cmd_grep(int argc, const char **argv, co=
nst
>> char *prefix)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int use_exclude =3D (opt_exclude < 0)=
 ? use_index :
>> !!opt_exclude;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (list.nr)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0die(_("--no-index or =
--untracked cannot be used
>> with revs."));
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 hit =3D grep_directory(&opt, &pathspec=
, use_exclude);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 hit =3D grep_directory(&opt, &pathspec=
, use_exclude,
>> &exclude_list);
>> =A0 =A0 =A0 =A0} else if (0 <=3D opt_exclude) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0die(_("--[no-]exclude-standard cannot=
 be used for tracked
>> contents."));
>> =A0 =A0 =A0 =A0} else if (!list.nr) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!cached)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0setup_work_tree();
>>
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 hit =3D grep_cache(&opt, &pathspec, ca=
ched);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 hit =3D grep_cache(&opt, &pathspec, ca=
ched,
>> &exclude_pathspec);
>> =A0 =A0 =A0 =A0} else {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (cached)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0die(_("both --cached =
and trees are given."));
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 hit =3D grep_objects(&opt, &pathspec, =
&list);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 hit =3D grep_objects(&opt, &pathspec, =
&list,
>> &exclude_pathspec);
>> =A0 =A0 =A0 =A0}
>>
>> =A0 =A0 =A0 =A0if (use_threads)
>> @@ -1102,5 +1133,8 @@ int cmd_grep(int argc, const char **argv, cons=
t char
>> *prefix)
>> =A0 =A0 =A0 =A0if (hit && show_in_pager)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0run_pager(&opt, prefix);
>> =A0 =A0 =A0 =A0free_grep_patterns(&opt);
>> + =A0 =A0 =A0 free_pathspec(&pathspec);
>> + =A0 =A0 =A0 free_pathspec(&exclude_pathspec);
>> + =A0 =A0 =A0 string_list_clear(&exclude_list, 0);
>> =A0 =A0 =A0 =A0return !hit;
>> =A0}
>> diff --git a/cache.h b/cache.h
>> index 10afd71..5c34ccb 100644
>> --- a/cache.h
>> +++ b/cache.h
>> @@ -536,6 +536,7 @@ struct pathspec {
>> =A0};
>>
>> =A0extern int init_pathspec(struct pathspec *, const char **);
>> +extern int init_pathspec_string_list(struct pathspec *, struct
>> string_list *);
>> =A0extern void free_pathspec(struct pathspec *);
>> =A0extern int ce_path_match(const struct cache_entry *ce, const stru=
ct
>> pathspec *pathspec);
>>
>> diff --git a/dir.c b/dir.c
>> index 0a78d00..65749cc 100644
>> --- a/dir.c
>> +++ b/dir.c
>> @@ -9,6 +9,8 @@
>> =A0#include "dir.h"
>> =A0#include "refs.h"
>>
>> +#include "string-list.h"
>> +
>> =A0struct path_simplify {
>> =A0 =A0 =A0 =A0int len;
>> =A0 =A0 =A0 =A0const char *path;
>> @@ -1259,6 +1261,36 @@ static int pathspec_item_cmp(const void *a_, =
const
>> void *b_)
>> =A0 =A0 =A0 =A0return strcmp(a->match, b->match);
>> =A0}
>>
>> +int init_pathspec_string_list(struct pathspec *pathspec, struct
>> string_list *path_list)
>> +{
>> + =A0 =A0 =A0 int i;
>> +
>> + =A0 =A0 =A0 memset(pathspec, 0, sizeof(*pathspec));
>> + =A0 =A0 =A0 if (!path_list)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> + =A0 =A0 =A0 pathspec->raw =3D 0; /* THIS IS PROBABLY BAD!!! */
>> + =A0 =A0 =A0 pathspec->nr =3D path_list->nr;
>> + =A0 =A0 =A0 if (!pathspec->nr)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> +
>> + =A0 =A0 =A0 pathspec->items =3D xmalloc(sizeof(struct
>> pathspec_item)*pathspec->nr);
>> + =A0 =A0 =A0 for (i =3D 0; i < pathspec->nr; i++) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct pathspec_item *item =3D pathspe=
c->items+i;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 const char *path =3D path_list->items[=
i].string;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 item->match =3D path;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 item->len =3D strlen(path);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 item->use_wildcard =3D !no_wildcard(pa=
th);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (item->use_wildcard)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pathspec->has_wildcard=
 =3D 1;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 qsort(pathspec->items, pathspec->nr,
>> + =A0 =A0 =A0 =A0 =A0 =A0 sizeof(struct pathspec_item), pathspec_ite=
m_cmp);
>> +
>> + =A0 =A0 =A0 return 0;
>> +}
>> +
>> =A0int init_pathspec(struct pathspec *pathspec, const char **paths)
>> =A0{
>> =A0 =A0 =A0 =A0const char **p =3D paths;
>> --
>> 1.7.8.3
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
