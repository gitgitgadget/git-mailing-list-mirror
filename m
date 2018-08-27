Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4667E1F404
	for <e@80x24.org>; Mon, 27 Aug 2018 10:37:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbeH0OXx (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Aug 2018 10:23:53 -0400
Received: from mail180-29.suw31.mandrillapp.com ([198.2.180.29]:50821 "EHLO
        mail180-29.suw31.mandrillapp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726825AbeH0OXx (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 27 Aug 2018 10:23:53 -0400
X-Greylist: delayed 903 seconds by postgrey-1.27 at vger.kernel.org; Mon, 27 Aug 2018 10:23:53 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=mandrill; d=nexedi.com;
 h=From:Subject:To:Cc:Message-Id:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding; i=kirr@nexedi.com;
 bh=NUTj37jtAB2KFb05DuMjcXBoYr2yW2gTFP1qD7jTqak=;
 b=fLZnMzv42Vn6ZMWrmZOF6Pr/UoKapSttqGuxbLNK7C7Dk0NPjjj/bIcaDbzsjCREpRAEqomiuJ4Q
   eEHLr2Wo2Ux4S6fC1fHS5VGnKzrbu0fzKW2n8A3ThpsUDTp8qVfnpxy5KjQxOFyRMoIxb6JyrYpT
   qOhvgpoA05u/UfXN9+o=
Received: from pmta03.mandrill.prod.suw01.rsglab.com (127.0.0.1) by mail180-29.suw31.mandrillapp.com id hgfa7m22sc05 for <git@vger.kernel.org>; Mon, 27 Aug 2018 10:22:46 +0000 (envelope-from <bounce-md_31050260.5b83d0f6.v1-9d1ba2aac1024befbda2539cb29b2cd8@mandrillapp.com>)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com; 
 i=@mandrillapp.com; q=dns/txt; s=mandrill; t=1535365366; h=From : 
 Subject : To : Cc : Message-Id : References : In-Reply-To : Date : 
 MIME-Version : Content-Type : Content-Transfer-Encoding : From : 
 Subject : Date : X-Mandrill-User : List-Unsubscribe; 
 bh=NUTj37jtAB2KFb05DuMjcXBoYr2yW2gTFP1qD7jTqak=; 
 b=Bv1kIPGHP6DN6sU5VJ9GohuJyI4wcOgL4NzJBazMKN7OP5yXVkcXM6wobNiP39bqrjvHER
 wkzuScoIe4gCga4vcH1J0B0pbHgzKhOyBYtmI9CQP4zQm6hcwxSbRDfpVCjHcsYbNh1y8wvL
 YM7CjLAwNJVuhbAuSLZ+YI/6HM/Pg=
From:   Kirill Smelkov <kirr@nexedi.com>
Subject: Re: [PATCH] t5310-pack-bitmaps: fix bogus 'pack-objects to file can use bitmap' test
Received: from [87.98.221.171] by mandrillapp.com id 9d1ba2aac1024befbda2539cb29b2cd8; Mon, 27 Aug 2018 10:22:46 +0000
To:     =?utf-8?Q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Message-Id: <20180827102238.GA26738@deco.navytux.spb.ru>
References: <20180814114721.25577-1-szeder.dev@gmail.com>
In-Reply-To: <20180814114721.25577-1-szeder.dev@gmail.com>
X-Report-Abuse: Please forward a copy of this message, including all headers, to abuse@mandrill.com
X-Report-Abuse: You can also report abuse here: http://mandrillapp.com/contact/abuse?id=31050260.9d1ba2aac1024befbda2539cb29b2cd8
X-Mandrill-User: md_31050260
Date:   Mon, 27 Aug 2018 10:22:46 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 14, 2018 at 01:47:21PM +0200, SZEDER G=C3=A1bor wrote:
> The test 'pack-objects to file can use bitmap' added in 645c432d61
> (pack-objects: use reachability bitmap index when generating
> non-stdout pack, 2016-09-10) is silently buggy and doesn't check what
> it's supposed to.
> 
> In 't5310-pack-bitmaps.sh', the 'list_packed_objects' helper function
> does what its name implies by running:
> 
>   git show-index <"$1" | cut -d' ' -f2
> 
> The test in question invokes this function like this:
> 
>   list_packed_objects <packa-$packasha1.idx >packa.objects &&
>   list_packed_objects <packb-$packbsha1.idx >packb.objects &&
>   test_cmp packa.objects packb.objects
> 
> Note how these two callsites don't specify the name of the pack index
> file as the function's parameter, but redirect the function's standard
> input from it.  This triggers an error message from the shell, as it
> has no filename to redirect from in the function, but this error is
> ignored, because it happens upstream of a pipe.  Consequently, both
> invocations produce empty 'pack{a,b}.objects' files, and the
> subsequent 'test_cmp' happily finds those two empty files identical.
> 
> Fix these two 'list_packed_objects' invocations by specifying the pack
> index files as parameters.  Furthermore, eliminate the pipe in that
> function by replacing it with an &&-chained pair of commands using an
> intermediate file, so a failure of 'git show-index' or the shell
> redirection will fail the test.
> 
> Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
> ---
>  t/t5310-pack-bitmaps.sh | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
> index 6ee4d3f2d9..557bd0d0c0 100755
> --- a/t/t5310-pack-bitmaps.sh
> +++ b/t/t5310-pack-bitmaps.sh
> @@ -9,7 +9,8 @@ objpath () {
>  
>  # show objects present in pack ($1 should be associated *.idx)
>  list_packed_objects () {
> -=09git show-index <"$1" | cut -d' ' -f2
> +=09git show-index <"$1" >object-list &&
> +=09cut -d' ' -f2 object-list
>  }
>  
>  # has_any pattern-file content-file
> @@ -204,8 +205,8 @@ test_expect_success 'pack-objects to file can use bit=
map' '
>  =09# verify equivalent packs are generated with/without using bitmap ind=
ex
>  =09packasha1=3D$(git pack-objects --no-use-bitmap-index --all packa </de=
v/null) &&
>  =09packbsha1=3D$(git pack-objects --use-bitmap-index --all packb </dev/n=
ull) &&
> -=09list_packed_objects <packa-$packasha1.idx >packa.objects &&
> -=09list_packed_objects <packb-$packbsha1.idx >packb.objects &&
> +=09list_packed_objects packa-$packasha1.idx >packa.objects &&
> +=09list_packed_objects packb-$packbsha1.idx >packb.objects &&
>  =09test_cmp packa.objects packb.objects
>  '

Thanks for catching and correcting this.

A minor comment from outside observer: running tests under something
like

=09-e and -o pipefail

would automatically catch the mistake in the first place. Maybe `-o
pipefail` is bashism (I had not checked), but `git grep " | " t/` shows
there are a lot of pipelines being used, and thus similar errors might be
silently resting there. Something like -o pipefail would catch all such
problems automatically.

Kirill

