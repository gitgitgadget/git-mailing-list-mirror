Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C57EC433EF
	for <git@archiver.kernel.org>; Sun,  3 Apr 2022 21:36:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355076AbiDCViX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Apr 2022 17:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiDCViW (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Apr 2022 17:38:22 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C40C38BD8
        for <git@vger.kernel.org>; Sun,  3 Apr 2022 14:36:28 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D3D16188ED4;
        Sun,  3 Apr 2022 17:36:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=l5SH61ujRO89rppoT9nbQufTxRTvLhzZSE76na
        3RcHk=; b=XJ7cqOA8Vp0pFSVQQhOfM5pqcfkzoTUk6KPQojb7Y6PMHUhgH4eStL
        rsvPFZ3lp1ROmTrrnOD4US5k7d8mJuNgkTobNXQ6i1wN4FP8JdDudvJ1xGNVscEw
        PvpBiaIwW80vNnLyLJxJANixa29880KxVtLIi+TmEE+036KuXjMEA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CDBAD188ED2;
        Sun,  3 Apr 2022 17:36:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 397AE188ED1;
        Sun,  3 Apr 2022 17:36:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Markus Vervier <markus.vervier@x41-dsec.de>
Cc:     git@vger.kernel.org
Subject: Re: Covierty Integration / Improvement
References: <10fd679a-eb94-5380-2070-699f1b56a7b1@x41-dsec.de>
Date:   Sun, 03 Apr 2022 14:36:22 -0700
In-Reply-To: <10fd679a-eb94-5380-2070-699f1b56a7b1@x41-dsec.de> (Markus
        Vervier's message of "Fri, 1 Apr 2022 22:49:48 +0200")
Message-ID: <xmqqbkxhvoh5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1BAE1E58-B396-11EC-89A1-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Markus Vervier <markus.vervier@x41-dsec.de> writes:

> - Was there a special purpose for the Coverity integration
>   (e.g. custom queries for variant analysis or regression testing?) or
>  did you try to integrate it as a best practice / general security
> hygiene tool?
> - Could you tell us more about the amount and types of false positives
>   and problems you've faced trying to eliminate them? This will help
>  us to understand the expectations / requirements for a successful
> integration of Coverity.
> - Could we get access to a sample of the scan results?

Not sure what X41 RfP is and how it matters to us, but anyway.

I have old e-mails from the scan-admin@coverity.com but the last one
seems to be from late June 2018, which is ages ago in Git timescale.
I do not recall us paying for such a service so I am guessing that
they had some program that open source projects can enroll, get our
public sources scanned and get the result sent back?

https://scan.coverity.com/projects/git/ (visible without signing in)
seems to match my recollection. They haven't been scanning since
late June 2018.  I wasn't the primary developer who registered us or
who has been reading these reports but if I recall correctly, we
weren't doing anything custom, and fell somewhere between just "we
are curious to see how well Coverity works" and "Yay, a free
offering. We have nothing to lose, other than our time, to sign
ourselves up and if it comes up with useful scan result that would
be good".

Below is a random one back from 2018 timeframe.  Looking at the
places around these three issues in the report in the current
codebase, I think the first two (i.e. calling die() with some
on-stack variable pointing at an allocated piece of memory in heap,
letting exit() to eventually clean up after us) are something we do
not care about, and consider "noise", and the other one (i.e. have
an open fd, leave the function without an intention to kill the
process soon, forgetting to close it) has long been fixed.  I am
reasonably sure that the "fix" happend regardless of the Coverity
report.

----- >8 --------- >8 --------- >8 --------- >8 -----


Hi,

Please find the latest report on new defect(s) introduced to git found with Coverity Scan.

3 new defect(s) introduced to git found with Coverity Scan.


New defect(s) Reported-by: Coverity Scan
Showing 3 of 3 defect(s)


** CID 1437531:  Resource leaks  (RESOURCE_LEAK)
/midx.c: 900 in clear_midx_file()


________________________________________________________________________________________________________
*** CID 1437531:  Resource leaks  (RESOURCE_LEAK)
/midx.c: 900 in clear_midx_file()
894     void clear_midx_file(const char *object_dir)
895     {
896     	char *midx = get_midx_filename(object_dir);
897     
898     	if (remove_path(midx))
899     		die(_("failed to clear multi-pack-index at %s"), midx);
>>>     CID 1437531:  Resource leaks  (RESOURCE_LEAK)
>>>     Variable "midx" going out of scope leaks the storage it points to.

** CID 1437530:  Resource leaks  (RESOURCE_LEAK)
/midx.c: 891 in write_midx_file()


________________________________________________________________________________________________________
*** CID 1437530:  Resource leaks  (RESOURCE_LEAK)
/midx.c: 891 in write_midx_file()
885     	}
886     
887     	FREE_AND_NULL(packs.list);
888     	FREE_AND_NULL(packs.names);
889     	FREE_AND_NULL(entries);
890     	FREE_AND_NULL(pack_perm);
>>>     CID 1437530:  Resource leaks  (RESOURCE_LEAK)
>>>     Variable "midx_name" going out of scope leaks the storage it points to.
891     	return 0;
892     }
893     
894     void clear_midx_file(const char *object_dir)
895     {
896     	char *midx = get_midx_filename(object_dir);
897     
898     	if (remove_path(midx))
899     		die(_("failed to clear multi-pack-index at %s"), midx);

** CID 1437529:  Resource leaks  (RESOURCE_LEAK)
/midx.c: 169 in load_multi_pack_index()


________________________________________________________________________________________________________
*** CID 1437529:  Resource leaks  (RESOURCE_LEAK)
/midx.c: 169 in load_multi_pack_index()
163     			      m->pack_names[i - 1],
164     			      m->pack_names[i]);
165     			goto cleanup_fail;
166     		}
167     	}
168     
>>>     CID 1437529:  Resource leaks  (RESOURCE_LEAK)
>>>     Handle variable "fd" going out of scope leaks the handle.
169     	return m;
170     
171     cleanup_fail:
172     	FREE_AND_NULL(m);
173     	FREE_AND_NULL(midx_name);
174     	munmap(midx_map, midx_size);


________________________________________________________________________________________________________
