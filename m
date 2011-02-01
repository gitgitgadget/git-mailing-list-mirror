From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH 1/3] vcs-svn: Introduce svnload, a dumpfile producer
Date: Tue, 1 Feb 2011 15:46:25 +0100
Message-ID: <AANLkTikUUojgj_H0r0L=XBi7H714xUvAS=vPsgMRNNjr@mail.gmail.com>
References: <1296570403-9082-1-git-send-email-artagnon@gmail.com> <1296570403-9082-2-git-send-email-artagnon@gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	David Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 01 15:46:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PkHVN-0003tZ-8W
	for gcvg-git-2@lo.gmane.org; Tue, 01 Feb 2011 15:46:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751923Ab1BAOqs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Feb 2011 09:46:48 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:55559 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751167Ab1BAOqr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Feb 2011 09:46:47 -0500
Received: by fxm20 with SMTP id 20so6876081fxm.19
        for <git@vger.kernel.org>; Tue, 01 Feb 2011 06:46:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=Xey/R5reoKoyKBHsoRS79rrwIQtuA5/1JaCbxh8KSJw=;
        b=hZr3SSQrpbdBki2W9frTFCFUr7Z1UIeFQy8LQID2CR4vI9woEzbf/ve08/9criLAcG
         YKlBlfw5IJTILVe5weMyjNkMAJ68ACs6hJ9XMF3DXD/wxGeGn4yYCWHWn/UCgsD2yRUH
         fwx4A9XbXl2CxhZbyYLIOLO2Ws9Aj4TrQAypQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=me+gacWiSs4f/zFmWjRHz7JmUsPMbqBLMEcnoaHSNmN1j8R+oFtJKRoonC7qZ7psBn
         GN68K5DkX5R2q1ToYyOLRPD6tyTCahaJB0BELCqK84YaYliPBUKqr6QPDKTzOXV5xW7O
         0DDQlEUXw5AGB7ul1Zfbm62XQrKsfzpkGvkuI=
Received: by 10.223.118.136 with SMTP id v8mr7528918faq.90.1296571605975; Tue,
 01 Feb 2011 06:46:45 -0800 (PST)
Received: by 10.223.116.210 with HTTP; Tue, 1 Feb 2011 06:46:25 -0800 (PST)
In-Reply-To: <1296570403-9082-2-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165811>

A very superficial review, because I don't have much time, and don't
know the surrounding code well. Sorry about that.

On Tue, Feb 1, 2011 at 3:26 PM, Ramkumar Ramachandra <artagnon@gmail.co=
m> wrote:
> diff --git a/vcs-svn/dir_cache.c b/vcs-svn/dir_cache.c
> new file mode 100644
> index 0000000..9a608ce
> --- /dev/null
> +++ b/vcs-svn/dir_cache.c
> @@ -0,0 +1,40 @@
> +/*
> + * Licensed under a two-clause BSD-style license.
> + * See LICENSE for details.
> + */
> +
> +#include "git-compat-util.h"
> +#include "string-list.h"
> +#include "line_buffer.h"
> +#include "dump_export.h"
> +
> +static struct string_list dirents =3D STRING_LIST_INIT_DUP;
> +static struct string_list_item *dir =3D NULL;
> +
> +void dir_cache_add(const char *path, enum node_kind kind) {

Style: we put the opening bracket of functions on the next line.

> + =A0 =A0 =A0 dir =3D string_list_insert(&dirents, path);
> + =A0 =A0 =A0 dir->util =3D malloc(sizeof(enum node_kind));
> + =A0 =A0 =A0 *((enum node_kind *)(dir->util)) =3D kind;

Unchecked malloc; perhaps you should use xmalloc instead?

> +}
> +
> +void dir_cache_remove(const char *path) {

Same style-violation as above.

> + =A0 =A0 =A0 dir =3D string_list_lookup(&dirents, path);
> + =A0 =A0 =A0 if (dir)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 *((enum node_kind *)(dir->util)) =3D NO=
DE_KIND_UNKNOWN;
> +}
> +
> +enum node_kind dir_cache_lookup(const char *path) {
> + =A0 =A0 =A0 dir =3D string_list_lookup(&dirents, path);
> + =A0 =A0 =A0 if (dir)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return *((enum node_kind *)(dir->util))=
;
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return NODE_KIND_UNKNOWN;
> +}
> +
> +void dir_cache_init() {
> + =A0 =A0 =A0 return;
> +}
> +
> +void dir_cache_deinit() {
> + =A0 =A0 =A0 string_list_clear(&dirents, 1);
> +}

Three more.

> +static void populate_revprops(struct strbuf *props, size_t author_le=
n,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 const char *author, siz=
e_t log_len, const char *log,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 size_t date_len, const =
char *date)
> +{
> + =A0 =A0 =A0 strbuf_reset(props);
> + =A0 =A0 =A0 strbuf_addf(props, "K 10\nsvn:author\nV %lu\n%s\n", aut=
hor_len, author);
> + =A0 =A0 =A0 strbuf_addf(props, "K 7\nsvn:log\nV %lu\n%s\n", log_len=
, log);
> + =A0 =A0 =A0 if (date_len)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* SVN doesn't like an empty svn:date v=
alue */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 strbuf_addf(props, "K 8\nsvn:date\nV %l=
u\n%s\n", date_len, date);

Perhaps a scope around here will make this a bit easier to read. At
first glance it looked like a missing scope to me, due to the indented
comment...

> + =A0 =A0 =A0 if (!val) die("Malformed author line");
> + =A0 =A0 =A0 if (!(tz_off =3D strrchr(val, ' '))) goto error;
> + =A0 =A0 =A0 *tz_off++ =3D '\0';
> + =A0 =A0 =A0 if (!(t =3D strrchr(val, ' '))) goto error;

style: use
"if (x)
	do_stuff();"
instead of
"if (x) do_stuff();"


> + =A0 =A0 =A0 *(t - 1) =3D '\0'; /* Ignore '>' from email */
> + =A0 =A0 =A0 t++;
> + =A0 =A0 =A0 tz_off_buf =3D atoi(tz_off);
> + =A0 =A0 =A0 if (tz_off_buf > 1200 || tz_off_buf =A0< -1200) goto er=
ror;

same

> + =A0 =A0 =A0 tm_time =3D time_to_tm(strtoul(t, NULL, 10), tz_off_buf=
);
> + =A0 =A0 =A0 strftime(time_buf, SVN_DATE_LEN + 1, SVN_DATE_FORMAT, t=
m_time);
> + =A0 =A0 =A0 strbuf_add(date, time_buf, SVN_DATE_LEN);
> + =A0 =A0 =A0 if (!(t =3D strchr(val, '<'))) goto error;

same

> +int parse_filemodify_mode(char *val)
> +{
> + =A0 =A0 =A0 char *t;
> +
> + =A0 =A0 =A0 if (!(t =3D strchr(val, ' '))) goto error;

same

> +void svnload_read(void)
> +{
> + =A0 =A0 =A0 char *t, *val;
> + =A0 =A0 =A0 int len;
> +
> + =A0 =A0 =A0 while ((t =3D buffer_read_line(&input))) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((val =3D strchr(t, ' ')))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *val++ =3D '\0';
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 len =3D (val ? val - t - 1 : strlen(t))=
;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 switch (len) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 case 1:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!memcmp(t, "D", 1))=
 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 node_ct=
x.action =3D NODE_ACTION_DELETE;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else if (!memcmp(t, "=
C", 1)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 node_ct=
x.action =3D NODE_ACTION_ADD;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else if (!memcmp(t, "=
R", 1)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 node_ct=
x.action =3D NODE_ACTION_REPLACE;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else if (!memcmp(t, "=
M", 1)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!va=
l) goto error;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 node_ct=
x.action =3D NODE_ACTION_CHANGE;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 val +=3D=
 parse_filemodify_mode(val);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!(t=
 =3D strchr(val, ' '))) goto error;

same
