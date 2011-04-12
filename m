From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: git archive: tar.umask ignored
Date: Tue, 12 Apr 2011 20:19:35 +0200
Message-ID: <4DA497B7.706@lsrfire.ath.cx>
References: <BANLkTimTs+Qh9fNs6pLcZidYy-YjXNR2iw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jacek Masiulaniec <jacekm@dobremiasto.net>
X-From: git-owner@vger.kernel.org Tue Apr 12 20:20:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9iCE-0005lT-1f
	for gcvg-git-2@lo.gmane.org; Tue, 12 Apr 2011 20:20:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932317Ab1DLSUG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Apr 2011 14:20:06 -0400
Received: from india601.server4you.de ([85.25.151.105]:52141 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932289Ab1DLSUF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Apr 2011 14:20:05 -0400
Received: from [192.168.2.103] (p4FFDBE81.dip.t-dialin.net [79.253.190.129])
	by india601.server4you.de (Postfix) with ESMTPSA id D08FC2F806F;
	Tue, 12 Apr 2011 20:20:02 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; de; rv:1.9.2.15) Gecko/20110303 Thunderbird/3.1.9
In-Reply-To: <BANLkTimTs+Qh9fNs6pLcZidYy-YjXNR2iw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171408>

Am 12.04.2011 11:39, schrieb Jacek Masiulaniec:
> Hello git@,
>
> I believe git has an issue with command line override of configuratio=
n options.
> Notice how in both cases below the file mode is 775 despite tar.umask
> difference:
>
> [jacekm@localhost git]$ ./git --version
> git version 1.7.4.4
> [jacekm@localhost git]$ ./git archive --remote=3D/repo/website.git HE=
AD
> | tar -tvf - | head -1
> drwxrwxr-x root/root         0 2011-04-11 13:47:09 bin/
> [jacekm@localhost git]$ ./git -c tar.umask=3D0022 archive
> --remote=3D/repo/website.git HEAD | tar -tvf - | head -1
> drwxrwxr-x root/root         0 2011-04-11 13:47:09 bin/
> [jacekm@localhost git]$
>
> In contrast, tweaking tar.umask in ~/.gitconfig does have the desired
> impact on the file mode.

The local setting of tar.umask does not affect the archive created at=20
the remote end.  If your "remote" repository is in fact located on the=20
same machine and accessed with the same user then of course settings in=
=20
~/.gitconfig will take effect.

If --remote is specified then the local archive process just passes all=
=20
command line options (except --remote itself, --output and --exec) to=20
the other side which then does all the actual work.  The config option=20
tar.umask is not even read in that case.

We'd need to read all relevant config settings (from the command line,=20
and perhaps the user's config file and the system-wide one, but not the=
=20
ones from any local repository) and then pass them over somehow.  We=20
could piggy-back on the existing command line option passing, but for=20
that we'd need to add new command line options.  OK, just a single one,=
=20
because archive only recognizes tar.umask currently.

Would a new --umask command line option alone (that overrides any confi=
g=20
setting) be sufficient for your use case?

Thanks,
Ren=E9
