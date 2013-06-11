From: =?UTF-8?Q?Beno=C3=AEt_Person?= <benoit.person@ensimag.fr>
Subject: Re: [PATCH/RFC] git-remote-mediawiki: new tool to preview local
 changes without pushing
Date: Tue, 11 Jun 2013 23:31:31 +0200
Message-ID: <CAETqRCiJmnz_1yjwvyWx+=kPkt3M+vKk--CnS=rnQcDA4wMSmg@mail.gmail.com>
References: <1370641831-9115-1-git-send-email-benoit.person@ensimag.fr>
	<20130609060807.GA8906@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org,
	=?UTF-8?Q?C=C3=A9lestin_Matte?= <celestin.matte@ensimag.fr>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 11 23:31:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmWAC-0008DD-V3
	for gcvg-git-2@plane.gmane.org; Tue, 11 Jun 2013 23:31:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756109Ab3FKVbd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jun 2013 17:31:33 -0400
Received: from mail-ie0-f182.google.com ([209.85.223.182]:51634 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755789Ab3FKVbb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jun 2013 17:31:31 -0400
Received: by mail-ie0-f182.google.com with SMTP id s9so6585568iec.13
        for <git@vger.kernel.org>; Tue, 11 Jun 2013 14:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=8Bnd8eOcH/dVZkbpe4sTClDUjZEDIKPSmDsc3MCTn6o=;
        b=QoIHPe51pA2exHHJTEqoCtJf29+dZrO5w/HWX3KD2x/6GaESVYpGkT+h/qrFsExYqW
         c0XHQu5jbzEBPpiMTXAADs72j0eZe99Pv44ySJWA4XSqwE+t7YXm/q1B5kairH47tts8
         QjB1fdRa41AFRTyqwLqemC8Kgz96+NKrN7323+LXAaZRY3KGZOjjTiye03TU6dchoByv
         4KxvTeaIwXxZ/wR1lymatwN9n02EuGrVUITyFQ+dGVgZgYL5lvMlHQyUkeJUDmqkuYWo
         hmswY6h2hi/9WfdstuMJuSuGk8Q9YOyM1U0ZQiITNQ0fByLGQRXvJNTHDX2KmvCwGs5t
         +4Vg==
X-Received: by 10.50.67.110 with SMTP id m14mr1839893igt.37.1370986291241;
 Tue, 11 Jun 2013 14:31:31 -0700 (PDT)
Received: by 10.42.210.20 with HTTP; Tue, 11 Jun 2013 14:31:31 -0700 (PDT)
In-Reply-To: <20130609060807.GA8906@sigill.intra.peff.net>
X-Google-Sender-Auth: vgkAXOwyE3Xauaw8qXbypGQVadA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227516>

The V2 is on the launchpad but I am still struggling with the code
factoring between git-mw.perl and git-remote-mediawiki.perl :/ .

On 9 June 2013 08:08, Jeff King <peff@peff.net> wrote:
>
> You could make a Git::MediaWiki.pm module, but installing that would
> significantly complicate the build procedure, and potentially be
> annoying for users. One trick I have done in the past is to concatenate
> bits of perl script together in the Makefile, like this:
>
>   foo: common.pl foo.pl
>           { \
>             echo '$(PERL_PATH_SQ)' && \
>             for i in $^; do \
>               echo "#line 1 $src" && \
>                 cat $src \
>             done \
>           } >$@+
>           mv $@+ $@
>
> That would conflict a bit with the way we chain to git's Makefile,
> though. I suspect you could do something complicated like build "foo.pl"
> from "common.pl" and "foo-main.pl", then chain to git's Makefile to
> build "foo" from "foo.pl".

I've implemented this one for now but after a real-life meeting with
Matthieu Moy we discussed the possibility to build a GitMediawiki.pm
module. It seems more "clean" than the concatenation of perl scripts.
Plus, it would force people to limit side effects inside the functions
used in this package/utils file (I have in mind the mw_connect_maybe
function here and a couple of others which directly *hope* for global
vars to be set to a nice value before being called).

What I find bad in the concatenating-thingy is the mandatory rename of
git-mw.perl into something like git-mw.unmerged.perl and
git-remote-mediawiki.perl into git-remote-mediawiki.unmerged.perl.
Otherwise, like you said, it would be hard to chain to git's Makefile
after the merge.

For now, I have really no idea which one is the best. If I may ask,
what did you have in mind while saying:

> You could make a Git::MediaWiki.pm module, but installing that would
> significantly complicate the build procedure, and potentially be
> annoying for users.

?

Since my previous commit (ea07ec1 in next - use Git.pm functions for
credentials), git-remote-mediawiki.perl already depends on the proper
installation of the Git.pm package. In what ways the need for the
installation of yet another package (GitMediawiki.pm) would annoy a
user ?

Thank you for your time,

Benoit
