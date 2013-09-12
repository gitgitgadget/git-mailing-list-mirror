From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 1/5] add a hashtable implementation that supports O(1) removal
Date: Wed, 11 Sep 2013 21:10:44 -0700
Message-ID: <xmqqmwnir86z.fsf@gitster.dls.corp.google.com>
References: <522FAAC4.2080601@gmail.com> <522FAB19.3080704@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 12 06:10:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJyF2-0008Dx-Cb
	for gcvg-git-2@plane.gmane.org; Thu, 12 Sep 2013 06:10:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752516Ab3ILEKt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Sep 2013 00:10:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42617 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751979Ab3ILEKs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Sep 2013 00:10:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 79C7C39ADE;
	Thu, 12 Sep 2013 04:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WZGbzqmUSU+P0iyVz6S7FHY9U18=; b=J/4Dyn
	yz1ri+6MuwGcF9a1lj9Xb4UNqW5yI4MlvjS5Uu46nPAg1kDDOBZ1bfxNBLwbEQLh
	E1EXJFAWyowUVTvoY1/1KBxjttoznITen4yXsHDz2pwOjkGL0lDzrBoOqisUkAhE
	4iyYwvFe4ULDzFTyieLvFs2lB6TpMUx7YHogk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SxvM7jcr67WEdEpCPKoG6g6pGu4571ef
	/Gado3LT8yYPpJj3AmDJ5i9pn27sC65qOw65gP+VHJxlXndj9PwBskcB7Lr9hzuO
	L7kZh/vFbFxKFsxghhxXc8S1CR06KzrS+MkFLdump9d/HcjnacarrhwIZERHfzUT
	HJx7PSuTh4Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6E50C39ADD;
	Thu, 12 Sep 2013 04:10:47 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B5BB039AD9;
	Thu, 12 Sep 2013 04:10:46 +0000 (UTC)
In-Reply-To: <522FAB19.3080704@gmail.com> (Karsten Blees's message of "Wed, 11
	Sep 2013 01:28:25 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 4CEBC690-1B61-11E3-A72A-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234620>

Karsten Blees <karsten.blees@gmail.com> writes:

> +/*
> + * Hashmap entry data structure, intended to be used as first member of user
> + * data structures. Consists of a pointer and an int. Ideally it should be

It is technically correct to say this is "intended to be" used, but
to those who are using this API, it would be more helpful to say "a
user data structure that uses this API *must* have this as its first
member field".

> + * followed by an int-sized member to prevent unused memory on 64-bit systems
> + * due to alignment.
> + */
> +typedef struct hashmap_entry {
> +	struct hashmap_entry *next;
> +	unsigned int hash;
> +} hashmap_entry;
> + ...
> +typedef struct hashmap {
> +	hashmap_entry **table;
> +	hashmap_cmp_fn cmpfn;
> +	unsigned int size, tablesize;
> +} hashmap;

I forgot to mention in my previous message, but we find that the
code tends to be easier to read if we avoid using typedef'ed struct
like these.  E.g. in 2/5 we see something like this:

     static int abbrev = -1; /* unspecified */
     static int max_candidates = 10;
    -static struct hash_table names;
    +static hashmap names;
     static int have_util;
     static const char *pattern;
     static int always;
    @@ -38,7 +38,7 @@ static const char *diff_index_args[] = {


     struct commit_name {
    -	struct commit_name *next;
    +	hashmap_entry entry;
            unsigned char peeled[20];

The version before the patch is preferrable.

Thanks.
