From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: [PATCH v3 2/3] config: add hashtable for config parsing & retrieval
Date: Wed, 25 Jun 2014 23:44:30 +0200
Message-ID: <53AB42BE.9010308@gmail.com>
References: <1403518300-23053-1-git-send-email-tanayabh@gmail.com> <1403518300-23053-3-git-send-email-tanayabh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Tanay Abhra <tanayabh@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 25 23:44:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wzuzb-0000ZX-1O
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jun 2014 23:44:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756493AbaFYVoc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2014 17:44:32 -0400
Received: from mail-wg0-f43.google.com ([74.125.82.43]:63285 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756427AbaFYVoa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2014 17:44:30 -0400
Received: by mail-wg0-f43.google.com with SMTP id b13so2681501wgh.14
        for <git@vger.kernel.org>; Wed, 25 Jun 2014 14:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=V6Wo7xKoj+fYjbcqDptU4gv6EHLaxOT1pcx0Qsmxg0w=;
        b=MNHFuDx2JBBgRqB611FZ6YO0MOAhzGehuzNAbslaPjOPhtYASNL6kBleiGGZKTURtG
         BskhUwweMlDjiYvcA8Lg1YGixyLTwPWpkHHnYIpz4rVr/GrswMGUSQ0NG66wjpUg5vn3
         mufAJOODkvLLh/jEcUTrv0aPWph5H9aP5WxcOa163+7KoA5ZB0v6Sx9AlozQsC/7evlZ
         f+zmkAei0t5e99mn4TCZnSt2buJR6ZgK1fBvpWXLslfpGxiB1f8Npf0CA54U0C4sLaNV
         FXH1gDTc1kTV6RwvSRhxgCH7A0sVE5fM3r9J8x5pNvmP1aVEzeYO+x7orjCAw5SuF1dp
         +Nug==
X-Received: by 10.180.72.201 with SMTP id f9mr34746493wiv.41.1403732669155;
        Wed, 25 Jun 2014 14:44:29 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id gi15sm9988974wjc.20.2014.06.25.14.44.27
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 25 Jun 2014 14:44:28 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <1403518300-23053-3-git-send-email-tanayabh@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252468>

Am 23.06.2014 12:11, schrieb Tanay Abhra:

[...]

> +
> +static struct config_cache_entry *config_cache_find_entry(const char *key)
> +{
> +	struct hashmap *config_cache;
> +	struct config_cache_entry k;
> +	struct config_cache_entry *found_entry;
> +	char *normalized_key;
> +	int ret;
> +	config_cache = get_config_cache();
> +	ret = git_config_parse_key(key, &normalized_key, NULL);

[I didn't follow all previous discussion, so feel free to ignore me if this has been discussed already]

Is it really necessary to normalize keys on each lookup? The current git config code simply does a 'strcmp("lower-case-key", var)' so normalization shouldn't be necessary for the majority of callers. If a caller uses a non-constant key (e.g. as passed to 'git config --get <name>'), it would be the caller's responsibility to normalize.

[...]

> +int git_config_get_string(const char *key, const char **value)

I would have expected '..._get_string' to return a string. If the return value indicates whether something was found, it should probably be called '..._find_...'?

In the end, you want typed config functions that do type conversion and handle parse errors, at least for the common types bool/int/string... Thus the generic function that returns unparsed data should probably be called '..._value', not '..._string'?

A typical pull-style config API will also let you specify default values, e.g.:

  const char *git_config_get_string(const char *key, const char *default_value)
  {
    const char *value;
    if (!git_config_find_value(key, &value))
      return default_value;
    if (!value)
      config_error_nonbool();
    return value;
  }

  int git_config_get_bool(const char *key, int default_value)
  {
    const char *value;
    if (!git_config_find_value(key, &value))
      return default_value;
    return git_config_bool(key, value);
  }
