From: Stefan Beller <stefanbeller@googlemail.com>
Subject: Re: [PATCH 1/2] repack: rewrite the shell script in C
Date: Sun, 15 Sep 2013 17:31:28 +0200
Message-ID: <5235D2D0.9030203@googlemail.com>
References: <1377808774-12505-1-git-send-email-stefanbeller@googlemail.com> <1377808774-12505-2-git-send-email-stefanbeller@googlemail.com> <52359D10.1060901@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Sun Sep 15 17:31:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VLEIE-0003NI-O7
	for gcvg-git-2@plane.gmane.org; Sun, 15 Sep 2013 17:31:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756964Ab3IOPbS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 Sep 2013 11:31:18 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:63879 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756894Ab3IOPbS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Sep 2013 11:31:18 -0400
Received: by mail-ee0-f46.google.com with SMTP id c13so1513317eek.19
        for <git@vger.kernel.org>; Sun, 15 Sep 2013 08:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=wZV5nLrH3yQ5Ta1MgUOLUjVIcyQP8Q7doawMCMXvNnY=;
        b=eCHj2nWqlBlDdtfVJvwQjvfZJRAnJy0B1PGA9GdWXt8As/gH4cYMoNZbZN3LApvWOU
         yS6p0NBvNCFq6uOl60kpsepOm00XO91GzUb1EqYJqV7gtobUASobvWxluMxMSHZkwHSJ
         HE8WKPwNgNACqdDDj6Dh0+brd1xDcjp1pZFQPzynyutF1qkYG96/BIQ+pK/WYvuLvXPz
         FAdSp429iuXFXk90CcAVP0RThYiFpfyIH/RaerB61Wo9ZNwRsyD1luV7Xll3MGb8cAd+
         EXX+Sz+IfjSDv0FzGvZZCZMuql0PcHEyWXtMRE6zorzONllKp74zvbyo73uV+JcRP2N0
         4PKw==
X-Received: by 10.14.177.199 with SMTP id d47mr35505026eem.14.1379259076439;
        Sun, 15 Sep 2013 08:31:16 -0700 (PDT)
Received: from [192.168.1.3] (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id a43sm33709454eep.9.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 15 Sep 2013 08:31:15 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130803 Thunderbird/17.0.8
In-Reply-To: <52359D10.1060901@web.de>
X-Enigmail-Version: 1.4.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234817>

Rene, thank you very much for the review!

On 09/15/2013 01:42 PM, Ren=E9 Scharfe wrote:

>> +static void remove_temporary_files(void)
>> +{
>> +    struct strbuf buf =3D STRBUF_INIT;
>> +    size_t dirlen, prefixlen;
>> +    DIR *dir;
>> +    struct dirent *e;
>> +
>> +    dir =3D opendir(packdir);
>> +    if (!dir)
>> +        return;
>> +
>> +    strbuf_addstr(&buf, packdir);
>=20
> Let's say packdir is ".git/objects/pack" (no trailing slash).  Then b=
uf
> is ".git/objects/pack" now as well.
>=20
>> +
>> +    /* Point at the slash at the end of ".../objects/pack/" */
>> +    dirlen =3D buf.len + 1;
>> +    strbuf_addf(&buf, "%s", packtmp);
>=20
> packtmp starts with packdir, so by adding it here we have it twice.  =
buf
> is now ".git/objects/pack.git/objects/pack/.tmp-123-pack" (if our pid=
 is
> 123), no?
>=20
> Perhaps don't add the packdir to the strbuf in the first place and
> calculate dirlen as strlen(packdir) + 1?
>=20
> Besided, strbuf_addstr(x, y) is better for adding a string than
> strbuf_addf(x, "%s", y).

Oops, thanks for catching that. I'll be sending a fixup commit.

>=20
>> +    /* Point at the dash at the end of ".../.tmp-%d-pack-" */
>> +    prefixlen =3D buf.len - dirlen;
>=20
> This is the length of "git/objects/pack/.tmp-123-pack" now.

Also fixed.


>> +static void get_non_kept_pack_filenames(struct string_list *fname_l=
ist)
>> +{
>> +    DIR *dir;
>> +    struct dirent *e;
>> +    char *fname;
>> +    size_t len;
>> +
>> +    if (!(dir =3D opendir(packdir)))
>> +        return;
>> +
>> +    while ((e =3D readdir(dir)) !=3D NULL) {
>> +        if (suffixcmp(e->d_name, ".pack"))
>> +            continue;
>> +
>> +        len =3D strlen(e->d_name) - strlen(".pack");
>> +        fname =3D xmemdupz(e->d_name, len);
>> +
>> +        if (!file_exists(mkpath("%s/%s.keep", packdir, fname)))
>> +            string_list_append_nodup(fname_list, fname);
>=20
> This leaks fname for packs with .keep files.
>=20

fixed.

>> +static void remove_redundant_pack(const char *path_prefix, const ch=
ar
>> *hex)
>> +{
>> +    const char *exts[] =3D {".pack", ".idx", ".keep"};
>> +    int i;
>> +    struct strbuf buf =3D STRBUF_INIT;
>> +    size_t plen;
>> +
>> +    strbuf_addf(&buf, "%s/%s", path_prefix, hex);
>> +    plen =3D buf.len;
>> +
>> +    for (i =3D 0; i < ARRAY_SIZE(exts); i++) {
>> +        strbuf_setlen(&buf, plen);
>> +        strbuf_addstr(&buf, exts[i]);
>> +        unlink(buf.buf);
>> +    }
>> +}
>=20
> hex must also include the "pack-" prefix and path_prefix must be a
> directory name.  Perhaps call them base_name and dir_name or similar =
to
> make that clearer?
>=20
> buf is leaked.


buf will be freed.

the parameter hex contains the "pack-" already.
The remove_redundant_pack function is called in a loop iterating over
elements of existing_packs, which is filled in get_non_kept_pack_filena=
mes,
which doesn't fill in the hex, but filenames without extension.

I'll rename the variables to base_name and dir_name as you suggested.


>> +    failed =3D 0;
>> +    for_each_string_list_item(item, &names) {
>> +        for (ext =3D 0; ext < 2; ext++) {
>> +            char *fname, *fname_old;
>> +            fname =3D mkpathdup("%s/%s%s", packdir,
>> +                        item->string, exts[ext]);
>> +            if (!file_exists(fname)) {
>> +                free(fname);
>> +                continue;
>> +            }
>> +
>> +            fname_old =3D mkpath("%s/old-%s%s", packdir,
>> +                        item->string, exts[ext]);
>> +            if (file_exists(fname_old))
>> +                if (unlink(fname_old))
>> +                    failed =3D 1;
>> +
>> +            if (!failed && rename(fname, fname_old)) {
>> +                failed =3D 1;
>> +                break;
>=20
> This leaks fname.

will fix.

>> +            if (rename(fname_old, fname))
>> +                die_errno(_("renaming '%s' failed"), fname_old);
>=20
> The Shell script exits silently in that case.  How about 	improving e=
rror
> reporting in a separate patch?

Moved out of the main patch.


>> +            if (remove_path(fname))
>> +                warning(_("removing '%s' failed"), fname);
>=20
> Similar case here: The Shell script continues silently.
>=20

here as well.

>=20
> If you take care to clear the argv_arrays then perhaps do the same fo=
r
> the string_lists?  The OS cleans up after us anyway, but calming
> Valgrind or similar leak checkers is a good practice nevertheless.
>=20

I'll do it.


So here are the changes, I'll resend the series as well.

--8<--
=46rom 63c94df8c74c6643d6291c324661a939b9945619 Mon Sep 17 00:00:00 200=
1
=46rom: Stefan Beller <stefanbeller@googlemail.com>
Date: Sun, 15 Sep 2013 17:05:49 +0200
Subject: [PATCH 1/2] Suggestions by Rene

---
 builtin/repack.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index a0314be..d345d16 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -39,12 +39,10 @@ static void remove_temporary_files(void)
 	if (!dir)
 		return;
=20
-	strbuf_addstr(&buf, packdir);
-
 	/* Point at the slash at the end of ".../objects/pack/" */
-	dirlen =3D buf.len + 1;
-	strbuf_addf(&buf, "%s", packtmp);
-	/* Point at the dash at the end of ".../.tmp-%d-pack-" */
+	dirlen =3D strlen(packdir) + 1;
+	strbuf_addstr(&buf, packtmp);
+	/* Hold the length of  ".tmp-%d-pack-" */
 	prefixlen =3D buf.len - dirlen;
=20
 	while ((e =3D readdir(dir))) {
@@ -88,6 +86,8 @@ static void get_non_kept_pack_filenames(struct string=
_list *fname_list)
=20
 		if (!file_exists(mkpath("%s/%s.keep", packdir, fname)))
 			string_list_append_nodup(fname_list, fname);
+		else
+			free(fname);
 	}
 	closedir(dir);
 }
@@ -107,6 +107,7 @@ static void remove_redundant_pack(const char *path_=
prefix, const char *hex)
 		strbuf_addstr(&buf, exts[i]);
 		unlink(buf.buf);
 	}
+	strbuf_release(&buf);
 }
=20
 #define ALL_INTO_ONE 1
@@ -273,10 +274,12 @@ int cmd_repack(int argc, const char **argv, const=
 char *prefix)
 					failed =3D 1;
=20
 			if (!failed && rename(fname, fname_old)) {
+				free(fname);
 				failed =3D 1;
 				break;
+			} else {
+				string_list_append(&rollback, fname);
 			}
-			string_list_append(&rollback, fname);
 		}
 		if (failed)
 			break;
@@ -324,7 +327,7 @@ int cmd_repack(int argc, const char **argv, const c=
har *prefix)
 				chmod(fname_old, statbuffer.st_mode);
 			}
 			if (rename(fname_old, fname))
-				die_errno(_("renaming '%s' failed"), fname_old);
+				exit(errno);
 			free(fname);
 			free(fname_old);
 		}
@@ -338,8 +341,7 @@ int cmd_repack(int argc, const char **argv, const c=
har *prefix)
 					packdir,
 					item->string,
 					exts[ext]);
-			if (remove_path(fname))
-				warning(_("removing '%s' failed"), fname);
+			remove_path(fname);
 		}
 	}
=20
@@ -376,5 +378,10 @@ int cmd_repack(int argc, const char **argv, const =
char *prefix)
 		argv_array_clear(&cmd_args);
 	}
 	remove_temporary_files();
+	string_list_clear(&names, 0);
+	string_list_clear(&rollback, 0);
+	string_list_clear(&existing_packs, 0);
+	strbuf_release(&line);
+
 	return 0;
 }
--=20
1.8.4.273.ga194ead
