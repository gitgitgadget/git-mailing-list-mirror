From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v2 6/8] gitweb: Push formatting diff lines to print_diff_chunk()
Date: Thu, 29 Mar 2012 17:59:44 +0100
Message-ID: <201203291859.44891.jnareb@gmail.com>
References: <1332543417-19664-1-git-send-email-michal.kiedrowicz@gmail.com> <1332543417-19664-7-git-send-email-michal.kiedrowicz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: =?utf-8?q?Micha=C5=82_Kiedrowicz?= <michal.kiedrowicz@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 29 18:59:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDIhU-0005Ij-GW
	for gcvg-git-2@plane.gmane.org; Thu, 29 Mar 2012 18:59:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759516Ab2C2Q7s convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 29 Mar 2012 12:59:48 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:55347 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759129Ab2C2Q7q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2012 12:59:46 -0400
Received: by wgbdr13 with SMTP id dr13so1749232wgb.1
        for <git@vger.kernel.org>; Thu, 29 Mar 2012 09:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=v5gvHp5b0mOvleVl6vcnhr4cbBBPbijTwZwznUxGT8Q=;
        b=viIA1zSz0TrH/m4d+UGNjXWzhmCJnTEIas83cLR3DPw0VomYOvg54/U0txeMhFEC3v
         0Mk+vBHii7H1x30gcRrwd14K8u3ZZrc3SaDZ7gnayo+gcUNnP+MUkeWW5e58kjPLhGX8
         c08Tn0rVZ7l07pAWjf+GB3Id2koeqfP36bEp3u2eg/nAoYTWMzFB0Si8RkrCcmbKj8TJ
         wfTd+FTypaQB8SKOidAaRZt6B5ednfSpJZmt11FyPVt1yXKqHvixm8kY3LNiUP+bRNQA
         z4HvELijvDtHct9zZYOtIOa8RIa/+wofx3imF/iL4pKWnPGDbOsfWJgvEUMpkBurt6/c
         OrDw==
Received: by 10.180.88.67 with SMTP id be3mr7290976wib.20.1333040385511;
        Thu, 29 Mar 2012 09:59:45 -0700 (PDT)
Received: from [192.168.1.13] (aeh224.neoplus.adsl.tpnet.pl. [83.25.111.224])
        by mx.google.com with ESMTPS id n8sm30847647wix.10.2012.03.29.09.59.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 29 Mar 2012 09:59:44 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1332543417-19664-7-git-send-email-michal.kiedrowicz@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194270>

On Fri, 23 Mon 2012, Micha=C5=82 Kiedrowicz wrote:

> Now git_patchset_body() only calls diff_line_class(), which is remove=
d
> from process_diff_line(). The latter function is renamed to
> format_diff_line() and its output is changed to return only
> HTML-formatted line, which brings it in line with outher format_*
> subroutined.
>=20
> This slightly changes the order of operations performed on diff lines=
=2E
> Before this commit, each read line was formatted and then put to the
> @chunk accumulator. Now, lines are formatted inside print_diff_chunk(=
),

This is a bit convoluted description.


As I understand it, what happens here is that formatting lines is
pushed down to print_diff_chunk(), closer to the place where we
actually use HTML formatted output.

This means that we put raw lines in the @chunk accumulator, rather
than formatted lines.  Because we still need to know class (type)
of line when accumulating data to post-process and print,=20
process_diff_line() subroutine was retired and replaced by=20
diff_line_class() used in git_patchset_body() and new / resurrected
format_diff_line() used in print_diff_chunk().

Isn't it?
=20

A side effect is that we have to pass \%from and \%to down the
callstack.

> This is a preparation patch for diff refinement highlightning. It's n=
ot
> meant to change gitweb output.
>=20
This is a very nice refactoring.  I was never really comfortable with
the API of process_diff_line(), which was different from all other
subroutines in gitweb, and error prone to call.  I wish we used this
solution presented in this commit from the very beginning.

BTW. I think we can simply squash this commit with previous one; no
need to improve process_diff_line() if we are retiring it.

> Signed-off-by: Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com>
> Acked-by: Jakub Nar=C4=99bski <jnareb@gmail.com>
> ---
>  gitweb/gitweb.perl |   25 ++++++++++++-------------
>  1 files changed, 12 insertions(+), 13 deletions(-)

--=20
Jakub Narebski
Poland
