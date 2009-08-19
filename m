From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] graph API: fix bug in graph_is_interesting()
Date: Tue, 18 Aug 2009 23:25:49 -0700
Message-ID: <7v4os41frm.fsf@alter.siamese.dyndns.org>
References: <1250628954.114121983@192.168.1.201>
 <20090818211812.GL8147@facebook.com>
 <7vk5103chi.fsf@alter.siamese.dyndns.org>
 <20090819022918.GO8147@facebook.com> <20090819023433.GP8147@facebook.com>
 <7vhbw41g3f.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Santi =?utf-8?Q?B=C3=A9jar?= <santi@agolina.net>,
	Git Mailing List <git@vger.kernel.org>
To: Adam Simpkins <simpkins@facebook.com>
X-From: git-owner@vger.kernel.org Wed Aug 19 08:26:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mdech-0004SI-El
	for gcvg-git-2@lo.gmane.org; Wed, 19 Aug 2009 08:26:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751198AbZHSGZ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Aug 2009 02:25:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751159AbZHSGZ6
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Aug 2009 02:25:58 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:33569 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751109AbZHSGZ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Aug 2009 02:25:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6951910057;
	Wed, 19 Aug 2009 02:25:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Wh05jTXxmhaEBiJqXgMMB1tno2w=; b=sJHQHP
	DiIH5i+1CIZlPFlPq4BdkCWMk+BsClD9TKzTmu6Tp7AmErEY7+2HHr3LwSjyCwze
	F2uM2EA6UPuPTRgGdB0KLmxt69ju3rFEFABh8quADfIrU9PQ97BpXZ5EgaxakgzI
	eweLbe5MnRroQdrwvUx0w+udzx2sZTS6SlHHA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=psvG227YOrJyzNPbB0eChjiXyzShn8fv
	T36+Q/E4fpW+AhEFximUKjejl2ewAv/9nMEN1E/fLT9EAONhlG1h2goCvPlvqlaw
	mkLnWw0/oO2+tycnE1sGUgVDy1g7XVL2T/De5O4XC3XAr2gvVOI4IVE5elr/e/H2
	YCDqSZ7IJcg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3767A10056;
	Wed, 19 Aug 2009 02:25:55 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5078410051; Wed, 19 Aug
 2009 02:25:51 -0400 (EDT)
In-Reply-To: <7vhbw41g3f.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue\, 18 Aug 2009 23\:18\:44 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 267EB96A-8C89-11DE-B828-0D381FFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126507>

Junio C Hamano <gitster@pobox.com> writes:

> Adam Simpkins <simpkins@facebook.com> writes:
>
>> -enum commit_action simplify_commit(struct rev_info *revs, struct commit *commit)
>> +enum commit_action get_commit_action(struct rev_info *revs, struct commit *commit)
>>  {
>>  	if (commit->object.flags & SHOWN)
>>  		return commit_ignore;
>> @@ -1692,12 +1692,21 @@ enum commit_action simplify_commit(struct rev_info *revs, struct commit *commit)
>>  			if (!commit->parents || !commit->parents->next)
>>  				return commit_ignore;
>>  		}
>> -		if (want_ancestry(revs) && rewrite_parents(revs, commit) < 0)
>> -			return commit_error;
>>  	}
>>  	return commit_show;
>>  }
>>  
>> +enum commit_action simplify_commit(struct rev_info *revs, struct commit *commit)
>> +{
>> +	enum commit_action action = get_commit_action(revs, commit);
>> +
>> +	if (action == commit_show && revs->prune && revs->dense && want_ancestry(revs)) {
>> +		if (rewrite_parents(revs, commit) < 0)
>> +			return commit_error;
>> +	}
>> +	return action;
>> +}
>
> When simplify_commit() logic (now called get_comit_action()) decides to
> show this commit because revs->show_all was specified, we did not rewrite
> its parents, but now we will?

That is, here is what I meant...

 revision.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/revision.c b/revision.c
index 15a2010..efa3b7c 100644
--- a/revision.c
+++ b/revision.c
@@ -1700,7 +1700,9 @@ enum commit_action simplify_commit(struct rev_info *revs, struct commit *commit)
 {
 	enum commit_action action = get_commit_action(revs, commit);
 
-	if (action == commit_show && revs->prune && revs->dense && want_ancestry(revs)) {
+	if (action == commit_show &&
+	    !revs->show_all &&
+	    revs->prune && revs->dense && want_ancestry(revs)) {
 		if (rewrite_parents(revs, commit) < 0)
 			return commit_error;
 	}

We may want to add some tests to demonstrate the breakage this fix
addresses.
