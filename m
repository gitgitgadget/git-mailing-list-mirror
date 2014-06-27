From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: [RFC/PATCH] pager.c: replace git_config with git_config_get_string
Date: Fri, 27 Jun 2014 18:57:18 +0200
Message-ID: <53ADA26E.8030801@gmail.com>
References: <1403520105-23250-1-git-send-email-tanayabh@gmail.com>	<1403520105-23250-6-git-send-email-tanayabh@gmail.com>	<CAPig+cTwBB8bmKDtdv8zPojR+6Kyu6fYB7Sw0-UJoSHFLQX+fQ@mail.gmail.com>	<53AC6A7B.3040602@gmail.com> <vpqr42afty5.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Tanay Abhra <tanayabh@gmail.com>,
	Git List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Jun 27 18:57:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X0ZSj-0000Hh-V3
	for gcvg-git-2@plane.gmane.org; Fri, 27 Jun 2014 18:57:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751437AbaF0Q5S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2014 12:57:18 -0400
Received: from mail-wg0-f50.google.com ([74.125.82.50]:60696 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750971AbaF0Q5R (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2014 12:57:17 -0400
Received: by mail-wg0-f50.google.com with SMTP id m15so5314950wgh.21
        for <git@vger.kernel.org>; Fri, 27 Jun 2014 09:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=LD5r4wZbbQ5wxVNj3ih7Hy6s/fcjWKNadQSsgwxYZS0=;
        b=snFzLLoGn6PjeV47pBP5dlYC3k0U2HXHtRtpIHKQ0aJdiutMrZdTGEEIyvsjmMdpGb
         8QDIuxlGUa0Lk5frvfHOVwWuA6Qd5X5n/vyGPKjL/TASh1nH6nD6wvP2Y796x44xDTe8
         ZPndMk4deQOACQgnkP3H7kxF/KRnlmCoaV3CeM4iclq8cH7UIkE49A1c0Skjv+/vRXny
         X/0u9ruRc7/VR06royqAiFUnDwI6jLAXoeFKEnO1U712bRXrShNdErWoRiU3hS8cRg4j
         cre6KL2cxB2C6gqv9K7WqfOxyklP4d/L9iN4IF5Qvz61YATppS2C4do9A6OHeb6ucVYF
         b7EQ==
X-Received: by 10.194.62.5 with SMTP id u5mr26340525wjr.46.1403888236337;
        Fri, 27 Jun 2014 09:57:16 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id ez8sm38398672wib.12.2014.06.27.09.57.14
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 27 Jun 2014 09:57:15 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <vpqr42afty5.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252560>

Am 27.06.2014 13:55, schrieb Matthieu Moy:
> Karsten Blees <karsten.blees@gmail.com> writes:
> 
>> If for some reason a config string is accessed after config_cache_free()
>> (which would be a bug), you won't notice if strings are xstrdup()ed (i.e. git
>> will continue to run with some invalid configuration). This is IMO much worse
>> than failing with segfault.
> 
> I disagree. In most case, continuing to use the old config value is the
> right thing.
> 
> First, config_cache_free() is called whenever _any_ configuration
> variable is set.

This is illogical. An API should do the right thing, and if the
right thing is to keep the old values, as you pointed out, then
setting a config value shouldn't invalidate the cache (at least
not automatically).

I can think of only git-clone and git-init that may want to refresh
the global config cache, otherwise, config_cache_free() should
probably _never_ be called. Least of all as a side effect of
git_config_set_multivar_in_file(), which is used to write all kinds
of unrelated files that just happen to have config-file format (e.g.
'.gitmodules', '.git/sequencer/opts').

> So, setting "core.foo" also invalidates "core.bar" in
> the cache, while a user of "core.bar" could continue working with the
> old, unchanged value.

But a user of an xstrdup()ed copy of "core.foo" would also continue
to work with the old value. So if everyone keeps copies of config
strings, invalidating the cache when setting a value has no effect.
We could just as well not invalidate the cache and not xstrdup()
strings.

Perhaps we should see this as an opportunity to get rid of all the
memory leaks in current config code (each string value defined in
system / global config and overridden locally will currently be
leaked with the 'standard' xstrdup() pattern).
