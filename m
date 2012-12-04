From: Nils Fenner <nilsfenner@web.de>
Subject: Git problem with CIFS/SAMBA URLs
Date: Tue, 4 Dec 2012 21:14:53 +0100
Message-ID: <3A877BE3-35EA-425D-A9B6-AE636E339E39@web.de>
Mime-Version: 1.0 (Apple Message framework v1085)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 04 21:15:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tfytc-0004S3-HH
	for gcvg-git-2@plane.gmane.org; Tue, 04 Dec 2012 21:15:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752169Ab2LDUO4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Dec 2012 15:14:56 -0500
Received: from mout.web.de ([212.227.15.4]:50945 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751757Ab2LDUOz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Dec 2012 15:14:55 -0500
Received: from [192.168.178.28] ([77.2.209.89]) by smtp.web.de (mrweb001) with
 ESMTPSA (Nemesis) id 0MK2JZ-1Tf9wZ12jV-001X1J for <git@vger.kernel.org>; Tue,
 04 Dec 2012 21:14:54 +0100
X-Mailer: Apple Mail (2.1085)
X-Provags-ID: V02:K0:mLSYgqJdrlL/1j2uc14QyxWnINbYH+AP+y1I5kLzmWT
 VDo0hfjjzw0JpnGpjWRakbaxGZCkifAyqcZ5dayE06mkXED/Lh
 J5NzFM/U8nEGo0WjY10GEAYO8+KaF0eLc9xGzdOW4KT4eREJYs
 Yo8Z9jOtWRgwC4Q2Q2LIBDqYDyIw3b5VkC7RxjqlgjEkFhloze
 nXzhbuZMbIbKZVOiDjlLA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211096>

Hi guys,
 
I tried to use url.insteadof to get URLs mapped correctly, starting with a double-slash (//). Unfortunately, Git doesn't recognize that and still tries to connect to the original URL. I am using Git in a productive environment. On Windows desktops, MsysGit 1.7.11 and 1.8.0. On ubuntu clients Git 1.7.9.0 (as delivered with the distro).

Problem is, that we have lots and lots of submodules, with URLs like //thegitserver/.../therepo.git. Now I'd like to checkout on the Ubuntu machine for the CI system. Should not be much of a preblem - well, in theory.

Let's replace the windows url's (//someserver/repo.git) with a mounted CIFS path (/media/samba_share/repo.git). On MsysGit this works as long as the server is reachable. On Ubuntu it completely doesn't work. All comes down to the url-alias, which seems not to be replaced correctly when using windows double-slash url's.
 
I'd like to give some more samples to show what's happening:
 
To access cross-plattform file systems I mounted the windows share via samba (e.g. on /media/samba_share). This works fine and we are able to clone the main repositories by using:
$ git clone /media/samba_share/repo.git
 
Now let's get the submodules:
$ git submodule init -> writes the "wrong" //thegitserver/... URLs in the config.
$ git submodule update -> fails because of the CIFS double-slash url's.

What to do? Simply define a "url.insteadof" alias
[url "/media/samba_share"]
    insteadof = //thegitserver

Uh, oh. Doesn't help.
 
The following would work like expected, but is not usable for my case. I would have to rewrite all URLs, what I don't want to do (maybe in the future):
[url "/media/samba_share"]
  insteadof = file:////serverurl
 
On MsysGit, replacing the double-slash works, as long as the URL is reachable (meaning the server has to be online). Otherwise it behaves the same like Linux.
 
Sample error Message:
fatal: repository '//thegitserver/.../repository.git' does not exist
 
The URL should be: /media/samba_share/.../repository.git
 
This seems to be the only case. Other URLs work like expected.

Seems like this is a bug in Git. Or did I miss something?

Please help!

Cheers,
Nils
