Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E2B6E200B9
	for <e@80x24.org>; Sun,  6 May 2018 15:48:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751810AbeEFPsx (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 May 2018 11:48:53 -0400
Received: from sub3.mail.dreamhost.com ([69.163.253.7]:52981 "EHLO
        homiemail-a39.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751520AbeEFPsx (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 6 May 2018 11:48:53 -0400
X-Greylist: delayed 678 seconds by postgrey-1.27 at vger.kernel.org; Sun, 06 May 2018 11:48:53 EDT
Received: from homiemail-a39.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a39.g.dreamhost.com (Postfix) with ESMTP id 7392315006D;
        Sun,  6 May 2018 08:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=novalis.org; h=message-id
        :subject:from:to:date:in-reply-to:references:content-type
        :mime-version:content-transfer-encoding; s=novalis.org; bh=L3Cqi
        EFuqQgIleUSONSW8AKJleM=; b=K30HUpXXesJz38WZ6IEJDHdeTmQHnxGlTAodi
        A/ht/xn6sOFW3ec8FoO3q8wUlEGmtNncckbYfsOCMGPpKzIfthLBT/ClhksDj+PE
        kuv5A45lgrYLhAX5peDaSbe57vid6eVsXeOLkMSK2fo3SUoiq1QPb2ipUcYyEjsm
        8CceWQ=
Received: from corey (unknown [74.213.195.68])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: novalis@novalis.org)
        by homiemail-a39.g.dreamhost.com (Postfix) with ESMTPSA id 4FDB8150069;
        Sun,  6 May 2018 08:48:52 -0700 (PDT)
Message-ID: <1525621731.16035.11.camel@novalis.org>
Subject: Re: [PATCH 2/5] refs.c: do not die if locking fails in
 `write_pseudoref()`
From:   David Turner <novalis@novalis.org>
To:     Martin =?ISO-8859-1?Q?=C5gren?= <martin.agren@gmail.com>,
        git@vger.kernel.org
Date:   Sun, 06 May 2018 11:48:51 -0400
In-Reply-To: <20180506141031.30204-3-martin.agren@gmail.com>
References: <20180506141031.30204-3-martin.agren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5-1 
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Re making the lock static, I wonder about the following case:
         =20
      if (read_ref(pseudoref, &actual_old_oid))
                       =20
die("could not read ref '%s'", pseudoref);

I think this calls exit(), and then atexit tries to clean up the lock
files.  But since lock is no longer static, the stack may have been
destroyed (I don't actually know whether this is true, so maybe someone
else does).

On Sun, 2018-05-06 at 16:10 +0200, Martin =C3=85gren wrote:
> If we could not take the lock, we add an error to the `strbuf err`
> and
> return. However, this code is dead. The reason is that we take the
> lock
> using `LOCK_DIE_ON_ERROR`. Drop the flag to allow our more gentle
> error-handling to actually kick in.
>=20
> We could instead just drop the dead code and die here. But everything
> is
> prepared for gently propagating the error, so let's do that instead.
>=20
> There is similar dead code in `delete_pseudoref()`, but let's save
> that
> for the next patch.
>=20
> While at it, make the lock non-static.
>=20
> Signed-off-by: Martin =C3=85gren <martin.agren@gmail.com>
> ---
>  refs.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/refs.c b/refs.c
> index 8b7a77fe5e..8c50b8b139 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -644,7 +644,7 @@ static int write_pseudoref(const char *pseudoref,
> const struct object_id *oid,
>  {
>  	const char *filename;
>  	int fd;
> -	static struct lock_file lock;
> +	struct lock_file lock =3D LOCK_INIT;
>  	struct strbuf buf =3D STRBUF_INIT;
>  	int ret =3D -1;
> =20
> @@ -654,8 +654,7 @@ static int write_pseudoref(const char *pseudoref,
> const struct object_id *oid,
>  	strbuf_addf(&buf, "%s\n", oid_to_hex(oid));
> =20
>  	filename =3D git_path("%s", pseudoref);
> -	fd =3D hold_lock_file_for_update_timeout(&lock, filename,
> -					       LOCK_DIE_ON_ERROR,
> +	fd =3D hold_lock_file_for_update_timeout(&lock, filename, 0,
>  					       get_files_ref_lock_ti
> meout_ms());
>  	if (fd < 0) {
>  		strbuf_addf(err, "could not open '%s' for writing:
> %s",
