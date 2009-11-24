From: Rafal Rusin <rafal.rusin@gmail.com>
Subject: Re: 'error: unable to set permission to './objects/...'
Date: Tue, 24 Nov 2009 01:59:34 +0100
Message-ID: <9bbf67fa0911231659n761bafdcm91f16d3259a9721b@mail.gmail.com>
References: <9bbf67fa0911221202r605de38coc2496b1f09123725@mail.gmail.com>
	 <7vd43acf7y.fsf@alter.siamese.dyndns.org>
	 <9bbf67fa0911230135j7cfe5bcem991e750b6754f344@mail.gmail.com>
	 <7vhbsl5x5e.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 24 01:59:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NCjkr-0002bl-SU
	for gcvg-git-2@lo.gmane.org; Tue, 24 Nov 2009 01:59:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757509AbZKXA7a convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Nov 2009 19:59:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756120AbZKXA7a
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Nov 2009 19:59:30 -0500
Received: from mail-bw0-f223.google.com ([209.85.218.223]:44194 "EHLO
	mail-bw0-f223.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757490AbZKXA73 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Nov 2009 19:59:29 -0500
Received: by bwz23 with SMTP id 23so5874969bwz.29
        for <git@vger.kernel.org>; Mon, 23 Nov 2009 16:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=5UHkMAXq/kF92xU+KcB7evCQ+xdQtFZOzoarbqgXWIs=;
        b=uDSmyhp4g6cs0jxLLXaK1M0HJftPPizE23nnJryBmzXgmpmo8sJN7rzjya6oZAuPBE
         zhysmsBBLEc02/gRqTrjKt0/1Mp2tkSuJso7KPtE1KppY3ewTcexL9cO73szx7teFgxy
         XOpkOztQCOxFjZ0YjQvjAd4fUxHLp2OCVYy8o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=ILP+k0RhgK6f/NSowKRIEv7RtsEC+AxQlrzvIfKY0j8n2gbu3JaAu13bv9mCEYk0t2
         Q74RUO3GfGowfrrLnN03eTWQ32+pNP3hOw0YzfLfhwX5gcne+xXn/3wEzC2lrLRWV9AT
         0vwLHoyK724K291t1OnYPk/zsWUaznv9r0Bc0=
Received: by 10.204.153.202 with SMTP id l10mr5259471bkw.92.1259024374482; 
	Mon, 23 Nov 2009 16:59:34 -0800 (PST)
In-Reply-To: <7vhbsl5x5e.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133550>

OK, I solved problem by upgrading samba on server from 3.0.23c to
3.2.8 (it's old, because it's arm server). This newer version doesn't
have problem with chmod.
Junio, your idea to investigate why it fails was good :-)
Thanks for your time.

2009/11/23 Junio C Hamano <gitster@pobox.com>:
> Rafal Rusin <rafal.rusin@gmail.com> writes:
>
>> As for detecting this particular case, I think it's not possible.
>
> Why not?
>
>> I think the best solution is to add repository config switch like
>> 'usefilepermissions' true by default. If set to false, git would ski=
p
>> chmod during push.
>> Does that make sense to you?
>
> Not at all. =C2=A0That is like creating an "allow broken behaviour" o=
ption and
> hoping for the best.
>
> You shouldn't have to invent such a configuration variable to begin w=
ith,
> as "let umask set whatever permission and leave it be" should already=
 be
> the case for !core.sharedrepository. =C2=A0There is something wrong i=
n your
> set up and you need to get to the bottom of it, instead of coming up =
with
> an even worse breakage as a unworkable workaround.
>
> There are some things I noticed while looking at the codepaths that a=
re
> involved.
>
> move_temp_to_file() is designed to move a temporary file that was cre=
ated
> by odb_mkstemp(). =C2=A0As the latter eventually uses mkstemp(), some
> implementations of which ignore umask and create a file that is reada=
ble
> only by the user, move_temp_to_file() must loosen the permission, eve=
n in
> a private repository that honors umask (i.e. not in a shared reposito=
ry)..
>
> =C2=A0 =C2=A0Side note. =C2=A0The creation of the temporary files in =
http.c that are
> =C2=A0 =C2=A0given to move_temp_to_file() is not quite correct; they =
are created by
> =C2=A0 =C2=A0fopen() without proper locking with mkstemp(). =C2=A0But=
 that is a separate
> =C2=A0 =C2=A0issue.
>
> But the codepath tries to loosen it a bit too much. =C2=A0Even if use=
r's umask
> is 077, files created in this codepath end up with world-readable bec=
ause
> we pretend that lstat() on the file returned 0444 (that is what a non=
-zero
> value given as the second parameter to set_shared_perm() means). =C2=A0=
We
> should tighten it perhaps like the attached patch does.
>
> In case it is not obvious, this patch is _not_ meant to help you work
> around the chmod() failure you are seeing on your filesystem. =C2=A0Y=
ou need to
> first see _why_ it fails for you, in order to come closer to the real
> solution.
>
> -- >8 --
> Subject: [PATCH] move_temp_to_file(): don't loosen permission too muc=
h
>
> We always feed 0444 as the second parameter to set_shared_perm() when
> finalizing a temporary file we created using mkstemp(), as some versi=
ons
> of glibc creates a temporary file with too tight a permission, ignori=
ng
> the user's umask. =C2=A0As the second parameter tells set_shared_perm=
() to
> pretend that it is the permission bits the file currently has (i.e. w=
hat
> should have been set by the user's umask), we should make it just as
> restrictive as user's umask suggests.
>
> ---
> =C2=A0sha1_file.c | =C2=A0 19 ++++++++++++++++---
> =C2=A01 files changed, 16 insertions(+), 3 deletions(-)
>
> diff --git a/sha1_file.c b/sha1_file.c
> index 63981fb..f0b8969 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -2233,6 +2233,21 @@ static void write_sha1_file_prepare(const void=
 *buf, unsigned long len,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git_SHA1_Final(sha1, &c);
> =C2=A0}
>
> +static int fix_tempfile_mode(const char *filename)
> +{
> + =C2=A0 =C2=A0 =C2=A0 static mode_t user_mode;
> +
> + =C2=A0 =C2=A0 =C2=A0 if (!user_mode) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 user_mode =3D umas=
k(0);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 umask(user_mode);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 user_mode =3D S_IF=
REG | ((user_mode ^ 0777) & 0666);
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 if (!set_shared_perm(filename, user_mode))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;
> + =C2=A0 =C2=A0 =C2=A0 return error("unable to set permission to '%s'=
", filename);
> +}
> +
> =C2=A0/*
> =C2=A0* Move the just written object into its final resting place.
> =C2=A0* NEEDSWORK: this should be renamed to finalize_temp_file() as
> @@ -2274,9 +2289,7 @@ int move_temp_to_file(const char *tmpfile, cons=
t char *filename)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> =C2=A0out:
> - =C2=A0 =C2=A0 =C2=A0 if (set_shared_perm(filename, (S_IFREG|0444)))
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return error("unab=
le to set permission to '%s'", filename);
> - =C2=A0 =C2=A0 =C2=A0 return 0;
> + =C2=A0 =C2=A0 =C2=A0 return fix_tempfile_mode(filename);
> =C2=A0}
>
> =C2=A0static int write_buffer(int fd, const void *buf, size_t len)
>
>


Regards,
--=20
Rafa=C5=82 Rusin
http://rrusin.blogspot.com
http://www.touk.pl
http://top.touk.pl
