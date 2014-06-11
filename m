From: Charles Brossollet <chbrosso@lltech.fr>
Subject: Relative submodule URLs, and forks that haven't forked the submodule
Date: Wed, 11 Jun 2014 12:15:39 +0200
Message-ID: <E4E16320-06C4-40C5-B561-8DAD720F0946@lltech.fr>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 11 12:15:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WufZK-0004St-DD
	for gcvg-git-2@plane.gmane.org; Wed, 11 Jun 2014 12:15:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755348AbaFKKPm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Jun 2014 06:15:42 -0400
Received: from mx0.network-studio.com ([62.93.225.99]:41817 "EHLO
	mx0.network-studio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754031AbaFKKPm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Jun 2014 06:15:42 -0400
Received: from zimbra-ne02.network-studio.com (zimbra.network-studio.com [192.168.101.82])
	by mx0.network-studio.com (Postfix) with ESMTP id 62334408251
	for <git@vger.kernel.org>; Wed, 11 Jun 2014 12:15:38 +0200 (CEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by zimbra-ne02.network-studio.com (Postfix) with ESMTP id 36F661E4000
	for <git@vger.kernel.org>; Wed, 11 Jun 2014 12:15:39 +0200 (CEST)
Received: from zimbra-ne02.network-studio.com ([127.0.0.1])
	by localhost (zimbra-ne02.network-studio.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id wJrJD2r8C5jh for <git@vger.kernel.org>;
	Wed, 11 Jun 2014 12:15:38 +0200 (CEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by zimbra-ne02.network-studio.com (Postfix) with ESMTP id 7CE601E4004
	for <git@vger.kernel.org>; Wed, 11 Jun 2014 12:15:38 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra-ne02.network-studio.com
Received: from zimbra-ne02.network-studio.com ([127.0.0.1])
	by localhost (zimbra-ne02.network-studio.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id WzBzdXm3QRpZ for <git@vger.kernel.org>;
	Wed, 11 Jun 2014 12:15:38 +0200 (CEST)
Received: from cluj.int.lltech.fr (95-141-98-68.as16211.net [95.141.98.68])
	(Authenticated sender: chbrosso@lltech.fr)
	by zimbra-ne02.network-studio.com (Postfix) with ESMTPSA id 346CB1E4001
	for <git@vger.kernel.org>; Wed, 11 Jun 2014 12:15:38 +0200 (CEST)
X-Mailer: Apple Mail (2.1878.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251357>

Hi,

I'm banging my head on this problem: I have a central repo cloned by SS=
H, and a fork on the same server. The central remote is origin, and the=
 fork is chbrosso-wip.

$ git remote -v | grep origin
origin  chbrosso@lltech:/git/lightct.git (fetch)
origin  chbrosso@lltech:/git/lightct.git (push)

$ git remote -v | grep chbrosso-wip
chbrosso-wip    chbrosso@lltech:~/prog/git/lightct.git (fetch)
chbrosso-wip    chbrosso@lltech:~/prog/git/lightct.git (push)

On a local working copy, fetched my fork and checked out a remote branc=
h out of it. Its remote-tracking branch is on the fork.

$ git branch -vv | grep \*
* actor                         d98ec24 [chbrosso-wip/actor] (commit ms=
g)

Now, submodules for this repo have relative URLs. And this is where the=
 problem begins, because the submodule isn't forked, but resides only i=
n origin.

But this shouldn't cause any problem, right? The docs says that if rela=
tive URL are used, they resolve using the origin URL. First issue, it's=
 not the case:

$ cat .gitmodules
[submodule "motors"]
        path =3D motors
        url =3D ../motors.git
        branch =3D master
$ git submodule init motors
Submodule 'motors' (chbrosso@lltech:~/prog/git/motors.git) registered f=
or path 'motors'

Here the submodule is registered on my fork, which doesn't exist, and i=
t's wrong with what the documentation says.

=46ine, I'll edit the .git/config entry to make it point to origin:

$ git config submodule.motors.url chbrosso@lltech:/git/motors.git

$ git config submodule.motors.url
chbrosso@lltech:/git/motors.git

$ ssh chbrosso@lltech "if  [ -d /git/motors.git ]; then echo 'ok'; fi"
Password:
ok

So the submodule's url is changed, and points to a correct path, let's =
update so that I can work

$ git submodule update motors
Password:
fatal: '~/prog/git/motors.git' does not appear to be a git repository
fatal: Could not read from remote repository.

Please make sure you have the correct access rights and the repository =
exists.
Unable to fetch in submodule path 'motors'

That's right, it is still the old url, and I can't have my submodule!
Can someone explain what's going on? And how can I get my submodule in =
the working copy?

git version 1.9.2.msysgit.0 on Windows 7 SP1 64 bit

Thanks,=20
=97-=20
Charles
