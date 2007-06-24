From: Nanako Shiraishi <nanako3@bluebottle.com>
Subject: Re: [PATCH] Add git-save script
Date: Sun, 24 Jun 2007 19:43:15 +0900
Message-ID: <200706241044.l5OAiMCB012492@mi0.bluebottle.com>
References: <7vmyyq2zrz.fsf@assigned-by-dhcp.pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: GIT <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 24 12:44:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2PZx-0006qz-Ny
	for gcvg-git@gmane.org; Sun, 24 Jun 2007 12:44:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754049AbXFXKoY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 24 Jun 2007 06:44:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754045AbXFXKoY
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Jun 2007 06:44:24 -0400
Received: from mi0.bluebottle.com ([206.188.25.15]:59785 "EHLO
	mi0.bluebottle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753992AbXFXKoX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jun 2007 06:44:23 -0400
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by mi0.bluebottle.com (8.13.1/8.13.1) with ESMTP id l5OAiMCB012492
	for <git@vger.kernel.org>; Sun, 24 Jun 2007 03:44:22 -0700
DomainKey-Signature: a=rsa-sha1; s=mail; d=bluebottle.com; c=nofws; q=dns;
	h=received:from:to:cc:date:subject:in-reply-to:mime-version:
	content-type:content-transfer-encoding:x-trusted-delivery;
	b=k0G/dyB58egtlpVcZSFZMg+lhHt1Q4jYYyMIu1PYQqLjV+cY2z5EhYtVLZjMjQ6N8
	oqcHbBe92kmLP8i0yGg2/0gig15/ws9MzdiqxZIRypgkVwdTa22qby1nGj9OdkY
Received: from nanako3.mail.bluebottle.com (81-21-243-20.televork.ee [81.21.243.20])
	(authenticated bits=0)
	by fe1.bluebottle.com (8.13.1/8.13.1) with ESMTP id l5OAiGef022774
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 24 Jun 2007 03:44:20 -0700
In-Reply-To: <7vmyyq2zrz.fsf@assigned-by-dhcp.pobox.com>
X-Trusted-Delivery: <af9601250a28332c2576fd21fb81ec61>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50790>

Junio C Hamano <gitster@pobox.com> writes:

> Nanako Shiraishi <nanako3@bluebottle.com> writes:
>
>> +function save_work () {
>
> No noiseword "function" for portability.
>
> When you say "#!/bin/sh", you are writing for the family of
> generic Bourne shells, not specifically for korn nor bash.  For
> example, dash is a fine POSIX shell, but does not grok function
> noiseword.  When in doubt, please stay away from things not in
> POSIX (e.g. function, [[, ]], ${parameter//pattern/string/}).

Is there a good reference you can point me?

>  - $GIT_DIR could contain shell metachararcters / whitespace, so
>    could $TMP as well.  Always quote such variables, or you risk
>    a surprise from "rm".
>
>  - You probably would not want to create a new "save" if your
>    working tree and the index are clean.  To test for the
>    condition, you can do something like:
>
> 	git-diff --quiet --cached && git-diff --quiet

I did not think of these problems, but I understand now.

>  - Although you keep a separate tree for the index (before the
>    "git add -u" to grab the working tree changes) in the saved
>    data, it does not seem to be used.  It _might_ make sense to
>    replace "git add -u" with "git add ." so that work/ tree
>    contains even untracked (but not ignored) files, and on the
>    restore side unstage the paths that appear in work/ but not
>    in indx/.  I dunno.

At first I wanted to do git-add . instead of git-add -u, but then I
became worried that will add files that are not interesting such as
temporary files.

>> +
>> +	head=3D$(git-log --abbrev-commit --pretty=3Doneline -n 1 HEAD)
>> +	if branch=3D$(git symbolic-ref -q HEAD); then
>> +		branch=3D${branch#refs/heads/}
>> +	else
>> +		branch=3D'(no branch)'
>> +	fi &&
>
> Minor style.  Please don't write "; then\n".  Line-up "then",
> "elif", "else", and "fi"; it is much easier to read that way.

I see.

> Nice, but after trying this myself a bit, I seriously wished for
> "git save show -p", so I did it myself, like this:
>
> 	show_save () {
> 		flags=3D$(git rev-parse --no-revs --flags "$@")
> 		if test -z "$flags"
> 		then
> 			flags=3D--stat
> 		fi
> 		save=3D$(git rev-parse --revs-only --no-flags --default saved "$@")
> 		git diff-tree $flags $save:base $save:work
> 	}
>
> It's a dense (and ancient style) plumbing code so needs a bit of
> explanation:
>
>  - The first git-rev-parse looks at "$@", discards everything
>    that are not options and discards object names.  So 'git save
>    show -p some' will give you "-p" in flags.
>
>  - The second one discards flags, and grabs 'some' out of '-p
>    some', or defaults to "saved".

I did not know about these commands.  I will study the manual pages
and I will re-submit my patch after adding these.

--=20
=E3=81=97=E3=82=89=E3=81=84=E3=81=97 =E3=81=AA=E3=81=AA=E3=81=93 http:/=
/ivory.ap.teacup.com/nanako3/

----------------------------------------------------------------------
Get a free email account with anti spam protection.
http://www.bluebottle.com
