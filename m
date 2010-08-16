From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [BUG RFC/PATCH] git-cvsimport
Date: Mon, 16 Aug 2010 06:24:06 +0200
Message-ID: <4C68BD66.9060506@alum.mit.edu>
References: <AANLkTikxxqgNpmqfFQq+5GVd7VAW2DTaro5anRHcx6Tt@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Martin Langhoff <martin@catalyst.net.nz>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 16 06:24:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OkrFI-0007qz-HC
	for gcvg-git-2@lo.gmane.org; Mon, 16 Aug 2010 06:24:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752013Ab0HPEYS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Aug 2010 00:24:18 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:45297 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751902Ab0HPEYR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Aug 2010 00:24:17 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.69.134] (p54BED8D4.dip.t-dialin.net [84.190.216.212])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id o7G4O6kH005467
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 16 Aug 2010 06:24:07 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.24) Gecko/20100317 Thunderbird/2.0.0.24 Mnenhy/0.7.6.666
In-Reply-To: <AANLkTikxxqgNpmqfFQq+5GVd7VAW2DTaro5anRHcx6Tt@mail.gmail.com>
X-Enigmail-Version: 0.95.0
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153649>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> This is more of a BUG than a RFC/PATCH.
>=20
> Now that Junio has applied my patch to not write test results under
> harness I can:
>=20
>     sudo chown -R root t
>=20
> And run the tests with --root=3D/dev/shm under prove, except for 3
> git-cvsimport tests. I have pending patches to these, after they'll
> get in I'll fix that.
>=20
> But the reason they hang is interesting:
>=20
>     rm -rf /tmp/meh;
>     git init /tmp/meh &&
>     cd /tmp/meh &&
>     sudo chown -R root /home/avar/g/git/t/t9601/cvsroot &&
>     cvsps --norc -q --cvs-direct -u -A --root
> /home/avar/g/git/t/t9601/cvsroot module
>     Initialized empty Git repository in /tmp/meh/.git/
>=20
> cvsps will just hang due to the unfriendly chmod. Maybe we want
> something like the below to deal with that.
>=20
> However, even then it'll still hang on something else, I haven't
> looked into what. I'm just going to fix this by having it copy the
> things it needs to the --root directory.

My guess is that cvsps is using CVS commands to access the test CVS
repository, and that CVS wants to write to the file CVSROOT/history to
log what is being done.  The logging behavior can be turned off either:

* by using the "-R" option when invoking CVS.  This is a global option,
meaning that it has to appear before the subcommand: "cvs -R update"
rather than "cvs update -R".

* by setting the "$CVSREADONLYFS" environment variable.

Apparently -R and "$CVSREADONLYFS" were added in CVS 1.12.1, which was
released in 2003.

Michael
