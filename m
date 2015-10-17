From: Jerry Snitselaar <jsnitsel@redhat.com>
Subject: Re: git tag --contains now takes a long time
Date: Sat, 17 Oct 2015 02:51:20 -0700
Message-ID: <20151017095120.GB4496@cantor.redhat.com>
References: <20151016220739.GF17700@cantor.redhat.com>
 <CAOLa=ZTDd3MSmqXArtNz8i5n=uj2NEB6UPk2jSnEhUsAqbr7nQ@mail.gmail.com>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: Git <git@vger.kernel.org>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 17 11:51:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZnO99-0008PG-6P
	for gcvg-git-2@plane.gmane.org; Sat, 17 Oct 2015 11:51:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751347AbbJQJvW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Oct 2015 05:51:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36443 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750943AbbJQJvV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Oct 2015 05:51:21 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (Postfix) with ESMTPS id 443708C1CE;
	Sat, 17 Oct 2015 09:51:21 +0000 (UTC)
Received: from localhost (ovpn-113-34.phx2.redhat.com [10.3.113.34])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t9H9pLlf021174;
	Sat, 17 Oct 2015 05:51:21 -0400
Content-Disposition: inline
In-Reply-To: <CAOLa=ZTDd3MSmqXArtNz8i5n=uj2NEB6UPk2jSnEhUsAqbr7nQ@mail.gmail.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.24
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279780>

On Sat Oct 17 15, Karthik Nayak wrote:
>On Sat, Oct 17, 2015 at 3:37 AM, Jerry Snitselaar <jsnitsel@redhat.com> wrote:
>> Is this known and being looked into? I've seen a jump from 12 seconds
>> to over 9 minutes with running git tag --contains on my kernel repo.
>>
>
>This wasn't known, thanks for bringing it up.
>
>>
>> snits ~/dev/linux> git --version
>> git version 2.6.1.145.gb27dacc
>>
>> snits ~/dev/linux> time git tag --contains 825fcfc
>> next-20151012
>> next-20151013
>> v4.3-rc5
>>
>> real    9m4.765s
>> user    8m56.157s
>> sys     0m2.450s
>>
>>
>>
>> snits ~/dev/linux> git --version
>> git version 2.5.0.275.gac4cc86
>>
>> snits ~/dev/linux> time git tag --contains 825fcfc
>> next-20151012
>> next-20151013
>> v4.3-rc5
>>
>> real    0m12.842s
>> user    0m11.536s
>> sys     0m1.098s
>>
>>
>> b7cc53e92c806b73e14b03f60c17b7c29e52b4a4 is the first bad commit
>> commit b7cc53e92c806b73e14b03f60c17b7c29e52b4a4
>> Author: Karthik Nayak <karthik.188@gmail.com>
>> Date:   Fri Sep 11 20:36:16 2015 +0530
>>
>>    tag.c: use 'ref-filter' APIs
>>
>>    Make 'tag.c' use 'ref-filter' APIs for iterating through refs, sorting
>>    and printing of refs. This removes most of the code used in 'tag.c'
>>    replacing it with calls to the 'ref-filter' library.
>>
>>    Make 'tag.c' use the 'filter_refs()' function provided by 'ref-filter'
>>    to filter out tags based on the options set.
>>
>>    For printing tags we use 'show_ref_array_item()' function provided by
>>    'ref-filter'.
>>
>>    We improve the sorting option provided by 'tag.c' by using the sorting
>>    options provided by 'ref-filter'. This causes the test 'invalid sort
>>    parameter on command line' in t7004 to fail, as 'ref-filter' throws an
>>    error for all sorting fields which are incorrect. The test is changed
>>    to reflect the same.
>>
>>    Modify documentation for the same.
>>
>>    Mentored-by: Christian Couder <christian.couder@gmail.com>
>>    Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
>>    Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>>    Signed-off-by: Junio C Hamano <gitster@pobox.com>
>
>As Junio mentioned I did notice ~13x slower speed.
>
> $ git version
>
>[12:02:08]
>git version 2.5.0.275.gac4cc86
>
>$ time git tag --contains HEAD~300
>                                                    [12:06:03]
>next-20150924
>next-20151016
>v4.3-rc1
>v4.3-rc2
>v4.3-rc3
>v4.3-rc4
>v4.3-rc5
>git tag --contains HEAD~300  2.89s user 0.14s system 99% cpu 3.031 total
>
>After applying b7cc53e92c806b73e14b03f60c17b7c29e52b4a4
>
> $ git version
>
>[12:07:33]
>git version 2.5.0.276.gb7cc53e
>
> $ time git tag --contains HEAD~300
>                                                     [12:07:35]
>next-20150924
>next-20151016
>v4.3-rc1
>v4.3-rc2
>v4.3-rc3
>v4.3-rc4
>v4.3-rc5
>../Git/git tag --contains HEAD~300  38.30s user 0.19s system 99% cpu
>38.519 total
>
>So I did poke around a little. I think I missed this out on the
>original commit (b7cc53e92c806b73e14b03f60c17b7c29e52b4a4).
>
>diff --git a/builtin/tag.c b/builtin/tag.c
>index 977a18c..2c5a9f1 100644
>--- a/builtin/tag.c
>+++ b/builtin/tag.c
>@@ -49,6 +49,7 @@ static int list_tags(struct ref_filter *filter,
>struct ref_sorting *sorting)
>                format = "%(refname:short)";
>
>        verify_ref_format(format);
>+       filter->with_commit_tag_algo = 1;
>        filter_refs(&array, filter, FILTER_REFS_TAGS);
>        ref_array_sort(sorting, &array);
>
>After applying this and running the test again, we get:
>
> $ git version
>
>[12:09:13]
>git version 2.5.0.276.gb7cc53e.dirty
>
> $ time git tag --contains HEAD~300
>                                                [12:12:00]
>next-20150924
>next-20151016
>v4.3-rc1
>v4.3-rc2
>v4.3-rc3
>v4.3-rc4
>v4.3-rc5
>../Git/git tag --contains HEAD~300  2.85s user 0.18s system 99% cpu 3.031 total
>
>
>Could you Squash that in, Junio?
>
>-- 
>Regards,
>Karthik Nayak

snits ~/dev/linux> time git tag --contains 825fcfc
next-20151012
next-20151013
v4.3-rc5

real	0m16.998s
user	0m12.539s
sys	0m1.572s


That worked for me.


Tested-by: Jerry Snitselaar <jsnitsel@redhat.com>
