From: David Kastrup <dak@gnu.org>
Subject: Re: Output from "git blame A..B -- path" for the bottom commit is misleading
Date: Thu, 08 May 2014 23:13:31 +0200
Message-ID: <878uqcotxg.fsf@fencepost.gnu.org>
References: <xmqq8uqc2dt5.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 08 23:14:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WiVds-0000dx-UJ
	for gcvg-git-2@plane.gmane.org; Thu, 08 May 2014 23:14:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755125AbaEHVOI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2014 17:14:08 -0400
Received: from fencepost.gnu.org ([208.118.235.10]:41157 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753348AbaEHVOG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2014 17:14:06 -0400
Received: from localhost ([127.0.0.1]:40199 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WiVdl-0000uO-LK; Thu, 08 May 2014 17:14:05 -0400
Received: by lola (Postfix, from userid 1000)
	id DC800E0A47; Thu,  8 May 2014 23:13:31 +0200 (CEST)
In-Reply-To: <xmqq8uqc2dt5.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Thu, 08 May 2014 13:52:38 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248448>

Junio C Hamano <gitster@pobox.com> writes:

> If you run
>
>     $ git blame -L103,107 v2.0.0-rc0..v2.0.0-rc2 t/t9117-git-svn-init-clone.sh
>
> you will see something like this:
>
>     ^cc29195 (Junio C Hamano 2014-04-18 11:21:43 -0700 103) 
>     7bbc458b (Kyle J. McKay  2014-04-22 04:16:22 -0700 104) test_expect_...
>     ^cc29195 (Junio C Hamano 2014-04-18 11:21:43 -0700 105)         test...
>     7bbc458b (Kyle J. McKay  2014-04-22 04:16:22 -0700 106)         git ...
>     ^cc29195 (Junio C Hamano 2014-04-18 11:21:43 -0700 107)         test...
>
> It is correct to attribute these lines that have not changed since
> the bottom of the range (i.e. v2.0.0-rc0) to that commit,

They are not attributed to that commit in particular.  They are traced
all the way up to that commit, so they are either from this commit or
from an earlier one.

> But I find it really misleading, as this is the true picture if we
> dug to the bottom of the history:
>
>     $ git blame -L103,107 v2.0.0-rc2 t/t9117-git-svn-init-clone.sh
>     f849bb6b (Johan Herland 2013-10-11 14:57:06 +0200 103) 
>     7bbc458b (Kyle J. McKay 2014-04-22 04:16:22 -0700 104) test_expect_...
>     f849bb6b (Johan Herland 2013-10-11 14:57:06 +0200 105)  test ! -d p...
>     7bbc458b (Kyle J. McKay 2014-04-22 04:16:22 -0700 106)  git svn ini...
>     f849bb6b (Johan Herland 2013-10-11 14:57:06 +0200 107)  test_must_f...

So indeed, an earlier one.

> I do not expect Johan's name to appear in the output for the first
> one, because that would require us to dig deeper than the commit we
> were told to stop at, but I am wondering if we can do better than the
> existing "-b" option to reduce the confusion from the output.

Do you mean "better than" or rather "better in the case where -b is
given"?

> The "-b" option blanks the commit object name, but still shows the
> name and timestamp for the bottom commit:
>
>              (Junio C Hamano 2014-04-18 11:21:43 -0700 103) 
>     7bbc458b (Kyle J. McKay  2014-04-22 04:16:22 -0700 104) test_expect_...
>              (Junio C Hamano 2014-04-18 11:21:43 -0700 105)         test...
>     7bbc458b (Kyle J. McKay  2014-04-22 04:16:22 -0700 106)         git ...
>              (Junio C Hamano 2014-04-18 11:21:43 -0700 107)         test...
>
> I am tempted to say "blame that is run without the --porcelain
> option is a end-user facing Porcelain, and people should not be
> reading its output in their scripts" and change the behaviour of the
> "-b" option to instead show something like this instead:
>     
>     ^cc29195 (Unknown        2014-04-18 11:21:43 -0700 103) 
>     7bbc458b (Kyle J. McKay  2014-04-22 04:16:22 -0700 104) test_expect_...
>     ^cc29195 (Unknown        2014-04-18 11:21:43 -0700 105)         test...
>     7bbc458b (Kyle J. McKay  2014-04-22 04:16:22 -0700 106)         git ...
>     ^cc29195 (Unknown        2014-04-18 11:21:43 -0700 107)         test...
>
> which shows the commit object name, its bottom-ness and the
> timestamp, or even
>
>              (                                         103) 
>     7bbc458b (Kyle J. McKay  2014-04-22 04:16:22 -0700 104) test_expect_...
>              (                                         105)         test...
>     7bbc458b (Kyle J. McKay  2014-04-22 04:16:22 -0700 106)         git ...
>              (                                         107)         test...
>
> which does away with the misleading information altogether.

That would make more sense for -b but hardly for the default.

> I myself is leaning towards the latter between the two, and not
> overriding "-b" but introducing another "cleanse the output of
> useless bottom information even more" option.

One could use -b -b but frankly, where is the point?  Name and date
deliver no useful information when the commit is absent.

-- 
David Kastrup
