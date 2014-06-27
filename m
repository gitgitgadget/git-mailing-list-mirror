From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] config: Add config sets for config parsing & retrieval
Date: Fri, 27 Jun 2014 14:07:49 -0700
Message-ID: <xmqq8uoi12oq.fsf@gitster.dls.corp.google.com>
References: <1403892285-9878-1-git-send-email-tanayabh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Karsten Blees <karsten.blees@gmail.com>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 27 23:08:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X0dNL-00073l-DW
	for gcvg-git-2@plane.gmane.org; Fri, 27 Jun 2014 23:08:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754137AbaF0VH7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2014 17:07:59 -0400
Received: from smtp.pobox.com ([208.72.237.35]:60876 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754116AbaF0VH6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2014 17:07:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C0F26237A0;
	Fri, 27 Jun 2014 17:07:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2tjDT8v9NsoaqQlzbJtWU038RMQ=; b=SwlCvt
	zp+1/hKJ2lI9OBbnOg8U1hfTCCCKzC3tZY11IRyQtwhA8D8wQG12fHXJbMkcgGUk
	jacbvxKBUFGfegrDsumfUFBm6MQWBceQEGRhgeVqLwB4XuT9TcBDthNguPJm1Fm0
	dFgeeJEquZghaRdTlzB/4EWXM5IqwLzuUTP4w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OjpGYlHYFKW62RjnuC3iFf70OIfJqwQ4
	jmJSU7a9s23HT+Nr1B7p6aN+SZfq5MwDhHCLD7ngQuR2k/6MkDV7Ey6XqayzXtub
	f3egkGslY2Geec3PMZYKTbXMj9jP+AfLeKCks3tiA2sRZaFG1fMoqGOJKKYHVUyx
	OOuBLYxNJZ4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B54612379F;
	Fri, 27 Jun 2014 17:07:48 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 8330E23785;
	Fri, 27 Jun 2014 17:07:42 -0400 (EDT)
In-Reply-To: <1403892285-9878-1-git-send-email-tanayabh@gmail.com> (Tanay
	Abhra's message of "Fri, 27 Jun 2014 11:04:45 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 14234D1C-FE3F-11E3-8D46-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252581>

Tanay Abhra <tanayabh@gmail.com> writes:

> API functions:
>
> 1. int git_config_get_value(char *k, char **v): The most generic function, traverses
> the usual config functions for values. (internally uses the the_config_set struct)

This may also want to be accompanied by a set of more type-specific
API functions, e.g.

     long git_config_get_long(char *key);
     unsigned long git_config_get_ulong(char *key);
     char *git_config_get_string(char *key);
     
but we would need to know how the error reporting should look like
for them.

You would also want to add a bit more before we can call the API to
be complete.  Here are two that comes to my mind:

 - Multi-valued variables

   int git_config_get_multi(char *k, char ***v, int *cnt);

   which may allocate an array of "char *" and return its address in
   *v, while returning its length in *cnt.  Alternatively, we can
   report the length of the array as the return value, signalling an
   error with a negative return value, without having the *cnt
   argument.

 - Iterating over keys

   Existing git_config() function signature can be kept for
   iterating over keys, I would think, even if we start caching the
   previous read of the config files from the filesystem.


> 2. int git_configset_get_value_from(const char *key, const char **value,
> 			 	const char *filename, struct config_set *cs)

Having to give "filename" each and every time I want to know about a
single variable does not make any sense to me.  I would have
expected the API to be more like this:

	struct config_set *cs = git_configset_init();
        char *value;

        git_configset_from_file(cs, ".gitmodule");
        git_configset_get_value(cs, "submodule.kernel.update", &value);

There will need to be a set of "config-set" variant of functions
that parallel the "work on the_config_set" variant above, e.g.

	long git_configset_get_long(struct config_set *, char *);
	int git_configset_get_multi(struct config_set *, char *, char ***, int *);
	int git_configset_config(struct config_set *, config_fn_t, void *);

The last one is the parallel to the traditional git_config() but it
walks over a specific config_set.

And once this is done, you wouldn't have any separate implementation of
git_config_get_value(). it will be a series of macros:

	#define git_config_get_value(k, v) \
        	git_configset_get_value(&the_config_set, (k), (v))

just like all the *_cache() API that used to be functions are now
implemented as macros built around corresponding *_index() API
functions (defined in cache.h).
