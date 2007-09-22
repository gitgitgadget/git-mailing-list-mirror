From: Eygene Ryabinkin <rea-git@codelabs.ru>
Subject: Re: [PATCH] Allow shell scripts to run with non-Bash /bin/sh
Date: Sat, 22 Sep 2007 07:54:34 +0400
Message-ID: <20070922035434.GA99140@void.codelabs.ru>
References: <20070921214346.GF97288@void.codelabs.ru> <7vlkazh1ji.fsf@gitster.siamese.dyndns.org> <20070921214346.GF97288@void.codelabs.ru> <7v8x6zinjf.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 22 05:54:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYw4w-0002xw-CK
	for gcvg-git-2@gmane.org; Sat, 22 Sep 2007 05:54:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756454AbXIVDym (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Sep 2007 23:54:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754596AbXIVDym
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Sep 2007 23:54:42 -0400
Received: from pobox.codelabs.ru ([144.206.177.45]:58660 "EHLO
	pobox.codelabs.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753311AbXIVDyl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Sep 2007 23:54:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=simple; s=one; d=codelabs.ru;
	h=Received:Date:From:To:Cc:Message-ID:References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:Sender:X-Spam-Status:Subject;
	b=TAYtDlua/+p//dWV1K5ud/g0XaKtsPHFDc1l8ICGcrKCMfwFhMFjcaWvLbq/vcTOSS65Ds0VUp3Qy3dkDCOPtNMaMuumb/jP7ZvYBWs/hKpgavpPjw+8PPbPx6uKJkEohogsTSQ/26+MHnEF/3nMJv+sbW7722hn1V7U5pIDkv8=;
Received: from void.codelabs.ru (void.codelabs.ru [144.206.177.25])
	by pobox.codelabs.ru with esmtpsa (TLSv1:AES256-SHA:256)
	id 1IYw4k-0004rc-He; Sat, 22 Sep 2007 07:54:38 +0400
Content-Disposition: inline
In-Reply-To: <7vlkazh1ji.fsf@gitster.siamese.dyndns.org> <7v8x6zinjf.fsf@gitster.siamese.dyndns.org>
X-Spam-Status: No, score=-2.4 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58914>

Junio, good day.

Fri, Sep 21, 2007 at 04:52:52PM -0700, Junio C Hamano wrote:
> > Option parsing in the Git shell scripts uses the construct 'while
> > case "$#" in 0) break ;; esac; do ... done'.  This is neat, because
> > it needs no external commands invocation.  But in the case when
> > /bin/sh is not GNU Bash (for example, on FreeBSD) this cycle will
> > not be executed at all.
> 
> I do not doubt that "while case $# in 0) break ;; esac" does not
> work for your shell.  But I think the above comment is grossly
> misleading.
> 
> Don't mention bash there.  You sound as if you are blaming
> bashism, but the thing is, your shell is simply broken.

OK, you're right.  Especially if /bin/sh from Solaris and OpenBSD
are working and they are not Bash.  But I would not tell that
the shell is broken now -- I had not seen the POSIX specification.
Does it specifies how the shell should work in this case?

> You have other choices than bash on BSD don't you?

Did not understand the question, sorry.  The thing is that
FreeBSD has /bin/sh that is derived from the original Berkeley
shell.  And it is desirable to have it working with Git
script, since I don't want to make bash (or whatever shell
that is not /bin/sh) a dependency for the port.

> My quick test shows that ksh, pdksh and dash seem to work
> correctly.  This idiom is what I picked up around late 80's from
> somebody, and kept using on many variants of Unices.  I would
> find quite surprising that something that claims to be a shell
> does not work correctly.  Even /bin/sh that comes with Solaris
> seems to work correctly, which should tell you something.
> 
> OpenBSD's /bin/sh seems to be Ok; I do not know whose shell they
> use, but it seems to be hard-linked to /bin/ksh which is pdksh.

OK, I think I need to find out why FreeBSD's /bin/sh behaves
like this, because the test you propose on your next message
works.  See below.

By the way, my FreeBSD is 7-CURRENT, but I'll test on 6-STABLE
and perhaps on 4-STABLE on Monday.

Fri, Sep 21, 2007 at 07:33:21PM -0700, Junio C Hamano wrote:
> I am assuming that this works around _a_ bug in that /bin/sh; I
> would make sure I understand the nature of the bug.  Is it Ok to
> understand that with that shell, after this construct runs:
> 
> 	case <some word> in
>         <case arm #1>)
>         	something ;;
> 	<case arm #2>)
>         	something else ;;
> 	esac
> 
> the status from the whole case statement is false, when <some word>
> does not match any of the glob patterns listed in any of the case arm?
> 
> That is, what does the shell say if you do this?
> 
> 	case Ultra in
>         Super)
>         	false ;;
> 	Hyper)
>         	true ;;
> 	esac &&
>         echo case returned ok

It says 'case returned ok', so I will try to understand why it
works here and does not work in the 'while' construct.

Thanks for the pointer!
-- 
Eygene
