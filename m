From: Wincent Colaiuta <win@wincent.com>
Subject: Re: git-daemon breakage in 1.5.4
Date: Wed, 6 Feb 2008 12:39:36 +0100
Message-ID: <57A122D1-6D7E-4210-A624-75D19ECC0258@wincent.com>
References: <BE051395-F4E1-428B-89B3-5D01BEA42C71@wincent.com> <7vr6fr9noj.fsf@gitster.siamese.dyndns.org> <C8E50E14-B50F-4385-A581-B69262E8E6A5@wincent.com> <47A98092.2070509@viscovery.net> <27E0A387-5A6B-4577-AAF4-ACE65A24E306@wincent.com> <47A98BD9.5040306@viscovery.net>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	git mailing list <git@vger.kernel.org>,
	Scott R Parish <sRp@srparish.net>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Feb 06 12:42:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMiew-0003fF-GD
	for gcvg-git-2@gmane.org; Wed, 06 Feb 2008 12:41:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757927AbYBFLlI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Feb 2008 06:41:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753627AbYBFLlH
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Feb 2008 06:41:07 -0500
Received: from wincent.com ([72.3.236.74]:60675 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757757AbYBFLlG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Feb 2008 06:41:06 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id m16Bdeku023161;
	Wed, 6 Feb 2008 05:39:41 -0600
In-Reply-To: <47A98BD9.5040306@viscovery.net>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72803>

El 6/2/2008, a las 11:28, Johannes Sixt escribi=F3:

>>> Which makes me think that you xinetd doesn't pass a PATH to git-=20
>>> daemon
>>> that includes /usr/local/bin. Add this to your /etc/xinetd.d/git:
>>>
>>>   env =3D PATH=3D/bin:/usr/bin:/usr/local/bin
>>>
>>> (not tested).
>>
>> That works. Thanks.
>>
>> It's an acceptable workaround (the other is installing /usr instead =
=20
>> of
>> /usr/local). Seeing as it worked in 1.5.3.8, does this qualify as
>> breakage, or should we not worry about it?
>
> Does this patch make a difference? (It does for me.)

Nope. I applied this on top of "maint", removed the PATH setup from /=20
etc/xinetd.d/git, and get the "remote end hung up unexpectedly" again. =
=20
If I restore the PATH setup then it works, but then, so does does 1.5.4=
=2E

Cheers,
Wincent

> diff --git a/daemon.c b/daemon.c
> index 41a60af..c99285e 100644
> --- a/daemon.c
> +++ b/daemon.c
> @@ -1026,6 +1026,7 @@ int main(int argc, char **argv)
> 	struct group *group;
> 	gid_t gid =3D 0;
> 	int i;
> +	char *cmd_path =3D strdup(argv[0]), *slash;
>
> 	/* Without this we cannot rely on waitpid() to tell
> 	 * what happened to our children.
> @@ -1184,6 +1185,13 @@ int main(int argc, char **argv)
> 	if (strict_paths && (!ok_paths || !*ok_paths))
> 		die("option --strict-paths requires a whitelist");
>
> +	slash =3D strrchr(cmd_path, '/');
> +	if (slash) {
> +		*slash =3D 0;
> +		setup_path(cmd_path);
> +	}
> +	free(cmd_path);
> +
> 	if (inetd_mode) {
> 		struct sockaddr_storage ss;
> 		struct sockaddr *peer =3D (struct sockaddr *)&ss;
