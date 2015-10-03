From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 41/68] init: use strbufs to store paths
Date: Sat, 03 Oct 2015 09:54:08 -0700
Message-ID: <xmqqtwq73nbj.fsf@gitster.mtv.corp.google.com>
References: <20150924210225.GA23624@sigill.intra.peff.net>
	<20150924210736.GL30946@sigill.intra.peff.net>
	<CAO2U3QjunOPoAbGSRjAmCwfk-TnoMveXOJhpb351eh1a_3Xp3A@mail.gmail.com>
	<20150930002347.GA23406@sigill.intra.peff.net>
	<560F6E98.8030305@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Michael Blume <blume.mike@gmail.com>,
	Git List <git@vger.kernel.org>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sat Oct 03 18:54:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZiQ4e-00042s-OW
	for gcvg-git-2@plane.gmane.org; Sat, 03 Oct 2015 18:54:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750758AbbJCQyM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 3 Oct 2015 12:54:12 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:35988 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750733AbbJCQyL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Oct 2015 12:54:11 -0400
Received: by pablk4 with SMTP id lk4so133900741pab.3
        for <git@vger.kernel.org>; Sat, 03 Oct 2015 09:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=9DPa1QyTik0dZ8gBNECG28VJTYtbHLo4j84U4AmyNC4=;
        b=cpFl180U7VRE4Z7BU4yumHo0iZtFGlMdX2BC3zswCsv7qo5EoAATlcQh0BPFAc3EPa
         FjSYrBYl5OPmS/+dRkGZzUGEgIdgY0h8YU4IvJLqc7n2Mvej+j6bSnkbX54iwkY/03CK
         H875eIYlGqduP0W1hIjg0DF21zZPMvGuffFEEp/VyAVHuF6hmcL5SpHJPOzxYLXSkRpa
         VwLFKXcLcMPaUkl9AKwFKQexU0EtLOCU/MmzdhIy3ZMMc1zKEI8fjXMBI1GCqPXOnZKM
         aAIj2JBxC6YwYwTAtliB6OEOclK3wnhopA5n/D7slW4VQBempM9XgcHqgaq68sZnFcK7
         FiHg==
X-Received: by 10.66.221.193 with SMTP id qg1mr28706280pac.103.1443891250683;
        Sat, 03 Oct 2015 09:54:10 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:6403:45be:a5c3:ebf3])
        by smtp.gmail.com with ESMTPSA id d13sm18362916pbu.17.2015.10.03.09.54.09
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 03 Oct 2015 09:54:09 -0700 (PDT)
In-Reply-To: <560F6E98.8030305@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of
	"Sat, 3 Oct 2015 07:58:48 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278975>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> On 30.09.15 02:23, Jeff King wrote:
>> On Tue, Sep 29, 2015 at 04:50:39PM -0700, Michael Blume wrote:
>>=20
>>> I see compile errors on my mac:
>>>
>
> This is my attempt, passing the test, but not fully polished.

Thanks.

> diff --git a/builtin/init-db.c b/builtin/init-db.c
> index 89f2c05..60b559c 100644
> --- a/builtin/init-db.c
> +++ b/builtin/init-db.c
> @@ -276,7 +276,9 @@ static int create_default_files(const char *templ=
ate_path)
>  		path =3D git_path_buf(&buf, "CoNfIg");
>  		if (!access(path, F_OK))
>  			git_config_set("core.ignorecase", "true");
> -		probe_utf8_pathname_composition(path);
> +		/* Probe utf-8 normalization withou mangling CoNfIG */
> +		path =3D git_path_buf(&buf, "config");
> +		probe_utf8_pathname_composition(path, strlen(path));

Hmph, Peff's quick-fix passed the original "CoNfIg" in &buf directly
to probe_utf8_pathname_composition() without changing its signature.

What is the reason behind these two changes?  i.e. why is it
inappropriate to use "CoNfIg" (and append the auml to it to use for
the checking) and why does the function need to take pointer + len,
only to store it in another strbuf itself?

> diff --git a/compat/precompose_utf8.c b/compat/precompose_utf8.c
> index b4dd3c7..37172a4 100644
> --- a/compat/precompose_utf8.c
> +++ b/compat/precompose_utf8.c
> @@ -8,6 +8,7 @@
>  #include "cache.h"
>  #include "utf8.h"
>  #include "precompose_utf8.h"
> +#include "strbuf.h"
> =20
>  typedef char *iconv_ibp;
>  static const char *repo_encoding =3D "UTF-8";
> @@ -36,28 +37,33 @@ static size_t has_non_ascii(const char *s, size_t=
 maxlen, size_t *strlen_c)
>  }
> =20
> =20
> -void probe_utf8_pathname_composition(struct strbuf *path)
> +void probe_utf8_pathname_composition(char *path, int len)
>  {
>  	static const char *auml_nfc =3D "\xc3\xa4";
>  	static const char *auml_nfd =3D "\x61\xcc\x88";
> -	size_t baselen =3D path->len;
> +	struct strbuf sbuf;
>  	int output_fd;
>  	if (precomposed_unicode !=3D -1)
>  		return; /* We found it defined in the global config, respect it */
> -	strbuf_addstr(path, auml_nfc);
> -	output_fd =3D open(path, O_CREAT|O_EXCL|O_RDWR, 0600);
> +	strbuf_init(&sbuf, len+3);
> +	strbuf_add(&sbuf, path, len);
> +	strbuf_addstr(&sbuf, auml_nfc);
> +	output_fd =3D open(sbuf.buf, O_CREAT|O_EXCL|O_RDWR, 0600);
> +	fprintf(stderr, "%s/%s:%d sbuf.buf=3D%s\n",
> +					__FILE__, __FUNCTION__, __LINE__, sbuf.buf);
>  	if (output_fd >=3D 0) {
>  		close(output_fd);
> -		strbuf_setlen(path, baselen);
> -		strbuf_addstr(path, auml_nfd);
> +		strbuf_setlen(&sbuf, len);
> +		strbuf_addstr(&sbuf, auml_nfd);
> +	fprintf(stderr, "%s/%s:%d sbuf.buf=3D%s\n",
> +					__FILE__, __FUNCTION__, __LINE__, sbuf.buf);
>  		precomposed_unicode =3D access(path, R_OK) ? 0 : 1;
>  		git_config_set("core.precomposeunicode", precomposed_unicode ? "tr=
ue" : "false");
> -		strbuf_setlen(path, baselen);
> -		strbuf_addstr(path, auml_nfc);
> +		strcpy(path + len, auml_nfc);
>  		if (unlink(path))
>  			die_errno(_("failed to unlink '%s'"), path);
>  	}
> -	strbuf_setlen(path, baselen);
> +	strbuf_release(&sbuf);
>  }
> =20
> =20
> diff --git a/compat/precompose_utf8.h b/compat/precompose_utf8.h
> index 7fc7be5..3b73585 100644
> --- a/compat/precompose_utf8.h
> +++ b/compat/precompose_utf8.h
> @@ -27,7 +27,7 @@ typedef struct {
>  } PREC_DIR;
> =20
>  void precompose_argv(int argc, const char **argv);
> -void probe_utf8_pathname_composition(struct strbuf *path);
> +void probe_utf8_pathname_composition(char *, int);
> =20
>  PREC_DIR *precompose_utf8_opendir(const char *dirname);
>  struct dirent_prec_psx *precompose_utf8_readdir(PREC_DIR *dirp);
