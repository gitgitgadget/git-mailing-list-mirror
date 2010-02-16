From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fix threaded grep for machines with only one cpu
Date: Tue, 16 Feb 2010 11:20:27 -0800
Message-ID: <7vocjpng1w.fsf@alter.siamese.dyndns.org>
References: <20100215225001.GA944@book.hvoigt.net>
 <7vwryet2cw.fsf@alter.siamese.dyndns.org>
 <7vocjpnc5v.fsf@alter.siamese.dyndns.org>
 <7vljetlx8r.fsf@alter.siamese.dyndns.org>
 <20100216180209.GA1532@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Fredrik Kuivinen <frekui@gmail.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Tue Feb 16 20:21:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhSyV-0004P8-Ox
	for gcvg-git-2@lo.gmane.org; Tue, 16 Feb 2010 20:20:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933182Ab0BPTUm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2010 14:20:42 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:54111 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932757Ab0BPTUl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2010 14:20:41 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6ED3E9AA39;
	Tue, 16 Feb 2010 14:20:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=/L9LvNNQ45L0HkARjeKTScGeEsg=; b=gCCO79kVz3B51adYqmZgLAE
	4HO6XhzsCkdwverRqr9cbHQ8fIT9qnkTWWN6+soggAAdeiA4/svQ8xj+OrUw/81o
	YNYzpzYCmDpl9H9SqMR0xTCL+VNmf8ND+7YzqphmazhAyC/AzG2xhLCmZriRQq5D
	2Acr6JufHm0F2wijHNSQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=lSilPCZZAiErwZriR1b1RUb+3GCn6lF1TXVwda8WIrwvjFckv
	3MF4p5H/jyiV3x0raINOVL8PL5dciVLiTthjwz62OsidfFA/XM7gCKJ2Aj3VC6WG
	I0owYOBmzS1WUYKMzmOILqXqlc2X2CkocuvBQxdtjtGY+72EKphcVKvVbg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2D4809AA38;
	Tue, 16 Feb 2010 14:20:34 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E1A6D9AA37; Tue, 16 Feb
 2010 14:20:28 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5AE15AE2-1B30-11DF-8B60-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140135>

Heiko Voigt <hvoigt@hvoigt.net> writes:

>> IOW, please try this patch.  I am planning to queue it to 'maint' as part
>> of 1.7.0.1 if this is the right solution (which I obviously think it is).
>
> Yes your patch does it correctly I just verified that the segfaults are
> gone as well. I think your solution is even nicer than mine. Thanks.

>> +#define read_sha1_lock() do { if (use_threads) pthread_mutex_lock(&read_sha1_mutex); } while (0)
>> +#define read_sha1_unlock() do { if (use_threads) pthread_mutex_unlock(&read_sha1_mutex); } while (0)
>
> One minor thing: Would it not be even nicer having the while loop inside
> the if clause? E.g like this
>
> #define read_sha1_lock() if (use_threads) do { pthread_mutex_lock(&read_sha1_mutex); } while (0)
> #define read_sha1_unlock() if (use_threads) do { pthread_mutex_unlock(&read_sha1_mutex); } while (0)

No.

	#define frotz() do { this compound stmt; } while (0)

is a common idiom to make a macro that expands to a compound stmt behave
as if it is a simple function call to avoid bugs when it is expanded,
regardless of in which context it is used by an unsuspecting caller.

Your rewrite is pointless because it is the same as saying

	#define read_sha1_lock() if (use_threads) p_m_l(&r_s_m)

and that is exactly what the idiom's use of "do { } while (0)"  is all
about.

Try this simple program.

-- >8 ---- >8 ---- >8 ---- >8 ---- >8 ---- >8 ---- >8 ---- >8 --
#include <stdio.h>

#define frotz() do { if (flag) printf("frotz"); } while (0)
#define xyzzy() if (flag) do { printf("xyzzy"); } while (0)
#define yomin() if (flag) printf("yomin")

void test(int foo, int bar, int baz, int flag)
{
        if (foo)
                frotz();
        else if (bar)
                xyzzy();
        else if (baz)
                yomin();
        else
                printf("huh?");

        printf("\n");
}

int main(int ac, char **av)
{
        int foo, bar, baz;
        for (foo = 0; foo < 2; foo++)
                for (bar = 0; bar < 2; bar++)
                        for (baz = 0; baz < 2; baz++) {
                                printf("%d %d %d ", foo, bar, baz);
                                test(foo, bar, baz, 1);
                        }
        return 0;
}
-- >8 ---- >8 ---- >8 ---- >8 ---- >8 ---- >8 ---- >8 ---- >8 --

Textually the "test" function expands to this:

        void test(int foo, int bar, int baz, int flag)
        {
         if (foo)
          do { if (flag) printf("frotz"); } while (0);
         else if (bar)
          if (flag) do { printf("xyzzy"); } while (0);
         else if (baz)
          if (flag) printf("yomin");
         else
          printf("huh?");

         printf("\n");
        }

but if you properly indent it, it looks like this:

        void test(int foo, int bar, int baz, int flag)
        {
                if (foo)
                        do {
                                if (flag)
                                        printf("frotz");
                        } while (0);
                else if (bar)
                        if (flag)
                                do {
                                        printf("xyzzy");
                                } while (0);
                        else if (baz)
                                if (flag)
                                        printf("yomin");
                                else
                                        printf("huh?");
                printf("\n");
        }

Notice how your version (xyzzy) broke the cascade of if..elseif..else.

Don't they teach this in schools anymore?
