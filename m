From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [RFC/PATCH 0/7] Rework git core for native submodules
Date: Mon, 08 Apr 2013 22:41:57 +0200
Message-ID: <51632B95.3040103@web.de>
References: <7v61zz9fu3.fsf@alter.siamese.dyndns.org> <CALkWK0n64BW8zQXweR38T6DjT+iYBbsZDPCLZ-4igqGJHoFwKw@mail.gmail.com> <7vr4im7m1y.fsf@alter.siamese.dyndns.org> <CALkWK0=jrO9MQotB+anAn-5YtG1RBTLWEnGL5=K4wy=yi7E-CQ@mail.gmail.com> <20130407161209.GG2222@serenity.lan> <CALkWK0kSF_q0o1V6BhO6X2jKAJQxNQ0c6MCi5o=jZdMwrba48g@mail.gmail.com> <20130407170201.GH2222@serenity.lan> <CALkWK0nSxfEzP7KHZxGjmBYD7pX5aa3CbMt1qAGrz4tonrtHhA@mail.gmail.com> <20130407175210.GI2222@serenity.lan> <CALkWK0n=vtPT7aFn9+T+bRxUpfXG+mYvV29YKC=_OAampQXJSA@mail.gmail.com> <20130407182112.GJ2222@serenity.lan> <5161BC33.8060707@web.de> <CALkWK0mBW63P0i6OhuujmAYO99pxLsS=ffFeqw8gBcBDgUpOPg@mail.gmail.com> <5161D3C5.9060804@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: John Keeping <john@keeping.me.uk>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 08 22:42:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPItC-0003CE-Kv
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 22:42:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936101Ab3DHUmB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Apr 2013 16:42:01 -0400
Received: from mout.web.de ([212.227.15.4]:57515 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935919Ab3DHUmA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Apr 2013 16:42:00 -0400
Received: from [192.168.178.41] ([91.3.157.185]) by smtp.web.de (mrweb103)
 with ESMTPA (Nemesis) id 0MOArg-1UUpBx1oxA-005sRU; Mon, 08 Apr 2013 22:41:58
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <5161D3C5.9060804@web.de>
X-Enigmail-Version: 1.5.1
X-Provags-ID: V02:K0:YSWQ1emxTJq5KFn+BxjJZFiJYDtw7DNemAqssLlIKxe
 RNXP6h7jjMEG1UcEE6w5WcsYMmy91TppXJ/DCuY2QjyO47U6cY
 ehD5E1N+ssrk6Xf5AdnztIfKe/ZBFZgVDD97Vti9LGLgTh1WzH
 kpZ56gjnr7B82L/DHpG/dXyHDKt9P3d24QOR9psB7D8mnaKgo4
 syZKKEDwQphpr4v0KiDNg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220512>

Ok, here comes an updated version of our comparison list which
I updated with what I read in recent discussions. As I said
earlier, please speak up if I missed anything (or forgot to add
anyone to the CC).

I picked up one advantage ("no need to cd-to-toplevel to edit
.gitmodules) two new disadvantages ("foreach" and "default
submodule config") and retired one Ram showed a solution for
(the "unstaged gitlink").


Advantages:

* Information is stored in one place, no need to lookup stuff in
  another file/blob.

* Easier coding, as we find all information in a single object.

* No need to cd-to-toplevel to change configuration in the
  .gitmodules file, the special tools to edit link information
  will work in any subdirectory.

(We currently need a checked out work tree to access the
.gitmodules file, but there is ongoing work to read the
configuration directly from the database)

(While it is easier to merge the link object, a .gitmodules
aware merge driver would work just as well)


Disadvantages:

* Changes in user visible behavior, possible compatibility
  problems when Git versions are mixed.

* Special tools are needed to edit submodule information where
  currently a plain editor is sufficient and a standard format
  is used.

* merge conflicts are harder to resolve and require special git
  commands, solving them in .gitmodules is way more intuitive
  as users are already used to conflict markers.

* "git submodule foreach" becomes harder to implement

* With .gitmodules we lose a central spot where configuration
  concerning many submodules can be stored

(I think when we also put the submodule name in the object we
could also retain the ability to repopulated moved submodules
from their old repo, which is found by that name)

(That a link object can have no unstaged counterpart that a file
easily has can be fixed by special casing this, e.g. in using a
file in .git/link-specs/)


Hmm, while it is still too early to close the polls, it looks
to me as most advantages are about easier coding while most
disadvantages hit the user. That makes it more understandable
for me why Ram is so convinced of his approach and why on the
other hand submodule users like myself are rather sceptical. I
think we need some more advantages that users will directly
profit from, the cd-to-toplevel for .gitmodules is definitely
not enough to support the change Ram is proposing. What other
advantages are missing here?
