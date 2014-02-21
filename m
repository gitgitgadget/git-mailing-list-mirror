From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH 1/3] introduce GIT_INDEX_VERSION environment variable
Date: Fri, 21 Feb 2014 23:02:53 +0100
Message-ID: <87d2ig5dki.fsf@hank.lan>
References: <1392492197-7724-1-git-send-email-t.gummerer@gmail.com> <1392492197-7724-2-git-send-email-t.gummerer@gmail.com> <xmqqsirg9c4z.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 21 23:02:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WGyBJ-0001KU-0A
	for gcvg-git-2@plane.gmane.org; Fri, 21 Feb 2014 23:02:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753332AbaBUWCs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Feb 2014 17:02:48 -0500
Received: from mail-la0-f51.google.com ([209.85.215.51]:59038 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752884AbaBUWCr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Feb 2014 17:02:47 -0500
Received: by mail-la0-f51.google.com with SMTP id c6so2817741lan.38
        for <git@vger.kernel.org>; Fri, 21 Feb 2014 14:02:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:in-reply-to:references:user-agent:date
         :message-id:mime-version:content-type;
        bh=BKVX+NojcZXl0YC09xDz9fhpxZm5nKcFznumYhtSvcs=;
        b=MDoTvBLu1Fkk5RFBXfTbLJzU6+UUVLbBgFmsvEoXccjVf19oezTLSWTB+h/uXnGXcJ
         HPz3f9XzWZls8nmhiBQSrowk/2yQwt8fq6RfnUxKGKigPG+oWpmzapdkWBEPWL93SACC
         T79c16FtxiJm37FVaXpEYZ5W8AASp68S6RoEgbC5mbspp5rcaT4MifqE93WAHwQR0cb2
         eEL1PmxCGVVanvtuJBDEKBRxggs2pv+tMhvDubSZToccrP40dXQY1sHYKzLV03/JcTNr
         P1lJgRbsTvY+qH1wnOKZhvtGA92dxLpmXzGbAyozpLxPPDNw/9CsTJ8NRht2jlNhZOAu
         Ezfg==
X-Received: by 10.152.1.130 with SMTP id 2mr5502869lam.88.1393020166330;
        Fri, 21 Feb 2014 14:02:46 -0800 (PST)
Received: from localhost (213-66-41-37-no99.tbcn.telia.com. [213.66.41.37])
        by mx.google.com with ESMTPSA id 10sm12560904lan.5.2014.02.21.14.02.44
        for <multiple recipients>
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Feb 2014 14:02:45 -0800 (PST)
In-Reply-To: <xmqqsirg9c4z.fsf@gitster.dls.corp.google.com>
User-Agent: Notmuch/0.17+57~g9c1bc97 (http://notmuchmail.org) Emacs/24.3.1 (x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242493>

Junio C Hamano <gitster@pobox.com> writes:

> Thomas Gummerer <t.gummerer@gmail.com> writes:
>
>> diff --git a/Documentation/git.txt b/Documentation/git.txt
>> index aec3726..bc9eeea 100644
>> --- a/Documentation/git.txt
>> +++ b/Documentation/git.txt
>> @@ -712,6 +712,11 @@ Git so take care if using Cogito etc.
>>  	index file. If not specified, the default of `$GIT_DIR/index`
>>  	is used.
>>  
>> +'GIT_INDEX_VERSION'::
>> +	This environment variable allows the specification of an index
>> +	version for new repositories.  It won't affect existing index
>> +	files.  By default index file version 3 is used.
>> +
>
> This is half-correct, isn't it?  In-code variable may say version 3
> but we demote it to version 2 unless we absolutely need to use the
> version 3 ugliness.

Yes, you're right, to be correct we should say [23] instead of 3 here
maybe?

>> diff --git a/read-cache.c b/read-cache.c
>> index 3f735f3..3993e12 100644
>> --- a/read-cache.c
>> +++ b/read-cache.c
>> @@ -1223,6 +1223,22 @@ static struct cache_entry *refresh_cache_entry(struct cache_entry *ce, int reall
>>  
>>  #define INDEX_FORMAT_DEFAULT 3
>>  
>> +static unsigned int get_index_format_default()
>> +{
>> +	char *envversion = getenv("GIT_INDEX_VERSION");
>> +	if (!envversion) {
>> +		return INDEX_FORMAT_DEFAULT;
>> +	} else {
>> +		unsigned int version = strtol(envversion, NULL, 10);
>
> If we are using strtol() to parse it carefully, we should make sure
> it parses to the end by giving a non-NULL second argument and
> checking where the parsing stopped.

Thanks, makes sense, will fix it in the re-roll.

>> diff --git a/t/t1600-index.sh b/t/t1600-index.sh
>> new file mode 100755
>> index 0000000..37fd84d
>> --- /dev/null
>> +++ b/t/t1600-index.sh
>> @@ -0,0 +1,24 @@
>> +#!/bin/sh
>> +
>> +test_description='index file specific tests'
>> +
>> +. ./test-lib.sh
>> +
>> +test_expect_success 'setup' '
>> +	echo 1 >a
>> +'
>> +
>> +test_expect_success 'out of bounds GIT_INDEX_VERSION issues warning' '
>> +	(
>> +		GIT_INDEX_VERSION=1 &&
>> +		export GIT_INDEX_VERSION &&
>> +		git add a 2>&1 | sed "s/[0-9]//" >actual.err &&
>> +		sed -e "s/ Z$/ /" <<-\EOF >expect.err &&
>> +			warning: GIT_INDEX_VERSION set, but the value is invalid.
>> +			Using version Z
>> +		EOF
>> +		test_i18ncmp expect.err actual.err
>> +	)
>> +'
>
> If we already have an index in version N when this test starts, what
> should happen?

I think we shouldn't print anything, since we won't change the file
format.  I'll add another test for that.

> Will queue on 'pu', with some suggested fixups.

Thanks, I think both fixups in 'pu' make sense, so I'll include them in
the re-roll.

> Thanks.
