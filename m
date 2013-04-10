From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH] test-lint-duplicates: Only check for numbered test cases
Date: Wed, 10 Apr 2013 16:14:34 +0200
Message-ID: <516573CA.2000804@web.de>
References: <201304030754.03100.tboegi@web.de> <20130403142804.GB10494@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 10 16:14:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPvnb-0004U2-0J
	for gcvg-git-2@plane.gmane.org; Wed, 10 Apr 2013 16:14:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936820Ab3DJOOu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Apr 2013 10:14:50 -0400
Received: from mout.web.de ([212.227.17.12]:49868 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936252Ab3DJOOt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Apr 2013 10:14:49 -0400
Received: from [192.168.209.26] ([195.67.191.23]) by smtp.web.de (mrweb101)
 with ESMTPA (Nemesis) id 0MKa6N-1UP6iK0sg3-001TNI; Wed, 10 Apr 2013 16:14:35
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <20130403142804.GB10494@sigill.intra.peff.net>
X-Provags-ID: V02:K0:BxUFrUqZizLWJuvZdM9Hqw3Zq+CltXkWh3O7Zv364pC
 DXO5z0fF+Oau4v9IrsvJ70+IjqwJmIfTFUGO79b5t7jMSBLTVp
 RtFoYGZZKpCx6//wLr2sTzaTR0j0sJfTAl+JMXON0eStaJjNEa
 R7YZ7UomhTYbeH1bQXQxUONqunEu6BxSSZRGZu9ZnBfAZU6Y4l
 xlHrmCJuF8nIR8QoS0/eg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220690>

On 03.04.13 16:28, Jeff King wrote:
> On Wed, Apr 03, 2013 at 07:54:02AM +0200, Torsten B=C3=B6gershausen w=
rote:
>=20
>> Running make inside contrib/remote-helpers fails in "test-lint-dupli=
cates"
>>
>> This was because the regexp checking for duplicate numbers strips ev=
erything
>> after the first "-" in the filename, including the prefix.
>>
>> As a result, 2 pathnames like
>> "xxxx/contrib/remote-helpers/test-bzr.sh" and
>> "xxxx/contrib/remote-helpers/test-hg-bidi.sh"
>>
>> are both converted into
>> "xxxx/contrib/remote", and reported as duplicate.
>>
>> Improve the regexp:
>> Remove everything after tNNNN- (where X stand for a digit)
>=20
> I think the approach to just make test-lint-duplicates a no-op on
> non-numbered tests is reasonable, but this is side-stepping half of t=
he
> issue. The problems are:
>=20
>   1. We do not have numbers in our test names.
>=20
>   2. We _do_ have full paths in the test names, which might have
>      elements which look like test script names.
>=20
> Your patch tightens the match so that a hyphen in the path name does =
not
> confuse our script. But it trades it for being confused by tNNNN in t=
he
> pathname. Which is admittedly less likely, but is not addressing the
> fundamental issues that we should only be processing basenames.
>=20
> So something like "sed 's,.*/,,'" would fix that. But that still leav=
es
> us with a bunch of tests called "test-foo", "test-bar", etc, which wi=
ll
> appear as duplicates. So we would still want to tighten the number
> parsing.
>=20
> Like:
>=20
> diff --git a/t/Makefile b/t/Makefile
> index 5c6de81..e5afa4c 100644
> --- a/t/Makefile
> +++ b/t/Makefile
> @@ -47,7 +47,9 @@ test-lint-duplicates:
>  test-lint: test-lint-duplicates test-lint-executable
> =20
>  test-lint-duplicates:
> -	@dups=3D`echo $(T) | tr ' ' '\n' | sed 's/-.*//' | sort | uniq -d` =
&& \
> +	@dups=3D`echo $(T) | tr ' ' '\n' | \
> +		sed -e 's,.*/,,' -e 's/\(t[0-9][0-9][0-9][0-9]\)-.*/\1/' | \
> +		sort | uniq -d` && \
>  		test -z "$$dups" || { \
>  		echo >&2 "duplicate test numbers:" $$dups; exit 1; }
> =20
>=20
> -Peff
I thinkg we need both the striping of the path and the "grepping" for
numbered test cases only.
I'll send a patch in a minute
