From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 4/7] struct ref_lock: delete the force_write member
Date: Mon, 02 Mar 2015 13:44:42 -0800
Message-ID: <xmqqk2yz9ir9.fsf@gitster.dls.corp.google.com>
References: <1425288597-20547-1-git-send-email-mhagger@alum.mit.edu>
	<1425288597-20547-5-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Mar 02 22:44:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YSY8w-0008QG-9R
	for gcvg-git-2@plane.gmane.org; Mon, 02 Mar 2015 22:44:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755535AbbCBVoq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Mar 2015 16:44:46 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:55446 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753846AbbCBVop (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Mar 2015 16:44:45 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5FA283D714;
	Mon,  2 Mar 2015 16:44:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Y/bBzWtfoJBkgR4o0svFBo+G+VE=; b=vUePCD
	+bVshM1BUowr7byWoQSu6l7MWJbyM67EVMUduLxKnYWC0gJOWAldGQiN89WAqC4L
	i94L7ehSQq3+boaoD9sJx2Q9wxa/s39PLpPNs+TcoFmobhn2eIEiMHF9Ei4UpTVq
	8StL9cMAtq5mJOv06mQDjfXCSg9D5N3weMTTk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XB2TGMjYruZTrkyPE2dsweB1G9r/JIA8
	UhGX00tB3kMobtuGvYRnyY9XFKuhX5VGpHzBljnc7Ln64xetOAgrAmFvA8MCmBHz
	LYzA/u3KO96aoRojtPrgffqH5SoppqL7V4Q02ZlKbq1D/sO4c2vInH04ZRC4WFnY
	uen7dCyNkOw=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 55B5D3D713;
	Mon,  2 Mar 2015 16:44:44 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9579D3D710;
	Mon,  2 Mar 2015 16:44:43 -0500 (EST)
In-Reply-To: <1425288597-20547-5-git-send-email-mhagger@alum.mit.edu> (Michael
	Haggerty's message of "Mon, 2 Mar 2015 10:29:54 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 567E6ABC-C125-11E4-B757-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264626>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Instead, compute the value when it is needed.

> @@ -2318,8 +2317,6 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
>  	lock->ref_name = xstrdup(refname);
>  	lock->orig_ref_name = xstrdup(orig_refname);
>  	ref_file = git_path("%s", refname);
> -	if ((flags & REF_NODEREF) && (type & REF_ISSYMREF))
> -		lock->force_write = 1;
>  
>   retry:
>  	switch (safe_create_leading_directories(ref_file)) {
> @@ -3787,8 +3784,13 @@ int ref_transaction_commit(struct ref_transaction *transaction,
>  		struct ref_update *update = updates[i];
>  
>  		if (!is_null_sha1(update->new_sha1)) {
> -			if (!update->lock->force_write &&
> -			    !hashcmp(update->lock->old_sha1, update->new_sha1)) {
> +			if (!((update->type & REF_ISSYMREF)
> +			      && (update->flags & REF_NODEREF))
> +			    && !hashcmp(update->lock->old_sha1, update->new_sha1)) {
> +				/*
> +				 * The reference already has the desired
> +				 * value, so we don't need to write it.
> +				 */
>  				unlock_ref(update->lock);
>  				update->lock = NULL;
>  			} else if (write_ref_sha1(update->lock, update->new_sha1,

The code before and after the change are equivalent.

It shouldn't be the case, but somehow I find the original slightly
easier to understand.  The before and after says the same thing,
i.e. the code used to be:

 - We say "do the write-out without questioning" when we are
   updating a symbolic ref without dereferencing.

 - Do nothing and unlock if we are not told to "do the write-out
   without questioning" and the update will be a no-op anyway.

while the code after the change says:

 + Do nothing and unlock if we are not handling "update a symbolic
   ref without dereferencing" and the update will be a no-op anyway.

Perhaps the former has the same effect as "avoid a single complex
sentence and use two short sentences instead".

The negation in the condition does not help, either.

 * If we are updating a symbolic ref without dereferencing, or if we
   are updating with a different object name, we definitely have to
   write.

would be easier to understand, perhaps?  I.e.

	if (hashcmp(update->lock->old_sha1, update->lock->new_sha1) ||
	    ((update->type & REF_ISSYMREF) && (update->flags & REF_NO_DEREF))) {
		/* do the write-out thing */
	} else {
		/* the request to update from the same to the same is a no-op */
		unlock_ref(update->lock);
                update->lock = NULL;
	}

I dunno.
