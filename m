From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v4] compat: Fix read() of 2GB and more on Mac OS X
Date: Mon, 19 Aug 2013 15:51:41 -0700
Message-ID: <CA+55aFzAQjxB7HkDqR6_3wdex1t1Tbrf5CeUVyiVm=DRyDVhhQ@mail.gmail.com>
References: <1376900499-662-1-git-send-email-prohaska@zib.de>
	<1376926879-30846-1-git-send-email-prohaska@zib.de>
	<CA+55aFzQhJqE4QDwJDKtkTtJpMNbz3_Aw5_Q3yTk5DnhLJyjCQ@mail.gmail.com>
	<xmqqeh9p8ut3.fsf@gitster.dls.corp.google.com>
	<7E527329-230E-4954-9942-8BB0935ACE4D@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Steffen Prohaska <prohaska@zib.de>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Sixt <j6t@kdbg.org>,
	John Keeping <john@keeping.me.uk>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Eric Sunshine <sunshine@sunshineco.com>
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 20 00:51:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBYIc-00051w-2Y
	for gcvg-git-2@plane.gmane.org; Tue, 20 Aug 2013 00:51:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751333Ab3HSWvm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Aug 2013 18:51:42 -0400
Received: from mail-vc0-f176.google.com ([209.85.220.176]:37191 "EHLO
	mail-vc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751215Ab3HSWvl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Aug 2013 18:51:41 -0400
Received: by mail-vc0-f176.google.com with SMTP id ha11so3462349vcb.35
        for <git@vger.kernel.org>; Mon, 19 Aug 2013 15:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=FaCJP5y1DO1qZtQDqw6KRz+bHJoxmIGUib3n+Cz05jI=;
        b=wXsn4FrQFSE4YFF4btbMAqC6qa4oJrZLCqyDfHlskQua2QzJbvZrMVZ946A4EbdpeI
         OrZ4sAdvo/OSz4PrV1BYdU2+lhbYH61G4v/AHLo6NWWLrt+15S4XWeUb0CZ5AoJdu8L9
         5mbwT8ywJ3swld7F5ZXVVqhjcapo1hFkrPk4/TMqe5rnZKLdz9BKLTDW+/urpT2bO5lJ
         J/Ohmy0wvgprjpkq0Mt64phIF7epXXQ6/S/TMkGd4y1dVhpq/EPPyf5Ww2vK6T1Ascfg
         lRt+eNWYksS1pRyyP8mszltHrxUAtpUcQZ+oGtsT2cQb33ZBlJWGSbAV6++JCR41qY4C
         Gadg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=FaCJP5y1DO1qZtQDqw6KRz+bHJoxmIGUib3n+Cz05jI=;
        b=O1P1g3+jv96aPanNsz6Tr+0UkoghPlG6aSVeivSKFsHRB21N5ZtlOn8a7jngdxT3Lq
         yHbMv/nMyQRvSFBc/LCTez7MQ2arPgo9kgeSWwFf1zUft4R2Nkj2IY2kF29blJeS+qds
         gZwfD4QboPA6Bzh24iFouFDiqL+Dja/BTHFl0=
X-Received: by 10.52.180.229 with SMTP id dr5mr13032241vdc.20.1376952701160;
 Mon, 19 Aug 2013 15:51:41 -0700 (PDT)
Received: by 10.220.3.137 with HTTP; Mon, 19 Aug 2013 15:51:41 -0700 (PDT)
In-Reply-To: <7E527329-230E-4954-9942-8BB0935ACE4D@gmail.com>
X-Google-Sender-Auth: u11Mu5Z8GlzH9lZM2x3W4EqCvH4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232575>

On Mon, Aug 19, 2013 at 2:56 PM, Kyle J. McKay <mackyle@gmail.com> wrote:
>
> The fact that the entire file is read into memory when applying the filter
> does not seem like a good thing (see #7-#10 above).

Yeah, that's horrible. Its likely bad for performance too, because
even if you have enough memory, it blows everything out of the L2/L3
caches, and if you don't have enough memory it obviously causes other
problems.

So it would probably be a great idea to make the filtering code able
to do things in smaller chunks, but I suspect that the patch to chunk
up xread/xwrite is the right thing to do anyway.

              Linus
