From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH] imap-send: use Apple's Security framework for base64 encoding
Date: Mon, 29 Jul 2013 00:23:31 -0700
Message-ID: <CAJDDKr7=Y=zRHv_NRS64tXN=bw8hCZ503oVP+96TAkSzYbV9ug@mail.gmail.com>
References: <1374957092-41505-1-git-send-email-davvid@gmail.com>
	<20130729033533.GB2890@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeremy Huddleston <jeremyhu@apple.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 29 09:23:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V3hnt-0000jE-04
	for gcvg-git-2@plane.gmane.org; Mon, 29 Jul 2013 09:23:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754227Ab3G2HXc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jul 2013 03:23:32 -0400
Received: from mail-pb0-f42.google.com ([209.85.160.42]:55567 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750764Ab3G2HXc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jul 2013 03:23:32 -0400
Received: by mail-pb0-f42.google.com with SMTP id un1so4314882pbc.15
        for <git@vger.kernel.org>; Mon, 29 Jul 2013 00:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=+tdB3bZKvWIakvEcSci41PXxruwBGOT4XAFdR+nOue8=;
        b=E3GVYbrryYRMlk0UOdCRNM7NaE+J3AUsAMiznq40GMpYzLPtsNehKu77TOLbKozteL
         dxq2Ch0hImd64gC66gbNRnHhVkNg9BUuJOTVEenddDN+mfQG85GF5j+8f7kMOEUz6oZG
         +Ft4xQeP/x0w+/HsJ9bBbh+POLCly0dxZ2Dl2140LTc+9Q9yFZSuTnK3fNAioe9l1+WB
         ig2P9ndtR4z+V0I1bQ2FIpDT8JkGaW7U1Qiwno80sB8XnOnwG0sZt2EcppTl2gr8gmrg
         4yAbqbTwBfmhmvNW6oLFR6u5Pz0cD9FaDsU4rZcRazTxJa7BFWg6TnHwGGBSe59VPWpD
         43pw==
X-Received: by 10.68.181.163 with SMTP id dx3mr65852799pbc.186.1375082611647;
 Mon, 29 Jul 2013 00:23:31 -0700 (PDT)
Received: by 10.70.47.1 with HTTP; Mon, 29 Jul 2013 00:23:31 -0700 (PDT)
In-Reply-To: <20130729033533.GB2890@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231276>

On Sun, Jul 28, 2013 at 8:35 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Hi,
>
> David Aguilar wrote:
>
>> --- a/imap-send.c
>> +++ b/imap-send.c
>> @@ -22,14 +22,11 @@
>>   *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
>>   */
>>
>> -#include "cache.h"
>> -#include "exec_cmd.h"
>> -#include "run-command.h"
>> -#include "prompt.h"
>>  #ifdef NO_OPENSSL
>>  typedef void *SSL;
>>  #else
>>  #ifdef APPLE_COMMON_CRYPTO
>> +/* git-compat-util.h overwrites ctype.h; this must be included first */
>>  #include <CommonCrypto/CommonHMAC.h>
>
> Thanks for your work on this.
>
> Currently each translation unit of git includes git-compat-util.h or a
> header like cache.h that includes git-compat-util.h before doing
> anything else, since otherwise feature test macros are not set before
> the first system header is included.
>
> The above (CommonCrypto needing to be included before some of the
> definitions from git-compat-util.h) suggests to me that CommonCrypto
> should just be included directly from git-compat-util.h in some
> appropriate place.  That way any other header that needs CommonCrypto
> routines only has to include git-compat-util.h first as usual and
> doesn't have to worry about the order of other #includes.  Could that
> work?

imap-send is currently the only user of this stuff; I believe this
would pull in these library dependencies for all builtins.

If we don't mind a new file, something like git-compat-crypto.h could
be a nice place to tuck all these #ifdefs away.  If we had another
command that needed these then it'd be a easier to justify a new file.

A test-crypto command in the test suite could be written to verify
that the implementations work as advertised.  That counts as "another
command", albeit an internal one.  I don't believe imap-send has any
test coverage so pulling this stuff out would help make it more
testable, which is a net win.  Libifying might be a little premature,
though.

Thoughts?
-- 
David
