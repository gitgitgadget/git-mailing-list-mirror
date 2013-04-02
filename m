From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] merge: a random object may not necssarily be a
 commit
Date: Tue, 02 Apr 2013 08:02:13 -0700
Message-ID: <7vk3olgemi.fsf@alter.siamese.dyndns.org>
References: <7v7gl3jmx0.fsf_-_@alter.siamese.dyndns.org>
 <1364846239-8802-1-git-send-email-gitster@pobox.com>
 <1364846239-8802-2-git-send-email-gitster@pobox.com>
 <20130402053004.GC22089@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Yann Droneaud <ydroneaud@opteya.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 02 17:02:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UN2jV-0001YX-1z
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 17:02:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932288Ab3DBPCQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 11:02:16 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38173 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932131Ab3DBPCP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 11:02:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4DBB5110FC;
	Tue,  2 Apr 2013 15:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SvOrjBXhJopcMVDfjKTFlLzZDQs=; b=F14vPp
	jNmlTEwi3ZXE4zTfd4q2MFexXZ1PGPeypyZaNlGziNV5NQiupwSyyNDPTIF7Ncby
	QHxaWf5qeh9kgn3F74o5s7LUIqh4C4k89sXxhjfS2/BAwxeyGloyx20sWf218BHD
	p6vI08uv8BVZR+6m8xUVTYqhGiWJIXZyqvn18=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fVS2CJB7xgxN8VHGownA3AePdytEPW0H
	Ex9IRl/n9VnRdnBT4aTkTU3A1mtznT6c2V89UenXM++E0AYOvVl2VLUhyK3SFSO/
	NPfg1OO9GVN7SVEWgu9AsjGjhOCEh0bIyJ+mjuHCivRIm1g5PZ2tSJZPf6ea9qGR
	pxasxp0IIJI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 43A4D110FB;
	Tue,  2 Apr 2013 15:02:15 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A12A8110FA; Tue,  2 Apr
 2013 15:02:14 +0000 (UTC)
In-Reply-To: <20130402053004.GC22089@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 2 Apr 2013 01:30:04 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4DCD3250-9BA6-11E2-A239-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219780>

Jeff King <peff@peff.net> writes:

> On Mon, Apr 01, 2013 at 12:57:17PM -0700, Junio C Hamano wrote:
>
>> The user could have said "git merge $(git rev-parse v1.0.0)"; we
>> shouldn't mark it as "Merge commit '15999998fb...'" as the merge
>> name, even though such an invocation might be crazy.
>> 
>> We could even read the "tag " header from the tag object and replace
>> the object name the user gave us, but let's not lose the information
>> by doing so, at least not yet.
>> 
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>> ---
>>  builtin/merge.c | 13 +++++++++++++
>>  1 file changed, 13 insertions(+)
>> 
>> diff --git a/builtin/merge.c b/builtin/merge.c
>> index 0ec8f0d..990e90c 100644
>> --- a/builtin/merge.c
>> +++ b/builtin/merge.c
>> @@ -516,6 +516,19 @@ static void merge_name(const char *remote, struct strbuf *msg)
>>  		strbuf_release(&line);
>>  		goto cleanup;
>>  	}
>> +
>> +	if (remote_head->util) {
>> +		struct merge_remote_desc *desc;
>> +		desc = merge_remote_util(remote_head);
>> +		if (desc && desc->obj && desc->obj->type == OBJ_TAG) {
>> +			strbuf_addf(msg, "%s\t\t%s '%s'\n",
>> +				    sha1_to_hex(desc->obj->sha1),
>> +				    typename(desc->obj->type),
>> +				    remote);
>> +			goto cleanup;
>> +		}
>> +	}
>> +
>>  	strbuf_addf(msg, "%s\t\tcommit '%s'\n",
>>  		sha1_to_hex(remote_head->object.sha1), remote);
>
> I guess there is no other object type besides OBJ_TAG and OBJ_COMMIT
> that would yield something we could merge, but it feels weird that you
> check only for OBJ_TAG here, and otherwise still say "commit". Would the
> intent be more clear if it just said:
>
>   if (desc && desc->obj && desc->obj->type != OBJ_COMMIT) {
>           ...
>
> ?

I suspect not.

The point of the added code is that it knows we want to special case
merging a tag object, and it wants to keep any other case behaving
the same as before.
