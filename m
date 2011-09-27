From: David Michael Barr <davidbarr@google.com>
Subject: Re: [PATCH] refs.c: Fix slowness with numerous loose refs
Date: Tue, 27 Sep 2011 12:04:43 +1000
Message-ID: <CAFfmPPMx9_nRE2Zfg2g0hwzybWDPJARc6LCHbSK8y-uZWQCZqQ@mail.gmail.com>
References: <CAFfmPPNCCCo=40CVvjRebXvkR7H_wh9+cz=tGxHZ1LtarE+w+A@mail.gmail.com>
	<1317085283-33943-1-git-send-email-davidbarr@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Julian Phillips <julian@quantumfyre.co.uk>,
	Martin Fick <mfick@codeaurora.org>,
	Junio C Hamano <gitster@pobox.com>,
	David Barr <davidbarr@google.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 27 04:04:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8N2V-0005Fj-PC
	for gcvg-git-2@lo.gmane.org; Tue, 27 Sep 2011 04:04:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751668Ab1I0CEr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Sep 2011 22:04:47 -0400
Received: from smtp-out.google.com ([74.125.121.67]:53240 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751472Ab1I0CEq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Sep 2011 22:04:46 -0400
Received: from wpaz5.hot.corp.google.com (wpaz5.hot.corp.google.com [172.24.198.69])
	by smtp-out.google.com with ESMTP id p8R24iOu006622
	for <git@vger.kernel.org>; Mon, 26 Sep 2011 19:04:45 -0700
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=google.com; s=beta;
	t=1317089085; bh=TFI6LedEQNdPHl3E8ntMfY36Qvc=;
	h=MIME-Version:In-Reply-To:References:Date:Message-ID:Subject:From:
	 To:Cc:Content-Type:Content-Transfer-Encoding;
	b=p0YQKAwYuLmlZW2Z1LrXmpU6pNLjsM8A7z2KmtwQWH1BGYvcNtlbQ5LvfC5qeII1i
	 OhciaVEpNmBSF822pz2KQ==
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=dkim-signature:mime-version:in-reply-to:references:date:
	message-id:subject:from:to:cc:content-type:
	content-transfer-encoding:x-system-of-record;
	b=hKKDy2n0Mc0ANeuqOPfGyD7dydrVQJs64BRHd8jsS+mGnMg1AE7i8sxOkqOJcofwi
	ivAfUiATcjl9EmXZZohuQ==
Received: from ywm39 (ywm39.prod.google.com [10.192.13.39])
	by wpaz5.hot.corp.google.com with ESMTP id p8R24guY015792
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <git@vger.kernel.org>; Mon, 26 Sep 2011 19:04:43 -0700
Received: by ywm39 with SMTP id 39so6280307ywm.4
        for <git@vger.kernel.org>; Mon, 26 Sep 2011 19:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=beta;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=XuIPLG9tgV3PAQxdfxpLL2KpSH5r+jheeCPI217Fq8A=;
        b=jYQUVwMk6cy3rSM8T7hxgN/8tJ//psqeF0tUfM4D9X6jfZgMpD6ib/loEzw6W2O9Nk
         P8Pxc3OBue7CBpZ8ub8Q==
Received: by 10.101.165.40 with SMTP id s40mr6653702ano.161.1317089083267;
        Mon, 26 Sep 2011 19:04:43 -0700 (PDT)
Received: by 10.101.165.40 with SMTP id s40mr6653696ano.161.1317089083095;
 Mon, 26 Sep 2011 19:04:43 -0700 (PDT)
Received: by 10.100.24.25 with HTTP; Mon, 26 Sep 2011 19:04:43 -0700 (PDT)
In-Reply-To: <1317085283-33943-1-git-send-email-davidbarr@google.com>
X-System-Of-Record: true
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182201>

+cc Shawn O. Pearce

I used the following to generate a test repo shaped like
a gerrit mirror with unpacked refs (10k, because life is too short for
100k tests):

cd test.git
git init
touch empty
git add empty
git commit -m 'empty'
REV=3D`git rev-parse HEAD`
for ((d=3D0;d<100;++d)); do
 for ((n=3D0;n<100;++n)); do
  let r=3Dn*100+d
  mkdir -p .git/refs/changes/$d/$r
  echo $REV > .git/refs/changes/$d/$r/1
 done
done
time git branch xyz

With warm caches...

Git 1.7.6.4:
real	0m8.232s
user	0m7.842s
sys	0m0.385s

Git 1.7.6.4, with patch below:
real	0m0.394s
user	0m0.069s
sys	0m0.324s

On Tue, Sep 27, 2011 at 11:01 AM, David Barr <davidbarr@google.com> wro=
te:
> Martin Fick reported:
> =A0OK, I have found what I believe is another performance
> =A0regression for large ref counts (~100K).
>
> =A0When I run git br on my repo which only has one branch, but
> =A0has ~100K refs under ref/changes (a gerrit repo), it takes
> =A0normally 3-6mins depending on whether my caches are fresh or
> =A0not. =A0After bisecting some older changes, I noticed that
> =A0this ref seems to be where things start to get slow:
> =A0v1.5.2-rc0~21^2 (refs.c: add a function to sort a ref list,
> =A0rather then sorting on add) (Julian Phillips, Apr 17, 2007)
>
> Martin Fick observed that sort_refs_lists() was called almost
> as many times as there were loose refs.
>
> Julian Phillips commented:
> =A0Back when I made that change, I failed to notice that get_ref_dir
> =A0was recursive for subdirectories ... sorry ...
>
> =A0Hopefully this should speed things up. My test repo went from
> =A0~17m user time, to ~2.5s.
> =A0Packing still make things much faster of course.
>
> Martin Fick acked:
> =A0Excellent! =A0This works (almost, in my refs.c it is called
> =A0sort_ref_list, not sort_refs_list). =A0So, on the non garbage
> =A0collected repo, git branch now takes ~.5s, and in the
> =A0garbage collected one it takes only ~.05s!
>
> [db: summarised transcript, rewrote patch to fix callee not callers]
>
> [attn jch: patch applies to maint]
>
> Analyzed-by: Martin Fick <mfick@codeaurora.org>
> Inspired-by: Julian Phillips <julian@quantumfyre.co.uk>
> Acked-by: Martin Fick <mfick@codeaurora.org>
> Signed-off-by: David Barr <davidbarr@google.com>
> ---
> =A0refs.c | =A0 14 ++++++++++----
> =A01 files changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/refs.c b/refs.c
> index 4c1fd47..e40a09c 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -255,8 +255,8 @@ static struct ref_list *get_packed_refs(const cha=
r *submodule)
> =A0 =A0 =A0 =A0return refs->packed;
> =A0}
>
> -static struct ref_list *get_ref_dir(const char *submodule, const cha=
r *base,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 struct ref_list *list)
> +static struct ref_list *walk_ref_dir(const char *submodule, const ch=
ar *base,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0struct ref_list *list)
> =A0{
> =A0 =A0 =A0 =A0DIR *dir;
> =A0 =A0 =A0 =A0const char *path;
> @@ -299,7 +299,7 @@ static struct ref_list *get_ref_dir(const char *s=
ubmodule, const char *base,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (stat(refdir, &st) =
< 0)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0contin=
ue;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (S_ISDIR(st.st_mode=
)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 list =3D=
 get_ref_dir(submodule, ref, list);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 list =3D=
 walk_ref_dir(submodule, ref, list);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0contin=
ue;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (submodule) {
> @@ -319,7 +319,13 @@ static struct ref_list *get_ref_dir(const char *=
submodule, const char *base,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0free(ref);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0closedir(dir);
> =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0 return sort_ref_list(list);
> + =A0 =A0 =A0 return list;
> +}
> +
> +static struct ref_list *get_ref_dir(const char *submodule, const cha=
r *base,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 struct ref_list *list)
> +{
> + =A0 =A0 =A0 return sort_ref_list(walk_ref_dir(submodule, base, list=
));
> =A0}
>
> =A0struct warn_if_dangling_data {
> --
> 1.7.5.75.g69330
>
>



--=20

David Barr=A0|=A0Software Engineer=A0|=A0davidbarr@google.com=A0|=A0614=
-3438-8348
