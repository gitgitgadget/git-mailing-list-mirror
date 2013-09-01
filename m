From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/8] refs: factor update_ref steps into helpers
Date: Sat, 31 Aug 2013 23:08:27 -0700
Message-ID: <xmqqvc2lul9g.fsf@gitster.dls.corp.google.com>
References: <cover.1377784597.git.brad.king@kitware.com>
	<cover.1377885441.git.brad.king@kitware.com>
	<d327c12d90c0c2500e51fb07c06f516f94438ff0.1377885441.git.brad.king@kitware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Brad King <brad.king@kitware.com>
X-From: git-owner@vger.kernel.org Sun Sep 01 08:08:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VG0py-0003S2-Uh
	for gcvg-git-2@plane.gmane.org; Sun, 01 Sep 2013 08:08:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753199Ab3IAGId (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Sep 2013 02:08:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38176 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751772Ab3IAGIc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Sep 2013 02:08:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E53F1390CE;
	Sun,  1 Sep 2013 06:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=GqU9YwEeN4Ta4iIDDXAQxou1k/k=; b=MmnmHsqdmDpZ0MOB8Aqn
	vQog+GgCVabKPXkpN6zIj17AAPGb0jtcbmpG1Ex31/mvLei7Lmbf1zY+SwWt5OI3
	K00fhpTRVG0MamS1jgQ1GbrJBEcWZZbusG9ho5k2N8XUl7SaBgR46nzYnvgZUjuR
	Fkd0VrMKkjQB10pOsU0ITHU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=IGE8ZZjYRCqVu/VC8zYrr6aRQ1IH6If6mBY/Ja6MJAhyp1
	lEnmfiGFdBg4nNe2JcFxnp9RI+pTEqoZD9ywlUY3dKoH1WNIwa6xloCQ0seA5qu0
	LzcDXN1OsDfx3qS3VYtr8vnVHUsIHU7mjs/UNO58gHRetbORWWghiO3brkPMk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D8223390CD;
	Sun,  1 Sep 2013 06:08:29 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 31E1E390CC;
	Sun,  1 Sep 2013 06:08:29 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: EBEE3892-12CC-11E3-B926-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233565>

Brad King <brad.king@kitware.com> writes:

> Factor the lock and write steps and error handling into helper functions
> update_ref_lock and update_ref_write to allow later use elsewhere.
> Expose lock_any_ref_for_update's type_p to update_ref_lock callers.
>
> Signed-off-by: Brad King <brad.king@kitware.com>
> ---
>  refs.c |   28 +++++++++++++++++++++++-----
>  1 file changed, 23 insertions(+), 5 deletions(-)
>
> diff --git a/refs.c b/refs.c
> index c69fd68..2e755b4 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -3170,12 +3170,13 @@ int for_each_reflog(each_ref_fn fn, void *cb_data)
>  	return retval;
>  }
>  
> -int update_ref(const char *action, const char *refname,
> -		const unsigned char *sha1, const unsigned char *oldval,
> -		int flags, enum action_on_err onerr)
> +static struct ref_lock *update_ref_lock(const char *refname,
> +					const unsigned char *oldval,
> +					int flags, int *type_p,
> +					enum action_on_err onerr)
>  {
>  	static struct ref_lock *lock;

Not the fault of this patch, as the original update_ref() had it
this way, but it is not necessary to keep the value of this variable
across invocations.  Let's drop "static" from here, and also the
corresponding variable in the new update_ref().

Will locally tweak while queuing.

> -	lock = lock_any_ref_for_update(refname, oldval, flags, NULL);
> +	lock = lock_any_ref_for_update(refname, oldval, flags, type_p);
>  	if (!lock) {
>  		const char *str = "Cannot lock the ref '%s'.";
>  		switch (onerr) {
> @@ -3183,8 +3184,14 @@ int update_ref(const char *action, const char *refname,
>  		case DIE_ON_ERR: die(str, refname); break;
>  		case QUIET_ON_ERR: break;
>  		}
> -		return 1;
>  	}
> +	return lock;
> +}
> +
> +static int update_ref_write(const char *action, const char *refname,
> +			    const unsigned char *sha1, struct ref_lock *lock,
> +			    enum action_on_err onerr)
> +{
>  	if (write_ref_sha1(lock, sha1, action) < 0) {
>  		const char *str = "Cannot update the ref '%s'.";
>  		switch (onerr) {
> @@ -3197,6 +3204,17 @@ int update_ref(const char *action, const char *refname,
>  	return 0;
>  }
>  
> +int update_ref(const char *action, const char *refname,
> +	       const unsigned char *sha1, const unsigned char *oldval,
> +	       int flags, enum action_on_err onerr)
> +{
> +	static struct ref_lock *lock;
> +	lock = update_ref_lock(refname, oldval, flags, 0, onerr);
> +	if (!lock)
> +		return 1;
> +	return update_ref_write(action, refname, sha1, lock, onerr);
> +}
> +
>  struct ref *find_ref_by_name(const struct ref *list, const char *name)
>  {
>  	for ( ; list; list = list->next)
