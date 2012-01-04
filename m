From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] Do not fetch tags on new shallow clones
Date: Wed, 4 Jan 2012 07:16:07 -0800
Message-ID: <CAJo=hJsVvEuUp8AbkCrvGQCHb29EPBP5amKA8Hp2EmykRjynjw@mail.gmail.com>
References: <1325676922-6995-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 04 16:16:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RiSZu-0003vh-C6
	for gcvg-git-2@lo.gmane.org; Wed, 04 Jan 2012 16:16:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755985Ab2ADPQa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Jan 2012 10:16:30 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:43662 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755893Ab2ADPQ2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Jan 2012 10:16:28 -0500
Received: by dajs34 with SMTP id s34so10991301daj.19
        for <git@vger.kernel.org>; Wed, 04 Jan 2012 07:16:28 -0800 (PST)
Received: by 10.68.197.165 with SMTP id iv5mr21049135pbc.69.1325690188310;
 Wed, 04 Jan 2012 07:16:28 -0800 (PST)
Received: by 10.68.26.37 with HTTP; Wed, 4 Jan 2012 07:16:07 -0800 (PST)
In-Reply-To: <1325676922-6995-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187923>

2012/1/4 Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>:
> The main purpose of shallow clones is to reduce download. Fetching
> tags likely defeats this purpose because old-enough repos tend to hav=
e
> a lot of tags, spreading across history, which may increase the numbe=
r
> of objects to download significantly.

Thank you for looking at this. I complained about it to Junio many
weeks ago, but never took the time myself to fix it. :-)

> =C2=A0We should also fetch a single branch, but because branches are
> =C2=A0usually less crowded and stay close the tip, they do not produc=
e too
> =C2=A0many extra objects. Let's leave it until somebody yells up.

Depends on the project. In git.git maint stays relatively close to
master, but its still not really that close. In other projects, there
are certainly huge differences between two active branches, sometimes
spanning years. Consider any product with a multiple year support
contract on an older version, where the support contract demands
patches for the older version to fix bugs.  :-)

I agree this can be looked at later with a different change, but there
should be a way to specify exactly which branches you want to clone,
especially in the shallow case.

> =C2=A0We should also fetch tags that reference to downloaded objects.=
 But I
> =C2=A0don't know how fetch does that magic,

If the remote advertises the capability "include-tag", and the client
wants tags, it asks for that include-tag capability in its request.
This is handled by the fetch_pack args field include_tag being set to
1. When the remote side sees the client requesting include-tag and it
packs the thing a tag points at, the tag is also packed, even though
it wasn't explicitly requested by the client.

> so for now users have to do
> =C2=A0"git fetch" after cloning for tags. I have only gone as far as
> =C2=A0fetching tags along by setting TRANS_OPT_FOLLOWTAGS? Help?

Right. Set TRANS_OPT_FOLLOWTAGS in the transport structure to fetch
only tags that are pointing at things already being sent. The delta
increase in transfer is 1 object (the tag) and whatever that tag takes
up on disk.

> diff --git a/builtin/clone.c b/builtin/clone.c
> index 86db954..abd8578 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -428,7 +428,7 @@ static struct ref *wanted_peer_refs(const struct =
ref *refs,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct ref **tail =3D head ? &head->next :=
 &local_refs;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0get_fetch_map(refs, refspec, &tail, 0);
> - =C2=A0 =C2=A0 =C2=A0 if (!option_mirror)
> + =C2=A0 =C2=A0 =C2=A0 if (!option_mirror && !option_depth)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0get_fetch_map(=
refs, tag_refspec, &tail, 0);
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return local_refs;

I think if you just add this into your patch, you get the auto follow
tag feature enabled:

diff --git a/builtin/clone.c b/builtin/clone.c
index efe8b6c..ecaafdb 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -641,6 +641,7 @@ int cmd_clone(int argc, const char **argv, const ch=
ar *prefi
                        die(_("Don't know how to clone %s"), transport-=
>url);

                transport_set_option(transport, TRANS_OPT_KEEP, "yes");
+               transport_set_option(transport, TRANS_OPT_FOLLOWTAGS, "=
1");

                if (option_depth)
                        transport_set_option(transport, TRANS_OPT_DEPTH=
,

totally untested (didn't even compile). This only works for the
"remote" cases where the native Git protocol is used. A local clone
using the hardlink or copy objects path, or a dumb HTTP or rsync clone
will ignore the option and not supply you the tags.

Annnddddd..... it doesn't appear to work.

You need to copy a block of code from fetch. The problem is the object
was copied locally by the transport, but the transport doesn't tell
you what extra objects came along. Clone has to loop back through the
advertised reference map from the transport, checking each tag to see
if has_sha1_file() says the object exists locally. If it does, then
clone needs to add that reference update to the set of things it will
store (and print to the terminal).

I think this loop is the find_non_local_tags() in builtin/fetch.c. Its
been a long time since I hacked on this code. The JGit version of
looking for these extra objects post transfer is more clearly
documented. *sigh*
