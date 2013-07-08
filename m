From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH 15/22] read-cache: read index-v5
Date: Mon, 08 Jul 2013 13:40:55 +0200
Message-ID: <87k3l1qny0.fsf@gmail.com>
References: <1373184720-29767-1-git-send-email-t.gummerer@gmail.com> <1373184720-29767-16-git-send-email-t.gummerer@gmail.com> <CAPig+cSyvjSKR7s8KpwsZxGcbHbxHXU1-4BRY02VvOPNvkLTng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>, Thomas Rast <trast@inf.ethz.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	robin.rosenberg@dewire.com
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Jul 08 13:41:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uw9oY-00050u-2R
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jul 2013 13:41:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751573Ab3GHLlB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jul 2013 07:41:01 -0400
Received: from mail-ea0-f169.google.com ([209.85.215.169]:33520 "EHLO
	mail-ea0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750932Ab3GHLlA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jul 2013 07:41:00 -0400
Received: by mail-ea0-f169.google.com with SMTP id h15so2851910eak.14
        for <git@vger.kernel.org>; Mon, 08 Jul 2013 04:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:in-reply-to:references:user-agent:date
         :message-id:mime-version:content-type;
        bh=59qFIFxl7AcIVq1aLjTWcuPzv6/x6v7vXyHL8O7I17Q=;
        b=uqLvYmhB9Ikao1uqyaynYaKJl5/5gS/7nsfmTiljCpjCEX7utl1N2JJXj2ZtKpt09s
         VMzFN8IvMk45zDSFw7jLipPHFNX/kZ++jpzQdOFyyG3/vPITDYUBxhO+B00n/7ZXNlN1
         CXBHZLshxnPwgnr/+6xTmqkKgZuiCJePMn2PdFqFzfX6gys7XPVAimwW8vyDc90mjZe1
         2UZmIJG47Y9ld+ZFGLjIoRUp+yd40SYpf0MGllYCYAV1qlq2mBD1685KrrT39IAGblwe
         qej/h4TcbrDTkENMeWodeASwlHzoD1OhA6vDVvRfuLlcCI5D3tv/vN/VgjJRSkqj8nRA
         srOQ==
X-Received: by 10.14.4.70 with SMTP id 46mr23869630eei.42.1373283659300;
        Mon, 08 Jul 2013 04:40:59 -0700 (PDT)
Received: from localhost (nat5.unibz.it. [46.18.27.5])
        by mx.google.com with ESMTPSA id w43sm41528790eez.6.2013.07.08.04.40.57
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 08 Jul 2013 04:40:58 -0700 (PDT)
In-Reply-To: <CAPig+cSyvjSKR7s8KpwsZxGcbHbxHXU1-4BRY02VvOPNvkLTng@mail.gmail.com>
User-Agent: Notmuch/0.15.2+119~gf0dfda5 (http://notmuchmail.org) Emacs/24.3.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229841>

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Sun, Jul 7, 2013 at 4:11 AM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
>> Make git read the index file version 5 without complaining.
>>
>> This version of the reader doesn't read neither the cache-tree
>> nor the resolve undo data, but doesn't choke on an index that
>> includes such data.
>> ---
>> diff --git a/read-cache-v5.c b/read-cache-v5.c
>> new file mode 100644
>> index 0000000..e319f30
>> --- /dev/null
>> +++ b/read-cache-v5.c
>> @@ -0,0 +1,658 @@
>> +static struct directory_entry *read_directories(unsigned int *dir_offset,
>> +                               unsigned int *dir_table_offset,
>> +                               void *mmap,
>> +                               int mmap_size)
>> +{
>> +       int i, ondisk_directory_size;
>> +       uint32_t *filecrc, *beginning, *end;
>> +       struct directory_entry *current = NULL;
>> +       struct ondisk_directory_entry *disk_de;
>> +       struct directory_entry *de;
>> +       unsigned int data_len, len;
>> +       char *name;
>> +
>> +       /* Length of pathname + nul byte for termination + size of
>> +        * members of ondisk_directory_entry. (Just using the size
>> +        * of the stuct doesn't work, because there may be padding
>
> s/stuct/struct/
>
>> +        * bytes for the struct)
>> +        */
>
> Also:
>
>   /*
>    * Format multi-line comment
>    * like this.
>    */
>
> Remaining multi-line comments appear to be formatted correctly.

Thanks for catching this and the other typos.
