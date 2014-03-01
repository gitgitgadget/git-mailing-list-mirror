From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: Branch Name Case Sensitivity
Date: Sat, 01 Mar 2014 07:54:46 +0100
Message-ID: <53118436.5080507@web.de>
References: <CAJHY66EQD280QgXBCoZU4y_aqSEu3A1hXzeW7X-rtT6vMZ92oA@mail.gmail.com>	<xmqqvbw0xrl6.fsf@gitster.dls.corp.google.com>	<530FA0C1.3000109@web.de>	<530FBB1D.3050505@gmail.com>	<CAJHY66FtC03YbJrbVn+adsePkYnVD2RGH1TGkzz2pKNBoee_iQ@mail.gmail.com>	<53102FB0.6040603@viscovery.net>	<5310959D.709@gmail.com>	<xmqqk3cfuksd.fsf@gitster.dls.corp.google.com>	<CACsJy8A6etyFkxn3D7hjM9JgzmokPBARXrEncVuw1x+OOHJ_Lg@mail.gmail.com>	<xmqq7g8eu891.fsf@gitster.dls.corp.google.com> <CAJHY66EP539ZsLJcmHcnRQcOqcLqXK-M45wME9DkKkqmumg8fA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Duy Nguyen <pclouds@gmail.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	=?ISO-8859-1?Q?Torsten_B=F6gersh?= =?ISO-8859-1?Q?ausen?= 
	<tboegi@web.de>, Git Mailing List <git@vger.kernel.org>
To: Lee Hopkins <leerhop@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 01 07:54:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJdp0-0003E7-KZ
	for gcvg-git-2@plane.gmane.org; Sat, 01 Mar 2014 07:54:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752157AbaCAGyt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Mar 2014 01:54:49 -0500
Received: from mout.web.de ([212.227.15.3]:58406 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751588AbaCAGys (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2014 01:54:48 -0500
Received: from [192.168.209.26] ([78.72.74.102]) by smtp.web.de (mrweb003)
 with ESMTPSA (Nemesis) id 0LopdT-1Wqo2f3oj5-00gm2a for <git@vger.kernel.org>;
 Sat, 01 Mar 2014 07:54:47 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
In-Reply-To: <CAJHY66EP539ZsLJcmHcnRQcOqcLqXK-M45wME9DkKkqmumg8fA@mail.gmail.com>
X-Provags-ID: V03:K0:n5Jw4R/eEiTPwwEqcbYaY0Ol+LXQPlh03H8VC6ikVXSRls2NGuW
 +zA2YqkMixMw7GxOM6S3r3sKjnhjX7swHcX/fwvs0b08j5h+pbMaVxDayiygnL86zzCMZfn
 /VLaN+2ypgkH/LSmxlBEnhdmYsEcJAjYt6XXcqBYE/WKr4HBmkb3aKUedWpyZRGlbbMy5eo
 VdnBn6asM8b7NH7xi4uqw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243047>

On 2014-03-01 03.42, Lee Hopkins wrote:
> I went ahead and took a stab at a solution. My solution is more
> aggressive than a warning, I actually prevent the creation of
> ambiguous refs. My changes are also in refs.c, which may not be
> appropriate, but it seemed like the natural place.
> 
> I have never contributed to Git (in fact this is my first dive into
> the source) and my C is a bit rusty, so bear with me, this is just a
> suggestion:
> 
> ---
>  refs.c |   31 ++++++++++++++++++++++++-------
>  1 files changed, 24 insertions(+), 7 deletions(-)
> 
> diff --git a/refs.c b/refs.c
> index 89228e2..12ccdac 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -359,14 +359,24 @@ struct string_slice {
>   const char *str;
>  };
> 
> +static int ref_entry_ncmp(const void *key_, const void *ent_, int
> (*cmp_fn)(const char *, const char *, size_t))
> +{
> +    const struct string_slice *key = key_;
> +    const struct ref_entry *ent = *(const struct ref_entry * const *)ent_;
> +    int cmp = cmp_fn(key->str, ent->name, key->len);
> +    if (cmp)
> +        return cmp;
> +    return '\0' - (unsigned char)ent->name[key->len];
> +}
> +
>  static int ref_entry_cmp_sslice(const void *key_, const void *ent_)
>  {
> - const struct string_slice *key = key_;
> - const struct ref_entry *ent = *(const struct ref_entry * const *)ent_;
> - int cmp = strncmp(key->str, ent->name, key->len);
> - if (cmp)
> - return cmp;
> - return '\0' - (unsigned char)ent->name[key->len];
> + return ref_entry_ncmp(key_, ent_, strncmp);
> +}
> +
> +static int ref_entry_casecmp_sslice(const void *key_, const void *ent_)
> +{
> +    return ref_entry_ncmp(key_, ent_, strncasecmp);
>  }
> 
>  /*
> @@ -378,6 +388,7 @@ static int search_ref_dir(struct ref_dir *dir,
> const char *refname, size_t len)
>  {
>   struct ref_entry **r;
>   struct string_slice key;
> +    int (*cmp_fn)(const void *, const void *);
> 
>   if (refname == NULL || !dir->nr)
>   return -1;
> @@ -385,8 +396,14 @@ static int search_ref_dir(struct ref_dir *dir,
> const char *refname, size_t len)
>   sort_ref_dir(dir);
>   key.len = len;
>   key.str = refname;
> +
> +    if(ignore_case)
Only looking at ignore_case here closes the door for people
who have a branch "foo" and "Foo" at the same time.
(Which means that they are carefully running git pack-refs)
How about something like this:
 +    if (refs_ignore_case < 0)
 +      refs_ignore_case = ignore_case;
 +    if (refs_ignore_case)
(And then we need the diff further down on top of this.)
(And of course Documentation/config.txt)
The main motivation is that you can set refs.ignorecase == true on
e.g. Linux, to prevent to have branches "Foo" and "foo" at the same time,
which gives problems when pulling into e.g. Windows/Mac OS
> +        cmp_fn = ref_entry_casecmp_sslice;
> +    else
> +        cmp_fn = ref_entry_cmp_sslice;
> +
>   r = bsearch(&key, dir->entries, dir->nr, sizeof(*dir->entries),
> -    ref_entry_cmp_sslice);
> +    cmp_fn);
> 
>   if (r == NULL)
>   return -1;
> --




diff --git a/builtin/init-db.c b/builtin/init-db.c
index c7c76bb..dbfc61f 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -288,8 +288,10 @@ static int create_default_files(const char *template_path)
                /* Check if the filesystem is case-insensitive */
                path[len] = 0;
                strcpy(path + len, "CoNfIg");
-               if (!access(path, F_OK))
-                       git_config_set("core.ignorecase", "true");
+               if (!access(path, F_OK)) {
+                       git_config_set("core.ignorecase", "true");
+                       git_config_set("refs.ignorecase", "true");
+               }
                probe_utf8_pathname_composition(path, len);
        }
 
diff --git a/config.c b/config.c
index d969a5a..8f1ec81 100644
--- a/config.c
+++ b/config.c
@@ -698,6 +698,11 @@ static int git_default_core_config(const char *var, const char *value)
                return 0;
        }
 
+       if (!strcmp(var, "refs.ignorecase")) {
+               refs_ignore_case = git_config_bool(var, value);
+               return 0;
+       }
+
        if (!strcmp(var, "core.attributesfile"))
                return git_config_pathname(&git_attributes_file, var, value);
 
diff --git a/environment.c b/environment.c
index 4a3437d..2eced48 100644
--- a/environment.c
+++ b/environment.c
@@ -18,6 +18,7 @@ int check_stat = 1;
 int has_symlinks = 1;
 int minimum_abbrev = 4, default_abbrev = 7;
 int ignore_case;
+int refs_ignore_case = -1;
 int assume_unchanged;
 int prefer_symlink_refs;
 int is_bare_repository_cfg = -1; /* unspecified */
