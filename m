From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/3] config: add hashtable for config parsing & retrieval
Date: Wed, 25 Jun 2014 11:13:55 -0700
Message-ID: <xmqq61joamcc.fsf@gitster.dls.corp.google.com>
References: <1403518300-23053-1-git-send-email-tanayabh@gmail.com>
	<1403518300-23053-3-git-send-email-tanayabh@gmail.com>
	<53A84077.4010200@ramsay1.demon.co.uk>
	<xmqqsimv9pjx.fsf@gitster.dls.corp.google.com>
	<53A99FEB.5040808@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tanay Abhra <tanayabh@gmail.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Wed Jun 25 20:14:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wzrhy-0004Jt-FZ
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jun 2014 20:14:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758050AbaFYSOF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2014 14:14:05 -0400
Received: from smtp.pobox.com ([208.72.237.35]:50212 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758044AbaFYSOD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2014 14:14:03 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4FDF02188A;
	Wed, 25 Jun 2014 14:13:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DVjMlcY9mlII7c6QYEYTUPLzVCA=; b=Den6GU
	PePZsGjytoawuqOnV5p5iNsQ0PhCBws/YkqMuwBP69F7APNh82oKkh+cf3N7D4bM
	UvDcJz9DFpaMgn1+uGW8AdNC2nJ7jt6zcA0i3SfCARrCB978KDrpKixo75KpkNxf
	apBnhaDkspbqZJVmaNP5sy94Hkii2eJilo5aI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pXs6cnkEpNiwTl3i2H5iKf/+uQTTvxrM
	/CnSMDPcYiHEt4qW9M3A5mP5Ht40zfYSKCAQVSL0Kb7w0yvgFMZw3rLmOHVFGfPM
	nhhVAxdCW9RBttdCtBOaIuz6QQmzEEruIeTlrM1r2xb9mFlJwtjxyiA50qcQlDDq
	xLElhRkRESw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4521621885;
	Wed, 25 Jun 2014 14:13:56 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 566382187F;
	Wed, 25 Jun 2014 14:13:51 -0400 (EDT)
In-Reply-To: <53A99FEB.5040808@ramsay1.demon.co.uk> (Ramsay Jones's message of
	"Tue, 24 Jun 2014 16:57:31 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 75D7DCDC-FC94-11E3-8387-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252453>

Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:

> On 24/06/14 00:25, Junio C Hamano wrote:
> ...
>> Yup, that is a very good point.  There needs an infrastructure to
>> tie a set of files (i.e. the standard one being the chain of
>> system-global /etc/gitconfig to repo-specific .git/config, and any
>> custom one that can be specified by the caller like submodule code)
>> to a separate hashmap; a future built-in submodule code would use
>> two hashmaps aka "config-caches", one to manage the usual
>> "configuration" and the other to manage the contents of the
>> .gitmodules file.
>> 
>
> I had expected to see one hash table per file/blob, with the three
> standard config hash tables linked together to implement the scope/
> priority rules. (Well, these could be merged into one, as the current
> code does, since that makes handling "multi" keys slightly easier).

Again, good point.  I think a rough outline of a design that take
both

 (1) we may have to read two or more separate sets of "config like
     things" (e.g. the contents from the normal config system and
     the contents from the .gitmodules file) and

 (2) we may have to read two or more files that make up a logically
     single set of "config-like things" (e.g. the "normal config
     system" reads from three separate files)

into account may look like this:

 * Each instance of in-core "config-like things" is expressed as a
   struct "config-set".

 * A "config-set" points at an ordered set of struct "config-file",
   each of which represents what was read and cached in-core from a
   file.

 * When we know or notice that a single file on the filesystem was
   modified, we do not have to invalidate the whole "config-set"
   that depends on the file; the "config-file" that corresponds to
   the file on the filesystem is invalidated instead.

 * The most generic API to read the values for a given key or
   enumerate the keys in a set of "config-like things" takes
   "config-set" as an argument, and reads from the ordered set of
   "config-file" to keep the established illusion that we read them
   all and accumulate, leading to "the last one wins" for single
   valued variables.

 * Because reading from the normal config system happens everywhere
   in the existing code, we will have one struct "config-set"
   instance, called "the_config_set", and have a parallel API of the
   most generic API above, that do not take the "config-set" as an
   explicit argument.  They operate on the_config_set singleton
   instance.


The implementation of the API function "git-config-get-string" may
look like this:

	int git_config_get_string(const char *key, const char **value)
	{
        	return git_configset_get_string(&the_config_set, key, value);
	}

which is the "thin-wrapper" for the more generic API to allow you
read from an arbitrary config_set, which may even look like this:

	#define git_config_get_string(k, v) \
        	git_configset_get_string(&the_config_set, (k), (v))


When the submodule script that uses "git config -f .gitmodules" is
converted into C, if the updated config API is ready, it may be able
to do something like these in a single program:

	const char *url;
	struct config_set *gm_config;

        /* read from $GIT_DIR/config */
        url = git_config_get_string("remote.origin.url");

        /*
         * allow us to read from .gitmodules; the parameters are
         * list of files that make up the configset, perhaps.
         */
	gm_config = git_configset_new(".gitmodules", NULL);


        if (!git_configset_get_bool(gm_config, "submodule.frotz.ignore")) {
		/* do a lot of stuff for the submodule */
                ...
	}

        /* when we are done with the configset */
        git_configset_clear(gm_config);
