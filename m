From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 37/38] refs: make lock generic
Date: Tue, 07 Jun 2016 10:50:44 -0700
Message-ID: <xmqqlh2griq3.fsf@gitster.mtv.corp.google.com>
References: <cover.1464983301.git.mhagger@alum.mit.edu>
	<d2a3cb56d7276c00174a08fe609d63e00755b205.1464983301.git.mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: David Turner <dturner@twopensource.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Jun 07 19:51:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAL9c-0007gS-0o
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jun 2016 19:51:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422748AbcFGRut (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2016 13:50:49 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56065 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1161476AbcFGRus (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2016 13:50:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id EFB0E21383;
	Tue,  7 Jun 2016 13:50:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7qj/Ei6V1oTLYLoAiTgFhTQnqO4=; b=AlZ19N
	TbuhHiRnHPD13reHIkVVMc86nwaKN2ruCLo8d92v0apvNb0RvUfLG0UwdACY3YSy
	5T5qaTcm5Xm8424S4p0EhV2kO3xZkADQA0FfP8hMV869BBwUHGXrqgo5G8OLMfNp
	gpxmSM3tOen7nq9nWp72AWl99a/HMHpejbrzA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZsOqXBUqS3wjBVGPzGlNottRCagCDAU8
	JtmGuxgBtsGMGTysybBC+XuBxHOrFyBXRQ11Mzyu9jwI1kj9D2mbZVfYraf5k3a1
	+78zq7hsBD58fNOo+l9V2toawAza11K0SFtMFBeycpugEfI6MaLlbt1bwJlG07E+
	973SDP3SXio=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E7CCA21382;
	Tue,  7 Jun 2016 13:50:46 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 70F3A21381;
	Tue,  7 Jun 2016 13:50:46 -0400 (EDT)
In-Reply-To: <d2a3cb56d7276c00174a08fe609d63e00755b205.1464983301.git.mhagger@alum.mit.edu>
	(Michael Haggerty's message of "Fri, 3 Jun 2016 23:04:12 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5CF2FE38-2CD8-11E6-9936-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296704>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> From: David Turner <dturner@twopensource.com>
>
> Instead of including a files-backend-specific struct ref_lock, change
> the generic ref_update struct to include a void pointer that backends
> can use for their own arbitrary data.

Hmph.

> @@ -3591,7 +3590,8 @@ static int lock_ref_for_update(struct files_ref_store *refs,
>  		for (parent_update = update->parent_update;
>  		     parent_update;
>  		     parent_update = parent_update->parent_update) {
> -			oidcpy(&parent_update->lock->old_oid, &lock->old_oid);
> +			struct ref_lock *parent_lock = parent_update->backend_data;
> +			oidcpy(&parent_lock->old_oid, &lock->old_oid);
>  		}
> ...
> @@ -3745,7 +3745,7 @@ static int files_transaction_commit(struct ref_store *ref_store,
>  	/* Perform updates first so live commits remain referenced */
>  	for (i = 0; i < transaction->nr; i++) {
>  		struct ref_update *update = updates[i];
> -		struct ref_lock *lock = update->lock;
> +		struct ref_lock *lock = update->backend_data;

OK, and files_* backend method downcasts it to what it wants, which
is good.
