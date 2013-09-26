From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: [PATCH v2 0/5] New hash table implementation
Date: Thu, 26 Sep 2013 15:55:52 +0200
Message-ID: <52443CE8.6000902@gmail.com>
References: <522FAAC4.2080601@gmail.com> <52416058.90008@gmail.com> <20130926101648.GD6615@paksenarrion.iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Thu Sep 26 15:55:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VPC2v-0000pF-Ka
	for gcvg-git-2@plane.gmane.org; Thu, 26 Sep 2013 15:55:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750789Ab3IZNzx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Sep 2013 09:55:53 -0400
Received: from mail-ee0-f54.google.com ([74.125.83.54]:52914 "EHLO
	mail-ee0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750722Ab3IZNzx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Sep 2013 09:55:53 -0400
Received: by mail-ee0-f54.google.com with SMTP id e53so564145eek.41
        for <git@vger.kernel.org>; Thu, 26 Sep 2013 06:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=gpjh7JeBYgDOTr51yT96JJZD3P2MyV4KJWznx55qiSg=;
        b=vwUoyc8gSPysSEQdubl4G9oHGqRW8qVr+E0k8hAWwONQlUc8DuqAt5eNS9XPzWWVos
         gLphneqSCZzTZbn9f+Jn6skM+PgF9D8qiW918AbLnyY5rKn32BEFIWaOtZDgZfLelxZg
         /63XzUGlIHZFY6S3IECAjkIXGD/L1fgC7FCOyjOW5waKSm90pKkUBo3u94IEK7Va8YFA
         1UxzXcTTXoY/ONNhG4eOkRckCFhzXoXOuJID+m9eNkS6w5zcy3ffnLztiicaJNkcJvQ6
         xU67ATsIU8g3STWNJTZLqgucJGy6gddHjQZglFiyiHbVNkG5r4288mEsz+Ux/4+EO+Iz
         6S/g==
X-Received: by 10.14.126.69 with SMTP id a45mr1435295eei.65.1380203752019;
        Thu, 26 Sep 2013 06:55:52 -0700 (PDT)
Received: from [10.1.100.53] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id bn13sm4265063eeb.11.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 26 Sep 2013 06:55:51 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
In-Reply-To: <20130926101648.GD6615@paksenarrion.iveqy.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235419>

Am 26.09.2013 12:16, schrieb Fredrik Gustafsson:
> On Tue, Sep 24, 2013 at 11:50:16AM +0200, Karsten Blees wrote:
>> Tests can be reproduced with 'time echo "perfhash[map] <method> 1000" | ./test-hashmap', see test-hashmap.c for definition of method flags.
> 
> So I'm still curious about the actual performance improvements for git.
> I runned git describe on the linux kernel with both the old hashmap and
> this new one:
> 

Performance was never the primary issue, the intention of the performance tests was to ensure that the new implementation doesn't *slow down* git.

>From the original PATCH/RFC:
- O(1) remove
- builtin entry chaining
- ready-to-use FNV-1 hash functions
- unit test
- additions are ~twice as fast
- uses less memory

So, the new implementation allows us to get rid of workarounds such as the CE_UNHASHED flag, duplicate entry chaining code and hash_name() implementations. It also addresses the memory usage FIXME in hash.h.

The simplified API may help prevent bugs such as the broken entry chaining in name-hash.c (see commits 2548183, 395c735, 2092678).

Maybe we can also replace some of the custom hash table implementations in attr.c, decorate.c, fast-import.c and object.c (to name just a few...).
