From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH v2 5/6] http-fetch: Use index-pack rather than verify-pack 
	to check packs
Date: Fri, 16 Apr 2010 10:55:08 +0800
Message-ID: <g2sbe6fef0d1004151955g6fa785c0id852c91c78584b06@mail.gmail.com>
References: <201004152134.10555.j6t@kdbg.org>
	 <1271366704-25262-1-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	git@vger.kernel.org, Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Christian Halstrick <christian.halstrick@gmail.com>,
	jan.sievers@sap.com, Matthias Sohn <matthias.sohn@sap.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Apr 16 04:55:21 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2biA-00010y-5B
	for gcvg-git-2@lo.gmane.org; Fri, 16 Apr 2010 04:55:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757354Ab0DPCzK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 Apr 2010 22:55:10 -0400
Received: from mail-iw0-f197.google.com ([209.85.223.197]:61995 "EHLO
	mail-iw0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757282Ab0DPCzJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Apr 2010 22:55:09 -0400
Received: by mail-iw0-f197.google.com with SMTP id 35so1073242iwn.21
        for <git@vger.kernel.org>; Thu, 15 Apr 2010 19:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=tUI1ZdKmYRIf9Gh4/5JjcI+8SZorO4X88XifgVbY2XE=;
        b=Z7V9LeCqZ48zj2ONbnEbOiKm6QoKmXo+TQNToj3qdGY6hAZ9aBgXWkNEwD6vxarPcC
         Zi5xUZkg3q8fyZcJyIgbi9uQHv2Ac6QuHcDDKCV2lVwcuI3nKP1U8t4NxiG3Urzdb9kD
         O5uLQlkjLjmbPmo91V3R/+TzRAwKN9HsB5kq4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=l/18gudpA1SpaV8BxDmWpR3tD36ePDELBrGPBUYcdoGwxp8eixwRTBDfzQ2PSfUvgt
         FtLYsLvVxSW/blxkOeo1dCYB18Rjp+FJHedeZ3cENi7hIP9OEnx2uWf1pEz5lAFegGUi
         ETsHFcOlQcFfK8zTSBJm/qQ/lyPmU50FLaWPA=
Received: by 10.231.10.65 with HTTP; Thu, 15 Apr 2010 19:55:08 -0700 (PDT)
In-Reply-To: <1271366704-25262-1-git-send-email-spearce@spearce.org>
Received: by 10.231.147.199 with SMTP id m7mr347317ibv.87.1271386508380; Thu, 
	15 Apr 2010 19:55:08 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145047>

Hi,

On Fri, Apr 16, 2010 at 5:25 AM, Shawn O. Pearce <spearce@spearce.org> =
wrote:
> By recreating the index file locally, we also can automatically
> upgrade from a v1 pack table of contents to v2. =A0This makes the
> CRC32 data available for use during later repacks, even if the
> server didn't have them on hand.

This is exceedingly interesting.

> diff --git a/cache.h b/cache.h
> index 5eb0573..4150603 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -916,6 +916,7 @@ extern struct packed_git *find_sha1_pack(const un=
signed char *sha1,
>
> =A0extern void pack_report(void);
> =A0extern int open_pack_index(struct packed_git *);
> +extern void close_pack_index(struct packed_git *);
> =A0extern unsigned char *use_pack(struct packed_git *, struct pack_wi=
ndow **, off_t, unsigned int *);
> =A0extern void close_pack_windows(struct packed_git *);
> =A0extern void unuse_pack(struct pack_window **);
> [snip]
> diff --git a/sha1_file.c b/sha1_file.c
> index ff65328..820063e 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -599,6 +599,14 @@ void unuse_pack(struct pack_window **w_cursor)
> =A0 =A0 =A0 =A0}
> =A0}
>
> +void close_pack_index(struct packed_git *p)
> +{
> + =A0 =A0 =A0 if (p->index_data) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 munmap((void *)p->index_data, p->index_=
size);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 p->index_data =3D NULL;
> + =A0 =A0 =A0 }
> +}
> +
> =A0/*
> =A0* This is used by git-repack in case a newly created pack happens =
to
> =A0* contain the same set of objects as an existing one. =A0In that c=
ase
> @@ -620,8 +628,7 @@ void free_pack_by_name(const char *pack_name)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0close_pack_windows(p);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (p->pack_fd !=3D -1=
)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0close(=
p->pack_fd);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (p->index_data)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 munmap(=
(void *)p->index_data, p->index_size);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 close_pack_index(p);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0free(p->bad_object_sha=
1);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*pp =3D p->next;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0free(p);

Perhaps these could go into a separate patch.

> diff --git a/http.c b/http.c
> index 64e0c18..aa3e380 100644
> --- a/http.c
> +++ b/http.c
> [snip]
> @@ -1014,13 +1017,37 @@ int finish_http_pack_request(struct http_pack=
_request *preq)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0lst =3D &((*lst)->next);
> =A0 =A0 =A0 =A0*lst =3D (*lst)->next;
>
> - =A0 =A0 =A0 ret =3D move_temp_to_file(preq->tmpfile, preq->filename=
);
> [snip]
> + =A0 =A0 =A0 if (move_temp_to_file(preq->tmpfile, sha1_pack_name(p->=
sha1))
> [snip]
> @@ -1043,7 +1070,6 @@ struct http_pack_request *new_http_pack_request=
(
> =A0 =A0 =A0 =A0preq->url =3D strbuf_detach(&buf, NULL);
>
> =A0 =A0 =A0 =A0filename =3D sha1_pack_name(target->sha1);
> - =A0 =A0 =A0 snprintf(preq->filename, sizeof(preq->filename), "%s", =
filename);
> =A0 =A0 =A0 =A0snprintf(preq->tmpfile, sizeof(preq->tmpfile), "%s.tem=
p", filename);
> =A0 =A0 =A0 =A0preq->packfile =3D fopen(preq->tmpfile, "a");
> =A0 =A0 =A0 =A0if (!preq->packfile) {
> [snip]
> diff --git a/http.h b/http.h
> index 5c9441c..e4a8126 100644
> --- a/http.h
> +++ b/http.h
> @@ -152,7 +152,6 @@ struct http_pack_request
> =A0 =A0 =A0 =A0struct packed_git *target;
> =A0 =A0 =A0 =A0struct packed_git **lst;
> =A0 =A0 =A0 =A0FILE *packfile;
> - =A0 =A0 =A0 char filename[PATH_MAX];
> =A0 =A0 =A0 =A0char tmpfile[PATH_MAX];
> =A0 =A0 =A0 =A0struct curl_slist *range_header;
> =A0 =A0 =A0 =A0struct active_request_slot *slot;

Why this change? Just curious, nothing strong against it.

> + =A0 =A0 =A0 tmp_idx =3D xstrdup(preq->tmpfile);
> + =A0 =A0 =A0 strcpy(tmp_idx + strlen(tmp_idx) - strlen(".pack.temp")=
,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0".idx.temp");

Could we use a strbuf here?

> [snip]
> + =A0 =A0 =A0 if (move_temp_to_file(preq->tmpfile, sha1_pack_name(p->=
sha1))
> + =A0 =A0 =A0 =A0|| move_temp_to_file(tmp_idx, sha1_pack_index_name(p=
->sha1))) {

Hmm, when moving the pack index file, should we unlink() the old,
downloaded one first?

--=20
Cheers,
Ray Chuan
