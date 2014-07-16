From: Tanay Abhra <tanayabh@gmail.com>
Subject: Re: [PATCH v9r2 1/2] add `config_set` API for caching config-like
 files
Date: Wed, 16 Jul 2014 22:14:27 +0530
Message-ID: <53C6ABEB.3060205@gmail.com>
References: <1405434571-25459-1-git-send-email-tanayabh@gmail.com>	<1405434571-25459-3-git-send-email-tanayabh@gmail.com>	<xmqqk37ewr5r.fsf@gitster.dls.corp.google.com>	<53C665A0.2060705@gmail.com> <vpqvbqxjzfx.fsf@anie.imag.fr>	<53C66E70.3050507@gmail.com> <vpqha2h9tjw.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jul 16 18:44:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X7SJp-0007GC-Si
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jul 2014 18:44:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965368AbaGPQoe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2014 12:44:34 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:44723 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933645AbaGPQod (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2014 12:44:33 -0400
Received: by mail-pd0-f182.google.com with SMTP id fp1so1526251pdb.27
        for <git@vger.kernel.org>; Wed, 16 Jul 2014 09:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=nlLvBwyXeRNNygp6Pw1AGxl/dC9LknsCL+qqNTHER10=;
        b=dWiWOEGPPfihqtulKHlI1+y9YBiKZziGxv1oNwpwUDKgJfCaSzHXmtC9O5wdMLXcp1
         I3GhoPH5qIiBSS9FMbXKxe0A3+4GEI3/qvvQ9FbyC0Vm+KvOthzboFiiGqqcoaXOR6hy
         sIm/94MqgezkhK35K2lh+QjTpsft7TisjHUMttlfj548y3C2/WWTfY3V09xhdmCPq67Z
         olyXkweZCR65XhZCE6fmaXFRo5XLqhbOqVqF4JTiZWgafN19Pz76XNW1itBu28tq8fki
         jKA2RpA6pjpLYLb0uHtxPbd6sySHaHclm/CQX66IEJUvLU/1Ntc6hJXC01/X1Tp1K4cx
         MJ/A==
X-Received: by 10.69.26.68 with SMTP id iw4mr11438345pbd.137.1405529072925;
        Wed, 16 Jul 2014 09:44:32 -0700 (PDT)
Received: from [127.0.0.1] ([223.176.232.183])
        by mx.google.com with ESMTPSA id r1sm23383556pdm.16.2014.07.16.09.44.28
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 16 Jul 2014 09:44:32 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <vpqha2h9tjw.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253675>



On 7/16/2014 9:36 PM, Matthieu Moy wrote:
> Tanay Abhra <tanayabh@gmail.com> writes:
> 
>> implemented as a thin wrapper around the `config_set` API.
>>
>> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
>> Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
>>  Documentation/technical/api-config.txt | 137 +++++++++++++++++
>>  cache.h                                |  30 ++++
>>  config.c                               | 264 +++++++++++++++++++++++++++++++++
>>  3 files changed, 431 insertions(+)
> 
> (you broke the patch by removing the ---)
>

Yikes, sorry about that.

>> +static void git_config_check_init(void)
>> +{
>> +	if (the_config_set.hash_initialized)
>> +		return;
>> +	git_configset_init(&the_config_set);
>> +	git_config(config_set_callback, &the_config_set);
>> +}
> 
> So, you're now ignoring the return value of git_config. What is the
> rationale for this? In particular, why did you reject the "die"
> possibility (I understood that you were inclined to take this option, so
> I'm curious why you changed your mind).
>

The errors (non accessible, non existent files etc) were already being caught by
git_config_early(). Since git_config() only returns positive values except
the weird race case you mentioned, I thought the die confused the reader
of the patch more than it provided error checking. I also tried myself
simulating the race condition but failed. All the callers of git_config()
also ignore the return value, so I ended up ignoring the return value myself.

> OTOH, you're transmitting the return value without dying here:
> 
> +int git_configset_add_file(struct config_set *cs, const char *filename)
> +{
> +	return git_config_from_file(config_set_callback, filename, cs);
> +}
> 
> and I think this one is correct, as we cannot tell in advance how
> serious an error would be for any callers. And we do test this (I think
> we can improve a bit, I'll send a fixup patch).
>

After reading the commit log that you mentioned and some previous ones before
that I surmised that the official slant was to silently ignore nonexistent
files. Though an access_or_warn() check was placed on most of the files
like git attributes, since non accessible file errors may be a user configuration
error. So, I decided to ignore the return value.

But I do think that an access_or_warn() check should be put on git config --file
and git_configset_add_file since other parts of git follow it. What do
you think about it, still I will send followup patch correcting the git config
--file condition where it silently ignores the file access error and continues?
