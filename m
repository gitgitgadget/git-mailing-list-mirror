From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] refs: document transaction semantics
Date: Thu, 25 Feb 2016 12:34:54 -0800
Message-ID: <xmqqvb5cmsup.fsf@gitster.mtv.corp.google.com>
References: <CACsJy8DDVbz9LnX5HM_2HB+uDvqzS7LU=12gxhxJFqYPHp0Tvg@mail.gmail.com>
	<1456430746-5565-1-git-send-email-dturner@twopensource.com>
	<1456431013.18017.50.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, pclouds@gmail.com
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Thu Feb 25 21:35:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZ2cs-0000En-JF
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 21:35:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750936AbcBYUfA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 15:35:00 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:65100 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750859AbcBYUfA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 15:35:00 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 405C347B46;
	Thu, 25 Feb 2016 15:34:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xo1PqakWw4I1ielQ/yPLsJbQdKQ=; b=Hbb6Wd
	t9kapuvbrjWZnSgbMt9lNRCNnNfxxypp67I9y0WKpcye0h8SBJDXjq1P2wU58auE
	+qxdxcqyMkTtNXZJpkVLrd5d3BLb72dH4CTyuOjzTO/UbBrKJxL+xoIxdpv4EYua
	aGTmAXQko1SCpIjrkv1CCcPb/6JRjSYb3ekVI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UR68q2BbvuAYSEaVjppWF9BUDn94k1LU
	DFuHV+WXqyEzAySs+XL3MwNLa+K3jSWDJmkrG8PtpNnWoIbE1AdrQqDxIz/5vOgp
	GCTvnIAEMIZeQEbpGsMQJuahBtV46oAksEvt3LvQH9YcteaHLY8DJhoqZr6MdL07
	Ehg5s3klSdQ=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 28BDE47B45;
	Thu, 25 Feb 2016 15:34:57 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 631F547B44;
	Thu, 25 Feb 2016 15:34:56 -0500 (EST)
In-Reply-To: <1456431013.18017.50.camel@twopensource.com> (David Turner's
	message of "Thu, 25 Feb 2016 15:10:13 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 3B63CACE-DBFF-11E5-9049-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287436>

David Turner <dturner@twopensource.com> writes:

> I thought it would be better in the api docs, since it's a design
> decision that all backends should follow.

Makes sense; as this describes an already available API, it
shouldn't have to wait for the remainder of your series and can just
go to 'master' (or even to 'maint' if we wanted to), right?



> On Thu, 2016-02-25 at 15:05 -0500, David Turner wrote:
>> Add some comments on ref transaction semantics to refs.h
>> 
>> Signed-off-by: David Turner <dturner@twopensource.com>
>> ---
>>  refs.h | 12 ++++++++++++
>>  1 file changed, 12 insertions(+)
>> 
>> diff --git a/refs.h b/refs.h
>> index c0964f5..9b3eaf3 100644
>> --- a/refs.h
>> +++ b/refs.h
>> @@ -112,6 +112,11 @@ extern int dwim_log(const char *str, int len,
>> unsigned char *sha1, char **ref);
>>   *   If this succeeds, the ref updates will have taken place and
>>   *   the transaction cannot be rolled back.
>>   *
>> + * - Instead of `ref_transaction_commit`, use
>> + *   `initial_ref_transaction_commit()` if the ref database is known
>> + *   to be empty (e.g. during clone).  This is likely to be much
>> + *   faster.
>> + *
>>   * - At any time call `ref_transaction_free()` to discard the
>>   *   transaction and free associated resources.  In particular,
>>   *   this rolls back the transaction if it has not been
>> @@ -127,6 +132,13 @@ extern int dwim_log(const char *str, int len,
>> unsigned char *sha1, char **ref);
>>   *
>>   * The message is appended to err without first clearing err.
>>   * err will not be '\n' terminated.
>> + *
>> + * Caveats
>> + * -------
>> + *
>> + * Note that no locks are taken, and no refs are read, until
>> + * `ref_transaction_commit` is called.  So `ref_transaction_verify`
>> + * won't report a verification failure until the commit is
>> attempted.
>>   */
>>  struct ref_transaction;
>>  
