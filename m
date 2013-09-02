From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Turn off pathspec magic on "{checkout,reset,add} -p"
 on native Windows builds
Date: Mon, 02 Sep 2013 12:41:52 +0200
Message-ID: <52246B70.3080200@viscovery.net>
References: <521EF02A.2020300@viscovery.net> <1378001284-18426-1-git-send-email-pclouds@gmail.com> <5224334A.2090300@viscovery.net> <20130902092959.GA17306@lanh>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Alex Riesen <raa.lkml@gmail.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 02 12:42:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGRa7-00013f-8q
	for gcvg-git-2@plane.gmane.org; Mon, 02 Sep 2013 12:42:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757998Ab3IBKl7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Sep 2013 06:41:59 -0400
Received: from so.liwest.at ([212.33.55.13]:27422 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755687Ab3IBKl6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Sep 2013 06:41:58 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.80.1)
	(envelope-from <j.sixt@viscovery.net>)
	id 1VGRZx-0000Wv-6h; Mon, 02 Sep 2013 12:41:53 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id BD9081660F;
	Mon,  2 Sep 2013 12:41:52 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
In-Reply-To: <20130902092959.GA17306@lanh>
X-Enigmail-Version: 1.5.2
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233632>

Am 9/2/2013 11:30, schrieb Duy Nguyen:
> On Mon, Sep 02, 2013 at 08:42:18AM +0200, Johannes Sixt wrote:
>> Am 9/1/2013 4:08, schrieb Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy:
>>> git-add--interactive.perl rejects arguments with colons in 21e9757
>>> (Hack git-add--interactive to make it work with ActiveState Perl -
>>> 2007-08-01). Pathspec magic starts with a colon, so it won't work i=
f
>>> these pathspecs are passed to git-add--interactive.perl running wit=
h
>>> ActiveState Perl. Make sure we only pass plain paths in this case.
>>>
>>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@g=
mail.com>
>>> ---
>>>  Johannes, can you check the test suite passes for you with this
>>>  patch? I assume that Cygwin Perl behaves differently and does not =
hit
>>>  this limit. So I keep the special case to GIT_WINDOWS_NATIVE only.
>>>  I'll resend the patch with a few others on the same topic if it wo=
rks
>>>  for you.
>>
>> It does not help. The error in git-add--interactive is avoided, but =
the
>> failure in t2016-checkout-patch.sh is now:
>>
>> expecting success:
>>         set_state dir/foo work head &&
>>         # the third n is to get out in case it mistakenly does not a=
pply
>>         (echo y; echo n; echo n) | (cd dir && git checkout -p foo) &=
&
>>         verify_saved_state bar &&
>>         verify_state dir/foo head head
>>
>> No changes.
>> not ok 13 - path limiting works: foo inside dir
>>
>> and the same "No changes." happens in t7105-reset-patch.sh
>=20
> Right. Because I got rid of ':(prefix)foo' form but I passed 'foo'
> instead of 'dir/foo'. How about this on top?
>=20
> -- 8< --
> diff --git a/builtin/add.c b/builtin/add.c
> index 3402239..a138360 100644
> --- a/builtin/add.c
> +++ b/builtin/add.c
> @@ -257,9 +257,15 @@ int run_add_interactive(const char *revision, co=
nst char *patch_mode,
>  	if (revision)
>  		args[ac++] =3D revision;
>  	args[ac++] =3D "--";
> +#ifdef GIT_WINDOWS_NATIVE
> +	GUARD_PATHSPEC(pathspec, PATHSPEC_FROMTOP);
> +	for (i =3D 0; i < pathspec->nr; i++)
> +		args[ac++] =3D pathspec->items[i].match;
> +#else
>  	for (i =3D 0; i < pathspec->nr; i++)
>  		/* pass original pathspec, to be re-parsed */
>  		args[ac++] =3D pathspec->items[i].original;
> +#endif
> =20
>  	status =3D run_command_v_opt(args, RUN_GIT_CMD);
>  	free(args);
> -- 8< --

With this patch, the two tests pass.

Which features do we lose on Windows with the previous patch and this f=
ixup?

-- Hannes
