From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Regulator updates for 3.3
Date: Tue, 10 Jan 2012 18:47:55 -0800
Message-ID: <CA+55aFx5NATrpLnkMiV2vAxSAJPK7wkY2vyHbyeZGgT9+jP06w@mail.gmail.com>
References: <20120109073727.GF22134@opensource.wolfsonmicro.com>
 <CA+55aFyhoh0rT_ujuE1w3RpuR7kqivYFwPpm66VC-xtq1PiGUQ@mail.gmail.com>
 <20120110184530.GE7164@opensource.wolfsonmicro.com> <CA+55aFxXb7wqfrpozS6iH0k25y-+Uy8_Tavv59JXMhaWrjXLaw@mail.gmail.com>
 <20120110222711.GK7164@opensource.wolfsonmicro.com> <CA+55aFxvQF=Bm4ae6euB_UO8otMCuN9Lv37Zn3TpE-L7JH3Kzw@mail.gmail.com>
 <7vmx9v7z1r.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>,
	Liam Girdwood <lrg@ti.com>, linux-kernel@vger.kernel.org,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 11 03:48:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RkoEp-0005R7-PZ
	for gcvg-git-2@lo.gmane.org; Wed, 11 Jan 2012 03:48:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933742Ab2AKCsR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jan 2012 21:48:17 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:64445 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757019Ab2AKCsQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jan 2012 21:48:16 -0500
Received: by yhjj63 with SMTP id j63so121280yhj.19
        for <multiple recipients>; Tue, 10 Jan 2012 18:48:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=yfrdLLTmZjvJo/I1mX4Ej/1nocXUpuGE3ZFMzR1XlGM=;
        b=CFhPZzZ8/qFFyiTFaYqRApcqGFr8ufBhAwLZoPRtXuCt05iCoHMcR1R36GB5eQYCZi
         3znWVL1IKMYrWdMwtRGYARLDZIYlI2ceQ8OeM+yG+xAr233bYnIGrdI/qpiGQyPt9Rp8
         9eqqVH4h+GzAnkGww5JKyfH08yKQtgGyPW6Hg=
Received: by 10.236.154.5 with SMTP id g5mr30205124yhk.63.1326250096290; Tue,
 10 Jan 2012 18:48:16 -0800 (PST)
Received: by 10.236.175.170 with HTTP; Tue, 10 Jan 2012 18:47:55 -0800 (PST)
In-Reply-To: <7vmx9v7z1r.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: mwC5g3ZEBgvVs5UycW36Q7kUgog
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188314>

On Tue, Jan 10, 2012 at 6:28 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> It is a non-starter to unconditionally start an editor.

I really wonder. Because not being default will always lead to really
odd ways of saying "it should have been default, so we'll make up
these complex and arbitrary special rules" (like the ones you were
starting to outline).

So I really suspect it would be easier and more straightforward to
instead just bite the bullet, and say:

 (a) start an editor by default if both stdin/stdout matched in fstat
and were istty().

 (b) have some trivial way to disable that default behavior for people
who really want the legacy behavior. And by "trivial" I mean "set the
GIT_LEGACY_MERGE environment variable" or something.

 (c) have a "--no-editor" command line switch so that scripts and/or
users that want to make it explicit (rather than rely on the hacky
legacy workaround) can do so (and a explicit "--editor" switch to
enable people to use a GUI editor even if they aren't on a terminal -
think something IDE environment, whatever).

Where (a) is so that people will always get the editor if they aren't
aware of it, and (b) is so that existing scripting environments can
then *trivially* work around the fact that we changed semantics,
including on a site-wide basis. With (c) being for future users. Of
course, just a "git merge < /dev/null" would also do it, but sounds
ridiculously hacky (and doesn't allow the "--editor" version), so that
"--no-editor" flag sounds saner and much more powerful.

Of course, if you use "-m", no editor would fire up anyway, exactly
like with "git commit", so that's one way to avoid the issue forever
(and be backwards compatible). But if you actually *want* to get the
auto-generated message and no editor, that would need that new switch.

Yes, git has been very good about not breaking semantics. But it's
happened before too when it needed to happen. We've had much bigger
breaks (like the whole "git-xyz" to "git xyz" transition, for example,
which broke a lot of scripts).

                       Linus
