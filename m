From: Tanay Abhra <tanayabh@gmail.com>
Subject: Re: [PATCH v1] config: Add hashtable for config parsing & retrival
Date: Tue, 10 Jun 2014 05:37:15 -0700
Message-ID: <5396FBFB.1010101@gmail.com>
References: <1402318146-5062-1-git-send-email-tanayabh@gmail.com> <1402318146-5062-2-git-send-email-tanayabh@gmail.com> <CAPig+cSosjLsRekAb6+jqmL3Lcyjpp5Z7MPWXJB+j+tj_g7FGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jeff King <peff@peff.net>,
	Torsten Bogershausen <tboegi@web.de>,
	Brian Gesiak <modocache@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Jun 10 14:37:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuLJ8-0004UH-3c
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 14:37:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752081AbaFJMhi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2014 08:37:38 -0400
Received: from mail-pd0-f177.google.com ([209.85.192.177]:35813 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752055AbaFJMhh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2014 08:37:37 -0400
Received: by mail-pd0-f177.google.com with SMTP id g10so6037248pdj.36
        for <git@vger.kernel.org>; Tue, 10 Jun 2014 05:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=TKv+l8D27S2lQv83e4cctlbrrdOZFsxWDMJoxEcdbHc=;
        b=PRhap/udYUg/7/NsVkz6wMcxo+UA2WfaNzZ/RgrO8DcW3bkLI2IopOEf+SjCkmRReZ
         h+UoxBDNsFLbaLUt8w4BQF3CkJaxEr5E9H9MbvWXaFeS9UYVVwJooPaV88Thb4xWCfaE
         +BL0vaAxcvcPSZEzxCOxVEZA4cfAOknW8PfHqSrO3/+dIxkxhH1c59DgQeA7xH5b9Vkv
         NufDQ35PoXpOiJFRKmyL6xTlMpUqF6HqL5YpPnlD8EhekxfYalSsLGadf/pFMxVxSsnr
         VKcf69oCWUjv1Ie6zWkLTAabbTJQp8BRCc4srU6sVQCwPbcUa3tHP7sNYjk/C4mI+tFi
         dtsg==
X-Received: by 10.68.245.100 with SMTP id xn4mr10548534pbc.152.1402403856739;
        Tue, 10 Jun 2014 05:37:36 -0700 (PDT)
Received: from [192.168.52.160] ([117.254.217.189])
        by mx.google.com with ESMTPSA id pb7sm12675544pac.10.2014.06.10.05.37.20
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 10 Jun 2014 05:37:36 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <CAPig+cSosjLsRekAb6+jqmL3Lcyjpp5Z7MPWXJB+j+tj_g7FGg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251184>

On 06/10/2014 04:45 AM, Eric Sunshine wrote:
> One additional comment...
> 
> On Mon, Jun 9, 2014 at 8:49 AM, Tanay Abhra <tanayabh@gmail.com> wrote:
>> +static int config_cache_set_value(const char *key, const char *value)
>> +{
>> +       struct hashmap *config_cache;
>> +       struct config_cache_entry *e;
>> +
>> +       config_cache = get_config_cache();
>> +       e = config_cache_find_entry(key);
>> +       if (!e) {
>> +               e = xmalloc(sizeof(*e));
>> +               hashmap_entry_init(e, strhash(key));
>> +               e->key = xstrdup(key);
>> +               e->value_list = xcalloc(sizeof(struct string_list), 1);
> 
> Order of xcalloc() arguments is incorrect [1].
> 

Noted. Thanks for pointing it out.

> [1]: http://git.661346.n2.nabble.com/PATCH-00-15-Rearrange-xcalloc-arguments-td7611675.html
> 
>> +               e->value_list->strdup_strings = 1;
>> +               string_list_append(e->value_list, value);
>> +               hashmap_add(config_cache, e);
>> +       } else {
>> +               string_list_append(e->value_list, value);
>> +       }
>> +       return 0;
>> +}
