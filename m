From: Dan McGee <dpmcgee@gmail.com>
Subject: Re: [PATCH 4/5] tree-walk: unroll get_mode since loop boundaries are well-known
Date: Tue, 5 Apr 2011 00:33:37 -0500
Message-ID: <BANLkTi==M=N+Z3qcsYk+tHap8A1Y41QfLw@mail.gmail.com>
References: <1301535481-1085-1-git-send-email-dpmcgee@gmail.com>
	<1301535481-1085-4-git-send-email-dpmcgee@gmail.com>
	<7v7hba9csn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Erik Faye-Lund <kusmabite@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 05 07:33:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6ytk-0000o6-O8
	for gcvg-git-2@lo.gmane.org; Tue, 05 Apr 2011 07:33:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752374Ab1DEFdq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 Apr 2011 01:33:46 -0400
Received: from mail-ww0-f42.google.com ([74.125.82.42]:40716 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751900Ab1DEFdj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Apr 2011 01:33:39 -0400
Received: by wwk4 with SMTP id 4so2359674wwk.1
        for <git@vger.kernel.org>; Mon, 04 Apr 2011 22:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=h/FBD/s4sLexzOQicDVhhv3t7+njZWTmDW2KwWbinT4=;
        b=dh51iJzAq4LpSK1Qfv1APIL9yeUEw2Ks8rl3gsnqgrYJ99aKsUHDMB2dOQ4oieH4fo
         JTDguQkAZjnepF234KvgVT4zf2N39UWZO0eONsAAh+86wTeDuOBHvOOQlpToGL2ai0UR
         hcWo/XuM45GcpWklY+Dn1liXVPjWburFlQ+oQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=BgDAZSrXZ+jBg9+QbdKLRmdV8uDQH3eAVeUcKXqjgVwwPYFLVrviHzMM6H8psF3T8h
         StUkDs1/TeCSXQYayYZZniRIVBCp7h5gUEm8zg0rgMXh6j876DPr5uAB0+m6gXBGdCtt
         Yse7ShfpAwpmLaTs1wUO672aRmcg/l5YYXckE=
Received: by 10.227.32.132 with SMTP id c4mr3830547wbd.190.1301981617843; Mon,
 04 Apr 2011 22:33:37 -0700 (PDT)
Received: by 10.227.147.16 with HTTP; Mon, 4 Apr 2011 22:33:37 -0700 (PDT)
In-Reply-To: <7v7hba9csn.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170866>

On Mon, Apr 4, 2011 at 5:29 AM, Erik Faye-Lund <kusmabite@gmail.com> wr=
ote:
>
> We perfer this style:
>
> if (c < '0' || c > '7')
>        return NULL;
>
> i.e a line-break and a tab between the if-statement and the condition=
al code.
I am well aware, I just wanted to make the code a bit less lengthy due
to the repetition.

On Mon, Apr 4, 2011 at 11:55 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Dan McGee <dpmcgee@gmail.com> writes:
>
>> We know our mode entry in our tree objects should be 5 or 6 characte=
rs
>> long. This change both enforces this fact...
>
> I find the implementation later shown in the thread is cleaner,
Totally agree; I should have tried to do it this way in the first
place. However, compiling the fixed-length 0 to 5 loop does not
produce fully-unrolled assembly for me with CFLAGS=3D"-march=3Dnative
-mtune=3Dnative -O2 -pipe -g" on x86_64. I see two copies of the loop
only, and even worse is the (lack of) performance (each is the mode of
3 runs). Compilers are stupid apparently.

Hand-unrolled:
$ time ../git/git-log -- zzzzz_not_exist > /dev/null
real	0m28.616s
user	0m28.428s
sys	0m0.177s

Static counter loop:
$ time ../git/git-log -- zzzzz_not_exist > /dev/null
real	0m26.393s
user	0m26.185s
sys	0m0.203s

Diff between the two down at the bottom.

> but I'd
> comment on the word "enforces" here.
>
> It is more like "versions of git we know how to read from writes mode=
 bits
> with 5 or 6 characters---if we see something else, either the tree ob=
ject
> is corrupt, or we are too old to read the new type of entry in the tr=
ee
> object".
OK, sounds like we have opposite thinking on this, interesting.

get_mode() is not get_permissions()- it is the same as the stat()
st_mode field, which means it has to (as of now) include at least one
of the S_IFREG, S_IFDIR, or S_IFGITLINK flags in its value.

All of S_ISREG, S_ISDIR, and S_ISGITLINK are used fsck_walk_tree(). So
I'm not seeing a change in the tree storage format happening anytime
soon as there is little way to preserve both forward and backward
compatibility.

Currently git will happily parse both a "1" in the tree stream, or a
"165324132132464677321513252351"- it doesn't care. The problem is in
the former case, a mode of 01 doesn't have any significance later on.
In the latter case, we will be left-shifting our mode to hell and it
becomes worthless.

Do we disagree on clamping the lower limit at 5, the upper limit at 6, =
or both?

> So returning NULL is fine and it tells the caller that we do not
> understand the tree object. =C2=A0The caller says "corrupt tree file"=
 when we
> do so here, but this change needs to rephrase it. =C2=A0If we stopped=
 because
> we saw something other than ' ' after the run of octal digits, then w=
e
> know the tree is corrupt. =C2=A0If we saw a three octal digits 644 in=
 the mode
> field, terminated with ' ', maybe we are seeing a new kind of tree en=
try
> generated from later versions of git.
>
> Ideally, I'd rather see error checking done even higher layer than
> decode_tree_entry() for the "we are too old" case, though. =C2=A0We s=
hould
> return mode 0644 in such a case, and let the caller suggest that the
> version of git we are running might be too old, or the tree may have =
been
> written by a broken system that tried to mimic git in its error messa=
ge.
>

diff --git a/tree-walk.c b/tree-walk.c
index 63901f8..63ec130 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -7,34 +7,21 @@
 static const char *get_mode(const char *str, unsigned int *modep)
 {
        unsigned char c;
-       unsigned int mode =3D 0;
+       unsigned int mode =3D 0, i;

        /*
-        * Unroll what looks like a loop since the bounds are
+        * Allow the compiler to unroll the loop since the bounds are
         * well-known. There should be at least 5 and at most 6
         * characters available in any valid mode, as '40000' is the
         * shortest while '160000' (S_IFGITLINK) is the longest.
         */
-       /* char 1 */
-       c =3D *str++;
-       if (c < '0' || c > '7') return NULL;
-       mode =3D (mode << 3) + (c - '0');
-       /* char 2 */
-       c =3D *str++;
-       if (c < '0' || c > '7') return NULL;
-       mode =3D (mode << 3) + (c - '0');
-       /* char 3 */
-       c =3D *str++;
-       if (c < '0' || c > '7') return NULL;
-       mode =3D (mode << 3) + (c - '0');
-       /* char 4 */
-       c =3D *str++;
-       if (c < '0' || c > '7') return NULL;
-       mode =3D (mode << 3) + (c - '0');
-       /* char 5 */
-       c =3D *str++;
-       if (c < '0' || c > '7') return NULL;
-       mode =3D (mode << 3) + (c - '0');
+       /* chars 1-5, optional */
+       for (i =3D 0; i < 5; i++) {
+               c =3D *str++;
+               if (c < '0' || c > '7')
+                       return NULL;
+               mode =3D (mode << 3) + (c - '0');
+       }
        /* char 6, optional */
        if (*str !=3D ' ') {
                c =3D *str++;
