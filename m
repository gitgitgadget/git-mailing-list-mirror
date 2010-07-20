From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] git-svn: write memoized data explicitly to avoid Storable 
	bug
Date: Tue, 20 Jul 2010 17:32:31 +0000
Message-ID: <AANLkTime7QQZGLXmXg_X3W7CsbyLe5NbPKcqs9dp0oaa@mail.gmail.com>
References: <1279455469-6384-1-git-send-email-vsu@altlinux.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>,
	A Large Angry SCM <gitzilla@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Sergey Vlasov <vsu@altlinux.ru>
X-From: git-owner@vger.kernel.org Tue Jul 20 19:32:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ObGgV-0001X4-8E
	for gcvg-git-2@lo.gmane.org; Tue, 20 Jul 2010 19:32:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758399Ab0GTRcp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Jul 2010 13:32:45 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:47172 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756924Ab0GTRco convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Jul 2010 13:32:44 -0400
Received: by pwi5 with SMTP id 5so2244353pwi.19
        for <git@vger.kernel.org>; Tue, 20 Jul 2010 10:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=lGwtB6V4u0OZh5sIyYG+zV6TlsH2TpeRVpYM/miSvZ0=;
        b=v6Y13jBNOtz/spQ8KtnavXYZ9aqLWDHj0Qt6Bew0O2Ei32hRSXZqnhYcVVuEBzUtGy
         buRvfgM0OWm0S5BEbIe1/nk1Bkn0JJwqbmxZ3s/dwqAGxDWW8aqp0klw9FjO64u/9Rrb
         R/kO8Y/C76t6CF71ODFTK06L38PX839WdzeUw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=CZs7PUCN2tbXZ3/PhZtNueXxO68QQPnowiMggTPTnzhPfDnvemYfuXh05O5HQkPzFu
         gyrgFjradwzAEcwXavx6/q3VgD6gkX/TRyPHU+RhUBFufG37jWYd5clLTzJIGjK3+nIp
         ZDvbKKLUJ9qDi5eQ3EBtKzebEowW7L9MXmGDQ=
Received: by 10.142.193.19 with SMTP id q19mr9667347wff.268.1279647151735; 
	Tue, 20 Jul 2010 10:32:31 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Tue, 20 Jul 2010 10:32:31 -0700 (PDT)
In-Reply-To: <1279455469-6384-1-git-send-email-vsu@altlinux.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151334>

On Sun, Jul 18, 2010 at 12:17, Sergey Vlasov <vsu@altlinux.ru> wrote:
> Apparently using the Storable module during global destruction is
> unsafe - there is a bug which can cause segmentation faults:
>
> =C2=A0http://rt.cpan.org/Public/Bug/Display.html?id=3D36087
> =C2=A0http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D482355

I did some investigation into the upstream issue:
https://rt.cpan.org/Ticket/Display.html?id=3D36087#txn-806832

> The persistent memoization support introduced in commit 8bff7c538
> relied on global destruction to write cached data, which was leading
> to segfaults in some Perl configurations. =C2=A0Calling Memoize::unme=
moize
> in the END block forces the cache writeout to be performed earlier,
> thus avoiding the bug.

Maybe I'm missing something obvious, but this seems like the wrong
solution. The core issue is that we don't want to clean up during
global destruction, but then we should just do:

       sub DESTROY {
               return if not $memoized;
               $memoized =3D 0;

               Memoize::unmemoize 'lookup_svn_merge';
               Memoize::unmemoize 'check_cherry_pick';
               Memoize::unmemoize 'has_no_changes';
       }

That should work since memoize_svn_mergeinfo_functions(); is being
called in find_extra_svn_parents, which is a Git::SVN object
method. Can you try this and confirm/deny? I can't because I can't get
the original to segfault on my box when run within git-svn.
