From: =?ISO-8859-1?Q?Johan_S=F8rensen?= <johan@johansorensen.com>
Subject: Re: [PATCH] upload-pack: add a trigger for post-upload-pack hook
Date: Thu, 27 Aug 2009 14:09:23 +0200
Message-ID: <9e0f31700908270509o1031a027y1b49efe7ea9a4fd3@mail.gmail.com>
References: <1250579093-40706-1-git-send-email-tom@mojombo.com>
	 <12c267e40908251043g4f3e36aya05d9c705f5afee2@mail.gmail.com>
	 <20090825184525.GC23731@coredump.intra.peff.net>
	 <7vprajmp16.fsf@alter.siamese.dyndns.org>
	 <7v1vmycfhd.fsf@alter.siamese.dyndns.org>
	 <7vy6p69j6a.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Tom Werner <mojombo@gmail.com>,
	Tom Preston-Werner <tom@mojombo.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 27 14:10:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MgdoO-00037V-K8
	for gcvg-git-2@lo.gmane.org; Thu, 27 Aug 2009 14:10:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752413AbZH0MJc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 Aug 2009 08:09:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752408AbZH0MJ3
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Aug 2009 08:09:29 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:55735 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752205AbZH0MJX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Aug 2009 08:09:23 -0400
Received: by bwz19 with SMTP id 19so911377bwz.37
        for <git@vger.kernel.org>; Thu, 27 Aug 2009 05:09:24 -0700 (PDT)
Received: by 10.204.160.73 with SMTP id m9mr4714637bkx.214.1251374963887; Thu, 
	27 Aug 2009 05:09:23 -0700 (PDT)
In-Reply-To: <7vy6p69j6a.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127157>

On Thu, Aug 27, 2009 at 2:47 AM, Junio C Hamano<gitster@pobox.com> wrot=
e:
> After upload-pack successfully finishes its operation, post-upload-pa=
ck
> hook can be called for logging purposes.
>
> The hook is passed various pieces of information, one per line, from =
its
> standard input. =A0Currently the following items can be fed to the ho=
ok, but
> more types of information may be added in the future:
>
> =A0 =A0want SHA-1::
> =A0 =A0 =A0 =A040-byte hexadecimal object name the client asked to in=
clude in the
> =A0 =A0 =A0 =A0resulting pack. =A0Can occur one or more times in the =
input.
>
> =A0 =A0have SHA-1::
> =A0 =A0 =A0 =A040-byte hexadecimal object name the client asked to ex=
clude from
> =A0 =A0 =A0 =A0the resulting pack, claiming to have them already. =A0=
Can occur zero
> =A0 =A0 =A0 =A0or more times in the input.
>
> =A0 =A0time float::
> =A0 =A0 =A0 =A0Number of seconds spent for creating the packfile.
>
> =A0 =A0size decimal::
> =A0 =A0 =A0 =A0Size of the resulting packfile in bytes.

Neat. And feeding it lines gives more room for future additions.

I'd like to suggest the following line from the original patch:

   full-pack integer::
        1 if the request was considered a full clone, 0 if it was a
partial update (fetch)


Also, on a similar note; in the little git-daemon (a tiny fork+exec
server in ruby) included with Gitorious there's a geo-ip lookup based
on the client addr. It would be fun if the client ip could be passed
along to this hook as well, but that would require passing it along
all the way from before fetch-pack is invoked as far as I can see..?

JS


>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>
> =A0> Here is an illustration patch.
>
> =A0And here is a bit more polished one with necessary supporting mate=
rial.
>
> =A0Documentation/git-upload-pack.txt | =A0 =A02 +
> =A0Documentation/githooks.txt =A0 =A0 =A0 =A0| =A0 25 +++++++++++++
> =A0t/t5501-post-upload-pack.sh =A0 =A0 =A0 | =A0 49 +++++++++++++++++=
+++++++++
> =A0upload-pack.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 68 +++=
++++++++++++++++++++++++++++++++-
> =A04 files changed, 142 insertions(+), 2 deletions(-)
> =A0create mode 100755 t/t5501-post-upload-pack.sh
>
> diff --git a/Documentation/git-upload-pack.txt b/Documentation/git-up=
load-pack.txt
> index b8e49dc..63f3b5c 100644
> --- a/Documentation/git-upload-pack.txt
> +++ b/Documentation/git-upload-pack.txt
> @@ -20,6 +20,8 @@ The UI for the protocol is on the 'git-fetch-pack' =
side, and the
> =A0program pair is meant to be used to pull updates from a remote
> =A0repository. =A0For push operations, see 'git-send-pack'.
>
> +After finishing the operation successfully, `post-upload-pack`
> +hook is called (see linkgit:githooks[5]).
>
> =A0OPTIONS
> =A0-------
> diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
> index 1c73673..036f6c7 100644
> --- a/Documentation/githooks.txt
> +++ b/Documentation/githooks.txt
> @@ -307,6 +307,31 @@ Both standard output and standard error output a=
re forwarded to
> =A0'git-send-pack' on the other end, so you can simply `echo` message=
s
> =A0for the user.
>
> +post-upload-pack
> +----------------
> +
> +After upload-pack successfully finishes its operation, this hook is =
called
> +for logging purposes.
> +
> +The hook is passed various pieces of information, one per line, from=
 its
> +standard input. =A0Currently the following items can be fed to the h=
ook, but
> +more types of information may be added in the future:
> +
> +want SHA-1::
> + =A0 =A040-byte hexadecimal object name the client asked to include =
in the
> + =A0 =A0resulting pack. =A0Can occur one or more times in the input.
> +
> +have SHA-1::
> + =A0 =A040-byte hexadecimal object name the client asked to exclude =
from
> + =A0 =A0the resulting pack, claiming to have them already. =A0Can oc=
cur zero
> + =A0 =A0or more times in the input.
> +
> +time float::
> + =A0 =A0Number of seconds spent for creating the packfile.
> +
> +size decimal::
> + =A0 =A0Size of the resulting packfile in bytes.
> +
> =A0pre-auto-gc
> =A0-----------
>
> diff --git a/t/t5501-post-upload-pack.sh b/t/t5501-post-upload-pack.s=
h
> new file mode 100755
> index 0000000..2cb63f8
> --- /dev/null
> +++ b/t/t5501-post-upload-pack.sh
> @@ -0,0 +1,49 @@
> +#!/bin/sh
> +
> +test_description=3D'post upload-hook'
> +
> +. ./test-lib.sh
> +
> +LOGFILE=3D".git/post-upload-pack-log"
> +
> +test_expect_success setup '
> + =A0 =A0 =A0 test_commit A &&
> + =A0 =A0 =A0 test_commit B &&
> + =A0 =A0 =A0 git reset --hard A &&
> + =A0 =A0 =A0 test_commit C &&
> + =A0 =A0 =A0 git branch prev B &&
> + =A0 =A0 =A0 mkdir -p .git/hooks &&
> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 echo "#!$SHELL_PATH" &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 echo "cat >post-upload-pack-log"
> + =A0 =A0 =A0 } >".git/hooks/post-upload-pack" &&
> + =A0 =A0 =A0 chmod +x .git/hooks/post-upload-pack
> +'
> +
> +: test_expect_success initial '
> + =A0 =A0 =A0 rm -fr sub &&
> + =A0 =A0 =A0 git init sub &&
> + =A0 =A0 =A0 (
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cd sub &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 git fetch --no-tags .. prev
> + =A0 =A0 =A0 ) &&
> + =A0 =A0 =A0 want=3D$(sed -n "s/^want //p" "$LOGFILE") &&
> + =A0 =A0 =A0 test "$want" =3D "$(git rev-parse --verify B)" &&
> + =A0 =A0 =A0 ! grep "^have " "$LOGFILE"
> +'
> +
> +test_expect_success second '
> + =A0 =A0 =A0 rm -fr sub &&
> + =A0 =A0 =A0 git init sub &&
> + =A0 =A0 =A0 (
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cd sub &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 git fetch --no-tags .. prev:refs/remote=
s/prev &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 git fetch --no-tags .. master
> + =A0 =A0 =A0 ) &&
> + =A0 =A0 =A0 want=3D$(sed -n "s/^want //p" "$LOGFILE") &&
> + =A0 =A0 =A0 test "$want" =3D "$(git rev-parse --verify C)" &&
> + =A0 =A0 =A0 have=3D$(sed -n "s/^have //p" "$LOGFILE") &&
> + =A0 =A0 =A0 test "$have" =3D "$(git rev-parse --verify B)"
> +'
> +
> +test_done
> diff --git a/upload-pack.c b/upload-pack.c
> index 4d8be83..69a6f46 100644
> --- a/upload-pack.c
> +++ b/upload-pack.c
> @@ -141,8 +141,60 @@ static int do_rev_list(int fd, void *create_full=
_pack)
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> +static int feed_obj_to_hook(const char *label, struct object_array *=
oa, int i, int fd)
> +{
> + =A0 =A0 =A0 int cnt;
> + =A0 =A0 =A0 char buf[512];
> +
> + =A0 =A0 =A0 cnt =3D sprintf(buf, "%s %s\n", label,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sha1_to_hex(oa->objects[i].=
item->sha1));
> + =A0 =A0 =A0 return write_in_full(fd, buf, cnt) !=3D cnt;
> +}
> +
> +static int run_post_upload_pack_hook(size_t total, struct timeval *t=
v)
> +{
> + =A0 =A0 =A0 const char *argv[2];
> + =A0 =A0 =A0 struct child_process proc;
> + =A0 =A0 =A0 int err, i;
> + =A0 =A0 =A0 int cnt;
> + =A0 =A0 =A0 char buf[512];
> +
> + =A0 =A0 =A0 argv[0] =3D "hooks/post-upload-pack";
> + =A0 =A0 =A0 argv[1] =3D NULL;
> +
> + =A0 =A0 =A0 if (access(argv[0], X_OK) < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> +
> + =A0 =A0 =A0 memset(&proc, 0, sizeof(proc));
> + =A0 =A0 =A0 proc.argv =3D argv;
> + =A0 =A0 =A0 proc.in =3D -1;
> + =A0 =A0 =A0 proc.stdout_to_stderr =3D 1;
> + =A0 =A0 =A0 err =3D start_command(&proc);
> + =A0 =A0 =A0 if (err)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return err;
> + =A0 =A0 =A0 for (i =3D 0; !err && i < want_obj.nr; i++)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err |=3D feed_obj_to_hook("want", &want=
_obj, i, proc.in);
> + =A0 =A0 =A0 for (i =3D 0; !err && i < have_obj.nr; i++)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err |=3D feed_obj_to_hook("have", &have=
_obj, i, proc.in);
> + =A0 =A0 =A0 if (!err) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cnt =3D sprintf(buf, "time %ld.%06ld\n"=
,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (long)tv->t=
v_sec, (long)tv->tv_usec);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err |=3D (write_in_full(proc.in, buf, c=
nt) !=3D cnt);
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 if (!err) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cnt =3D sprintf(buf, "size %ld\n", (lon=
g)total);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err |=3D (write_in_full(proc.in, buf, c=
nt) !=3D cnt);
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 if (close(proc.in))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D 1;
> + =A0 =A0 =A0 if (finish_command(&proc))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D 1;
> + =A0 =A0 =A0 return err;
> +}
> +
> =A0static void create_pack_file(void)
> =A0{
> + =A0 =A0 =A0 struct timeval start_tv, tv;
> =A0 =A0 =A0 =A0struct async rev_list;
> =A0 =A0 =A0 =A0struct child_process pack_objects;
> =A0 =A0 =A0 =A0int create_full_pack =3D (nr_our_refs =3D=3D want_obj.=
nr && !have_obj.nr);
> @@ -150,10 +202,12 @@ static void create_pack_file(void)
> =A0 =A0 =A0 =A0char abort_msg[] =3D "aborting due to possible reposit=
ory "
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"corruption on the remote side.";
> =A0 =A0 =A0 =A0int buffered =3D -1;
> - =A0 =A0 =A0 ssize_t sz;
> + =A0 =A0 =A0 ssize_t sz, total_sz;
> =A0 =A0 =A0 =A0const char *argv[10];
> =A0 =A0 =A0 =A0int arg =3D 0;
>
> + =A0 =A0 =A0 gettimeofday(&start_tv, NULL);
> + =A0 =A0 =A0 total_sz =3D 0;
> =A0 =A0 =A0 =A0if (shallow_nr) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rev_list.proc =3D do_rev_list;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rev_list.data =3D 0;
> @@ -262,7 +316,7 @@ static void create_pack_file(void)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sz =3D xread(pack_obje=
cts.out, cp,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0si=
zeof(data) - outsz);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (0 < sz)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 ;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 total_s=
z +=3D sz;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0else if (sz =3D=3D 0) =
{
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0close(=
pack_objects.out);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pack_o=
bjects.out =3D -1;
> @@ -314,6 +368,16 @@ static void create_pack_file(void)
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0if (use_sideband)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0packet_flush(1);
> +
> + =A0 =A0 =A0 gettimeofday(&tv, NULL);
> + =A0 =A0 =A0 tv.tv_sec -=3D start_tv.tv_sec;
> + =A0 =A0 =A0 if (tv.tv_usec < start_tv.tv_usec) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tv.tv_sec--;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tv.tv_usec +=3D 1000000;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 tv.tv_usec -=3D start_tv.tv_usec;
> + =A0 =A0 =A0 if (run_post_upload_pack_hook(total_sz, &tv))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 warning("post-upload-hook failed");
> =A0 =A0 =A0 =A0return;
>
> =A0fail:
> --
> 1.6.4.1.288.g10d22
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
