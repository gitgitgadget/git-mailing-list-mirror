From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 11/19] pull: check if in unresolved merge state
Date: Wed, 10 Jun 2015 07:38:33 -0700
Message-ID: <xmqqr3pjocgm.fsf@gitster.dls.corp.google.com>
References: <1433314143-4478-1-git-send-email-pyokagan@gmail.com>
	<1433314143-4478-12-git-send-email-pyokagan@gmail.com>
	<xmqqsia0uzaa.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stephen Robin <stephen.robin@gmail.com>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 10 16:38:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2h9S-0003i5-Uy
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jun 2015 16:38:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933052AbbFJOig (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2015 10:38:36 -0400
Received: from mail-ig0-f176.google.com ([209.85.213.176]:38741 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754078AbbFJOif (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2015 10:38:35 -0400
Received: by igblz2 with SMTP id lz2so34953284igb.1
        for <git@vger.kernel.org>; Wed, 10 Jun 2015 07:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=HUz87RwdKBcQyCqbFCq2kH0ErY/9zczx7bOZKjkwhsk=;
        b=rr71IxqbnK0S660qXyeOIRzPXKZihmrN+0YiRJZVcZlrsdsuvSYtIWbdaKyhCNSgb4
         NCOhzbq/8cTbWTBJZaiaKczNvZrN+XoqvwrfHpydkHxIq7r79nFTQ1RoWFjgur7XPpuv
         mcXWsiht1bhcSNV8pDeUC1/kYguXau8ytyxIMSYJgCe0iyuTitD1YBjWc7M4PHua0KZG
         sXBjLYcXDPG9IcV8p4tW6/lEr0aaA+lOaUR5BSqe5BHVskpk/i7GlP7YW8YleBIopXNK
         L8HuDGM4jrb0x7rhT2DVr8qIFs33rND5Rai6c+crp/UHfxBLcznc23KKqW/5KlMkLHTm
         aD0A==
X-Received: by 10.43.133.137 with SMTP id hy9mr5117392icc.74.1433947115073;
        Wed, 10 Jun 2015 07:38:35 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:b116:bf29:c748:758b])
        by mx.google.com with ESMTPSA id g12sm6130912ioe.28.2015.06.10.07.38.34
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 10 Jun 2015 07:38:34 -0700 (PDT)
In-Reply-To: <xmqqsia0uzaa.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 09 Jun 2015 18:29:01 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271290>

Junio C Hamano <gitster@pobox.com> writes:

> Paul Tan <pyokagan@gmail.com> writes:
>
>> @@ -422,6 +423,14 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
>>  
>>  	parse_repo_refspecs(argc, argv, &repo, &refspecs);
>>  
>> +	git_config(git_default_config, NULL);
>> +
>> +	if (read_cache_unmerged())
>> +		die_resolve_conflict("Pull");
>> +
>> +	if (file_exists(git_path("MERGE_HEAD")))
>> +		die_conclude_merge();
>> +
>>  	if (!opt_ff.len)
>>  		config_get_ff(&opt_ff);
>
> Hmph.
>
> If you are going to do the git_config() call yourself, it might make
> more sense to define git_pull_config() callback and parse the pull.ff
> yourself, updating the use of the lazy git_config_get_value() API you
> introduced in patch 10/19.
>
> The above "might" is stronger than my usual "might"; I am undecided
> yet before reading the remainder of the series.

Let me clarify the above with s/stronger/with much less certainty/;
