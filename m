From: Michal Rokos <michal.rokos@nextsoft.cz>
Subject: Re: [PATCH] Add compat/vsnprintf.c for systems that returns -1 on maxsize reached
Date: Wed, 5 Mar 2008 09:37:39 +0100
Organization: NextSoft
Message-ID: <200803050937.40345.michal.rokos@nextsoft.cz>
References: <200803041459.29000.michal.rokos@nextsoft.cz> <47CD78C9.80003@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: GIT <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Mar 05 09:38:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWp8s-0002n9-Ve
	for gcvg-git-2@gmane.org; Wed, 05 Mar 2008 09:38:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755542AbYCEIht (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2008 03:37:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755127AbYCEIhs
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Mar 2008 03:37:48 -0500
Received: from holub.nextsoft.cz ([195.122.198.235]:38616 "EHLO
	holub.nextsoft.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750829AbYCEIhr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2008 03:37:47 -0500
Received: by holub.nextsoft.cz (Postfix, from userid 111)
	id BBFCB8E5; Wed,  5 Mar 2008 09:37:45 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by holub.nextsoft.cz (Postfix) with ESMTP id 25BA98E4;
	Wed,  5 Mar 2008 09:37:44 +0100 (CET)
Received: from holub.nextsoft.cz ([127.0.0.1])
	by localhost (holub.nextsoft.cz [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 22207-08; Wed, 5 Mar 2008 09:37:44 +0100 (CET)
Received: from 89-24-238-42.i4g.tmcz.cz (89-24-238-42.i4g.tmcz.cz [89.24.238.42])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by holub.nextsoft.cz (Postfix) with ESMTP id B98B8756;
	Wed,  5 Mar 2008 09:37:43 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <47CD78C9.80003@viscovery.net>
Content-Disposition: inline
X-Bogosity: Ham, tests=bogofilter, spamicity=0.000000, version=1.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76193>

Hello,

On Tuesday 04 March 2008 17:28:57 Johannes Sixt wrote:
> Michal Rokos schrieb:
> > If anybody could think of some better define than BROKEN_VSNPRINTF, I'm
> > all ears.
>
> CLUELESS_OVERFLOWN_VSNPRINTF?

Heh. My first one was VSNPRINTF_RETURNS_MINUS_1...

> Because we have the same issue on Windows where vsnprintf returns -1 on
> overflow.
>
> But there is also another complication: The size parameter of the system's
> vsnprintf must not count the trailing NUL, i.e. the buffer must actually
> have space for one extra byte, whereas the POSIX version must count NUL.
> Can you check whether your vsnprintf has this flaw, too? If it doesn't, we
> would need another configuration variable so that we can distinguish these
> two kinds of brokenness.

I did my homework and prepared this:

#include "stdio.h"
#include "stdarg.h"

int test_vsnprintf(char *str, size_t maxsize, const char *format, ...)
{
  int ret;
  va_list ap;

  va_start(ap, format);
  ret = vsnprintf(str, maxsize, format, ap);
  va_end(ap);

  return ret;
}

int main(void)
{
  char buf[10];
  int ret;

  ret = test_vsnprintf(buf, 1, "%s", "12345");
  printf("case1: %d\n", ret);

  ret = test_vsnprintf(buf, 5, "%s", "12345");
  printf("case2: %d\n", ret);

  ret = test_vsnprintf(buf, 6, "%s", "12345");
  printf("case3: %d\n", ret);

  ret = test_vsnprintf(buf, 10, "%s", "12345");
  printf("case4: %d\n", ret);

  return 0;
}

which returns:
Linux 2.6.25-rc3-mr i686
case1: 5
case2: 5
case3: 5
case4: 5

HP-UX B.11.11 9000/800
case1: -1
case2: -1
case3: 5
case4: 5

HP-UX B.11.23 ia64
case1: -1
case2: -1
case3: 5
case4: 5

So HPUX impl is the same as a Windows one. So we can share the replacement.
Please note that there's no va_copy() on HPUX.

I think that Tru64 has the same issue, but I have no HW to test it on now.

Could somebody else try to run testcase above on some other OSes?

Thanks

Michal
