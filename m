From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] setup_revisions(): do not access outside argv
Date: Wed, 20 May 2009 18:58:41 -0700
Message-ID: <7v7i0btdwu.fsf@alter.siamese.dyndns.org>
References: <1242806900-3499-1-git-send-email-pclouds@gmail.com>
	<4A13BC3C.5070000@viscovery.net>
	<fcaeb9bf0905200123r3649a7e5vc40ece402379e701@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 21 03:58:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6xYh-0005qO-5Q
	for gcvg-git-2@gmane.org; Thu, 21 May 2009 03:58:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754483AbZEUB6l convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 May 2009 21:58:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753805AbZEUB6l
	(ORCPT <rfc822;git-outgoing>); Wed, 20 May 2009 21:58:41 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:44561 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753739AbZEUB6k (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 May 2009 21:58:40 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090521015841.FMWL20430.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Wed, 20 May 2009 21:58:41 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id u1yh1b00H4aMwMQ041yhmW; Wed, 20 May 2009 21:58:41 -0400
X-Authority-Analysis: v=1.0 c=1 a=i0WuDx7MCDMA:10 a=CyN2yqzJZ20A:10
 a=pGLkceISAAAA:8 a=fv-XvKvnAAAA:8 a=UPoPOXdqmAl_iPotR7kA:9
 a=EXerjN5_2_X_jWbEqDKAf3S0oJ8A:4 a=MSl-tDqOz04A:10 a=l9rlz7MJbUIA:10
X-CM-Score: 0.00
In-Reply-To: <fcaeb9bf0905200123r3649a7e5vc40ece402379e701@mail.gmail.com> (Nguyen Thai Ngoc Duy's message of "Wed\, 20 May 2009 18\:23\:27 +1000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119646>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> 2009/5/20 Johannes Sixt <j.sixt@viscovery.net>:
>> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy schrieb:
>>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@g=
mail.com>
>>> ---
>>>  revision.c |    4 ++--
>>>  1 files changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/revision.c b/revision.c
>>> index 18b7ebb..be1e307 100644
>>> --- a/revision.c
>>> +++ b/revision.c
>>> @@ -1241,9 +1241,9 @@ int setup_revisions(int argc, const char **ar=
gv, struct rev_info *revs, const ch
>>>               if (strcmp(arg, "--"))
>>>                       continue;
>>>               argv[i] =3D NULL;
>>> -             argc =3D i;
>>> -             if (argv[i + 1])
>>> +             if (i + 1 < argc && argv[i + 1])
>>>                       revs->prune_data =3D get_pathspec(revs->prefi=
x, argv + i + 1);
>>> +             argc =3D i;
>>>               seen_dashdash =3D 1;
>>>               break;
>>>       }
>>
>> Why is this necessary? I'd expect that argv arrays have NULL at the =
end.
>
> I have no idea. I hit this "bug" in my builtin-rebase.c and had that
> question too. But I grepped through and saw that
> at least verify_bundle() does not terminate argv with NULL. So I
> assume that setup_revisions() does not expect NULL at the end.

If a function takes (int ac, char **av), then people should be able to
depend on the usual convention of

 (1) for any i < ac, av[i] is not NULL; and
 (2) av[ac] is NULL.

With your patch, a broken caller's wish is simply discarded and nobody
will notice.  Without your patch, at least you will know that the calle=
r
passed an inconsistent pair of ac and av to this function by seeing a
coalmine canary segfault.

I would not mind a patch that adds an assertion that protects this
function from broken callers, so that we can find them, but your patch
makes me feel very uneasy.
