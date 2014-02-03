From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/8] fixup! combine_diff: simplify intersect_paths() further
Date: Mon, 03 Feb 2014 11:40:18 -0800
Message-ID: <xmqqy51sdly5.fsf@gitster.dls.corp.google.com>
References: <cover.1391430523.git.kirr@mns.spb.ru>
	<60ec61bdd2ef3cba7537e29c42f9c8a810da245d.1391430523.git.kirr@mns.spb.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Kirill Smelkov <kirr@mns.spb.ru>
X-From: git-owner@vger.kernel.org Mon Feb 03 20:40:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WAPNi-0004ET-9C
	for gcvg-git-2@plane.gmane.org; Mon, 03 Feb 2014 20:40:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753310AbaBCTkZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Feb 2014 14:40:25 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60670 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752975AbaBCTkX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Feb 2014 14:40:23 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4EFF169EEA;
	Mon,  3 Feb 2014 14:40:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jMHyTn2gc/25NyumUHStsqK09uY=; b=fT+i5U
	xX8lOZizNEZidTVDAfKkoEu1D6CHKPaer/eIr4tQh6lmKVS7bMSsnNwD4MuMMtg1
	YZaLDW8T26zpP3Il5lSDedUgwT0xIyHv0vdnOnd4RHogtiXgyPJAtr0sYWl5UmF2
	U+UIxGSbBD9xsEtL4Hcg1KLxHa3yHG3RhpuW0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=J386CLsmpm7xELfnzs4oFmjN9I5/twgh
	XsEIAZ2gdndV6BgYG5oeHbDZiEDoLeLxUST6SgX39Lql2rR52+VKN2fElTGU6fpE
	sLgFIsjeWiWIR36upODS2wgDkNQVo4A5xWtLtiBVxCmtd3pmPLKQXUFJpB4mRNzS
	dG1I7/emyqQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3954D69EE8;
	Mon,  3 Feb 2014 14:40:22 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7C4A369EDF;
	Mon,  3 Feb 2014 14:40:20 -0500 (EST)
In-Reply-To: <60ec61bdd2ef3cba7537e29c42f9c8a810da245d.1391430523.git.kirr@mns.spb.ru>
	(Kirill Smelkov's message of "Mon, 3 Feb 2014 16:47:15 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 0428C202-8D0B-11E3-BF8C-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241454>

Kirill Smelkov <kirr@mns.spb.ru> writes:

> That cleanup patch is good, but I've found a bug in it. In the item removal
> code
>
>> +                      /* p->path not in q->queue[]; drop it */
>> +                      struct combine_diff_path *next = p->next;
>> +
>> +                      if ((*tail = next) != NULL)
>> +                              tail = &next->next;
>> +                      free(p);
>>                        continue;
>
>         *tail = next
>
> is right, but
>
>         tail = &next->next
>
> is wrong,

Heh, surely.  We just have skipped, and the fact that tail points at
the pointer variable that points at the first of the remaining items
does not change with this skipping of next by assigning it to *tail.  
An extra assignment to tail will skip one more, which is unnecessary.
