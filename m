From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <l.s.r@web.de>
Subject: Re: [RFC PATCHv3] repack: rewrite the shell script in C.
Date: Sun, 18 Aug 2013 18:44:46 +0200
Message-ID: <5210F9FE.1080801@web.de>
References: <5210DB77.3090004@googlemail.com> <1376836587-25248-1-git-send-email-stefanbeller@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, mfick@codeaurora.org, apelisse@gmail.com,
	Matthieu.Moy@grenoble-inp.fr, pclouds@gmail.com, iveqy@iveqy.com,
	gitster@pobox.com
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Sun Aug 18 18:45:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VB66P-0001LJ-B0
	for gcvg-git-2@plane.gmane.org; Sun, 18 Aug 2013 18:45:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753957Ab3HRQpK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 18 Aug 2013 12:45:10 -0400
Received: from mout.web.de ([212.227.17.12]:51143 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753299Ab3HRQpJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Aug 2013 12:45:09 -0400
Received: from [192.168.2.102] ([79.250.178.242]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0MUFGo-1VbwOG1MbS-00Qwpq for <git@vger.kernel.org>;
 Sun, 18 Aug 2013 18:45:07 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
In-Reply-To: <1376836587-25248-1-git-send-email-stefanbeller@googlemail.com>
X-Provags-ID: V03:K0:VXkLJItgzdso3id9Zdhh+knLlFuWxOFHi5q2KOT721zykS43f0t
 JyzMd1JT0MP7Faga/1jTS+YGInCqEh3ChpXgtDM0jyraUAAQT64xOHEBoSmmTcd86Jwn5GJ
 7vKeqplWQp8vzoMLYn2urnzSpgBy0D8U4iSZ0dBbZTjt6d2F4PkpA/wKUzVov5ZpDVy+8u7
 Xc6hPHoWefUgOApgHM6bw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232481>

> +static void remove_temporary_files() {
> +	DIR *dir;
> +	struct dirent *e;
> +	char *prefix, *path;
> +
> +	prefix =3D mkpathdup(".tmp-%d-pack", getpid());
> +	path =3D mkpathdup("%s/pack", get_object_directory());
> +
> +	dir =3D opendir(path);
> +	while ((e =3D readdir(dir)) !=3D NULL) {
> +		if (!prefixcmp(e->d_name, prefix)) {
> +			struct strbuf fname =3D STRBUF_INIT;
> +			strbuf_addf(&fname, "%s/%s", path, e->d_name);
> +			unlink(strbuf_detach(&fname, NULL));

I'm not sure I like the memory allocation done here for each file to be
deleted, but it's probably not worth worrying about.

> +void get_pack_sha1_list(char *packdir, struct string_list *sha1_list=
)
> +{
> +	DIR *dir;
> +	struct dirent *e;
> +	char *path, *suffix;
> +
> +	path =3D mkpathdup("%s/pack", get_object_directory());
> +	suffix =3D ".pack";
> +
> +	dir =3D opendir(path);
> +	while ((e =3D readdir(dir)) !=3D NULL) {
> +		if (!suffixcmp(e->d_name, suffix)) {
> +			char *buf, *sha1;
> +			buf =3D xmemdupz(e->d_name, strlen(e->d_name));
> +			buf[strlen(e->d_name) - strlen(suffix)] =3D '\0';
> +			if (strlen(e->d_name) - strlen(suffix) > 40) {
> +				sha1 =3D &buf[strlen(e->d_name) - strlen(suffix) - 40];
> +				string_list_append_nodup(sha1_list, sha1);

Unless sha1 =3D=3D buf, this will crash when that string_list is freed
because sha1 was not returned by malloc.  If it doesn't crash for
you then I guess sha1_list is never freed. :)  How about just
taking the part of d_name we need, like this?

			size_t len =3D strlen(e->d_name) - strlen(suffix);
			if (len > 40) {
				char *sha1 =3D xmemdupz(e->d_name + len - 40, 40);
				string_list_append_nodup(sha1_list, sha1);
			}

> +			} else {
> +				/*TODO: what should happen to pack files having no 40 char sha1 =
specifier?*/

What does the current code do with them?  From a quick glance it
looks like it deletes them in the end, right?

Ren=E9
