Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92E661F461
	for <e@80x24.org>; Fri, 17 May 2019 00:10:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727393AbfEQAKM (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 May 2019 20:10:12 -0400
Received: from resqmta-ch2-02v.sys.comcast.net ([69.252.207.34]:41802 "EHLO
        resqmta-ch2-02v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726523AbfEQAKM (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 16 May 2019 20:10:12 -0400
X-Greylist: delayed 488 seconds by postgrey-1.27 at vger.kernel.org; Thu, 16 May 2019 20:10:12 EDT
Received: from resomta-ch2-16v.sys.comcast.net ([69.252.207.112])
        by resqmta-ch2-02v.sys.comcast.net with ESMTP
        id RJSNhwRTzB4iYRQK3hMmKw; Fri, 17 May 2019 00:02:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=20190202a; t=1558051323;
        bh=uVVYddpr9FOEzHH/A/aGdsISkPydASzK1H6n0L4Yd/g=;
        h=Received:Received:Content-Type:Mime-Version:Subject:From:Date:
         Message-Id:To;
        b=GYQLC2506IAACC4fCKAL6NeEhMGpCJN5gS93BIMPtyBqZPJlJxI2nOAI9NZiJmpON
         uIijP4B7zvDy1xQg9Y+5AjST8JWtPPF6P9EZDQqj09aez0vb8wbW2z9UzfRNIFBXfm
         bKmkah6syznyQXzdjxfclZs0QQW2ZZjXS6ppbKDCQAMkwH0gsyyGaXo65wjk2IG75Y
         ypouObhshetnTOjF2MeqEV2zgi8J4jZtprqwXTNxbUoOuoexnso2mJQMxMvvDUyro/
         auUO2GOmE5paijfpjxeEDR6djlPj6hovBMrR6mQrwlQ5GsVvknCLVXWYBRY1iMLI08
         IWG75V8U8+2VA==
Received: from [IPv6:2620::100e:913:f5a7:cfbe:d129:9d11] ([IPv6:2620:0:100e:913:f5a7:cfbe:d129:9d11])
        by resomta-ch2-16v.sys.comcast.net with ESMTPA
        id RQJoh6dkwNwSxRQJthDpNG; Fri, 17 May 2019 00:02:01 +0000
X-Xfinity-VMeta: sc=0;st=legit
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [RFC PATCH 0/3] implement composite filters
From:   Matthew DeVore <matvore@comcast.net>
In-Reply-To: <20190516224150.243395-1-jonathantanmy@google.com>
Date:   Thu, 16 May 2019 17:01:48 -0700
Cc:     matvore@google.com, git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <740617F3-9C9F-4F1D-86F7-1A129C7F3F3D@comcast.net>
References: <cover.1558030802.git.matvore@google.com>
 <20190516224150.243395-1-jonathantanmy@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



> On 2019/05/16, at 15:41, Jonathan Tan <jonathantanmy@google.com> =
wrote:
>=20
> Thanks - seeing these patches reduces my concerns significantly. A

Thank you for taking a look :)

>=20
> - LOFR_MARK_SEEN is tracked for LHS and RHS separately. To support an
>  arbitrary number of filters, we don't use object flags to track this,
>  so we use oidsets instead. I don't think that the extra memory usage
>  will be a problem (we already allocate more for all the struct
>  object). If this is an issue in the future, we can switch to using
>  object flags for the first N filters, and oidsets thereafter.

Yup. Another possibility that comes to mind is that when both the lhs =
and rhs seen sets contain the same object, we promote it to a combined =
set, and remove it from the individual ones at that time.

>=20
> - LOFR_SKIP_TREE is simulated if only one filter wants to skip the =
tree.
>=20
> - I haven't fully figured out LOFR_DO_SHOW yet. It seems to me that if
>  an object appears twice in the walk, and the LHS says LOFR_DO_SHOW on
>  the first occurrence, if the RHS says LOFR_DO_SHOW on the second
>  occurrence, the object will be shown twice. But perhaps this isn't a

LOFR_DO_SHOW is only propagated upward from the combine: filter if both =
children indicate LOFR_DO_SHOW for the same object at the same point in =
the traversal (see the line that has "combined_result |=3D =
LOFR_DO_SHOW"). In the scenario you draw out, the object won=E2=80=99t =
be shown at all, since the first occurrence is filtered out for one =
reason, and the second is filtered out for a separate reason. This may =
happen when a sparse: filter includes a "deep" blob but excludes the =
same blob at a shallower point in the tree, and a tree: filter does the =
opposite with the same blob. Just thinking about it now for a moment, =
this seems intuitive and reasonable.

