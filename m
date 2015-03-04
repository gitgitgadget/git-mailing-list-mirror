From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Use unsigned char to squash compiler warnings
Date: Wed, 04 Mar 2015 14:11:14 -0800
Message-ID: <xmqqd24o76rh.fsf@gitster.dls.corp.google.com>
References: <1425324151-5480-1-git-send-email-bdwalton@gmail.com>
	<xmqqoaob9m82.fsf@gitster.dls.corp.google.com>
	<CAP30j1684A=QsA0o+zLMP70V09mFTS_MtiPZB2TrRywYK2NWWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Ben Walton <bdwalton@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 04 23:11:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTHVh-0006Td-T0
	for gcvg-git-2@plane.gmane.org; Wed, 04 Mar 2015 23:11:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753127AbbCDWLR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Mar 2015 17:11:17 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:55716 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752963AbbCDWLR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Mar 2015 17:11:17 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 48C933D1C3;
	Wed,  4 Mar 2015 17:11:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SPAUVVU/AHWS2/Ns8/JYTioz8mo=; b=Yr9wRm
	0jG5H453GZQGqxHPpcK/DhkEBcR7l93DAycQ+alDoXyc4wiuVd3q/TKfWkgOuzWV
	WTRVS8k9uEK0bwEGzlgkkMya/iWXI2pK5EbDuusHV0rBasQ8BVO+SuTxxUBjtREK
	6Gl0yiGwS9Ms93wF1LtXGgoMXuJdspFkYzZEQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=n7webTBN+LnsqmHKeYHa/SeaESsr9LIB
	U//yTJADB3tSKJrCdwVg3E/8wZdjzvUY07f5H0oyQPgeHktQA79x+0NBTV0RPXos
	5ds0aKU85MqpcpFsk2og8SalE6BzUMRFfPLbWCOzH0BCVJXmMwwCHxoAb9UTRCRc
	SNctoLr4k7U=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 403C53D1C2;
	Wed,  4 Mar 2015 17:11:16 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7CFE13D1C1;
	Wed,  4 Mar 2015 17:11:15 -0500 (EST)
In-Reply-To: <CAP30j1684A=QsA0o+zLMP70V09mFTS_MtiPZB2TrRywYK2NWWw@mail.gmail.com>
	(Ben Walton's message of "Wed, 04 Mar 2015 21:09:01 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 601EC458-C2BB-11E4-817F-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264791>

Ben Walton <bdwalton@gmail.com> writes:

> On Mon, Mar 2, 2015 at 8:30 PM Junio C Hamano <gitster@pobox.com> wrote:
>
>> The conversion looked good from a cursory view; I didn't check it
>> very carefully though.
>>
> Yes, because of the Solaris ABI, the Studio compiler defaults char to
> signed char.

Doesn't our beloved GCC also uses signed char when you write char?
You keep saying that "defaults to signed char is the problem", but
that does not explain why those in the rest of the world outside the
Solaris land do not encounter this problem.

	$ cat >x.c <<\EOF
        #include <stdio.h>
        int main (void) {
                SIGNED char ch = 0xff;
                printf("%d\n", ch);
                return 0;
        }
	EOF
        $ gcc -Wall -DSIGNED= x.c && ./a.out
        -1
        $ gcc -Wall -DSIGNED=signed x.c && ./a.out
	-1

I think th problem is not Solaris uses signed char for char like
everybody else does ;-) but it gives a fairly useless warning to
annoy people.

In any case, here is what I queued, FYI, on bw/kwset-use-unsigned
topic.

Thanks.

commit 189c860c9ec5deb95845c056ca5c15b58970158e
Author: Ben Walton <bdwalton@gmail.com>
Date:   Mon Mar 2 19:22:31 2015 +0000

    kwset: use unsigned char to store values with high-bit set
    
    Sun Studio on Solaris issues warnings about improper initialization
    values being used when defining tolower_trans_tbl[] in ctype.c.  The
    array wants to store values with high-bit set and treat them as
    values between 128 to 255.  Unlike the rest of the Git codebase
    where we explicitly specify 'unsigned char' for such variables and
    arrays, however, kwset code we borrowed from elsewhere uses 'char'
    for this and other variables.
    
    Fix the declarations to explicitly use 'unsigned char' where
    necessary to bring it in line with the rest of the Git.
    
    Signed-off-by: Ben Walton <bdwalton@gmail.com>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>
