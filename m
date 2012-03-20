From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Use SSH key from `GIT_SSH_KEY` variable if supplied
Date: Mon, 19 Mar 2012 18:55:06 -0700
Message-ID: <7vhaxk829x.fsf@alter.siamese.dyndns.org>
References: <1332207557-10965-1-git-send-email-me@mmalecki.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Maciej =?utf-8?Q?Ma=C5=82ecki?= <me@mmalecki.com>
X-From: git-owner@vger.kernel.org Tue Mar 20 02:55:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S9oIC-0003Z2-Cy
	for gcvg-git-2@plane.gmane.org; Tue, 20 Mar 2012 02:55:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758794Ab2CTBzM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 19 Mar 2012 21:55:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59136 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756745Ab2CTBzL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Mar 2012 21:55:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CF0B462B3;
	Mon, 19 Mar 2012 21:55:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=qKqRAp7UGGO9
	12j4tG3d6xHJW8M=; b=hj9XWbydnPiTQZZ3AocqwP6VSXZKOOwz4uqS/4u2yy4B
	acFp6orZhg0Jc91ZD0X8DOrFEsJ6vae+hg9E/wGEWN/607tWtfASev4IaHFbWpL6
	a+TG8BMt6j3GR33xpKMHzj8S1zHu0F3q5xUG4A4REQZBcVe/XwEcLXgks1pmKNM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=eNeTJA
	fDpc3j95+/sClmj1qMhm5LONsHhKUKiWzwPVw0xKAWUAXk/oTPo4KUIiOleaPO8Y
	aaYu3Bzo3N/V4jtwe9XZlKlvAg6m6qF5He/nYDDiwnE+Ht7ARsekt4m0OWF9472R
	4ptO8zv83ekXdp2kglbuQ8Iu2JCk47mnbz+pI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C153162B2;
	Mon, 19 Mar 2012 21:55:09 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 40E6362B1; Mon, 19 Mar 2012
 21:55:08 -0400 (EDT)
In-Reply-To: <1332207557-10965-1-git-send-email-me@mmalecki.com> ("Maciej
 =?utf-8?Q?Ma=C5=82ecki=22's?= message of "Tue, 20 Mar 2012 02:39:17 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B887D8E4-722F-11E1-B74A-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193477>

Maciej Ma=C5=82ecki <me@mmalecki.com> writes:

>  	if (protocol =3D=3D PROTO_SSH) {
> +		const char *key;
>  		const char *ssh =3D getenv("GIT_SSH");
>  		int putty =3D ssh && strcasestr(ssh, "plink");
>  		if (!ssh) ssh =3D "ssh";
> @@ -589,6 +590,13 @@ struct child_process *git_connect(int fd[2], con=
st char *url_orig,
>  			*arg++ =3D putty ? "-P" : "-p";
>  			*arg++ =3D port;
>  		}
> +
> +		key =3D getenv("GIT_SSH_KEY");
> +		if (key) {
> +			*arg++ =3D "-i";
> +			*arg++ =3D key;
> +		}

Hmm. I am somewhat torn.

The minimalist in me finds this extraneous and unnecessary noise.  Why
should the user always set GIT_SSH_KEY environment variable that only
applies to git and does not help his other ssh sessions?  Why isn't hav=
ing
an entry in .ssh/config to name IdentityFile sufficient?

On the other hand, the feature-creepist in me finds this somewhat lacki=
ng.
Why should we give special treatment only to "-i $identity_file" option
[*1*] and not others?  Do we have to invent new environment variables i=
f
we wanted to pass "-c $cipher_spec", "-l $login_name", "-I $pkcs11", "-=
4",
"-6", or "-b $bind_address"?

Would GIT_SSH_ARGS=3D'-i /home/me/.ssh/there.pub -l me' be more appropr=
iate?


[Footnote]

*1* In any case, GIT_SSH_KEY is misnamed.  It should match whatever wor=
d
ssh(1) uses to describe the concept--in this case, it is "identity file=
".
