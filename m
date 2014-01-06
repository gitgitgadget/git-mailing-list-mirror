From: David Engster <deng@randomsample.de>
Subject: Re: [PATCH 2/2] Introduce git submodule attached update
Date: Mon, 06 Jan 2014 20:21:24 +0100
Message-ID: <87ppo4zzkb.fsf@engster.org>
References: <1388890249-3577-1-git-send-email-ceztko@gmail.com>
	<1388890249-3577-2-git-send-email-ceztko@gmail.com>
	<20140105203349.GB3737@book.hvoigt.net>
	<CALas-ijjzyRVuc0NaAS5QS98pX2198mv4HoHDacgYFYNLXbXFw@mail.gmail.com>
	<20140106140627.GA27265@t2784.greatnet.de>
	<CALas-ihHD_eJOXLUrhCVZjidQDmrCN=QpdfMKoN1i9A7FAo3RQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Heiko Voigt <hvoigt@hvoigt.net>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <jens.lehmann@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	"W. Trevor King" <wking@tremily.us>
To: Francesco Pretto <ceztko@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 06 20:52:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0GDZ-0008Fe-Re
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jan 2014 20:52:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755456AbaAFTvm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jan 2014 14:51:42 -0500
Received: from randomsample.de ([5.45.97.173]:60930 "EHLO randomsample.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755102AbaAFTvl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jan 2014 14:51:41 -0500
X-Greylist: delayed 1810 seconds by postgrey-1.27 at vger.kernel.org; Mon, 06 Jan 2014 14:51:41 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=randomsample.de; s=a;
	h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From; bh=vJqqwyOFp8Bcv5TsAvHeKC8DVbEkDuJBnttpXdF3JOM=;
	b=BOdgW32BkSPoFgQUxEnbTPkiyWEBPETbt/KJvDNjCBk1n+nBqBvNLJPj8dhEJGYAQxFXuTc+DJR253ka47CTbRM0Vk72kwb9tUzHYhNecqEqqkEpJQvv+Hx3i5+Fb7ZT;
Received: from dslc-082-083-045-175.pools.arcor-ip.net ([82.83.45.175] helo=spaten)
	by randomsample.de with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
	(Exim 4.80)
	(envelope-from <deng@randomsample.de>)
	id 1W0Fjq-0000kw-6c; Mon, 06 Jan 2014 20:21:26 +0100
In-Reply-To: <CALas-ihHD_eJOXLUrhCVZjidQDmrCN=QpdfMKoN1i9A7FAo3RQ@mail.gmail.com>
	(Francesco Pretto's message of "Mon, 6 Jan 2014 18:47:58 +0100")
User-Agent: Gnus/5.130008 (Ma Gnus v0.8) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240054>

Francesco Pretto writes:
> 2014/1/6 Heiko Voigt <hvoigt@hvoigt.net>:
>> Could you describe something like this for your workflow? A complete
>> change lifecycle when a developer works, as you call it, "actively" in a
>> submodule?
>>
>
> I'm really sorry, I thought this was already clear from the first
> patch iteration. I will go more in depth:

While I have some trouble understanding all the details of Francesco's
description, I find the idea of "attaching submodules to branches" very
useful.  I think I could well use that to simplify my merging grunt work
for GNU Emacs (which, in case you're wondering, is probably switching to
git as its VCS). I don't mean to hijack this thread, and I guess my use
case is a bit different than what Francesco has in mind; still, I think
it is similar enough that my use case could help in talking about the
details of his patch; if not, please feel free to ignore it.

GNU Emacs ships with some pretty large packages, namely Gnus, Org and
CEDET, which are also available as "stand-alone" versions for manual
installation, and their development happens in separate upstream
repositories. Since I'm a CEDET developer, I'll use it as an example in
the following.

First off, it is important to note that merges are always
bi-directional: not only is new CEDET code pulled into Emacs, but Emacs
developers also change things which have to be merged back upstream. So
far, merging between the two repositories was done manually by me, which
is error-prone (and boring). I think that by pulling in CEDET directly
as a submodule, this merging could be made easier. Most importantly, my
hope is that more people than me could do it. :-)

Here's how I would like this to work; first the CEDET -> Emacs part,
which is rather straight-forward:

- The CEDET repository has two branches: 'master' and 'stable'.

- The Emacs repository imports CEDET's 'stable' branch as a submodule.

- CEDET's main development happens in 'master', and the CEDET developers
  are responsible for merging stable code to 'stable'. They will then
  make a new commit for the submodule in Emacs accordingly.

The Emacs -> CEDET part is more hairy. Most of the time, the fixes
happening in the Emacs repository for CEDET are very small and/or
trivial and can usually be considered "always stable": fixes for
spelling, compiler warnings, or small refactorings like renames,
etc. This kind of "merging back to CEDET upstream" should hence be as
easy as possible for Emacs developers:

- When an Emacs developer changes something in the CEDET submodule, the
  changes they commit should by default automatically land in CEDET's
  'stable' branch. That means that when they enter the submodule, they
  should be in the branch 'stable' instead of being detached, and a push
  should update the 'stable' branch in CEDET accordingly. The submodule
  must then be committed as well.

- It is then up to the CEDET developers to merge these changes into the
  'master' branch of the CEDET repo.

I know that the "correct" workflow would be to always use feature
branches, but it'd be nice if that could be avoided if one so chooses.

A little picture in the hope that it makes things clearer:

             +-----------+
             |  master   | <--
+-------+    +-----------+    | Merges to/from master
| CEDET |                     | done only by CEDET developers
+-------+                     | 
             +-----------+    |
             |  stable   | <--  <--------
             +-----------+               |
                                         |
                                         |
                                         | Any Emacs developer
                                         | can push and commit
                                         | submodule
+--------+    +----------------------+   |
| Emacs  | -- | lisp/cedet submodule | <-
+--------+    +----------------------+

AFAICS the main problem with this approach is that one always has to
think of committing the new SHA1 of the submodule. If I understand
Francesco correctly, he wants to eliminate the need for that by simply
always taking the head of the attached branch. I also think that would
be a nice feature, since in the above drawing, the lisp/cedet submodule
should always follow the 'stable' branch in CEDET upstream. However, as
Heiko notes, the history must be preserved to be able to go back to
earlier revisions, so there must be some kind of commit for the
submodule when 'stable' changes; maybe that could be automated somehow?

-David
