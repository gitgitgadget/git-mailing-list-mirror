From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 09/16] index-helper: use watchman to avoid refreshing index with lstat()
Date: Thu, 07 Apr 2016 23:03:26 -0700
Message-ID: <xmqq8u0oy6vl.fsf@gitster.mtv.corp.google.com>
References: <1459980722-4836-1-git-send-email-dturner@twopensource.com>
	<1459980722-4836-10-git-send-email-dturner@twopensource.com>
	<xmqqh9fdxcht.fsf@gitster.mtv.corp.google.com>
	<xmqqd1q1xc8r.fsf@gitster.mtv.corp.google.com>
	<1460074483.5540.9.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, pclouds@gmail.com, aevarb@gmail.com,
	jeffhost@microsoft.com
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri Apr 08 08:04:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoPWZ-0000Gf-CQ
	for gcvg-git-2@plane.gmane.org; Fri, 08 Apr 2016 08:04:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757544AbcDHGDb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Apr 2016 02:03:31 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:58749 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757451AbcDHGDa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Apr 2016 02:03:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A8BB948499;
	Fri,  8 Apr 2016 02:03:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zzScIRiVd3gULGnnpU7I7dcyW8w=; b=toKOMw
	fLG3hyCk4/21gmlfcwI9246lNknEsVHlL3WzCnLQ55/1vtvN3Obmyk06l94afLEi
	MF+nvhGaXEZ3+peXwKD5Q2lnsi/PPObBHle3fvqGxmRPuwwxRgWYn9XtF8IezDkq
	kjfaT/pDf6qYVGgEkfHY5NJ5CW97qzSp8ITQ4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=irLl21tdq/B6Ez7irGkUgV5mXA0pRUEe
	iEEJHX4yIIGr1OX3cgZ61DP/cvyx2Q6/f2RoMW+ntB4au616TZ9KvRkDFnoa3rkn
	v78jDJ17Jspr9sg3yz/aTGEfI25Me5uiZblxTH9Jvyd6jJKMGKeYbLoVsPFDR2Ev
	7RV5WPluIvM=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9164348498;
	Fri,  8 Apr 2016 02:03:28 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 15AC248497;
	Fri,  8 Apr 2016 02:03:28 -0400 (EDT)
In-Reply-To: <1460074483.5540.9.camel@twopensource.com> (David Turner's
	message of "Thu, 07 Apr 2016 20:14:43 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 9CE36D10-FD4F-11E5-984F-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290997>

David Turner <dturner@twopensource.com> writes:

> On Thu, 2016-04-07 at 15:52 -0700, Junio C Hamano wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>> 
>> > > +		untracked = data + len + 8 + bitmap_size;
>> > 
>> > This breaks compilation as data here is of type (void *).
>> > 
>> > There may be similar breakages in this patch.
>> 
>> It turns out that this is the only one, and
>> 
>> 	untracked = (char *)data + len + 8 + bitmap_size;
>> 
>> is a sufficient fix (I've squashed it in to my copy).
>> 
>> Thanks.
>
> Thanks.  I've squashed it into mine as well but with const char *
> instead (seems maybe cleaner to me)

Yeah, I agree, as "data" is "const void *", so even though the left
hand side of the assignment, "untracked", is "const char *", my cast
is (temporarily) casting the const away--it would be better to use
"const char *" there.

Thanks.
