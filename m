From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 05/38] refs: create a base class "ref_store" for files_ref_store
Date: Tue, 07 Jun 2016 10:03:46 -0700
Message-ID: <xmqqbn3drkwd.fsf@gitster.mtv.corp.google.com>
References: <cover.1464983301.git.mhagger@alum.mit.edu>
	<8ee7d7359f6763cba29dc788aba2f236204bb76e.1464983301.git.mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: David Turner <dturner@twopensource.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Jun 07 19:03:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAKPz-0000Ib-KA
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jun 2016 19:03:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750961AbcFGRDv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2016 13:03:51 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58291 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750723AbcFGRDu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2016 13:03:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id EEB3420AF0;
	Tue,  7 Jun 2016 13:03:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WxTejIPKTNxgLG65QcplLfmvTeg=; b=reIlRa
	9XL4RxWr3VQLGDDdy2pnxhL9xZH7W5qqlE74DpErbrvAVekU7iPDsxR8qy0Mvxui
	7U9alls0kNbHQn2Q4KPYucXfzdunBCufDLwAzyPzJ2R1TIJtNtKMOy6sTAOxn7Ej
	RQ5IBROy4hDeYMfcNO3T63MqCVPMsmpliQHdE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CnXLfbO5gQW/eZhpQMQRDm5Jtxf/0099
	4/lZuZHKcMczIOJpWlWUCTEm5lMBchRZwHnRxkh9uQJmtsO6D4soX5+edbnmLbSo
	OmUdcioZTbEtAqVr6gmpbK4iORAgz9UpcF4jmK2Y4lx8ux73JJW1iFGzbOdAlFA1
	jWaklwzjvIY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E663420AEF;
	Tue,  7 Jun 2016 13:03:48 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6C97720AEE;
	Tue,  7 Jun 2016 13:03:48 -0400 (EDT)
In-Reply-To: <8ee7d7359f6763cba29dc788aba2f236204bb76e.1464983301.git.mhagger@alum.mit.edu>
	(Michael Haggerty's message of "Fri, 3 Jun 2016 23:03:40 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: CD47CD0A-2CD1-11E6-B02C-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296698>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> We want ref_stores to be polymorphic, so invent a base class of which
> files_ref_store is a derived class. For now there is a one-to-one
> relationship between ref_stores and submodules.

The mention of "submodules" made me go "Huh?" but thinking about it
for a second it is clear and obvious.  We often peek into refs in a
different repository that is a submodule, and we do not mix them with
our own refs.  Logically that is what a "ref store" is, and one-to-one
relationship is expected.

> @@ -1284,3 +1288,90 @@ const char *resolve_ref_unsafe(const char *refname, int resolve_flags,
>  	errno = ELOOP;
>  	return NULL;
>  }
> +
> +static struct ref_store *main_ref_store = NULL;
> +
> +static struct ref_store *submodule_ref_stores = NULL;

Let's let BSS take care of these initialization.

> +/*
> + * Downcast ref_store to files_ref_store. Die if ref_store is not a
> + * files_ref_store. If submodule_allowed is not true, then also die if
> + * files_ref_store is for a submodule (i.e., not for the main
> + * repository). caller is used in any necessary error messages.
> + */
> +static struct files_ref_store *files_downcast(
> +		struct ref_store *ref_store, int submodule_allowed,
> +		const char *caller)
>  {
>  	struct files_ref_store *refs;
>  
> +	if (ref_store->be != &refs_be_files)
> +		die("BUG: ref_store is type \"%s\" not \"files\" in %s",
> +		    ref_store->be->name, caller);
>  
> +	refs = (struct files_ref_store *)ref_store;
> +
> +	if (!submodule_allowed)
> +		assert_main_repository(ref_store, caller);
> +
> +	return refs;
>  }
>
>  /*
> + * Return a pointer to the reference store for the specified
> + * submodule. For the main repository, use submodule==NULL; such a
> + * call cannot fail. For a submodule, the submodule must exist and be
> + * a nonbare repository, otherwise return NULL. Verify that the
> + * reference store is a files_ref_store, and cast it to that type
> + * before returning it.
>   */
> +static struct files_ref_store *get_files_ref_store(const char *submodule,
> +						   const char *caller)
>  {
> +	struct ref_store *refs = get_ref_store(submodule);
>  
> +	return refs ? files_downcast(refs, 1, caller) : NULL;
>  }

This comment may be barking up a wrong tree, but the support for
class inheritance makes me wonder if I can do something along this
line:

 * implement a filesystem based ref_store, that is very similar to
   what you have as files_ref_store, but 

   - when storing a ref as a loose ref, or when checking if a ref
     exists as a loose ref, quote them somehow (e.g. a branch
     "Branch" is not stored as a file "$GIT_DIR/refs/heads/branch"
     but by using "^" as a single shift marker, i.e. as
     "$GIT_DIR/refs/heads/^branch");

   - when enumerating what refs we have as loose refs, unquote what
     readdir(3) gave us, e.g. seeing "$GIT_DIR/refs/heads/^branch",
     I say "there is a branch whose name is 'Branch'".

 * as locking and other 'methods' are likely to be very similar to
   your files_ref_store, make this new backend as a subclass of it,
   i.e. create a new class but function pointers to many methods are
   copied from files ref_store vtable.

Would the strict "when downcasting to 'files', we make sure vtable
is that of 'files' backend" interfere with such an approach?
