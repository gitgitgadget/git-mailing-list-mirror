From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] Add a commit.signoff configuration option to always
 use --signoff in commit
Date: Tue, 30 Dec 2008 13:04:13 -0800
Message-ID: <7v4p0l1ik2.fsf@gitster.siamese.dyndns.org>
References: <20081227120128.GA11322@chistera.yi.org>
 <1230549405-10000-1-git-send-email-dato@net.com.org.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Adeodato =?utf-8?Q?Sim=C3=B3?= <dato@net.com.org.es>
X-From: git-owner@vger.kernel.org Tue Dec 30 22:06:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHlmk-0005My-QL
	for gcvg-git-2@gmane.org; Tue, 30 Dec 2008 22:05:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752124AbYL3VEV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 30 Dec 2008 16:04:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752002AbYL3VEV
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Dec 2008 16:04:21 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:44572 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751566AbYL3VEU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 Dec 2008 16:04:20 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 7111B1B675;
	Tue, 30 Dec 2008 16:04:20 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 3537C1B673; Tue,
 30 Dec 2008 16:04:15 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 6D709076-D6B5-11DD-88AB-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104207>

Adeodato Sim=C3=B3 <dato@net.com.org.es> writes:

> diff --git a/builtin-revert.c b/builtin-revert.c
> index d48313c..395c7a5 100644
> --- a/builtin-revert.c
> +++ b/builtin-revert.c
> @@ -429,6 +429,8 @@ static int revert_or_cherry_pick(int argc, const =
char **argv)
>  		args[i++] =3D "-n";
>  		if (signoff)
>  			args[i++] =3D "-s";
> +		else
> +			args[i++] =3D "--no-signoff";
>  		if (!edit) {
>  			args[i++] =3D "-F";
>  			args[i++] =3D defmsg;

Introduction of --no-commit to "git commit" is absolutely necessary for
interactive users if we were to introduce commit.signoff, but I am not
sure about this change and similar ones given to the other Porcelain
commands that use "git commit".  They actually started making me think
that commmit.signoff might be more trouble than it is worth.

It is plausible that your workflow is to have others push to your 'mob'
branch and integrating good bits from there by cherry-picking, sort of
like using the 'mob' branch as if they are e-mailed patches.  In such a
setup, if you are so forgetful to type "-s" for your commit that you wo=
uld
want commit.signoff configuration, you would likely to be equally
forgetful to type "-s" for your cherry-pick, and would want to have som=
e
configuration affect how this part of the code works.

I however moderately doubt if the complexity and flexibility of having
rebase.signoff, revert.signoff, and cherry-pick.signoff as independent
options is worth it.  I am inclined to think that is too many knobs to
tweak, and it is far simpler to understand and easier to explain if the
single configuration, commit.signoff, applied to every Porcelain that
creates commits.

If we were to go that route, instead of passing --no-signoff when they
invoke "git commit", these commands need to take their own --no-signoff
option instead, and when neither --signoff nor --no-signoff is given, t=
hey
just should just invoke "git commit" and let it use the config (if set)=
=2E
