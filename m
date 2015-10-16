From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git tag --contains now takes a long time
Date: Fri, 16 Oct 2015 15:37:17 -0700
Message-ID: <xmqqd1wecuea.fsf@gitster.mtv.corp.google.com>
References: <20151016220739.GF17700@cantor.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Jerry Snitselaar <jsnitsel@redhat.com>
X-From: git-owner@vger.kernel.org Sat Oct 17 00:37:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZnDcr-00078A-M5
	for gcvg-git-2@plane.gmane.org; Sat, 17 Oct 2015 00:37:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752124AbbJPWhV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Oct 2015 18:37:21 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:35825 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751877AbbJPWhT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Oct 2015 18:37:19 -0400
Received: by payp3 with SMTP id p3so1210903pay.2
        for <git@vger.kernel.org>; Fri, 16 Oct 2015 15:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=Z6F4wTIc/QWv5pUYc2queOiHdQcYGrBE8H6IwpPORnQ=;
        b=rwlQHBIVjtx8eyPk1N45A8fkdvSHlw81rsVbE/50EmGnLW385GuJS8Wzxo2SBkaR5q
         6MJwvrXEietbrFqrJqlvVzeherfDWyiu5vOng3cyme8A3D00ioOzh2yqEEqN9hc9y8DM
         8gNFMZSHHfybmIbCof6KU5jFt4JD9iZ/W9z3hVYg4eJAou8enOVqZ6AFYfTto1uIo48x
         /4RE3s5V9h3KU0GLafjMNZ5GpcqmTsEv8KjJLF5L5c2dcL6SBOHpDqncB49t75ZFQH+z
         bg6vgUPiehsLm7n39eLilTkeyqBYaEFxZK+JZsNeByxcupcOA4rMaHeg6J81dcuxObfQ
         l+uQ==
X-Received: by 10.68.201.168 with SMTP id kb8mr19201139pbc.95.1445035039033;
        Fri, 16 Oct 2015 15:37:19 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:b1ee:7c8f:ac32:e39f])
        by smtp.gmail.com with ESMTPSA id dg2sm23079041pbb.9.2015.10.16.15.37.18
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 16 Oct 2015 15:37:18 -0700 (PDT)
In-Reply-To: <20151016220739.GF17700@cantor.redhat.com> (Jerry Snitselaar's
	message of "Fri, 16 Oct 2015 15:07:39 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279776>

Jerry Snitselaar <jsnitsel@redhat.com> writes:

> Is this known and being looked into? I've seen a jump from 12 seconds
> to over 9 minutes with running git tag --contains on my kernel repo.

Thanks for a report.  Yes, it seems that there is a recent
regression on the 'master' branch, not yet in any released version,
and we can observe with a much smaller repository X-<.  E.g.

    git tag --contains v2.5.0~12

in git itself seems to have got 10 times slower.


> snits ~/dev/linux> git --version
> git version 2.6.1.145.gb27dacc
>
> snits ~/dev/linux> time git tag --contains 825fcfc
> next-20151012
> next-20151013
> v4.3-rc5
>
> real	9m4.765s
> user	8m56.157s
> sys	0m2.450s
>
>
>
> snits ~/dev/linux> git --version
> git version 2.5.0.275.gac4cc86
>
> snits ~/dev/linux> time git tag --contains 825fcfc
> next-20151012
> next-20151013
> v4.3-rc5
>
> real	0m12.842s
> user	0m11.536s
> sys	0m1.098s
>
>
>
> b7cc53e92c806b73e14b03f60c17b7c29e52b4a4 is the first bad commit
> commit b7cc53e92c806b73e14b03f60c17b7c29e52b4a4
> Author: Karthik Nayak <karthik.188@gmail.com>
> Date:   Fri Sep 11 20:36:16 2015 +0530
>
>    tag.c: use 'ref-filter' APIs
>
>    Make 'tag.c' use 'ref-filter' APIs for iterating through refs, sorting
>    and printing of refs. This removes most of the code used in 'tag.c'
>    replacing it with calls to the 'ref-filter' library.
>
>    Make 'tag.c' use the 'filter_refs()' function provided by 'ref-filter'
>    to filter out tags based on the options set.
>
>    For printing tags we use 'show_ref_array_item()' function provided by
>    'ref-filter'.
>
>    We improve the sorting option provided by 'tag.c' by using the sorting
>    options provided by 'ref-filter'. This causes the test 'invalid sort
>    parameter on command line' in t7004 to fail, as 'ref-filter' throws an
>    error for all sorting fields which are incorrect. The test is changed
>    to reflect the same.
>
>    Modify documentation for the same.
>
>    Mentored-by: Christian Couder <christian.couder@gmail.com>
>    Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
>    Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>    Signed-off-by: Junio C Hamano <gitster@pobox.com>
