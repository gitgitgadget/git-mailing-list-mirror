Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 378F11F453
	for <e@80x24.org>; Thu, 24 Jan 2019 18:38:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726015AbfAXSiW (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Jan 2019 13:38:22 -0500
Received: from kitenet.net ([66.228.36.95]:54882 "EHLO kitenet.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725909AbfAXSiW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jan 2019 13:38:22 -0500
X-Question: 42
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=joeyh.name; s=mail;
        t=1548355091; bh=+1CRzM2GinLT7rZoJNT3bvi/i6O1lNV04+VHljotNjc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m/JgAmHXtAwabkxHapY40LqM7oxjEZIIVg9k5u0PatdlKjRc8Ists077cGr4lemJA
         3vyqhAogdHr7bUp5aSyWj+nf3tzo6LDAqqYZXglFXG0Q7998q8ZAOrRXRQs6PMbZHg
         gvkWUJvJq/VYVuySyB8BMIyDh+moMTPj/7bmENY0=
Date:   Thu, 24 Jan 2019 14:38:10 -0400
From:   Joey Hess <id@joeyh.name>
To:     Jeff King <peff@peff.net>
Cc:     git <git@vger.kernel.org>
Subject: Re: git status OOM on mmap of large file
Message-ID: <20190124183810.GC29200@kitenet.net>
References: <20190122220714.GA6176@kitenet.net>
 <20190124121037.GA4949@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190124121037.GA4949@sigill.intra.peff.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
> Looking at apply_single_file_filter(), it's not the _original_ file that
> it's trying to store, but rather the data coming back from the filter.
> It's just that we use the original file size as a hint!

Thanks much for working that out!

> In other words, I think this patch fixes your problem:
>=20
> diff --git a/convert.c b/convert.c
> index 0d89ae7c23..85aebe2ed3 100644
> --- a/convert.c
> +++ b/convert.c
> @@ -732,7 +732,7 @@ static int apply_single_file_filter(const char *path,=
 const char *src, size_t le
>  	if (start_async(&async))
>  		return 0;	/* error was already reported */
> =20
> -	if (strbuf_read(&nbuf, async.out, len) < 0) {
> +	if (strbuf_read(&nbuf, async.out, 0) < 0) {
>  		err =3D error(_("read from external filter '%s' failed"), cmd);
>  	}
>  	if (close(async.out)) {

Yes, confirmed that does fix it.

> though possibly we should actually continue to use the file size as a
> hint up to a certain point, which avoids reallocations for more "normal"
> filters where the input and output sizes are in the same ballpark.
>=20
> Just off the top of my head, something like:
>=20
>   /* guess that the filtered output will be the same size as the original=
 */
>   hint =3D len;
>=20
>   /* allocate 10% extra in case the clean size is slightly larger */
>   hint *=3D 1.1;
>=20
>   /*
>    * in any case, never go higher than half of core.bigfileThreshold.
>    * We'd like to avoid allocating more bytes than that, and that still
>    * gives us room for our strbuf to preemptively double if our guess is
>    * just a little on the low side.
>    */
>   if (hint > big_file_threshold / 2)
> 	hint =3D big_file_threshold / 2;
>=20
> But to be honest, I have no idea if that would even produce measurable
> benefits over simply growing the strbuf from scratch (i.e., hint=3D=3D0).

Half of 512 MB is still quite a lot of memory to default to using in
this situation. Eg smaller VPS's still often only have a GB or two of ram.

When the clean filter is being used in a way that doesn't involve hashes
of large files, it will mostly be operating on typically sized source
code files. So capping the maximum hint size around the size of a typical
source code file would be plenty for both common cases for the clean filter.

I did some benchmarking, using cat as the clean filter:

git status 32 kb file, hint =3D=3D len
   time                 3.865 ms   (3.829 ms .. 3.943 ms)
                        0.994 R=C2=B2   (0.987 R=C2=B2 .. 0.999 R=C2=B2)
   mean                 3.934 ms   (3.889 ms .. 4.021 ms)
   std dev              191.8 =CE=BCs   (106.8 =CE=BCs .. 291.8 =CE=BCs)
git status 32 kb file, hint =3D=3D 0
   time                 3.887 ms   (3.751 ms .. 4.064 ms)
                        0.992 R=C2=B2   (0.986 R=C2=B2 .. 0.998 R=C2=B2)
   mean                 4.002 ms   (3.931 ms .. 4.138 ms)
   std dev              292.2 =CE=BCs   (189.0 =CE=BCs .. 498.3 =CE=BCs)
git status 1 mb file, hint =3D=3D len
   time                 3.942 ms   (3.816 ms .. 4.078 ms)
                        0.995 R=C2=B2   (0.991 R=C2=B2 .. 0.999 R=C2=B2)
   mean                 3.969 ms   (3.916 ms .. 4.054 ms)
   std dev              220.1 =CE=BCs   (155.1 =CE=BCs .. 304.3 =CE=BCs)
git status 1 mb file, hint =3D=3D 0
   time                 3.869 ms   (3.836 ms .. 3.911 ms)
                        0.998 R=C2=B2   (0.995 R=C2=B2 .. 1.000 R=C2=B2)
   mean                 3.895 ms   (3.868 ms .. 3.947 ms)
   std dev              112.3 =CE=BCs   (47.93 =CE=BCs .. 182.7 =CE=BCs)
git status 1 gb file, hint =3D=3D len
   time                 7.173 s    (6.834 s .. 7.564 s)
                        0.999 R=C2=B2   (0.999 R=C2=B2 .. 1.000 R=C2=B2)
   mean                 7.560 s    (7.369 s .. 7.903 s)
   std dev              333.2 ms   (27.65 ms .. 412.2 ms)
git status 1 gb file, hint =3D=3D 0
   time                 7.652 s    (6.307 s .. 8.263 s)
                        0.996 R=C2=B2   (0.992 R=C2=B2 .. 1.000 R=C2=B2)
   mean                 8.082 s    (7.843 s .. 8.202 s)
   std dev              232.3 ms   (2.362 ms .. 277.1 ms)

=46rom this, it looks like the file has to be quite large before the
preallocation makes a sizable improvement to runtime, and the
smudge/clean filters have to be used for actual content filtering
(not for hash generation purposes as git-annex and git-lfs use it).
An unusual edge case I think. So hint =3D=3D 0 seems fine.

--=20
see shy jo
