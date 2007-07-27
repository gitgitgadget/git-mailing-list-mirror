From: "Carlos Rica" <jasampler@gmail.com>
Subject: Re: [PATCH] Make verify-tag a builtin.
Date: Fri, 27 Jul 2007 21:51:41 +0200
Message-ID: <1b46aba20707271251g7cf968a6o3840739dec548408@mail.gmail.com>
References: <46A96F86.2030704@gmail.com>
	 <7vr6mu2uo0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 27 21:51:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEVqp-0007kR-3t
	for gcvg-git@gmane.org; Fri, 27 Jul 2007 21:51:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765898AbXG0Tvo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Jul 2007 15:51:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1766009AbXG0Tvn
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jul 2007 15:51:43 -0400
Received: from wa-out-1112.google.com ([209.85.146.181]:13392 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765898AbXG0Tvm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2007 15:51:42 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1040002wah
        for <git@vger.kernel.org>; Fri, 27 Jul 2007 12:51:42 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=j7+04VP01w7zPzOWG5tVNSfp5AcDQTyQXxOGyl33+FOU2O8uSt5QBSvI7HedCKUH9r/70fQgd2o0H70VxZ8zKTDJdo96Q0rE8NWp13GwrJMIM2gxppR1VnuOe9CtNq+gsV7aSJk0oe7vV7r14K5QFcY/ZhlA/RpBTOlnkZLrsKQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=skiuFzxWLWJnbcOWbUhQhybkrEahxa4zvMDVAK6n9QP2M6b12xKeUvpd7ulrgFSNdPHPNjLEtc6Wa0oaP8zzWo6OmQk471sLwajPgLHwbbNc3EvOnfIgMx4s+DoyPdDmJBPck6EwiQvFq981jwW2wM49GRctjylPA+pgXwB6YcE=
Received: by 10.114.180.1 with SMTP id c1mr3260023waf.1185565901940;
        Fri, 27 Jul 2007 12:51:41 -0700 (PDT)
Received: by 10.114.61.17 with HTTP; Fri, 27 Jul 2007 12:51:41 -0700 (PDT)
In-Reply-To: <7vr6mu2uo0.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53960>

2007/7/27, Junio C Hamano <gitster@pobox.com>:
> Carlos Rica <jasampler@gmail.com> writes:
> > Signal SIGPIPE is ignored because the program sometimes was
> > terminated because that signal when writing the input for gpg.
>
> This "sometimes" does not give confidence to readers, I am
> afraid.
>
> What is happening is perfectly normal, not "sometimes it gets
> the signal mysteriously, so we need to paper it over by ignoring
> it".
>
> You invoke gpg, giving it a file that is supposed to contain a
> detached signature, and start feeding the payload that ought to
> verify Ok with the signature.  If the tag is not signed, after
> gpg has read the detached signature, it already knows that the
> signature will not verify and it can exit without reading the
> payload from its standard input.  When you try to write the
> payload to the pipe, you would get SIGPIPE.

By using "sometimes" I was requesting an answer to this strange
behaviour (for me) to you and the mailing list. Now I could reproduce it
removing the call to signal and running this:

#!/bin/sh
echo "creating vtag1..."
git tag -s -m "a signed tag" vtag1
echo "creating vtag2..."
git tag -m "an annotated non-signed tag" vtag2
echo "creating vtag3..."
git tag -m "another annotated non-signed tag is " vtag3
# 141 returned sometimes when gpg got
# a non-signed file as detached signature:
# (it refuses to read from the input when
# no signature is given, sometimes)
for i in 1 2 3 4 5 6 7 8 9 10
do
        ./git verify-tag vtag1 vtag2 vtag3
        echo "git verify-tag vtag1 vtag2 vtag3 exit code: $?"
        echo
done
git tag -d vtag1
git tag -d vtag2
git tag -d vtag3

In my system, some of the tests give 141 and others give 1 as exit code.
Dscho said that it could depend on the CPU current load of the computer,
since he got always 141 as you said, so perhaps it's me.
