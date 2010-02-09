From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 2/4] rev-parse: make --git-dir return /.git instead of //.git
Date: Tue, 9 Feb 2010 20:18:55 +0100
Message-ID: <201002092018.55951.j6t@kdbg.org>
References: <1265734950-15145-1-git-send-email-pclouds@gmail.com> <1265734950-15145-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?q?Jo=C3=A3o_Carlos_Mendes_Lu=C3=ADs?= <jonny@jonny.eng.br>,
	Junio C Hamano <gitster@pobox.com>
To: =?utf-8?q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 09 20:20:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NevdJ-0000kv-4k
	for gcvg-git-2@lo.gmane.org; Tue, 09 Feb 2010 20:20:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751900Ab0BITUU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Feb 2010 14:20:20 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:50321 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751651Ab0BITUT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2010 14:20:19 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 55E722C4017;
	Tue,  9 Feb 2010 20:20:18 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 0D05019F6B8;
	Tue,  9 Feb 2010 20:18:56 +0100 (CET)
User-Agent: KMail/1.9.10
In-Reply-To: <1265734950-15145-2-git-send-email-pclouds@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139433>

On Dienstag, 9. Februar 2010, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy=
 wrote:
> @@ -647,7 +647,7 @@ int cmd_rev_parse(int argc, const char **argv, co=
nst
> char *prefix) }
>  				if (!getcwd(cwd, PATH_MAX))
>  					die_errno("unable to get current working directory");
> -				printf("%s/.git\n", cwd);
> +				printf("%s%s.git\n", cwd, *cwd =3D=3D '/' && cwd[1] =3D=3D '\0' =
? "" : "/");

On Windows, when you are in the root of a drive, then cwd is "C:/", i.e=
=2E there=20
is a trailing slash just as in the Unix root directory. But you do not =
take=20
care of this situation. That is, you would print "C://".

How about:

static inline int is_root_path(const char *path)
{
	if (has_dos_drive_prefix(path))
		path +=3D 2;
	while (is_dir_sep(*path))
		path++;
	return !*path;
}

and use it though-out your series?

(Simplify the loop to 'return is_dir_sep(*path) && !path[1];' if you ca=
n=20
assume that paths are nomalized.)

-- Hannes
