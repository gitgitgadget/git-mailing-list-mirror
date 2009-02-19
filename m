From: Lars Hjemli <hjemli@gmail.com>
Subject: Re: [RFC/PATCHv2] git submodule split
Date: Thu, 19 Feb 2009 20:23:08 +0100
Message-ID: <8c5c35580902191123h4f1e56c7m3192bc1ffdf9fee6@mail.gmail.com>
References: <431341160902121350x45076c8cj26afab0b7a51cac5@mail.gmail.com>
	 <1234578258-48870-1-git-send-email-git@randomhacks.net>
	 <7v3aeh3a84.fsf@gitster.siamese.dyndns.org>
	 <431341160902132117s1696c975mbf20dfbdc65a7df3@mail.gmail.com>
	 <8c5c35580902140103o3e5dd091qe2a18ca52b6fe44a@mail.gmail.com>
	 <20090217191748.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Eric Kidd <git@randomhacks.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Ping Yin <pkufranky@gmail.com>
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Thu Feb 19 20:27:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaEVl-0007B1-36
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 20:24:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752898AbZBSTXM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 14:23:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751754AbZBSTXL
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 14:23:11 -0500
Received: from mail-ew0-f21.google.com ([209.85.219.21]:48590 "EHLO
	mail-ew0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751875AbZBSTXK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2009 14:23:10 -0500
Received: by ewy14 with SMTP id 14so542756ewy.13
        for <git@vger.kernel.org>; Thu, 19 Feb 2009 11:23:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=XOi7RAd0B10myqryAzGtSEmiFZOF2953mJ4CnGV7hCc=;
        b=ZXjlQlzvXL2jlcY5adV1k5NT0bAafYA65bSm06WNc4Hh0ZUMoZ209KEHeuwMgb9qyO
         4zgSjRkie86iPL3z47nO3cgiaOwotdYrBmsk8skadjH0FoAfpi0GGkA9x+XjbZz03q/L
         O7aKC8Nw3YWux+r3Mm4pXtBZWlrjur2531FHw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=x+35YP/Cs9QISJt5iGDHuBo1acCKl2g3zJUnvGQOEi3duzMYIZG7J2uXY0eQZ5MwdP
         WWO5JJYSjj91zp5He2xLBrXbPiI96AJzz432eL36/BEA0lxkUvPbsGZBYRTrtq/qYcuq
         9D8Co6Lrwo87vE5rmqbTjVRA1PUzV6Wy22B/c=
Received: by 10.210.136.10 with SMTP id j10mr7470935ebd.25.1235071388208; Thu, 
	19 Feb 2009 11:23:08 -0800 (PST)
In-Reply-To: <20090217191748.6117@nanako3.lavabit.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110734>

[* sorry for the late reply *]

On Tue, Feb 17, 2009 at 11:17, Nanako Shiraishi <nanako3@lavabit.com> wrote:
> Quoting Lars Hjemli <hjemli@gmail.com>:
>
>> I didn't look at the patch, but if the submodule uses a single
>> module-name while moving around, the re-cloning problem would by
>> solved if the submodule git-dir was stored inside the git-dir of the
>> containing repository  (by using the git-file mechanism). Maybe I
>> should try to finally implement this...
>
> Is it similar to what was discussed earlier in the thread
> http://thread.gmane.org/gmane.comp.version-control.git/47466/focus=47621
> (I asked gmane for "submodule relocate")?

Well, kind of. We ended up with a scheme similar to what Junio
described in the linked mail: every submodule in a repository is given
a canonical name by the .gitmodules file and this name is then linked
with a url in .git/config. The .gitmodules file also states at which
path(s) this submodule is located. So we can keep track of which
submodules we're interested in (and what urls to use for fetching
objects to those submodules) irrespective of the path used to check
out the submodules.

But when we're switching between branches in which a submodule is
checked out at different paths, we currently loose track of both the
old worktree and its gitdir. My gitfile proposal would salvage the
gitdir but, as Dscho mentioned, uncommited+untracked data in the
worktree would not be handled.

So I currently think it's better to make `git submodule init` update
.git/config with information about the current submodule path (again,
as Dscho mentioned). Then, after switching branches, `git submodule
<some-verb>` could notice that the current path is different from the
one in .git/config and simply `mv oldpath newpath` before updating
.git/config with the new path.

Btw. this wouldn't work smoothly if a single submodule was checked out
at multiple paths in the same revision, but I don't see why anyone
would want to do something like that...

--
larsh
