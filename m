From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 24/34] mailinfo: move content/content_top to struct mailinfo
Date: Wed, 21 Oct 2015 14:04:49 -0700
Message-ID: <xmqqzizcszke.fsf@gitster.mtv.corp.google.com>
References: <1444855557-2127-1-git-send-email-gitster@pobox.com>
	<1445239731-10677-1-git-send-email-gitster@pobox.com>
	<1445239731-10677-25-git-send-email-gitster@pobox.com>
	<CAGZ79kbRLVaNNR=ZuMZNtJD2vorV5K1-wZ+R9CY5FY_zS3i95Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Oct 21 23:05:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zp0ZW-000815-Sx
	for gcvg-git-2@plane.gmane.org; Wed, 21 Oct 2015 23:05:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752468AbbJUVFP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Oct 2015 17:05:15 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:60282 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754197AbbJUVEv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Oct 2015 17:04:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2358525594;
	Wed, 21 Oct 2015 17:04:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7XeLoxCEm4asBSaampgpxJ+zpSk=; b=uk5JhG
	vIV8fhk04KyX2cmH7IRosmfycgvsc+1ycndBeQ8nAew11uzx3O8NEN33pagrOzMv
	UVBE4sqeE9d5caJLvaayKz2ySkXEDpx9fIQo/XvAjZJW3cuCqdWvgTkYcUgnDNNN
	D/escigANJDi71atnaRTNZupbNzh5JoYQsQlk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jT6Eq5zb2mxpAc2/pNAHBaZ/9mOIGqXA
	XM74L5c2qcPdn1iXlp+SZfLw7KGipNTAVjKNJnMIEzj43WNKdIDe+EmRe7YK47xU
	SXGSLjH1OeOBGBCHfu6iB2Zy1MVKPjsGLte9rBWT51zCEKNd4Al30BPxCq0qyU1E
	cFfA6JyjO4k=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1B85825593;
	Wed, 21 Oct 2015 17:04:51 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 932CD25592;
	Wed, 21 Oct 2015 17:04:50 -0400 (EDT)
In-Reply-To: <CAGZ79kbRLVaNNR=ZuMZNtJD2vorV5K1-wZ+R9CY5FY_zS3i95Q@mail.gmail.com>
	(Stefan Beller's message of "Wed, 21 Oct 2015 13:36:01 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5E5A25C2-7837-11E5-874E-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280020>

Stefan Beller <sbeller@google.com> writes:

> On Mon, Oct 19, 2015 at 12:28 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>> ---
>>  builtin/mailinfo.c | 45 ++++++++++++++++++++++++++-------------------
>>  1 file changed, 26 insertions(+), 19 deletions(-)
>>
>> diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
>> index 2c194da..ec65805 100644
>> --- a/builtin/mailinfo.c
>> +++ b/builtin/mailinfo.c
>> @@ -7,6 +7,8 @@
>>  #include "utf8.h"
>>  #include "strbuf.h"
>>
>> +#define MAX_BOUNDARIES 5
>> +
>>  struct mailinfo {
>>         FILE *input;
>>         FILE *output;
>> @@ -22,6 +24,8 @@ struct mailinfo {
>>         int use_inbody_headers; /* defaults to 1 */
>>         const char *metainfo_charset;
>>
>> +       struct strbuf *content[MAX_BOUNDARIES];
>> +       struct strbuf **content_top;
>>         struct strbuf charset;
>>         char *message_id;
>>         enum  {
>> @@ -35,7 +39,6 @@ struct mailinfo {
>>  };
>>
>>  #define MAX_HDR_PARSED 10
>> -#define MAX_BOUNDARIES 5
>
> Would it make sense to also move MAX_HDR_PARSED, such that we have all
> defines in one place?

Looking at their final resting place, I do not think so.
