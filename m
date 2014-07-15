From: Tanay Abhra <tanayabh@gmail.com>
Subject: Re: [PATCH v9 1/2] add `config_set` API for caching config-like files
Date: Tue, 15 Jul 2014 21:52:18 +0530
Message-ID: <53C5553A.2090700@gmail.com>
References: <1405434571-25459-1-git-send-email-tanayabh@gmail.com>	<1405434571-25459-2-git-send-email-tanayabh@gmail.com> <xmqqoawqwrov.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 15 18:22:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X75Uq-0004UT-EB
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jul 2014 18:22:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751601AbaGOQWZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2014 12:22:25 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:38362 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751279AbaGOQWX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2014 12:22:23 -0400
Received: by mail-pa0-f54.google.com with SMTP id fa1so4187881pad.13
        for <git@vger.kernel.org>; Tue, 15 Jul 2014 09:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=Uzv+NYgG5Xcv3wdj0BlNwRjVlsNQktEH8bgvSWcWOVQ=;
        b=1HerIZg+C8DdpZQipH2hKeuO9dc9bHOWsUNpet2QVcFMVCXOvJhZJe0LoPMpvA6Dfl
         To2h8pQW4mWMS16c1dQ1xlK/nJF4/uOhsTz5/A7U++0rxJZYKS/IwKQqgd56SHtA69F5
         fnavH4n0msPLeWW0hPiUMyCW4rByp9ulS+amBPK+J0ZEIySMTTL/Um15WmA4oi9G8FgW
         dLwXJOVi82kVz7oIhphkBwPLwXcJxBDxDRy63lZRVGUAtJOgApGmdaRtvoLP+9jpHkbK
         +dovCwxuyS19hcmrJZOqIAZXW4GYYWZ7KC47yA2j/7DueoCABfvBd5SYtfxL696+Kh22
         QgYQ==
X-Received: by 10.69.26.103 with SMTP id ix7mr23552575pbd.41.1405441343174;
        Tue, 15 Jul 2014 09:22:23 -0700 (PDT)
Received: from [127.0.0.1] ([223.226.20.20])
        by mx.google.com with ESMTPSA id gw8sm14414830pbc.28.2014.07.15.09.22.19
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 15 Jul 2014 09:22:22 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <xmqqoawqwrov.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253569>



On 7/15/2014 9:16 PM, Junio C Hamano wrote:
> Tanay Abhra <tanayabh@gmail.com> writes:
> 
>> diff --git a/config.c b/config.c
>> index ba882a1..89e2d67 100644
>> --- a/config.c
>> +++ b/config.c
>> ...
>> +const struct string_list *git_configset_get_value_multi(struct config_set *cs, const char *key)
>> +{
>> +	struct config_set_element *e = configset_find_element(cs, key);
>> +	return e ? &e->value_list : NULL;
>> +}
> 
> Somehow I find the placement of this function out of place.  Didn't
> you get the same impression while proofreading the entire file after
> you are done writing this patch?
> 
> The right place for it would probably be immediately before
> git_configset_get_value(), I would think.
>

Noted. My fault, will correct in the reroll.

>> +int git_configset_add_file(struct config_set *cs, const char *filename)
>> +{
>> +	int ret = 0;
>> +	ret = git_config_from_file(config_hash_callback, filename, cs);
>> +	if (!ret)
>> +		return 0;
>> +	else {
>> +		git_configset_clear(cs);
>> +		return -1;
>> +	}
>> +}
> 
> If I add contents from file "A" successfully and then attempt to
> further add contents from file "B" which fails, I would lose
> contents I read from "A"?
> 
> It would not be worth trying to make it transactional (i.e. making
> sure cs contains what was there before the config-from-file was
> called if it failed), so in such a case we may end up seeing a
> mixture of full contents from A and partial contents from B, which
> is just as useless as a cleared configset, so it is not wrong to
> clear it per-se.  An alternative might be to return without
> clearing, as we are leaving the configset in a useless state either
> way and give the caller a choice between clearing it and continue,
> and dying without even spending unnecessary cycles to clear.  That
> might be more consistent with what git_config_check_init() does,
> where you die without bothering to clear what was half-read into the
> configset.
> 
> Whatever behaviour is chosen in the error codepath, it needs to be
> documented.
>

Since syntactical errors in reading the file will cause a die when we
use either `git_config_from_file` or `git_config`, I don't think
incomplete parsing would trigger the error path, as it will die before
reaching there.

So, the best way would be just to return without clearing and let the
user take the decision if he wants to go on with the incomplete
config_set or clear it when he sees that configset_add_file() failed.

Die in git_config_check_init() is never triggered expect in rare race
conditions like between access_or_die() and git_config_from_file() in

	if (git_config_system() && !access_or_die(git_etc_gitconfig(), R_OK, 0)) {
		ret += git_config_from_file(fn, git_etc_gitconfig(),
					    data);
		found += 1;
	}
which I think would never happen in reality, dunno. I think I will take
out the die() in git_config_check_init(). Thus, the behavior of both
functions git_config_check_init() & git_configset_add_file will be consistent.

Thanks.
