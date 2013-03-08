From: Andrew Wong <andrew.kw.w@gmail.com>
Subject: Re: [PATCH] setup.c: Fix prefix_pathspec from looping pass end of string
Date: Thu, 7 Mar 2013 19:25:36 -0500
Message-ID: <CADgNja=8f+_ORb_WStRz2grr0pYmJ2gZTnCHbOGUb3ogPPd_LQ@mail.gmail.com>
References: <1362674163-24682-1-git-send-email-andrew.kw.w@gmail.com>
	<7vobeulw4d.fsf@alter.siamese.dyndns.org>
	<CADgNjakrBCD2jMNUz95E-7FkyKmNgcQeuz8grDWczb-hM6yHhg@mail.gmail.com>
	<7vvc92kbho.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 08 01:26:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDl8c-0001GY-HZ
	for gcvg-git-2@plane.gmane.org; Fri, 08 Mar 2013 01:26:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760101Ab3CHAZk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Mar 2013 19:25:40 -0500
Received: from mail-wg0-f41.google.com ([74.125.82.41]:43909 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759998Ab3CHAZi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Mar 2013 19:25:38 -0500
Received: by mail-wg0-f41.google.com with SMTP id ds1so7676350wgb.0
        for <git@vger.kernel.org>; Thu, 07 Mar 2013 16:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=PxUTsftBafYXrKRIqnf0Kq2Q8uhSklefbt9VPNotE7A=;
        b=HWwuESRvY0FumNOaO7y3ifhhle+jgy37qq1lps+DnmFVsG6lzvk1mvNFzFe30M13aG
         1ohJFoIsUygr5GAJ7onF7r3omzOVuU0MX4NMnMKQjid3pGGvsBD1Fuc6XvzyGu3u8oZh
         c7NkV1jP6BIz5k7+qfgQNYQx2237KtQB3fqVFxYOrnguMGfzh0Ny7s94skvhpiNtyr8g
         QcGx4ZEd+Ec9zbWI18V95YzAE/nRiOn9QfwBV2wmYLW1JAIleN/dFrAoMM6orXtQjwvH
         MVJWQtgAxI4/DtlDj7uQUH0KTUudjvjQSXgSJxthtm7IeSItGmw0+H7pJ1Vnze9KDsNh
         ad+A==
X-Received: by 10.180.105.229 with SMTP id gp5mr424057wib.10.1362702336938;
 Thu, 07 Mar 2013 16:25:36 -0800 (PST)
Received: by 10.194.39.202 with HTTP; Thu, 7 Mar 2013 16:25:36 -0800 (PST)
In-Reply-To: <7vvc92kbho.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217634>

On 3/7/13, Junio C Hamano <gitster@pobox.com> wrote:
> This did not error out for me, though.
>
>     $ cd t && git ls-files ":(top"

No error message at all? Hm, maybe in your case, the byte after the
end of string happens to be '\0' and the loop ended by chance?

git doesn't crash for me, but it generates this error:
    $ git ls-files ":(top"
    fatal: Invalid pathspec magic 'LS_COLORS=' in ':(top'

The loop runs for a second time after parsing "top", and copyfrom now
points to the byte after ":(top", which is coming from argv. And in my
distribution/platform, it looks like the envp, the third param of
main(), is packed right after the argv strings, because:
    $ env | head -n 1
    LS_COLORS=
