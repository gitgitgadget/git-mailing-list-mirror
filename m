From: =?UTF-8?B?VMO2csO2ayBFZHdpbg==?= <edwintorok@gmail.com>
Subject: Re: [PATCH] Fix 'git clean' failure on NFS.
Date: Fri, 18 Jun 2010 16:09:58 +0300
Message-ID: <4C1B7026.2010501@gmail.com>
References: <loom.20100618T122039-876@post.gmane.org> <1276859235-13534-1-git-send-email-edwintorok@gmail.com> <4C1B63CB.7080209@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Jun 18 15:10:14 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OPbKn-00034a-9H
	for gcvg-git-2@lo.gmane.org; Fri, 18 Jun 2010 15:10:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761214Ab0FRNKE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Jun 2010 09:10:04 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:47194 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758327Ab0FRNKB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jun 2010 09:10:01 -0400
Received: by fxm10 with SMTP id 10so599570fxm.19
        for <git@vger.kernel.org>; Fri, 18 Jun 2010 06:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:openpgp:content-type:content-transfer-encoding;
        bh=8h1xrmE4FuyyOq70+Kdatbg9XHzjer28EdMH/OCSxdk=;
        b=OflfKG49CLoFE3BjoYSq/AoUEduYYtw6mP9BcET/TsFpW2b0OK52kwqE+hfApmtU6+
         4KwFBinn5NFizPsa4eZD4+K4P9lHwuoCs/lDSrP8iAEg+WmG2nUKreaVCX7It/1W+fnA
         jBpzlaXMNXHKq7qr6N0qqcTodM84fZkIGuCLU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:openpgp:content-type
         :content-transfer-encoding;
        b=uJigj/q0vzAkVULCtpreB1vZx51SJ0fTlZyKKhyQdT9gLIVEc9GzkX7XIa45IbpZAL
         XakWW29WZ6Q1b8HOkJgFUg5dK8Y7VibtTiMkUw02Ta6LlgiG4zJqaTB8UkZ6dOKxteey
         HsjqCFE03DS+9z/7jjsyNk4CK9mBQwm4mg3Sk=
Received: by 10.223.67.144 with SMTP id r16mr824143fai.102.1276866600194;
        Fri, 18 Jun 2010 06:10:00 -0700 (PDT)
Received: from debian ([79.114.67.113])
        by mx.google.com with ESMTPS id o19sm17334576fal.47.2010.06.18.06.09.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 18 Jun 2010 06:09:59 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by debian (Postfix) with ESMTP id 1A9C626D58;
	Fri, 18 Jun 2010 16:09:58 +0300 (EEST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9) Gecko/20100515 Icedove/3.0.4
In-Reply-To: <4C1B63CB.7080209@viscovery.net>
X-Enigmail-Version: 1.0.1
OpenPGP: id=5379965D
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149345>

On 06/18/2010 03:17 PM, Johannes Sixt wrote:
> Am 6/18/2010 13:07, schrieb T=C3=B6r=C3=B6k Edwin:
>>  		else if (S_ISDIR(st.st_mode)) {
>> -			if (!remove_dir_recursively(path, only_empty))
>> +			if (!remove_dir_recursively(path, only_empty)) {
>> +				did_rm =3D 1;
>>  				continue; /* happy */
>=20
> Is it possible that remove_dir_recursively exits with 0, but it actua=
lly
> did not remove the directory? That would result in an endless loop: i=
t
> would have to re-enter remove_dir_recursively on the next iteration,
> return 0 again (without removing the directory), next iteration, etc.

Hmm, I think this could cause problems:
	if ((flag & REMOVE_DIR_KEEP_NESTED_GIT) &&
	    !resolve_gitlink_ref(path->buf, "HEAD", submodule_head))
		/* Do not descend and nuke a nested git work tree. */
		return 0;

What if we limit the amount of times you can loop?
The worst case is that you loop =3D=3D number of files in the directory=
, if
you loop more times than we could break out early.

Or we can compare the number of files listed in one pass, and in
another. If they stay equal, we can break out (since we'd infloop), if
it is higher (new files added) or lower (successfully removed some) we
can keep looping.

How does that sound?

--Edwin
