From: Tanay Abhra <tanayabh@gmail.com>
Subject: Re: [PATCH 02/11] http-backend.c: replace `git_config()` with `git_config_get_bool()`
 family
Date: Wed, 06 Aug 2014 20:48:40 +0530
Message-ID: <53E24750.4000602@gmail.com>
References: <1407177229-30081-1-git-send-email-tanayabh@gmail.com>	<1407177229-30081-3-git-send-email-tanayabh@gmail.com> <CAPig+cRpf9fc4HhNWpJ9Su+hSVEDc2+m4QmhY38zLD3RO8pGnA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Aug 06 17:18:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XF2zP-0005UV-Cf
	for gcvg-git-2@plane.gmane.org; Wed, 06 Aug 2014 17:18:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755520AbaHFPSt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Aug 2014 11:18:49 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:36910 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752897AbaHFPSs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2014 11:18:48 -0400
Received: by mail-pd0-f182.google.com with SMTP id fp1so3456493pdb.41
        for <git@vger.kernel.org>; Wed, 06 Aug 2014 08:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=jUD+E07ZoWj6nPFsx9Uhw3qGR1dc2nY1g0/UjfBASXw=;
        b=AO/pN7y9juDoBm9tFIrt2hVL6BgS2Vg4MOuZmLb9GP0vXvc2e3wGrbuNcnJpBKOO2h
         bD1gLubqgLUZ1cXg8X3VyqylaRRms0lbFU4Rc/tBVSOmHDoMGVf3hggtVaCOCJ3wCBU5
         vObZ+EigPfqcb4hlMGg1QUT9P9SdNR0sqvs0fCOAz3r3Kor1p6w5FYf/jL6GVr/F5TC9
         1qzUYPAiYSFGnGtOKsRGtkZiPIcF7Wu5T7/y1+jNc+Nz/aBf6YkpFOjLtcmpSpjQ/G4c
         PtvFI86K73Kfeemj8udK7Oq2oifl0dAtYUDquJMJEbDwOTpRejB1oMLQtzlCYYV+LdUa
         GbzQ==
X-Received: by 10.69.26.134 with SMTP id iy6mr11952393pbd.115.1407338327747;
        Wed, 06 Aug 2014 08:18:47 -0700 (PDT)
Received: from [127.0.0.1] ([223.176.214.188])
        by mx.google.com with ESMTPSA id fl15sm2157421pdb.96.2014.08.06.08.18.44
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 06 Aug 2014 08:18:47 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <CAPig+cRpf9fc4HhNWpJ9Su+hSVEDc2+m4QmhY38zLD3RO8pGnA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254864>



On 8/5/2014 12:29 AM, Eric Sunshine wrote:
> On Mon, Aug 4, 2014 at 2:33 PM, Tanay Abhra <tanayabh@gmail.com> wrote:
>> Use `git_config_get_bool()` family instead of `git_config()` to take advantage of
>> the config-set API which provides a cleaner control flow.
>>
>> Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
>> ---
>>  http-backend.c | 31 ++++++++++++-------------------
>>  1 file changed, 12 insertions(+), 19 deletions(-)
>>
>> diff --git a/http-backend.c b/http-backend.c
>> index 80790bb..106ca6b 100644
>> --- a/http-backend.c
>> +++ b/http-backend.c
>> @@ -219,29 +219,22 @@ static void get_idx_file(char *name)
>>         send_local_file("application/x-git-packed-objects-toc", name);
>>  }
>>
>> -static int http_config(const char *var, const char *value, void *cb)
>> +static void http_config(void)
>>  {
>> -       const char *p;
>> +       int i, value = 0;
>> +       struct strbuf var = STRBUF_INIT;
>>
>> -       if (!strcmp(var, "http.getanyfile")) {
>> -               getanyfile = git_config_bool(var, value);
>> -               return 0;
>> -       }
>> +       git_config_get_bool("http.getanyfile", &getanyfile);
>>
>> -       if (skip_prefix(var, "http.", &p)) {
>> -               int i;
>> -
>> -               for (i = 0; i < ARRAY_SIZE(rpc_service); i++) {
>> -                       struct rpc_service *svc = &rpc_service[i];
>> -                       if (!strcmp(p, svc->config_name)) {
>> -                               svc->enabled = git_config_bool(var, value);
>> -                               return 0;
>> -                       }
>> -               }
>> +       for (i = 0; i < ARRAY_SIZE(rpc_service); i++) {
>> +               struct rpc_service *svc = &rpc_service[i];
>> +               strbuf_addf(&var, "http.%s", svc->config_name);
>> +               if (!git_config_get_bool(var.buf, &value))
>> +                       svc->enabled = value;
>> +               strbuf_reset(&var);
>>         }
> 
> There is a behavior change here. The original code set svc->enabled to
> the first matching rpc_service[] entry, whereas the new code sets it
> to the last matching entry. Is this change intentional?
>

I was preparing the reroll and I saw that I had missed your mail.
I think that I haven't changed the behaviour, the original one is
written in callback form so it has to go through the array every time for each
new value.
When there are multiple entries for a service say,

http.receivepack = 1
http.receivepack = 0

the old code would have at overwritten the previous entry with the new value.
The new code just populates the whole array of `rpc_service` in one go, choosing
the last matching value for each entry. For reviewing purpose the original array is
this,

	struct rpc_service {
	const char *name;
	const char *config_name;
	signed enabled : 2;
	};

	static struct rpc_service rpc_service[] = {
		{ "upload-pack", "uploadpack", 1 },
		{ "receive-pack", "receivepack", -1 },
	};

What do you think, am I interpreting it wrong? Thanks.

>> -       /* we are not interested in parsing any other configuration here */
>> -       return 0;
>> +       strbuf_release(&var);
>>  }
>>
>>  static struct rpc_service *select_service(const char *name)
>> @@ -627,7 +620,7 @@ int main(int argc, char **argv)
>>             access("git-daemon-export-ok", F_OK) )
>>                 not_found("Repository not exported: '%s'", dir);
>>
>> -       git_config(http_config, NULL);
>> +       http_config();
>>         cmd->imp(cmd_arg);
>>         return 0;
>>  }
>> --
>> 1.9.0.GIT
