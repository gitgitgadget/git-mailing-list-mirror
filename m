From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: [RFC/PATCH] pager.c: replace git_config with git_config_get_string
Date: Thu, 26 Jun 2014 20:46:19 +0200
Message-ID: <53AC6A7B.3040602@gmail.com>
References: <1403520105-23250-1-git-send-email-tanayabh@gmail.com>	<1403520105-23250-6-git-send-email-tanayabh@gmail.com> <CAPig+cTwBB8bmKDtdv8zPojR+6Kyu6fYB7Sw0-UJoSHFLQX+fQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Eric Sunshine <sunshine@sunshineco.com>,
	Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 26 20:46:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X0Egj-0001na-4P
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jun 2014 20:46:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751281AbaFZSqV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jun 2014 14:46:21 -0400
Received: from mail-wg0-f51.google.com ([74.125.82.51]:52603 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751093AbaFZSqU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2014 14:46:20 -0400
Received: by mail-wg0-f51.google.com with SMTP id x12so3997023wgg.34
        for <git@vger.kernel.org>; Thu, 26 Jun 2014 11:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=1M8JcH4IeU9jiIBnw26PjGP9ke64dO0loeVl86LXSnM=;
        b=pEVqq+oLJW0NBW15dKN5R4FpI6vl2ndBy/Vt6aQ550xnhkZWDEP/AmWG0hwDlYarQi
         438v00ZwR1p/nRw0vtD4W9UyD5L/RCiDmPMMrl6x1L3834MeC0ikZVAqd1r2AXIfEKLf
         FXwsijlqNeRNF7KPbuVbOLS2smIKRMPggmCXKqW7/DCJvvU4IVB/x3gjkbKJi+hTpi5j
         Ugyrw6W4Q91syXCovPO7ivJb9XTkIVmmsetk0yZHbD0aYGM0LR77CZUdYmysSPWh+kuA
         M0cHP88BzirTKKrv49q8tgpjp2/Cv5Vii4FHRde91KNqXRO0YpeT/Xv1lfDpYyXPjFYf
         MDrw==
X-Received: by 10.194.243.10 with SMTP id wu10mr20307594wjc.44.1403808379430;
        Thu, 26 Jun 2014 11:46:19 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id fh5sm68705658wic.9.2014.06.26.11.46.17
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 26 Jun 2014 11:46:18 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <CAPig+cTwBB8bmKDtdv8zPojR+6Kyu6fYB7Sw0-UJoSHFLQX+fQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252514>

Am 25.06.2014 05:59, schrieb Eric Sunshine:
> On Mon, Jun 23, 2014 at 6:41 AM, Tanay Abhra <tanayabh@gmail.com> wrote:

[...]

>>  /* returns 0 for "no pager", 1 for "use pager", and -1 for "not specified" */
>>  int check_pager_config(const char *cmd)
>>  {
>> -       struct pager_config c;
>> -       c.cmd = cmd;
>> -       c.want = -1;
>> -       c.value = NULL;
>> -       git_config(pager_command_config, &c);
>> -       if (c.value)
>> -               pager_program = c.value;
>> -       return c.want;
>> +       struct strbuf key = STRBUF_INIT;
>> +       int want = -1;
>> +       const char *value = NULL;
>> +       strbuf_addf(&key, "pager.%s", cmd);
>> +       if (!git_config_get_string(key.buf, &value)) {
>> +               int b = git_config_maybe_bool(key.buf, value);
>> +               if (b >= 0)
>> +                       want = b;
>> +               else
>> +                       want = 1;
>> +       }
>> +       if (value)
>> +               pager_program = value;

[...]
> 
> Second, don't you want to xstrdup(value) when assigning to
> 'pager_program'? If you don't, then 'pager_program' will become a
> dangling pointer when config_cache_free() is invoked.
> 

I don't think that values from the global config cache should be xstrdup()ed.
After all, caching the values during the lifetime of the git process is the
entire point of the config cache, isn't it?

The only reason to call config_cache_free() is to load a _different_
configuration. In this case, however, you would also need to call the relevant
config functions again, leaking all xstrdup()ed strings.

If for some reason a config string is accessed after config_cache_free()
(which would be a bug), you won't notice if strings are xstrdup()ed (i.e. git
will continue to run with some invalid configuration). This is IMO much worse
than failing with segfault.
