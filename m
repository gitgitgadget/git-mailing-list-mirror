From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] Teach rm to remove submodules unless they contain a
 git directory
Date: Tue, 11 Sep 2012 12:41:53 -0700
Message-ID: <7vhar4gxdq.fsf@alter.siamese.dyndns.org>
References: <7vpq5tjuw3.fsf@alter.siamese.dyndns.org>
 <504F8427.1020507@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	=?utf-8?B?TWljaGHFgiBHw7Nybnk=?= <mgorny@gentoo.org>,
	Phil Hord <phil.hord@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Sep 11 21:42:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBWLd-0005Kt-Tb
	for gcvg-git-2@plane.gmane.org; Tue, 11 Sep 2012 21:42:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760041Ab2IKTmF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Sep 2012 15:42:05 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57398 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759174Ab2IKTl4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Sep 2012 15:41:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DE0D48B01;
	Tue, 11 Sep 2012 15:41:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2ACx4/ifZb5QHQRaKXrQflHUNPc=; b=WiRr1U
	CtdMJbI/jrOGI9hjqcE0kEhVo+IdU+AiysBniQD9yTSnGYfYyR/Pa2KeWPL85rHZ
	Xh+ufd1y7BnaMTyLyJUSNGiyodoccwO26X27sx3O+Dsjr2dMg7AO+cwv7YUi49rc
	YyP0eOHFkQJ7mjAh7gXZ1hfnK9LDzmzwct+Qc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sJSkHXm2bWTBBE8e0VnMCQw1p42cfYpK
	mTEEhjykKhUxFvilQgKlfxB8zlNvkGZJm+daLEUDGNuymgCyeZE+SxPpha8wdfL5
	xHTSCoa57x6GyUxPJmmawIR9X7+LW/0bcvO06naNyXRo4g334xRBKLF2VZyjuFft
	TZ6vP8amd0o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CA0A38B00;
	Tue, 11 Sep 2012 15:41:55 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 04AC68AFF; Tue, 11 Sep 2012
 15:41:54 -0400 (EDT)
In-Reply-To: <504F8427.1020507@web.de> (Jens Lehmann's message of "Tue, 11
 Sep 2012 20:34:15 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BDD15200-FC48-11E1-A7FF-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205260>

Jens Lehmann <Jens.Lehmann@web.de> writes:

>> * jl/submodule-rm (2012-08-27) 1 commit
>>  - Teach rm to remove submodules unless they contain a git directory
>> 
>> "git rm submodule" cannot blindly remove a submodule directory as
>> its working tree may have local changes, and worse yet, it may even
>> have its repository embedded in it.  Teach it some special cases
>> where it is safe to remove a submodule, specifically, when there is
>> no local changes in the submodule working tree, and its repository
>> is not embedded in its working tree but is elsewhere and uses the
>> gitfile mechanism to point at it.
>> 
>> I lost track; what is the doneness of the discussion on this patch?
>
> The review of v2 revealed that in case of submodule merge conflicts
> the necessary checks weren't done. This (and the minor issues raised
> in http://permalink.gmane.org/gmane.comp.version-control.git/204370)
> is fixed in this version.

Thanks.  I wish all others paid attention to "What's cooking" like
you did here.

And if it is hard to do so for whatever reason, suggest a better way
for me to publish "What's cooking" or an equivalent (I am interested
in finding the least bureaucratic way to help people and keep the
balls rolling).

> +static int check_submodules_use_gitfiles(void)
> +{
> +	int i;
> +	int errs = 0;
> +
> +	for (i = 0; i < list.nr; i++) {
> +		const char *name = list.entry[i].name;
> +		int pos;
> +		struct cache_entry *ce;
> +		struct stat st;
> +
> +		pos = cache_name_pos(name, strlen(name));
> +		if (pos < 0)
> +			pos = -pos-1;
> +		ce = active_cache[pos];
> +
> +		if (!S_ISGITLINK(ce->ce_mode) ||
> +		    (lstat(ce->name, &st) < 0) ||
> +		    is_empty_dir(name))
> +			continue;

If the name doesn't exist in the index (i.e. "list" has names that
do not exist in the index for whatever reason), a negative pos is
returned to tell you where it _would_ be inserted if you said "git
add" the path.  But these names in the "list" are guaranteed to
exist in the index in _some_ form, so for a negative pos, (-pos-1)
will have the conflicted entry at the lowest stage (typically the
common ancestor's version).  I am not sure checking only that one is
sufficient, though.  Wouldn't you want to at least check stage #2
(ours, which should most resemble the working tree)?  If this were
"common ancestor had it as a submodule, our side removed it and
created something else, their side updated the submodule" conflict,
the stage #2 would not be a gitlink (it would be a blob if that
something else is a file, or may be missing if the submodule was
replaced with a directory), and the path ce->name would definitely
not be a submodule.

> +		if (!submodule_uses_gitfile(name))
> +			errs = error(_("submodule '%s' (or one of its nested "
> +				     "submodules) uses a .git directory\n"
> +				     "(use 'rm -rf' if you really want to remove "
> +				     "it including all of its history)"), name);
> +	}
> +
> +	return errs;
> +}
> +
>  static int check_local_mod(unsigned char *head, int index_only)
>  {
>  	/*
> @@ -37,15 +72,23 @@ static int check_local_mod(unsigned char *head, int index_only)
>  		struct stat st;
>  		int pos;
>  		struct cache_entry *ce;
> -		const char *name = list.name[i];
> +		const char *name = list.entry[i].name;
>  		unsigned char sha1[20];
>  		unsigned mode;
>  		int local_changes = 0;
>  		int staged_changes = 0;
>
>  		pos = cache_name_pos(name, strlen(name));
> -		if (pos < 0)
> -			continue; /* removing unmerged entry */
> +		if (pos < 0) {
> +			/*
> +			 * Skip unmerged entries except for populated submodules
> +			 * that could loose history when removed.

s/loose/lose/

> +			 */
> +			pos = -pos-1;
> +			if (!S_ISGITLINK(active_cache[pos]->ce_mode) ||
> +			    is_empty_dir(name))
> +				continue;
> +		}

Lilewise.  It may make sense to introduce a helper function to tell
if it is a submodule on our side by checking only the stage #2 entry
when you see a nagetive pos returned from cache_name_pos() and call
it "is_ours_submodule?()" or something.
