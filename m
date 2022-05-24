Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2ED0C433EF
	for <git@archiver.kernel.org>; Tue, 24 May 2022 13:06:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234109AbiEXNGm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 May 2022 09:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232181AbiEXNGj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 May 2022 09:06:39 -0400
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24115403E3
        for <git@vger.kernel.org>; Tue, 24 May 2022 06:06:38 -0700 (PDT)
Date:   Tue, 24 May 2022 13:06:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1653397594; x=1653656794;
        bh=uF1JzaamVn1vw8bUvjGBF78rKqfOxhKeUyDQ6DTzGYk=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:Feedback-ID:From:To:Cc:Date:Subject:Reply-To:
         Feedback-ID:Message-ID;
        b=ZLtsH3zUci9l9EGdn9ePRVUTEEyhXQewIhiRw5yiEwO7A2JxXNR0h6ZRrdl08qBmk
         nVSsjhWGUakHycQApaTQkljXiNWWwTefdywAvR1Qfbk114vV3EDG/NYQSt5fPwrIcO
         9ZQ/dnF+b19DTo0DuTZaKVrD5+naBZbMNYePC/NvimmQ11Pt8MoW+nLCvSr7MNnReM
         7pHPlns246EA8YNN0TDtADZdBCLD+pd8L3bTwi17JVFSPiq06XGm8bVTZVCyAIzAXV
         ruv1bXWGnh49DHF9gwEzFLFPITaiV0/o3PDdZCMsldtDxQMEUy/cInFqbk8egMq7D3
         YEfNyfDIWbzWA==
To:     Derrick Stolee <derrickstolee@github.com>
From:   Carl Smedstad <carl.smedstad@protonmail.com>
Cc:     git@vger.kernel.org
Reply-To: Carl Smedstad <carl.smedstad@protonmail.com>
Subject: Re: [PATCH] check-ignore: --non-matching without --verbose
Message-ID: <qzzAQ1fG52vlhFocoEqahGa8X0FRYpdAzxAHP6NwLXvMFuu0eZQzoa2ew3b1I31puAx__Cr3I2EZObON40rN0UWKT_rSXY3F0tuPqmh2aNc=@protonmail.com>
In-Reply-To: <362128ff-690d-8dc1-88fd-620f52b14d54@github.com>
References: <pull.1236.git.1653310466062.gitgitgadget@gmail.com> <362128ff-690d-8dc1-88fd-620f52b14d54@github.com>
Feedback-ID: 27944746:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> This may be better to indicate the behavior as predicated on the
> existence of --verbose:
>
> =09If `--verbose` is enabled, then all paths are listed along
> =09with an indicator (`::`) that no matching pattern was found.
> =09Without `--verbose`, list only the paths that do not match
> =09any pattern.

Good point. I've adopted you changes but made some slight changes to the fi=
rst
line:

=09If `--verbose` is enabled, list both matching and non-matching
=09paths (non-matching paths along with the indicator `::`). Without
=09`--verbose`, list only the paths that do not match any pattern.

> These three blocks all call the same code line. So really you want
> to avoid a single case:
>
> =09if (!quiet &&
> =09    ((verbose && (show_non_matching || pattern)) ||
> =09     (!verbose && !!show_non_matching !=3D !!pattern)))
>
> This is the most direct way to write what you had above. However,
> we could do this more simply:
>
> =09/* If --non-matching, then show if verbose or the pattern is missing. =
*/
> =09if (!quiet && show_non_matching && (verbose || !pattern))
> =09=09output_pattern(...);
>
> =09/* If not --non-matching, then show if the pattern exists. */
> =09if (!quiet && !show_non_matching && pattern)
> =09=09output_pattern(...);
>
> Hopefully that's a bit easier to parse. I believe it is
> equivalent.

That is indeed equivalent and a lot easier to read. Implemented the changes=
 in
full. Thanks!
