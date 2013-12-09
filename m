From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: What's cooking in git.git (Dec 2013, #02; Fri, 6)
Date: Mon, 09 Dec 2013 15:03:28 +0100
Message-ID: <52A5CDB0.2020206@gmail.com>
References: <xmqqk3fh1qrc.fsf@gitster.dls.corp.google.com>	<52A37D70.3090400@gmail.com> <87fvq41esw.fsf@thomasrast.ch>	<52A3A1F5.3080906@gmail.com> <87lhzvhceb.fsf@linux-1gf2.Speedport_W723_V_Typ_A_1_00_098>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Thomas Rast <tr@thomasrast.ch>
X-From: git-owner@vger.kernel.org Mon Dec 09 15:03:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vq1Qy-0005Bo-OF
	for gcvg-git-2@plane.gmane.org; Mon, 09 Dec 2013 15:03:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932756Ab3LIODf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Dec 2013 09:03:35 -0500
Received: from mail-ea0-f170.google.com ([209.85.215.170]:39166 "EHLO
	mail-ea0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752958Ab3LIODe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Dec 2013 09:03:34 -0500
Received: by mail-ea0-f170.google.com with SMTP id k10so1611195eaj.29
        for <git@vger.kernel.org>; Mon, 09 Dec 2013 06:03:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=d4SpQb+nr7p2sus9s/M2SnMlWCjP4VaAuOLHM8o+tqk=;
        b=X//v9GBD5lpMYy7HrjjhVCQsU0G+jOczxa1/O7YG/CR2bEHHgwi4HU9TVd6S3VXqrs
         0s2zq+4jnHs1O5Kp3lvnsk5mhW8jJJIQdzLwH0MhCQj61zsiEZop7eT82C/31UmlW3Oc
         XP7StlOXU86qBeURnUNvfJK5ZAoN3WBJzkuxnZwiUhecCVb8Y8EIfz11pi+f0ImcQhAM
         As4X9avUvra6Yl+/TG8DZHbwnM/b2pOHLcqTwjev+og4HyvOBzMi+9Lg4zToefbAOfTs
         7ygfCataYEMYQedrGoJdHMCOSiksIAZBfrcwvvG5q++r1zLd7IVRDGjeY/KapxXcjv6C
         tnHg==
X-Received: by 10.14.149.139 with SMTP id x11mr12757350eej.35.1386597810832;
        Mon, 09 Dec 2013 06:03:30 -0800 (PST)
Received: from [10.1.100.53] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id m1sm29160972eeg.0.2013.12.09.06.03.29
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 09 Dec 2013 06:03:29 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.1.1
In-Reply-To: <87lhzvhceb.fsf@linux-1gf2.Speedport_W723_V_Typ_A_1_00_098>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239069>

Am 08.12.2013 11:20, schrieb Thomas Rast:
> Karsten Blees <karsten.blees@gmail.com> writes:
> 
>> Am 07.12.2013 23:23, schrieb Thomas Rast:
>>> Karsten Blees <karsten.blees@gmail.com> writes:
>>>
>>>> Extending 'struct hashmap_entry' with an int-sized member shouldn't waste
>>>> memory on 64-bit systems. This is already documented in api-hashmap.txt,
>>>> but needs '__attribute__((__packed__))' to work. Reduces e.g.
>>>
>>> You'd have to guard __attribute__((__packed__)) with some compiler
>>> detection in git-compat-util.h though.
>>>
>>
>> Isn't that already handled? __attribute__ is already widely used
>> (e.g. for printf formats), and platforms that don't support it define
>> it as empty (e.g. MSVC). Or do you mean I should account for
>> compiler-specific variants (#pragma pack...)?
> 
> True, __attribute__ expands to nothing on unknown compilers, but what
> does the compiler do when it sees an unknown attribute?  If some of them
> choke, you need a separate macro.
> 
> I'm a bit confused myself though, many attributes have special macros in
> git-compat-util.h but others we just use in the code.
> 

So what do you propose? I basically see three options:

1.) Trial and error

GCC supports __packed__ as of 2.3 (1992), so any other compilers that copied the __attribute__ feature probably won't complain.

2.) Accept the wasted memory

Moving the hash code from the hash table (as in hash.[ch]) to the entry is already a big improvement, as it no longer multiplies hash code + wasted bytes with the load factor. 64-bit software uses more memory in general, so we could just live with it (and only fix the documentation in api-hashmap.txt).

3.) Inject individual fields via macro

Instead of injecting a struct hashmap_entry, which implies alignment to sizeof(struct hashmap_entry), we could inject the individual fields, e.g.

 #define HASHMAP_ENTRY_HEADER struct hashmap_entry __next; unsinged int __hash;

 struct name_entry {
   HASHMAP_ENTRY_HEADER
   int namelen;
   char *name;
 };


What do you think?

Karsten
