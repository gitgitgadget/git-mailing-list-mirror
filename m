From: Tanay Abhra <tanayabh@gmail.com>
Subject: Re: [PATCH v3 2/3] config: add hashtable for config parsing & retrieval
Date: Tue, 24 Jun 2014 17:51:01 +0530
Message-ID: <53A96D2D.1020102@gmail.com>
References: <1403518300-23053-1-git-send-email-tanayabh@gmail.com>	<1403518300-23053-3-git-send-email-tanayabh@gmail.com> <xmqqwqc79q1p.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 24 14:21:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WzPis-0008MG-2U
	for gcvg-git-2@plane.gmane.org; Tue, 24 Jun 2014 14:21:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752955AbaFXMVK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2014 08:21:10 -0400
Received: from mail-pd0-f170.google.com ([209.85.192.170]:50948 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750806AbaFXMVI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2014 08:21:08 -0400
Received: by mail-pd0-f170.google.com with SMTP id z10so185602pdj.15
        for <git@vger.kernel.org>; Tue, 24 Jun 2014 05:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=2Ga6SvKWu/sdly0rCff7flYr2U386UixdxzyHDrUnIk=;
        b=QcdVWErGu5ccZpqbLwGMxtSuk3XDvUGybJKGbrZaUmS6Nalqc4m9I+MW1FFom6lGxQ
         +1uuKj+4ed5JNZFZo5SvNIDMVSLu7e/6eyGSgdaqC2mC3n7alm46kiGMO8jfEW5qTK1a
         Bp/gfc5zCH8rCIckLLvqFURQGQZw2kAUGu25Eu4FigAhhWLcUeBhlZdLmRzzAHj5H9FN
         +Dd5Z+bGrHmuRK8WB0fZmt582uMZRPS6WSGRl3AeY9Y5CkTMUxNp6MV418/tETjmS8y4
         abZpikMJixFqHbFdo0zIJEAalryh6BxrPJr+OB+eoh1x7gLbnXJMmra3U2Kvik4Za2eA
         5+4Q==
X-Received: by 10.66.65.169 with SMTP id y9mr696331pas.145.1403612468269;
        Tue, 24 Jun 2014 05:21:08 -0700 (PDT)
Received: from [127.0.0.1] ([117.254.217.87])
        by mx.google.com with ESMTPSA id x5sm216946pbw.26.2014.06.24.05.21.04
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 24 Jun 2014 05:21:07 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <xmqqwqc79q1p.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252404>

On 6/24/2014 4:44 AM, Junio C Hamano wrote:
> Tanay Abhra <tanayabh@gmail.com> writes:
>
>> +static int hashmap_initialized;
>> + ...
>> +static struct hashmap *get_config_cache(void)
>> +{
>> +	static struct hashmap config_cache;
>> +	if (!hashmap_initialized) {
>> +		config_cache_init(&config_cache);
>> +		hashmap_initialized = 1;
>
> I find the arrangement of these two variables somewhat dubious at
> the API design level.
>
> If you are going to keep the singleton "config_cache" as a function
> scope static, shouldn't the corresponding guard also be in the same
> scope?
>
> If you ever need to "uninitialize" to force re-read the file to the
> in-core cache, such an uninitializer will need access to not just
> the "is hashmap initialized?" boolean (which you do by having it as
> a file-scope global like this patch does) but also the thing that
> may need to be uninitialized (i.e. the hashmap that may already be
> populated), but a function scope static variable config_cache does
> not allow access from other places, so you end up calling this
> function to initialize it if necessary only to get the pointer to
> that structure in order to uninitialize it.
>
> Sounds very twisted and ugly, doesn't it?
>

Hmn, You are right. but I couldn't find a way for that without making
"config_cache" file-scope static.

For the config_cache_free(), would this change be enough?

+static void config_cache_free(void)
+{
+	struct hashmap *config_cache;
+	struct config_cache_entry *entry;
+	struct hashmap_iter iter;
+	if (!hashmap_initialized)
+		return;
+	config_cache = get_config_cache();
+	hashmap_iter_init(config_cache, &iter);
+	while ((entry = hashmap_iter_next(&iter))) {
+		free(entry->key);
+		string_list_clear(&entry->value_list, 1);
+	}
+	hashmap_free(config_cache, 1);
+	hashmap_initialized = 0;
+}
+

The idea was only initialize the hashmap only once,
as it is fed by git_config(). I ended up following
this approach where the map would be lazily generated whenever
a function asked for the map. Is there another way out?
