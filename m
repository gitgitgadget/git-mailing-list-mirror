Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D23D6C49EA5
	for <git@archiver.kernel.org>; Sat, 26 Jun 2021 08:27:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B00AC61613
	for <git@archiver.kernel.org>; Sat, 26 Jun 2021 08:27:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbhFZIaH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Jun 2021 04:30:07 -0400
Received: from mout.web.de ([212.227.17.12]:50927 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229518AbhFZIaH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Jun 2021 04:30:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1624696062;
        bh=4NOWna/A72PVGIAdeVAwIFlknpDH2bVvAniVHQi/Oig=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=LMZgqnuEWxm43ZoE7TM8Mm9fnyyc1xbZ1OWGEInIaPCZ8lDhfVATRTzdzMGAKGAMs
         ColOj9XoaIu4x7dpuxj4rtBl7uyrt3gtdRJjVHKkP44Ihd+pG+W0RkomWp28NYKFfP
         3TFIUqe6FLA1VgVP5tekhJHxNrR5GXG9GlUvdjJk=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([91.47.158.105]) by smtp.web.de
 (mrweb105 [213.165.67.124]) with ESMTPSA (Nemesis) id
 1Mm9Va-1lWUGs1g8G-00iFeS; Sat, 26 Jun 2021 10:27:42 +0200
Subject: Re: [PATCH 02/12] environment: move strbuf into block to plug leak
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Andrzej Hunt <andrzej@ahunt.org>
References: <20210620151204.19260-1-andrzej@ahunt.org>
 <20210620151204.19260-3-andrzej@ahunt.org>
 <CABPp-BGFH787gsw-yd3BpLt_rDe2zDoSFP6mMx6PSQfy1Ct4vw@mail.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <15df4c07-988e-baff-8760-a199ec9aeb1b@web.de>
Date:   Sat, 26 Jun 2021 10:27:42 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BGFH787gsw-yd3BpLt_rDe2zDoSFP6mMx6PSQfy1Ct4vw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0FLA9ADd5thEA+89mYyG6bKP5w/TJCXcApNeFD7sLlco6RZCJ4D
 1zTwKwQW+MZfI+/cegHZMk4+rIn6P6ULHrQu81NcZAmRhQeSCRwbBZIHshG4Cgne0lsL1xJ
 fQrLbfAAPIrNZ1oiP91OJuDFo4ZTF7qYRb3FbvPW46TM/iWQiDiVo+NmENNC4conD4Nsua3
 JG4wZQbh0K8aC+akSsZkg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:RMFN7mruMIo=:o8VwBI3aN0S/o9ISHIdXPz
 /LvD2BQJw6cGmfTldsKYoO99/QFBwI2VITi3JnnKZ6j7lEYar9CFn9JXhpkwMmCepdbsRcGt4
 OFWiJpA2knG/uzkeXFlkqMcEOq7g0QZVn2rXXjAZWgeZRRnTkJymRSC1IHO0zmpHM501TN/JF
 ofh1y7Cf+mBFyRoFqerddsQ33CZIalPnBwldZj8g3m1ZgD9s+12IPN8LFZWqkLKAqti04CnM8
 7UPoKu6ghVkF4SfnKImw1rEXRMKNfd6jS5XXBgnWQlRgyECAHOH7mUBrwHXHugq70Uepm+30B
 YSyVFzn60Xxx2cRECH+5PAa7qkulcBYfDIBaBNgnhWECkruLVzWa8kVeujTNTTh5OH08+6nFe
 7quDdkBhQDpt6wR59ebvnFMedgI2HqZ7MDDQ+JpTLTmJYoV7QS/SXAEAoI1Xseedb4OJNjoXz
 Q4i6E+AeGMrDYEJ7vonqyMJCrH981X5lUq+8cb50A8g6gocuFjUX+iPYHNkTne0d3N3J27HOb
 RmwnN1GAuyKppvuzt2lUZ1DTFEtt3MKT9YmxxhVbE1esSnwNWrmdhTEjfn4tYqiihbGEGT8HG
 t6vdgekpFzdidHrjLNszOCI08AriliQiCyJMgbstv1Q9XR5sl9GVifU8BD5BnEa+4Z7TJdGsh
 idsWxlf7GxHWN5ZSzMMHC7IL3XqQLmQOkZuI/z5pgsuiVvpm4SF6AZ+Q+doBne5iclrnFjlih
 fhKTFlwvE3K159XiI1Gw7hsy9ryTIb5rVQkDRVBdKmNnRySNx0nho9+ztfsh7mb1Sr9ttEGA5
 1mKZDe4Ik/7EAms6xuBAsaWTr5gVnZoyozK7uErwp2VnqmkdDr9b7VI5u3fmXA1reYkyKlX0G
 Hx9zkSGsI72WxpRJZnerCFGWMzxA2tLxeBcJenrrAzsjeDejjHn3bJJtH4LjbTFq8PLUhDFw1
 1p7IPuDsx1Ahsv9hv4uwEsBCrDGL2Nf8hAHK7s4LgBZc0DxWBO0XFxxnYT2nlgaBXi7cvc5CO
 D307kD2HeE5SfgHh+PTtN0aKKflTFsbBiMqt0lGd20aOWVGqsTseulQcaGxtg0o5Nsfu/l6RL
 nJzO8m2O6mEn1FBswMPp5Mb3IK1Sn8FIE4F
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 21.06.21 um 22:49 schrieb Elijah Newren:
> On Sun, Jun 20, 2021 at 8:14 AM <andrzej@ahunt.org> wrote:
>> It looks like this leak has existed since realpath was first added to
>> set_git_work_tree() in:
>>   3d7747e318 (real_path: remove unsafe API, 2020-03-10)
>
> Looking at that commit, it appears to have introduced other problems.
> For example, the documentation for read_gitfile_gently() claims it
> returns a value from a shared buffer, but that commit got rid of the
> shared buffer so the documentation is no longer accurate.  The thing
> that is returned is either the path that was passed in, or some newly
> allocated path that differs, in which case the caller would be
> responsible to free() it, but it looks like the callers aren't doing
> so.

That comment is still correct.  The returned pointer references a shared
static buffer declared in read_gitfile_gently().  The control flow is a
bit hard to follow; path points to the static buffer if and only if
error_code is zero.  Using a dedicated variable for the result would
make that clearer, I think:

diff --git a/setup.c b/setup.c
index ead2f80cd8..75b0a4bea6 100644
=2D-- a/setup.c
+++ b/setup.c
@@ -720,86 +720,87 @@ void read_gitfile_error_die(int error_code, const ch=
ar *path, const char *dir)
 /*
  * Try to read the location of the git directory from the .git file,
  * return path to git directory if found. The return value comes from
  * a shared buffer.
  *
  * On failure, if return_error_code is not NULL, return_error_code
  * will be set to an error code and NULL will be returned. If
  * return_error_code is NULL the function will die instead (for most
  * cases).
  */
 const char *read_gitfile_gently(const char *path, int *return_error_code)
 {
 	const int max_file_size =3D 1 << 20;  /* 1MB */
 	int error_code =3D 0;
 	char *buf =3D NULL;
 	char *dir =3D NULL;
 	const char *slash;
 	struct stat st;
 	int fd;
 	ssize_t len;
 	static struct strbuf realpath =3D STRBUF_INIT;
+	const char *result =3D NULL;

 	if (stat(path, &st)) {
 		/* NEEDSWORK: discern between ENOENT vs other errors */
 		error_code =3D READ_GITFILE_ERR_STAT_FAILED;
 		goto cleanup_return;
 	}
 	if (!S_ISREG(st.st_mode)) {
 		error_code =3D READ_GITFILE_ERR_NOT_A_FILE;
 		goto cleanup_return;
 	}
 	if (st.st_size > max_file_size) {
 		error_code =3D READ_GITFILE_ERR_TOO_LARGE;
 		goto cleanup_return;
 	}
 	fd =3D open(path, O_RDONLY);
 	if (fd < 0) {
 		error_code =3D READ_GITFILE_ERR_OPEN_FAILED;
 		goto cleanup_return;
 	}
 	buf =3D xmallocz(st.st_size);
 	len =3D read_in_full(fd, buf, st.st_size);
 	close(fd);
 	if (len !=3D st.st_size) {
 		error_code =3D READ_GITFILE_ERR_READ_FAILED;
 		goto cleanup_return;
 	}
 	if (!starts_with(buf, "gitdir: ")) {
 		error_code =3D READ_GITFILE_ERR_INVALID_FORMAT;
 		goto cleanup_return;
 	}
 	while (buf[len - 1] =3D=3D '\n' || buf[len - 1] =3D=3D '\r')
 		len--;
 	if (len < 9) {
 		error_code =3D READ_GITFILE_ERR_NO_PATH;
 		goto cleanup_return;
 	}
 	buf[len] =3D '\0';
 	dir =3D buf + 8;

 	if (!is_absolute_path(dir) && (slash =3D strrchr(path, '/'))) {
 		size_t pathlen =3D slash+1 - path;
 		dir =3D xstrfmt("%.*s%.*s", (int)pathlen, path,
 			      (int)(len - 8), buf + 8);
 		free(buf);
 		buf =3D dir;
 	}
 	if (!is_git_directory(dir)) {
 		error_code =3D READ_GITFILE_ERR_NOT_A_REPO;
 		goto cleanup_return;
 	}

 	strbuf_realpath(&realpath, dir, 1);
-	path =3D realpath.buf;
+	result =3D realpath.buf;

 cleanup_return:
 	if (return_error_code)
 		*return_error_code =3D error_code;
 	else if (error_code)
 		read_gitfile_error_die(error_code, path, dir);

 	free(buf);
-	return error_code ? NULL : path;
+	return result;
 }

 static const char *setup_explicit_git_dir(const char *gitdirenv,
