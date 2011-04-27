From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCHv2 5/6] Use floating point for --dirstat percentages
Date: Tue, 26 Apr 2011 19:45:33 -0700
Message-ID: <BANLkTi=uWxpyJhEGt97K_qSZV_VPuD5JcQ@mail.gmail.com>
References: <1303776102-9085-1-git-send-email-johan@herland.net>
 <1303870359-26083-1-git-send-email-johan@herland.net> <1303870359-26083-6-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Apr 27 04:46:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QEulj-00058U-9y
	for gcvg-git-2@lo.gmane.org; Wed, 27 Apr 2011 04:46:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758101Ab1D0CqS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Apr 2011 22:46:18 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:55552 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757169Ab1D0CqR convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2011 22:46:17 -0400
Received: from mail-ew0-f46.google.com (mail-ew0-f46.google.com [209.85.215.46])
	(authenticated bits=0)
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id p3R2jtK9012100
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=FAIL)
	for <git@vger.kernel.org>; Tue, 26 Apr 2011 19:45:56 -0700
Received: by ewy4 with SMTP id 4so379688ewy.19
        for <git@vger.kernel.org>; Tue, 26 Apr 2011 19:45:53 -0700 (PDT)
Received: by 10.14.9.97 with SMTP id 73mr675026ees.29.1303872353069; Tue, 26
 Apr 2011 19:45:53 -0700 (PDT)
Received: by 10.14.124.148 with HTTP; Tue, 26 Apr 2011 19:45:33 -0700 (PDT)
In-Reply-To: <1303870359-26083-6-git-send-email-johan@herland.net>
X-Spam-Status: No, hits=-103.466 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,USER_IN_WHITELIST
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172159>

On Tue, Apr 26, 2011 at 7:12 PM, Johan Herland <johan@herland.net> wrot=
e:
> Allow specifying --dirstat cut-off percentage as a floating point num=
ber.
>
> When printing the dirstat output, floating point numbers are presente=
d in
> rounded form (as opposed to truncated). Therefore, this patch include=
s a
> significant churn in the expected output of the dirstat selftests.

Hmm. So thinking more about this, I do think it's preferable that the
percentages never be rounded up.

Why? Having them add up to 99.9 due to rounding error makes a ton more
sense to me than having percentages add up to 100.1 But I guess I
don't care _that_ much, since most of the time I use "cumulative",
where you don't much have that issue anyway.

Also:

> Remaining questions:
>
> =A0- Locale issues with strod(), e.g. decimal separator is a comma in=
 certain
> =A0 locales.

I think this is a serious issue. Of course, any sane user will have
the numeric locale be set to "C", but we know that any argument that
depends on sane users is likely broken.

So regardless of the rounding, I do think we should make sure that we h=
ave a

  setlocale(LC_NUMERIC, "C");

both for the parsing _and_ for the printout. And if somebody really
wants the locale to affect these kinds of things, we might have a
config option to allow it, but I think we should default to a nice
fixed format in this case.

(I don't know anybody who uses LC_NUMERIC that actually sets the
decimal point character to ',' though - it is bound to break a ton of
applications. And I say that as somebody who grew up with a "decimal
comma").

                   Linus
