From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 08/19] completion: use $__git_dir instead of $(__gitdir)
Date: Wed, 09 May 2012 12:43:33 -0700
Message-ID: <7vaa1hrvh6.fsf@alter.siamese.dyndns.org>
References: <1336524290-30023-1-git-send-email-szeder@ira.uka.de>
 <1336524290-30023-9-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Wed May 09 21:43:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSCnV-0006Tf-5b
	for gcvg-git-2@plane.gmane.org; Wed, 09 May 2012 21:43:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757178Ab2EITng convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 May 2012 15:43:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58834 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752437Ab2EITng convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 May 2012 15:43:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 961AF8A39;
	Wed,  9 May 2012 15:43:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=8VsFk6KfI22v
	aCxJbwhX9/gLYLU=; b=H8ad13juo/dukIjIOo5fsovY6JHyONpmrsFZMbGXzdse
	sQov5fHpl/Davcmirp+gldgqg4gVgV3qWryUf4vxu9t/8Aj7+U3Gvnd5tT0echJB
	BpoZ2HcYw4WBGwsNwcbHCtygDuuZ6ng7mdHU87Bi6Ldm0OQVRJT0N7co8eMLjHo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=o674Qp
	voek6i+h9PeFcWqETg4c4qLzdn7Ma1wTH+TAWwJgl0ybcF9fWpnOMWlLIezpUx0l
	pUPhOcJ4ioa3K0L7XQFBG5/HfHliclF9Aubzk1xMzq/4M6LIPFvbJThznG4Cab39
	nJUEotFuvKcoN6xZxaafTWE1QfdPLt1yWJnhs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8C3758A37;
	Wed,  9 May 2012 15:43:35 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0804E8A35; Wed,  9 May 2012
 15:43:34 -0400 (EDT)
In-Reply-To: <1336524290-30023-9-git-send-email-szeder@ira.uka.de> ("SZEDER
 =?utf-8?Q?G=C3=A1bor=22's?= message of "Wed, 9 May 2012 02:44:39 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 43CBA7C6-9A0F-11E1-9E49-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197497>

SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:

> +	__gitdir >/dev/null

If this becomes the only call site of __gitdir helper function (and tha=
t
was the way I read the log message), it would be sane to rename it to
a more descriptive __setup_dash_dash_git_dir function and lose the need=
 to
redirect its output, no?

> @@ -962,7 +967,8 @@ __git_aliases ()
>  # __git_aliased_command requires 1 argument
>  __git_aliased_command ()
>  {
> -	local word cmdline=3D$(git --git-dir=3D"$(__gitdir)" \
> +	__gitdir >/dev/null
> +	local word cmdline=3D$(git --git-dir=3D"$__git_dir" \
>  		config --get "alias.$1")
>  	for word in $cmdline; do
>  		case "$word" in

Now this worries me.  The way I read 07/19 was that the local __git_dir=
=3D""
declarations in __git_ps1 and __git were what protected this whole
machinery to protect us against surprises from user doing "cd" between
interactive commands, but you have the same __gitdir call to set up the
global $__git_dir variable there, without the initialization to "".

Having to have a call to __gitdir seems to indicate to me that you cann=
ot
assume that the other initialization sites may not have been called bef=
ore
we get to this point.  Then why is 'local __git_dir=3D""' unneeded here=
?
