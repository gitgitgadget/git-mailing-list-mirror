From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/3] config: add hashtable for config parsing & retrieval
Date: Mon, 23 Jun 2014 16:25:22 -0700
Message-ID: <xmqqsimv9pjx.fsf@gitster.dls.corp.google.com>
References: <1403518300-23053-1-git-send-email-tanayabh@gmail.com>
	<1403518300-23053-3-git-send-email-tanayabh@gmail.com>
	<53A84077.4010200@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tanay Abhra <tanayabh@gmail.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Tue Jun 24 01:25:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WzDcF-0001zp-0e
	for gcvg-git-2@plane.gmane.org; Tue, 24 Jun 2014 01:25:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751798AbaFWXZa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2014 19:25:30 -0400
Received: from smtp.pobox.com ([208.72.237.35]:59619 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750931AbaFWXZ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2014 19:25:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7A27523485;
	Mon, 23 Jun 2014 19:25:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eYBMmA35o457A5hSWt1xHOY4tcE=; b=U04Y8m
	PTEP974wEvAN180z5uh5/f+00tYocLFHSuJoD54Fnci/4N892tVhYlqUuIQkF3ei
	ttIHnTffjT2IsojRmEEhzSc17dlKOSbDNQMCOctyoLfImSa5Q1j7hKO6oWEmd2dZ
	rRGlaX+C8fkwncE9qRhD97bLT0BesFMAcs/fc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tc0GMkZh+MuRVj4D/ynrEIBRFosm865L
	gpYjCKrSSZiTvkGAukAaAHDTJSnw4FF2T0lu8nrUy4CuzaqBMeUqHguupUpXFe5/
	AeoUjHkoo2nkAM0azt3dxAqHl4oIE57cfQFBEbAKz1q+7WFn/rxGCaaKKRCfL0qO
	cLR/DJTdU3c=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6F6A323484;
	Mon, 23 Jun 2014 19:25:24 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id D473423481;
	Mon, 23 Jun 2014 19:25:19 -0400 (EDT)
In-Reply-To: <53A84077.4010200@ramsay1.demon.co.uk> (Ramsay Jones's message of
	"Mon, 23 Jun 2014 15:57:59 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: A446E576-FB2D-11E3-ADDF-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252379>

Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:

>> +static struct hashmap *get_config_cache(void)
>> +{
>> +	static struct hashmap config_cache;
>> +	if (!hashmap_initialized) {
>> +		config_cache_init(&config_cache);
>> +		hashmap_initialized = 1;
>> +		git_config(config_cache_callback, NULL);
>> +	}
>> +	return &config_cache;
>> +}
>
> [I have not been following this series at all (sorry I haven't had
> the time to spare), so take these comments with a very big pinch of
> salt! ie just ignore me if it's already been discussed etc. ;-) ]
>
> The 'git config' command can be used to read arbitrary files (so long
> as they conform to the config syntax). For example, see the --file and
> --blob options to git-config. At present, I think only scripted commands
> use this facility (eg git-submodule). Noting the singleton config_cache,
> what happens when git-submodule becomes a C builtin, or indeed any other
> C builtin wants to take advantage of the new code when processing a non-
> standard config file?

Yup, that is a very good point.  There needs an infrastructure to
tie a set of files (i.e. the standard one being the chain of
system-global /etc/gitconfig to repo-specific .git/config, and any
custom one that can be specified by the caller like submodule code)
to a separate hashmap; a future built-in submodule code would use
two hashmaps aka "config-caches", one to manage the usual
"configuration" and the other to manage the contents of the
.gitmodules file.

When we are operating across repositories (think "recursive
checkout"), we somehow have to deal with multiple sets of
configuration, one that applies to the top-level superproject and
others that apply to individual submodule repositories.

Even there is currently one caller, the "git config" command
implementation, if one is designing the new API, the design
shouldn't be tied to a singleton limitation, I would have to say, so
that future callers do not have to throw away everything done in
this series and start from scratch.
