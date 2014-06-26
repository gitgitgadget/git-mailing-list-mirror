From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: [PATCH v3 2/3] config: add hashtable for config parsing & retrieval
Date: Thu, 26 Jun 2014 21:19:42 +0200
Message-ID: <53AC724E.3090106@gmail.com>
References: <1403518300-23053-1-git-send-email-tanayabh@gmail.com>	<1403518300-23053-3-git-send-email-tanayabh@gmail.com>	<53A84077.4010200@ramsay1.demon.co.uk>	<xmqqsimv9pjx.fsf@gitster.dls.corp.google.com>	<53A99FEB.5040808@ramsay1.demon.co.uk>	<xmqq61joamcc.fsf@gitster.dls.corp.google.com>	<vpq1tubinbx.fsf@anie.imag.fr> <xmqqpphv4hu6.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Tanay Abhra <tanayabh@gmail.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Jun 26 21:19:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X0FD1-0006Dr-K8
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jun 2014 21:19:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751047AbaFZTTn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jun 2014 15:19:43 -0400
Received: from mail-we0-f173.google.com ([74.125.82.173]:63867 "EHLO
	mail-we0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750844AbaFZTTn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2014 15:19:43 -0400
Received: by mail-we0-f173.google.com with SMTP id t60so4203666wes.18
        for <git@vger.kernel.org>; Thu, 26 Jun 2014 12:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=cNaUnUa1NlNhgbqfjL2FCFYs51kx9Wl10nh8mFCnedw=;
        b=DAk3rg8hvDvKua+I97OFMwO1b4qpOKKf/O0l5305iIaWP78p9DiP5mqouL5SejBfXP
         zQTt4QbqKp2UgS7cbhvzzqiYb7gMrRtJzCBHK8EwA5lVWjlwGiixBNEPyE+5vfExL4+y
         UzOUXE7ZGjDSYC7/bMVe8940BhIMH9PE9/tTZorNxKcL6/O1tEqWXA0DsW/AszsR2sIM
         v9CSpehfXt3z2+NZvkiIg5fxBuicryk9TssSUY6SEJANC+YUFvvztwZ3ICLX9/TdbzNj
         d3oOe94C2HxeP9HXFQtrXVS9kIf94cAUNx8NYgNhtXzSy/3CZg8vECuqDKd6+ddJ3ioA
         kU3w==
X-Received: by 10.194.237.135 with SMTP id vc7mr20860212wjc.86.1403810381664;
        Thu, 26 Jun 2014 12:19:41 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id i12sm16270450wjr.32.2014.06.26.12.19.40
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 26 Jun 2014 12:19:41 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <xmqqpphv4hu6.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252518>

Am 26.06.2014 21:00, schrieb Junio C Hamano:
> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
> 
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> When the submodule script that uses "git config -f .gitmodules" is
>>> converted into C, if the updated config API is ready, it may be able
>>> to do something like these in a single program:
>>>
>>> 	const char *url;
>>> 	struct config_set *gm_config;
>>>
>>>         /* read from $GIT_DIR/config */
>>>         url = git_config_get_string("remote.origin.url");
>>>
>>>         /*
>>>          * allow us to read from .gitmodules; the parameters are
>>>          * list of files that make up the configset, perhaps.
>>>          */
>>> 	gm_config = git_configset_new(".gitmodules", NULL);
>>>
>>>
>>>         if (!git_configset_get_bool(gm_config, "submodule.frotz.ignore")) {
>>> 		/* do a lot of stuff for the submodule */
>>>                 ...
>>> 	}
>>>
>>>         /* when we are done with the configset */
>>>         git_configset_clear(gm_config);
>>
>> Isn't that a bit overkill? Why not just let the caller manage a hashmap
>> directly instead of a config_set?
> 
> Because I had an experience under my belt of a painful refactoring
> of "the_index" which turned out to be not just a single array, I
> simply suspect that the final data structure to represent a "set of
> config-like things" will not be just a single hashmap, hence I do
> prefer to have one layer of abstraction "struct config_set", which
> would contain a hashmap and possibly more.  Doesn't "is the hashmap
> initialized" bit belong there, for example?

Would an additional

  int hashmap_is_initialized(constr struct hashmap *map)
  {
    return !!map->table;
  }

API help? (Note that hashmap_free() already does memset(0), so the usual notion of "zero memory means unitialized" applies).
