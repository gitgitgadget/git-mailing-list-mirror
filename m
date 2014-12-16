From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] remote: allow adding remote w same name as alias
Date: Tue, 16 Dec 2014 10:01:53 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1412160944180.13845@s15462909.onlinehome-server.info>
References: <20141216021900.50095.24877@random.io>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1784107012-1176372359-1418720513=:13845"
Cc: git@vger.kernel.org
To: Anastas Dancha <anapsix@random.io>
X-From: git-owner@vger.kernel.org Tue Dec 16 10:02:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y0o13-0007An-J8
	for gcvg-git-2@plane.gmane.org; Tue, 16 Dec 2014 10:02:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751165AbaLPJB5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Dec 2014 04:01:57 -0500
Received: from mout.gmx.net ([212.227.15.19]:63799 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751122AbaLPJB4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Dec 2014 04:01:56 -0500
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx002) with ESMTPSA (Nemesis) id 0LkgEO-1XQMnl3TD2-00aUxc;
 Tue, 16 Dec 2014 10:01:53 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <20141216021900.50095.24877@random.io>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:kfNzWV7Hl2ifPdILiCHkkIRCcTF4PPUkc1+2LTT3jqkhdIpr4RG
 Ymo86ambUAx5uacjRi4PvIQwLUqWDsMTkO9X3L6uAF9aQ5nqpQwyygd4eUYr49vpIznH67P
 V868nQROfugMb89YHQ6nbi5rId7cra11v9nOJBfw+eqnXUuEPEJZHjHaJwPUtNj1FvnHL9a
 P4EuOGBFMZFtOBSmOb26w==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261440>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1784107012-1176372359-1418720513=:13845
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Anastas,

On Tue, 16 Dec 2014, Anastas Dancha wrote:

> When ~/.gitconfig contains an alias (i.e. myremote)
> and you are adding a new remote using the same name
> for remote, Git will refuse to add the remote with
> the same name as one of the aliases, even though the
> remote with such name is not setup for current repo.

Just to make sure we're on the same page... you are talking about

=09[remote "myremote"]

not

=09[alias]
=09=09myremote =3D ...

yes? If so, please avoid using the term "alias"...

Further, I assume that your .gitconfig lists the "myremote" without a URL?

Also:

> -       if (remote && (remote->url_nr > 1 || strcmp(name, remote->url[0])=
 ||
> -                       remote->fetch_refspec_nr))
> -               die(_("remote %s already exists."), name);
> +       if (remote && (remote->url_nr > 1 || remote->fetch_refspec_nr))
> +               die(_("remote %s %s already exists."), name, url);

The real problem here is that strcmp() is performed even if url_nr =3D=3D 0=
,
*and* that it compares the name =E2=80=93 instead of the url =E2=80=93 to t=
he remote's URL.
That is incorrect, so the correct fix would be:

-       if (remote && (remote->url_nr > 1 || strcmp(name, remote->url[0]) |=
|
+       if (remote && (remote->url_nr > 1 ||
+=09=09=09(remote->url_nr =3D=3D 1 && strcmp(url, remote->url[0])) ||
                        remote->fetch_refspec_nr))
                die(_("remote %s already exists."), name);

In other words, we would still verify that there is no existing remote,
even if that remote was declared in ~/.gitconfig. However, if a remote
exists without any URL, or if it has a single URL that matches the
provided one, and there are no fetch refspecs, *then* there is nothing to
complain about and we continue.

Ciao,
Johannes
--1784107012-1176372359-1418720513=:13845--
