From: Jim Meyering <jim@meyering.net>
Subject: Re: [PATCH] diff: avoid stack-buffer-read-overrun for very long name
Date: Thu, 26 Apr 2012 18:22:11 +0200
Message-ID: <874ns6xy30.fsf@rho.meyering.net>
References: <87ty0jbt5p.fsf@rho.meyering.net> <20120416222713.GA2396@moj>
	<87397t862o.fsf@rho.meyering.net>
	<xmqq1unbd2m5.fsf@junio.mtv.corp.google.com>
	<87d36uxzfw.fsf@rho.meyering.net>
	<xmqq62cma2uo.fsf@junio.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Marcus Karlsson <mk@acc.umu.se>, git list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 26 18:22:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SNRSb-0002VC-0Q
	for gcvg-git-2@plane.gmane.org; Thu, 26 Apr 2012 18:22:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758481Ab2DZQWU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Apr 2012 12:22:20 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:33791 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758416Ab2DZQWT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Apr 2012 12:22:19 -0400
Received: from mx.meyering.net (unknown [88.168.87.75])
	by smtp5-g21.free.fr (Postfix) with ESMTP id B2FA8D48103
	for <git@vger.kernel.org>; Thu, 26 Apr 2012 18:22:12 +0200 (CEST)
Received: from rho.meyering.net (localhost.localdomain [127.0.0.1])
	by rho.meyering.net (Acme Bit-Twister) with ESMTP id 16CE160055;
	Thu, 26 Apr 2012 18:22:11 +0200 (CEST)
In-Reply-To: <xmqq62cma2uo.fsf@junio.mtv.corp.google.com> (Junio C. Hamano's
	message of "Thu, 26 Apr 2012 09:13:03 -0700")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196379>

Junio C Hamano wrote:
> Jim Meyering <jim@meyering.net> writes:
>
>> What do you think about replacing those two append-if-needed two-liners:
>>
>>     if (buffer2.len && buffer2.buf[buffer2.len - 1] != '/')
>>             strbuf_addch(&buffer2, '/');
>>
>> by something that readably encapsulates the idiom:
>>
>>     strbuf_append_if_absent (&buffer2, '/');
>>
>> (though the name isn't particularly apt, because you might
>> take "absent" to mean "not anywhere in the string," so maybe
>>   strbuf_append_if_not_already_at_end (ugly) or
>>   strbuf_append_uniq
>> )
>
> I am not good at names, but strbuf_terminate_with(&buffer2, '/')
> perhaps?

Maybe, but it still doesn't evoke the conditional nature
of don't-append-if-already-there the operation.  i.e., one
might wonder how it's different from "strbuf_append".

How about one of these?

  strbuf_ensure_suffix  // but might make you think suffix==more than 1 byte
  strbuf_ensure_last_byte    // maybe?
  strbuf_ensure_last_byte_is // rather long, but apt

>> There are several other uses that would benefit from such a transformation:
>> To find the easy ones, I ran this:
>>
>>   git grep -B1 "strbuf_addch.*'"|grep -A1 '!='
>>
>> I've manually marked/separated the ones that don't apply.
>>
>> Note how only 2 of the 6 candidates ensure that length is positive
>> before using ".len - 1":
>
> Yikes, that is embarrasing ;-)

Knowing you/git, each is because the buffer is known to be non-empty.
