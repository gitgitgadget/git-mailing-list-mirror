From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH v2 05/16] fetch-pack: support fetching from a shallow repository
Date: Mon, 22 Jul 2013 20:10:41 +0100
Organization: OPDS
Message-ID: <DADC072FCD7749C8B51D9DE594D67AB7@PhilipOakley>
References: <1374065234-870-1-git-send-email-pclouds@gmail.com> <1374314290-5976-1-git-send-email-pclouds@gmail.com> <1374314290-5976-6-git-send-email-pclouds@gmail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed	reply-type=original
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Junio C Hamano" <gitster@pobox.com>
To: =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
	<pclouds@gmail.com>, <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 22 21:10:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V1LVE-0007Mc-TZ
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jul 2013 21:10:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932775Ab3GVTKc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Jul 2013 15:10:32 -0400
Received: from out1.ip05ir2.opaltelecom.net ([62.24.128.241]:65424 "EHLO
	out1.ip05ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932521Ab3GVTKa (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Jul 2013 15:10:30 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AjQOABuD7VFZ8YYB/2dsb2JhbABbgwY1g1qFPrdlAQMBgRUXdIIfBQEBBAEIAQEZBAsBBREFCAEBIQUGAgMFAgEDFAEFAgUhAgIUAQQIEAIGBxcGAQcCCQgCAQIDAQwEh10DCQoIplSIVA2IXoEojAKBVS1lBYJkM24Djn2Gd4MSin6FJoEzgWA7gSwk
X-IPAS-Result: AjQOABuD7VFZ8YYB/2dsb2JhbABbgwY1g1qFPrdlAQMBgRUXdIIfBQEBBAEIAQEZBAsBBREFCAEBIQUGAgMFAgEDFAEFAgUhAgIUAQQIEAIGBxcGAQcCCQgCAQIDAQwEh10DCQoIplSIVA2IXoEojAKBVS1lBYJkM24Djn2Gd4MSin6FJoEzgWA7gSwk
X-IronPort-AV: E=Sophos;i="4.89,720,1367967600"; 
   d="scan'208";a="426067417"
Received: from host-89-241-134-1.as13285.net (HELO PhilipOakley) ([89.241.134.1])
  by out1.ip05ir2.opaltelecom.net with SMTP; 22 Jul 2013 20:10:27 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230985>

=46rom: "Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy" <pclouds@gmail.com>
> upload-pack already advertises all shallow grafts if server repositor=
y
> is shallow. This information can be used to add more grafts to the
> client if the server sends commit chains down to its graft points.
>
> If the server is shallow, before we receive the pack, we setup a
> temporary shallow file that contains both local graft points and the
> server's. This stops index-pack from going beyond server's graft
> points.
>
> Only server graft points that do not have corresponding SHA-1s in
> local repo are added to the temp shallow file because we don't want t=
o
> accidentally cut the client history because the server's is
> shorter. The client cutting can only happen when --depth is requested=
=2E
>
> After index-pack finishes successfully, we write the temporary shallo=
w
> down with one exception: unused graft points provided by the server
> are removed. We don't want those lying around and suddenly become
> active.
>
> Note that in the "shallow -> shallow" case, the server might not have
> enough information to find common roots to create an optimum pack. It
> might send complete commit chains down to the graft points as a
> result. I don't think we can improve this, unless upload-pack somehow
> has access to a full repository.
>
> "shallow -> shallow" case only makes sense when the upstream provides
> a stable shallow repo (e.g. make a cut every year or so and ask devs
> to all move to the new base). If the cloned repos are all based on a
> stable (shallow) upstream, the above problem is unlikely to happen.
>
> A side effect of this change is we can now clone from a shallow
> repository.

>             And a full repository may automatically become shallow if
> you fetch from a shallow repository.

This "sounds" risky: Perhaps add a note about '[PATCH v2 15/16] config:=
=20
add core.noshallow to prevent turning a repo into a shallow one' which=20
will become available later in the series. The later core.noshallow may=
=20
be a hostage to fortune.

>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
> builtin/fetch-pack.c              |   7 ++-
> commit.h                          |  27 +++++++++-
> fetch-pack.c                      |  30 +++++++++--
> fetch-pack.h                      |   1 +
> shallow.c                         |  90=20
> +++++++++++++++++++++++++++++---
> t/t5536-fetch-shallow.sh (new +x) | 105=20
> ++++++++++++++++++++++++++++++++++++++
> transport.c                       |  10 ++--
> 7 files changed, 252 insertions(+), 18 deletions(-)
> create mode 100755 t/t5536-fetch-shallow.sh
>
> diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
> index 080e599..f6a6d76 100644
> --- a/builtin/fetch-pack.c
> +++ b/builtin/fetch-pack.c
> @@ -37,6 +37,7 @@ int cmd_fetch_pack(int argc, const char **argv,=20
> const char *prefix)
>  char **pack_lockfile_ptr =3D NULL;
>  struct child_process *conn;
>  struct fetch_pack_args args;
> + struct extra_have_objects shallow;
>
>  packet_trace_identity("fetch-pack");
>
> @@ -144,10 +145,12 @@ int cmd_fetch_pack(int argc, const char **argv,=
=20
> const char *prefix)
>     args.verbose ? CONNECT_VERBOSE : 0);
>  }
>
> - get_remote_heads(fd[0], NULL, 0, &ref, 0, NULL, NULL);
> + memset(&shallow, 0, sizeof(shallow));
> + get_remote_heads(fd[0], NULL, 0, &ref, 0, NULL,
> + args.stateless_rpc ? NULL : &shallow);
>
>  ref =3D fetch_pack(&args, fd, conn, ref, dest,
> - sought, nr_sought, pack_lockfile_ptr);
> + sought, nr_sought, &shallow, pack_lockfile_ptr);
>  if (pack_lockfile) {
>  printf("lock %s\n", pack_lockfile);
>  fflush(stdout);
> diff --git a/commit.h b/commit.h
> index 678fa20..97fd54e 100644
> --- a/commit.h
> +++ b/commit.h
> @@ -188,9 +188,32 @@ extern struct commit_list=20
> *get_shallow_commits(struct object_array *heads,
> extern void check_shallow_file_for_update(void);
> extern void set_alternate_shallow_file(const char *path);
> extern void advertise_shallow_grafts(int);
> -extern int write_shallow_commits(struct strbuf *out, int=20
> use_pack_protocol);
> +
> +/*
> + * Ignore graft points that cut out existing "good" parts of our
> + * history. Graft points pointing to incomplete commit islands are
> + * _not_ ignore.
> + */
> +#define WRITE_SHALLOW_NO_CUT         1
> +/*
> + * Remove graft points that are not attached to any SHA-1 in current
> + * history.
> + */
> +#define WRITE_SHALLOW_NO_UNUSED      2
> +/*
> + * Not really write_shallow_commits() flag, this lets
> + * setup_alternate_shallow know this is the "final" setup before
> + * committing to .git/shallow
> + */
> +#define WRITE_SHALLOW_REWRITE        4
> +
> +extern int write_shallow_commits(struct strbuf *out, int=20
> use_pack_protocol,
> + struct extra_have_objects *extra,
> + unsigned int flags);
> extern void setup_alternate_shallow(struct lock_file *shallow_lock,
> -     const char **alternate_shallow_file);
> +     const char **alternate_shallow_file,
> +     struct extra_have_objects *extra,
> +     unsigned int flags);
>
> int is_descendant_of(struct commit *, struct commit_list *);
> int in_merge_bases(struct commit *, struct commit *);
> diff --git a/fetch-pack.c b/fetch-pack.c
> index dc71a2b..f337526 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -311,7 +311,7 @@ static int find_common(struct fetch_pack_args=20
> *args,
>  }
>
>  if (is_repository_shallow())
> - write_shallow_commits(&req_buf, 1);
> + write_shallow_commits(&req_buf, 1, NULL, WRITE_SHALLOW_NO_CUT);
>  if (args->depth > 0)
>  packet_buf_write(&req_buf, "deepen %d", args->depth);
>  packet_buf_flush(&req_buf);
> @@ -769,6 +769,7 @@ static struct ref *do_fetch_pack(struct=20
> fetch_pack_args *args,
>  int fd[2],
>  const struct ref *orig_ref,
>  struct ref **sought, int nr_sought,
> + struct extra_have_objects *shallow,
>  char **pack_lockfile)
> {
>  struct ref *ref =3D copy_ref_list(orig_ref);
> @@ -844,8 +845,10 @@ static struct ref *do_fetch_pack(struct=20
> fetch_pack_args *args,
>
>  if (args->stateless_rpc)
>  packet_flush(fd[1]);
> - if (args->depth > 0)
> - setup_alternate_shallow(&shallow_lock, &alternate_shallow_file);
> + if (args->depth > 0 || shallow->nr)
> + setup_alternate_shallow(&shallow_lock, &alternate_shallow_file,
> + shallow,
> + WRITE_SHALLOW_NO_CUT);
>  if (get_pack(args, fd, pack_lockfile))
>  die("git fetch-pack: fetch failed.");
>
> @@ -922,6 +925,7 @@ struct ref *fetch_pack(struct fetch_pack_args=20
> *args,
>         const struct ref *ref,
>         const char *dest,
>         struct ref **sought, int nr_sought,
> +        struct extra_have_objects *shallow,
>         char **pack_lockfile)
> {
>  struct ref *ref_cpy;
> @@ -934,14 +938,30 @@ struct ref *fetch_pack(struct fetch_pack_args=20
> *args,
>  packet_flush(fd[1]);
>  die("no matching remote head");
>  }
> - ref_cpy =3D do_fetch_pack(args, fd, ref, sought, nr_sought,=20
> pack_lockfile);
> + ref_cpy =3D do_fetch_pack(args, fd, ref, sought, nr_sought,
> + shallow, pack_lockfile);
>
>  if (alternate_shallow_file) {
>  if (*alternate_shallow_file =3D=3D '\0') { /* --unshallow */
>  unlink_or_warn(git_path("shallow"));
>  rollback_lock_file(&shallow_lock);
> - } else
> + } else {
> + /*
> + *  The server is a shallow clone and it sends
> + *  us all of its shallow grafts. Some may be
> + *  needed if the server sends objects down to
> + *  the bottom. Remove all unused grafts.
> + */
> + if (shallow->nr) {
> + reprepare_packed_git();
> + setup_alternate_shallow(&shallow_lock,
> + &alternate_shallow_file,
> + shallow,
> + WRITE_SHALLOW_NO_CUT |
> + WRITE_SHALLOW_REWRITE);
> + }
>  commit_lock_file(&shallow_lock);
> + }
>  }
>
>  reprepare_packed_git();
> diff --git a/fetch-pack.h b/fetch-pack.h
> index 40f08ba..c55bf1c 100644
> --- a/fetch-pack.h
> +++ b/fetch-pack.h
> @@ -32,6 +32,7 @@ struct ref *fetch_pack(struct fetch_pack_args *args=
,
>         const char *dest,
>         struct ref **sought,
>         int nr_sought,
> +        struct extra_have_objects *shallow,
>         char **pack_lockfile);
>
> #endif
> diff --git a/shallow.c b/shallow.c
> index ee9edd4..337f676 100644
> --- a/shallow.c
> +++ b/shallow.c
> @@ -2,6 +2,7 @@
> #include "commit.h"
> #include "tag.h"
> #include "pkt-line.h"
> +#include "connected.h"
>
> static int is_shallow =3D -1;
> static struct stat shallow_stat;
> @@ -183,26 +184,103 @@ static int write_one_shallow(const struct=20
> commit_graft *graft, void *cb_data)
>  return 0;
> }
>
> -int write_shallow_commits(struct strbuf *out, int use_pack_protocol)
> +static int sha1_iterate(void *cb, unsigned char *sha1)
> +{
> + if (is_null_sha1(cb))
> + return 1;
> + hashcpy(sha1, cb);
> + hashclr(cb);
> + return 0;
> +}
> +
> +struct connectivity_cache_item {
> + unsigned char sha1[20];
> + int good;
> +};
> +
> +static int good_connectivity_from(const unsigned char *sha1)
> +{
> + static struct connectivity_cache_item *cache;
> + static int nr, alloc;
> + int i;
> + unsigned char sha1_cb[20];
> +
> + for (i =3D 0; i < nr; i++)
> + if (!hashcmp(cache[i].sha1, sha1))
> + return cache[i].good;
> +
> + ALLOC_GROW(cache, nr + 1, alloc);
> + hashcpy(sha1_cb, sha1);
> + hashcpy(cache[nr].sha1, sha1);
> + cache[nr].good =3D !check_everything_connected(sha1_iterate, 1,=20
> sha1_cb);
> + nr++;
> + return cache[nr - 1].good;
> +}
> +
> +int write_shallow_commits(struct strbuf *out, int use_pack_protocol,
> +   struct extra_have_objects *extra,
> +   unsigned int flags)
> {
>  struct write_shallow_data data;
> + int i;
>  data.out =3D out;
>  data.use_pack_protocol =3D use_pack_protocol;
>  data.count =3D 0;
>  for_each_commit_graft(write_one_shallow, &data);
> + if (!extra)
> + return data.count;
> +
> + for (i =3D 0; i < extra->nr; i++) {
> + if ((flags & WRITE_SHALLOW_NO_CUT) &&
> +     good_connectivity_from(extra->array[i]))
> + /*
> + * The server may have even shorter history
> + * than the client (e.g. the client has
> + * A-B-C-D but the server only has C-D). We do
> + * NOT want to cut client's history down to
> + * C-D simply because the server is set up
> + * so. If we don't have "C" and the server
> + * sends C-D to us, then we set up a graft at
> + * "C".
> + *
> + * If the client has (broken)-B-C-D, then "C"
> + * _is_ accepted. The -B-C-D is an incomplete
> + * island that normally has no connectivity to
> + * the rest of the repo.
> + */
> + continue;
> + if ((flags & WRITE_SHALLOW_NO_UNUSED) &&
> +     !has_sha1_file(extra->array[i]))
> + continue;
> + strbuf_addstr(out, sha1_to_hex(extra->array[i]));
> + strbuf_addch(out, '\n');
> + data.count++;
> + }
>  return data.count;
> }
>
> void setup_alternate_shallow(struct lock_file *shallow_lock,
> -      const char **alternate_shallow_file)
> +      const char **alternate_shallow_file,
> +      struct extra_have_objects *extra,
> +      unsigned int flags)
> {
>  struct strbuf sb =3D STRBUF_INIT;
> + int rewrite =3D flags & WRITE_SHALLOW_REWRITE;
>  int fd;
>
> - check_shallow_file_for_update();
> - fd =3D hold_lock_file_for_update(shallow_lock, git_path("shallow"),
> -        LOCK_DIE_ON_ERROR);
> - if (write_shallow_commits(&sb, 0)) {
> + if (!rewrite)
> + fd =3D hold_lock_file_for_update(shallow_lock,
> +        git_path("shallow"),
> +        LOCK_DIE_ON_ERROR);
> + else {
> + flags |=3D WRITE_SHALLOW_NO_UNUSED;
> + fd =3D shallow_lock->fd;
> + }
> + if (write_shallow_commits(&sb, 0, extra, flags)) {
> + if (rewrite && (lseek(fd, 0, SEEK_SET) =3D=3D -1 ||
> + ftruncate(fd, 0) =3D=3D -1))
> + die_errno("unable to truncate the new shallow file %s",
> +   shallow_lock->filename);
>  if (write_in_full(fd, sb.buf, sb.len) !=3D sb.len)
>  die_errno("failed to write to %s",
>    shallow_lock->filename);
> diff --git a/t/t5536-fetch-shallow.sh b/t/t5536-fetch-shallow.sh
> new file mode 100755
> index 0000000..15a8208
> --- /dev/null
> +++ b/t/t5536-fetch-shallow.sh
> @@ -0,0 +1,105 @@
> +#!/bin/sh
> +
> +test_description=3D'fetch/clone from a shallow clone'
> +
> +. ./test-lib.sh
> +
> +commit() {
> + echo "$1" >tracked &&
> + git add tracked &&
> + git commit -m "$1"
> +}
> +
> +test_expect_success 'setup' '
> + commit 1 &&
> + commit 2 &&
> + commit 3 &&
> + commit 4 &&
> + git config --global transfer.fsckObjects true
> +'
> +
> +test_expect_success 'setup shallow clone' '
> + git clone --no-local --depth=3D2 .git shallow &&
> + git --git-dir=3Dshallow/.git log --format=3D%s >actual &&
> + cat <<EOF >expect &&
> +4
> +3
> +EOF
> + test_cmp expect actual
> +'
> +
> +test_expect_success 'clone from shallow clone' '
> + git clone --no-local shallow shallow2 &&
> + (
> + cd shallow2 &&
> + git fsck &&
> + git log --format=3D%s >actual &&
> + cat <<EOF >expect &&
> +4
> +3
> +EOF
> + test_cmp expect actual
> + )
> +'
> +
> +test_expect_success 'fetch from shallow clone' '
> + (
> + cd shallow &&
> + commit 5
> + ) &&
> + (
> + cd shallow2 &&
> + git fetch &&
> + git fsck &&
> + git log --format=3D%s origin/master >actual &&
> + cat <<EOF >expect &&
> +5
> +4
> +3
> +EOF
> + test_cmp expect actual
> + )
> +'
> +
> +test_expect_success 'fetch --depth from shallow clone' '
> + (
> + cd shallow &&
> + commit 6
> + ) &&
> + (
> + cd shallow2 &&
> + git fetch --depth=3D2 &&
> + git fsck &&
> + git log --format=3D%s origin/master >actual &&
> + cat <<EOF >expect &&
> +6
> +5
> +EOF
> + test_cmp expect actual
> + )
> +'
> +
> +test_expect_success 'fetch something upstream has but hidden by=20
> clients shallow boundaries' '
> + # the blob "1" is available in .git but hidden by the
> + # shallow2/.git/shallow and it should be resent
> + ! git --git-dir=3Dshallow2/.git cat-file blob `echo 1|git=20
> hash-object --stdin` >/dev/null &&
> + echo 1 > 1.t &&
> + git add 1.t &&
> + git commit -m add-1-back &&
> + (
> + cd shallow2 &&
> + git fetch ../.git +refs/heads/master:refs/remotes/top/master &&
> + git fsck &&
> + git log --format=3D%s top/master >actual &&
> + cat <<EOF >expect &&
> +add-1-back
> +4
> +3
> +EOF
> + test_cmp expect actual
> + ) &&
> + git --git-dir=3Dshallow2/.git cat-file blob `echo 1|git=20
> hash-object --stdin` >/dev/null
> +
> +'
> +
> +test_done
> diff --git a/transport.c b/transport.c
> index 10a8cb8..f167ca5 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -453,6 +453,7 @@ struct git_transport_data {
>  int fd[2];
>  unsigned got_remote_heads : 1;
>  struct extra_have_objects extra_have;
> + struct extra_have_objects shallow;
> };
>
> static int set_git_option(struct git_transport_options *opts,
> @@ -509,7 +510,8 @@ static struct ref *get_refs_via_connect(struct=20
> transport *transport, int for_pus
>
>  connect_setup(transport, for_push, 0);
>  get_remote_heads(data->fd[0], NULL, 0, &refs,
> - for_push ? REF_NORMAL : 0, &data->extra_have, NULL);
> + for_push ? REF_NORMAL : 0,
> + &data->extra_have, &data->shallow);
>  data->got_remote_heads =3D 1;
>
>  return refs;
> @@ -540,13 +542,13 @@ static int fetch_refs_via_pack(struct transport=
=20
> *transport,
>  if (!data->got_remote_heads) {
>  connect_setup(transport, 0, 0);
>  get_remote_heads(data->fd[0], NULL, 0, &refs_tmp, 0,
> - NULL, NULL);
> + NULL, &data->shallow);
>  data->got_remote_heads =3D 1;
>  }
>
>  refs =3D fetch_pack(&args, data->fd, data->conn,
>    refs_tmp ? refs_tmp : transport->remote_refs,
> -   dest, to_fetch, nr_heads,
> +   dest, to_fetch, nr_heads, &data->shallow,
>    &transport->pack_lockfile);
>  close(data->fd[0]);
>  close(data->fd[1]);
> @@ -803,6 +805,8 @@ static int git_transport_push(struct transport=20
> *transport, struct ref *remote_re
>  get_remote_heads(data->fd[0], NULL, 0, &tmp_refs, REF_NORMAL, NULL,=20
> NULL);
>  data->got_remote_heads =3D 1;
>  }
> + if (data->shallow.nr)
> + die("pushing to a shallow repository is not supported");
>
>  memset(&args, 0, sizeof(args));
>  args.send_mirror =3D !!(flags & TRANSPORT_PUSH_MIRROR);
> --=20
> 1.8.2.83.gc99314b
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
> -----
> No virus found in this message.
> Checked by AVG - www.avg.com
> Version: 2013.0.3349 / Virus Database: 3204/6504 - Release Date:=20
> 07/19/13
>=20
