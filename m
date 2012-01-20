From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t/Makefile: Use $(sort ...) explicitly where needed
Date: Thu, 19 Jan 2012 23:14:18 -0800
Message-ID: <7vbopyhmlx.fsf@alter.siamese.dyndns.org>
References: <1327004244-18892-1-git-send-email-kirr@navytux.spb.ru>
 <7v8vl3ic6o.fsf@alter.siamese.dyndns.org>
 <20120120063450.GA15371@mini.zxlink>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Kirill Smelkov <kirr@navytux.spb.ru>
X-From: git-owner@vger.kernel.org Fri Jan 20 08:14:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ro8g5-0007DK-Hr
	for gcvg-git-2@lo.gmane.org; Fri, 20 Jan 2012 08:14:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751295Ab2ATHOV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jan 2012 02:14:21 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47676 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750966Ab2ATHOU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jan 2012 02:14:20 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4E7B82727;
	Fri, 20 Jan 2012 02:14:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vdn31OK4+zPiVwfAWpq6RDbL/YI=; b=a8jB5X
	wlLqJZpOvlC/xegajk14IFSg1gFpmeOCKgFK0OumIoAtideqHhkUakbQ2mpt2Juq
	Q3WOOkXJCpAReI2fmcxS19wwNp+WIx82FPPIuDAkbVcPkrCHYthiGwBaVoxo8OPb
	5fbtLDC6KetMAS69l+cpXxp8IiLHTPf4RBCnI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FWvK4oR5nnfTctOxohp+BK29iBD+Z/cr
	ot8hiGJTm9wlef0pWsMUnubM6feiqbeznCNasld5saDvoicp9ykF4QEdkrAowv8M
	vWEx8KgzeG+M+/ELyaXAw/3yQ9o6YSIgdNoYfT1CG2jZM5RAbqv2qU8QzMzCNmm5
	3pvaWJry+t0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 457C62726;
	Fri, 20 Jan 2012 02:14:20 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 98D7B2725; Fri, 20 Jan 2012
 02:14:19 -0500 (EST)
In-Reply-To: <20120120063450.GA15371@mini.zxlink> (Kirill Smelkov's message
 of "Fri, 20 Jan 2012 10:34:50 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5ED8770E-4336-11E1-A70C-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188858>

Kirill Smelkov <kirr@navytux.spb.ru> writes:

>> I do not necessarily buy your "so we HAVE TO, OR ELSE".
>> 
>> Even though I can understand "We can sort the list of tests _if_ we do not
>> want them executed in seemingly random order when running 'make -j1'", I
>> tend to think that *if* is a big one.  Aren't these tests designed not to
>> depend on each other anyway?
>
> Yes, they don't depend on each other, but what's the point in not
> sorting them? I usually watch test progress visually, and if tests are
> sorted, even with make -j4 they go more or less incrementally by their t
> number.
>
> On my netbook, adding $(sort ...) adds approximately 0.008s to make
> startup, so imho there is no performance penalty to adding that sort.

Heh, who said anything about performance?

I was pointing out that your justification "we HAVE TO" was wrong.

If you are doing this for perceived prettyness and not as a fix for any
correctness issue, I want to see the patch honestly described as such;
that's all.

By the way, if I recall correctly, $(sort) in GNU make not just sorts but
as a nice side effect removes duplicates. So if we used a(n fictional)
construct in our Makefile like this:

    T = $(wildcard *.sh a.*)

that might produce duplicates (i.e. "a.sh" might appear twice), which
might leave us two identical pathnames in $T and cause us trouble.  Even
if we do not have such a use currently, rewriting $(wildcard) like your
patch does using $(sort $(wildcard ...)) may be a good way to future-proof
our Makefile, and if you justify your patch that way, it would be a
possible correctness hardening, not just cosmetics, and phrasing it with
"HAVE TO" may be justifiable.

Care to try if $(wildcard *.sh a.*) give you duplicated output with newer
GNU make? I am lazy but am a bit curious ;-)
