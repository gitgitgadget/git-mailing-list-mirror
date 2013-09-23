From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: [PATCH/RFC 1/5] add a hashtable implementation that supports
 O(1) removal
Date: Mon, 23 Sep 2013 11:21:57 +0200
Message-ID: <52400835.8090902@gmail.com>
References: <522FAAC4.2080601@gmail.com> <522FAB19.3080704@gmail.com> <xmqqmwnir86z.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 23 11:22:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VO2LH-00007P-Iq
	for gcvg-git-2@plane.gmane.org; Mon, 23 Sep 2013 11:22:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753419Ab3IWJWA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Sep 2013 05:22:00 -0400
Received: from mail-we0-f176.google.com ([74.125.82.176]:48128 "EHLO
	mail-we0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753365Ab3IWJV7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Sep 2013 05:21:59 -0400
Received: by mail-we0-f176.google.com with SMTP id u56so2801670wes.35
        for <git@vger.kernel.org>; Mon, 23 Sep 2013 02:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=3HfSeb5Cu3e2Bf6zxvUiKm59bTBTdnngakpkSkWLmTI=;
        b=HXmWiArU7ZPr9RimIxLilUKbI8/+TDiIeGPVOnLY3DmwEk77T19OHn5EFSimhFO07F
         KG1mksYpmtXvibq7/IvNhnLDhq1kc6oYawbqjhKkWrwq/XTxDn+YYQKK/hVPC+l2N2Hq
         sT3+RIdLlmHdmcmoywTvo3yaryajMIUuIvgnPuC/EBZsIg3SwxFOSdy4XJMQSS3+mcdJ
         hx/M/f4SJFZIXptCxxEstvg2j+FWpAblVRRkcxwGK0uavL3Qo7m7EwVH60TCFA7s5ZII
         kJueqn2B43ASMgMfotsZlOE68QWZOoP441uZnVS8mCJmFZgH2tpzBFX4Z5S/6O3xOAF5
         idhw==
X-Received: by 10.194.175.193 with SMTP id cc1mr477235wjc.54.1379928118500;
        Mon, 23 Sep 2013 02:21:58 -0700 (PDT)
Received: from [10.1.100.51] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id ed12sm23732648wic.11.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 23 Sep 2013 02:21:58 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
In-Reply-To: <xmqqmwnir86z.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235204>

Am 12.09.2013 06:10, schrieb Junio C Hamano:
> Karsten Blees <karsten.blees@gmail.com> writes:
> 
>> +/*
>> + * Hashmap entry data structure, intended to be used as first member of user
>> + * data structures. Consists of a pointer and an int. Ideally it should be
> 
> It is technically correct to say this is "intended to be" used, but
> to those who are using this API, it would be more helpful to say "a
> user data structure that uses this API *must* have this as its first
> member field".
> 

Right. I considered making the position in the user struct configurable via some offsetof() magic, but this would have just complicated things unnecessarily.

>> + * followed by an int-sized member to prevent unused memory on 64-bit systems
>> + * due to alignment.
>> + */
>> +typedef struct hashmap_entry {
>> +	struct hashmap_entry *next;
>> +	unsigned int hash;
>> +} hashmap_entry;
>> + ...
>> +typedef struct hashmap {
>> +	hashmap_entry **table;
>> +	hashmap_cmp_fn cmpfn;
>> +	unsigned int size, tablesize;
>> +} hashmap;
> 
> I forgot to mention in my previous message, but we find that the
> code tends to be easier to read if we avoid using typedef'ed struct
> like these.  E.g. in 2/5 we see something like this:
> 
>      static int abbrev = -1; /* unspecified */
>      static int max_candidates = 10;
>     -static struct hash_table names;
>     +static hashmap names;
>      static int have_util;
>      static const char *pattern;
>      static int always;
>     @@ -38,7 +38,7 @@ static const char *diff_index_args[] = {
> 
> 
>      struct commit_name {
>     -	struct commit_name *next;
>     +	hashmap_entry entry;
>             unsigned char peeled[20];
> 
> The version before the patch is preferrable.
> 

OK
