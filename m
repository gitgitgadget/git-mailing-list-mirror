From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git init with template dir
Date: Fri, 12 Jun 2015 09:13:16 -0700
Message-ID: <xmqqeglgewgz.fsf@gitster.dls.corp.google.com>
References: <loom.20150612T085835-977@post.gmane.org>
	<xmqqioatdk0z.fsf@gitster.dls.corp.google.com>
	<loom.20150612T175402-182@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Alex Cornejo <acornejo@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 12 18:13:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z3Ra8-0004p4-Qy
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jun 2015 18:13:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752650AbbFLQNU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jun 2015 12:13:20 -0400
Received: from mail-ig0-f170.google.com ([209.85.213.170]:33836 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751130AbbFLQNT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jun 2015 12:13:19 -0400
Received: by igbhj9 with SMTP id hj9so15716125igb.1
        for <git@vger.kernel.org>; Fri, 12 Jun 2015 09:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=KQW43h/UfEWreL2kqjyk/E0ceUVjTqGg13urgPreeLA=;
        b=zi9EvOKHa+XuPSmHkHQU0YzI7+3damJ/ULjiFqTYpet/ZU5tliM5IBZrivIsYWNRsA
         9hKmqhyp1Fczi0Yq1SCIWvXmI4VV3kzzcq11HKofLdu859IPn4lW9ZWErhc6eXwAqvKi
         Dpa6+24udj28+hivyYZ8jMq9ClGHcKHr1tglC14pW3gEFTNWPM9Hn/hwPthG4ho79xhz
         pGgSPI5CTGbMLkPhXbwTLwYh2WOpLg/zz9wOIc1WWNI/lfjXVUrQa2O4fk4Bs/wWuKJP
         X6y4BuRFk/5xUff7V72rlSZ/75xWIP3CUrTkTTS1dOTQHaqt4kDbY8zaTHpJLts77NrM
         o13g==
X-Received: by 10.43.148.72 with SMTP id kf8mr17745034icc.76.1434125598763;
        Fri, 12 Jun 2015 09:13:18 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:ac40:153c:ed59:12ce])
        by mx.google.com with ESMTPSA id g23sm2753696iod.37.2015.06.12.09.13.17
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 12 Jun 2015 09:13:18 -0700 (PDT)
In-Reply-To: <loom.20150612T175402-182@post.gmane.org> (Alex Cornejo's message
	of "Fri, 12 Jun 2015 15:59:51 +0000 (UTC)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271495>

Alex Cornejo <acornejo@gmail.com> writes:

> Junio C Hamano <gitster <at> pobox.com> writes:
>
>> Hmmm, I do not seem to be able to do this, though.
>> 
>>         $ ln -s $HOME/g/share/git-core/templates /var/tmp/git-template
>>         $ cd /var/tmp
>>         $ git init --template=/var/tmp/git-template new
>>         $ find new/.git -type l
>>         ... nothing ...
>
> Thanks for your prompt response Juno.
>
> That make sense. The fact that you were unable to reproduce this tells
> me that there is probably something fishy/unexpected with the
> environment in which I tried this (which is not too surprising, given
> that I was doing it inside a linux container, inside a virtual machine,
> where both of these were setup using a scripts which ultimately failed
> after the git init step, due to the symlink behavior I described, but
> most likely this is my own fault).

I wouldn't call that your "fault".  After all, as more people want
to run Git in different environments, we would want to make sure Git
runs correctly for them.

I quickly re-scanned what we do inside "git init" and how we
populate the repository from templates.  This happens all in
builtin/init-db.c:

 - copy_templates() does opendir(), so it should not have mattered
   that I used /var/tmp/git-template that is a symbolic link to a
   real location in my quick reproduction attempt;

 - it calls a recursive copy_templates_1() with that directory
   handle it opened for the template directory.  Each entry it finds
   are inspected and

   - real directories are recursed into;
   - files are copied; and
   - symlinks are recreated.

So if I instead made a new directory /var/tmp/git-template/ and then
populated it with a bunch of symbolic links e.g. hooks, description,
etc., that points at their real location, I would have seen that the
resulting repository populated with symbolic links.

And I think that is an expected behaviour.

But if "git init" made bunch of symbolic links only because it was
given a symbolic link to the real directory via its --template
parameter, that _is_ unexpected, and we may want to dig deeper to
correct it.
