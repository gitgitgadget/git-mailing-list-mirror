From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: Git --file doesn't override $HOME in version 1.8.1.2
Date: Tue, 9 Jul 2013 13:49:21 +0200
Message-ID: <87mwpweywu.fsf@linux-k42r.v.cablecom.net>
References: <C8A88C530F38AE47B22BDC434090CBB0ED26E0@IT-EXMB01-HKI.it.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: =?utf-8?Q?Saraj=C3=A4rvi?= Tony <Tony.Sarajarvi@digia.com>
X-From: git-owner@vger.kernel.org Tue Jul 09 13:49:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwWQD-0006l9-Ew
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jul 2013 13:49:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753705Ab3GILtZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Jul 2013 07:49:25 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:10901 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753487Ab3GILtY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Jul 2013 07:49:24 -0400
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 9 Jul
 2013 13:49:20 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (129.132.153.233) by
 CAS21.d.ethz.ch (172.31.51.111) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Tue, 9 Jul 2013 13:49:21 +0200
In-Reply-To: <C8A88C530F38AE47B22BDC434090CBB0ED26E0@IT-EXMB01-HKI.it.local>
	(=?utf-8?Q?=22Saraj=C3=A4rvi?= Tony"'s message of "Tue, 9 Jul 2013 11:05:46
 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229948>

Saraj=C3=A4rvi Tony <Tony.Sarajarvi@digia.com> writes:

> Using Ubuntu 13.04 with Git 1.8.1.2 I stumbled upon a problem using P=
uppet.
>
> In Puppet we launch Git with the command: '/usr/bin/git config --file
> /home/qt/.gitconfig --get "user.name" "Qt Continuous Integration
> System"'
> However, puppet logs: "fatal: unable to access '/root/.config/git/con=
fig': Permission denied".
>
> Puppet is run as root, so HOME points to /root, but still -file shoul=
d override the environment variable.
>
> If the same command is run directly from terminal as root, it works a=
s well.

To elaborate (I briefly talked to Saraj=C3=A4rvi on IRC): this isn't ab=
out
the fatal error; we downgraded this to a nonfatal error in 4698c8f
(config: allow inaccessible configuration under $HOME, 2013-04-12).

Rather, it's very strange that 'git config --file foo' tries to look at
any config file other than 'foo'.  In a git repo:

  $ strace git config --file fooconfig test.var 2>&1 | grep 'open.*conf=
ig'
  open("/home/thomas/.gitconfig", O_RDONLY) =3D 3
  open(".git/config", O_RDONLY)           =3D 3
  open("/home/thomas/.gitconfig", O_RDONLY) =3D 3
  open(".git/config", O_RDONLY)           =3D 3
  open("fooconfig", O_RDONLY)             =3D 3

I haven't looked into the code yet.  Probably it's simply following the
usual code paths to discover a repo and read its config.  However, with
the --file option, it shouldn't.

--=20
Thomas Rast
trast@{inf,student}.ethz.ch
