From: Dave Zarzycki <zarzycki@apple.com>
Subject: Re: [PATCH] Only print an error for the last connect() failure
Date: Thu, 09 Jun 2011 09:49:28 -0700
Message-ID: <767D7D04-6089-4C7B-A532-C5EC9FE0CCC6@apple.com>
References: <13539E82-3E8D-4210-9A3A-DD83F0CA6F85@apple.com>
 <20110609163340.GD25885@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 09 18:49:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUiQK-0002HL-Os
	for gcvg-git-2@lo.gmane.org; Thu, 09 Jun 2011 18:49:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752416Ab1FIQtb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jun 2011 12:49:31 -0400
Received: from honeycrisp.apple.com ([17.151.62.51]:49278 "EHLO
	mail-out.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751346Ab1FIQtb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2011 12:49:31 -0400
Received: from relay11.apple.com ([17.128.113.48])
 by mail-out.apple.com (Oracle Communications Messaging Exchange Server
 7u4-20.01 64bit (built Nov 21 2010))
 with ESMTPS id <0LMJ00G0682EN991@mail-out.apple.com> for git@vger.kernel.org;
 Thu, 09 Jun 2011 09:49:30 -0700 (PDT)
X-AuditID: 11807130-b7c15ae000005aca-8a-4df0f99afa91
Received: from koseret (koseret.apple.com [17.151.62.39])
	(using TLS with cipher RC4-MD5 (RC4-MD5/128 bits))
	(Client did not present a certificate)	by relay11.apple.com (Apple SCV relay)
 with SMTP id 9B.F6.23242.A99F0FD4; Thu, 09 Jun 2011 09:49:30 -0700 (PDT)
Received: from [17.153.30.81] (unknown [17.153.30.81])
 by koseret.apple.com (Oracle Communications Messaging Exchange Server
 7u4-20.01 64bit (built Nov 21 2010))
 with ESMTPSA id <0LMJ006DR82G9V10@koseret.apple.com> for git@vger.kernel.org;
 Thu, 09 Jun 2011 09:49:30 -0700 (PDT)
In-reply-to: <20110609163340.GD25885@sigill.intra.peff.net>
X-Mailer: Apple Mail (2.1237.1)
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175550>

On Jun 9, 2011, at 9:33 AM, Jeff King wrote:

> On Thu, Jun 09, 2011 at 09:18:10AM -0700, Dave Zarzycki wrote:
> 
>> IPv6 hosts are often unreachable on the primarily IPv4 Internet and
>> therefore we shouldn't print an error if there are still other hosts we
>> can try to connect() to. This helps "git fetch --quiet" stay quiet.
>> ---
>> connect.c |   12 +++++++-----
>> 1 files changed, 7 insertions(+), 5 deletions(-)
>> 
>> diff --git a/connect.c b/connect.c
>> index 2119c3f..7f70ce7 100644
>> --- a/connect.c
>> +++ b/connect.c
>> @@ -225,11 +225,13 @@ static int git_tcp_connect_sock(char *host, int flags)
>> 		}
>> 		if (connect(sockfd, ai->ai_addr, ai->ai_addrlen) < 0) {
>> 			saved_errno = errno;
>> -			fprintf(stderr, "%s[%d: %s]: errno=%s\n",
>> -				host,
>> -				cnt,
>> -				ai_name(ai),
>> -				strerror(saved_errno));
>> +			if (ai->ai_next == NULL) {
>> +				fprintf(stderr, "%s[%d: %s]: errno=%s\n",
>> +					host,
>> +					cnt,
>> +					ai_name(ai),
>> +					strerror(saved_errno));
>> +			}
> 
> I agree being noisy about early failures when we succeed later is a bad
> thing. But when we fail completely, doesn't your code now mask early
> failures and print only the final one? The early failures might be the
> important ones for the user.
> 
> So perhaps we should do something instead like:
> 
>  struct strbuf error_message = STRBUF_INIT;
>  ...
>  if (connect(...) < 0) {
>          strbuf_addf(&error_message, "%s[%d: %s]: errno=%s\n",
>                      host, cnt, ai_name(ai), strerror(errno));
>          ...
>  }
> 
>  if (sockfd < 0)
>          die("unable to connect to %s:\n%s", host, error_message.buf);
>  strbuf_release(&error_message);

I'm happy to make that change.

Personally speaking, I don't think we're masking failures any more than git is masking failures when it doesn't find a ref in .git/refs and it falls back to .git/packed-refs. This fallback is by design, and the same is true of any classic loop around getaddrinfo(). Of course, reasonable people may disagree about what the "right" thing to do here is. :-)

In any case, I'll update the patch later today.

davez
