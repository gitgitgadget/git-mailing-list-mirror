From: Junio C Hamano <gitster@pobox.com>
Subject: Re: "git checkout" resets modified files
Date: Sat, 29 Aug 2015 00:58:01 -0700
Message-ID: <xmqqh9nizfue.fsf@gitster.mtv.corp.google.com>
References: <CANDob0LdQpoSfsedPK_yhNunXBvNTc9L1zKOM9h8dBUDePs0kg@mail.gmail.com>
	<xmqqlhcuzhsu.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Steve Heyns <notzippy@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 29 09:58:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZVb1v-0007Iz-Un
	for gcvg-git-2@plane.gmane.org; Sat, 29 Aug 2015 09:58:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752302AbbH2H6G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Aug 2015 03:58:06 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:34529 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752261AbbH2H6E (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Aug 2015 03:58:04 -0400
Received: by pabzx8 with SMTP id zx8so85629663pab.1
        for <git@vger.kernel.org>; Sat, 29 Aug 2015 00:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=QVtYFs57RO/vh4/N1xHXrB8B7m/mWPUkTmyUvrGIN9U=;
        b=EoUiJFqrWR4s2obj1ab3njZ3KHcOZgukPn1vt7GUxUQiMStUDuPxQ6b2IqCfPjIKRU
         S4wslJXDN66Bw/D3WXnukI3grHoBBaAEg+xWy+Bu9MLDA7qQl9NUdn5YE2Tfzh5xNgJq
         CcMZqvfHRnPvjX8kjQsSvrXaKzt1TlNXVOEF4qQF9N0Zkfl8USV4p6YpI2biiptjLgQ8
         g4W7knwLQNPe6syYIEXNwJjkEmjicd3rPLrGQzx/VN7QFVYiMf/7m78nwGqQ3UQRsrs2
         bQBSNnW3gPCY2ZjomTVYkSvT5f2CRjSYkg/na/p7586DVmrIe7krsYK959qx0SY/VG1C
         4T8g==
X-Received: by 10.66.228.71 with SMTP id sg7mr21335380pac.121.1440835083775;
        Sat, 29 Aug 2015 00:58:03 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:8d2:f21a:caa6:b0e7])
        by smtp.gmail.com with ESMTPSA id fx4sm7885947pbb.92.2015.08.29.00.58.01
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 29 Aug 2015 00:58:02 -0700 (PDT)
In-Reply-To: <xmqqlhcuzhsu.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Sat, 29 Aug 2015 00:15:45 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276770>

Junio C Hamano <gitster@pobox.com> writes:

> I do not think this behaviour depends on the vintage of Git.  An
> empty string as pathspec has always matched "everything in here"
> AFAIR.

Having said all that, I think the DWIM used by "git checkout" has
some room for improvement, namely, its "we didn't see a double-dash;
is it a ref or is it a pathspec?" disambiguation should become
similar to the revision parser's.

Notice that

    $ git log ""

will error out, saying that an empty string does not name either a
revision or an existing path in the working tree.  I think the same
"refusal due to ambiguity" should be in "git checkout" when the user
says

    $ git checkout ""

Right now, when there is no double-dash, the code checks if the
first token X can be DWIMmed as a ref.  It may either name an
existing branch X, or it may be a non-existing branch name, but
there is a single remotes/Y/X and the user is too lazy to say 'git
checkout -t -b remotes/Y/X X' and instead said 'git checkout X'.

And if the first token X cannot be DWIMmed as a ref according to the
above logic, unlike the revision parser, we do not check it (and all
the subsequent tokens) name existing filesystem entity.

I think we really should.  With that, Steve's command line would
have correctly diagnosed as a liely error.

Of course, that still allows people to say

    $ git checkout -- ""

if they really mean it, but they can type

    $ git checkout -- :/

just as easily, so there is no big loss.

After following the existing code myself, I think this is a rather
easy low-hanging fruit for any aspiring Git hacker.  Hint, hint...


> [Footnote]
>
> *1* Checking out a branch whose name is an empty string can be asked
>     explicitly by disambiguating double-dash like this:
>
>     $ git checkout "" --
>
> And it will be answered (correctly) with:
>
>     fatal: invalid reference
