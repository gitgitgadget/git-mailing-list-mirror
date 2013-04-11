From: Junio C Hamano <gitster@pobox.com>
Subject: Re: regression: "96b9e0e3 config: treat user and xdg config
 permission problems as errors" busted git-daemon
Date: Thu, 11 Apr 2013 08:35:46 -0700
Message-ID: <7vwqs9jd0t.fsf@alter.siamese.dyndns.org>
References: <1365572015.4658.51.camel@marge.simpson.net>
 <20130410135605.GB4694@odin.tremily.us>
 <1365651583.19620.8.camel@marge.simpson.net>
 <20130411054207.GE27795@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mike Galbraith <bitbucket@online.de>,
	"W. Trevor King" <wking@tremily.us>, git <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 11 17:36:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQJXX-00034c-Vs
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 17:35:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936515Ab3DKPfv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Apr 2013 11:35:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63010 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936478Ab3DKPfu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Apr 2013 11:35:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 75E4D131E5;
	Thu, 11 Apr 2013 15:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Nn/uuGC4WE31pLA5pKHZartkVm8=; b=TmSD5t
	pkkxszrRYUfvtip/QH6itKfN/xYpOXDc78OdfglI0GvvMxfrdQTEtyIqmt+n1Fkr
	GdCtBz8HMo4G/ouCJWSAQqaiD+1XYIhdI37+w0GwfQiac6ShYCq3eqT5Uu1m2SmY
	99vL8COr/KisU6xUlRA4rswxeQD1nmknH7vvE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=L52Z8uNNy1rw19cTpio0PGjlIxYmQPqS
	Ug9UmAqFjI3BppMYqCvpN2ZjQCvplJn9+TDDyu7Nid4qxSJ/i5j69pS9Z5fSLAfd
	Xv/MuDcbqBLMSThVV8s/9H51O2rDdgqjy4bmupskczTiK6e5yAXQUQrcxCw1j351
	y1OIKL48vO8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6D2E4131E4;
	Thu, 11 Apr 2013 15:35:49 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C7800131E2; Thu, 11 Apr
 2013 15:35:48 +0000 (UTC)
In-Reply-To: <20130411054207.GE27795@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 11 Apr 2013 01:42:07 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7C0D2FDA-A2BD-11E2-B9BF-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220883>

Jeff King <peff@peff.net> writes:

> On Thu, Apr 11, 2013 at 05:39:43AM +0200, Mike Galbraith wrote:
>
>> >   ALLOWED_ENV="PATH HOME"
>> >   HOME=/
>> 
>> I can work around it by changing the init script to use su - git -c "bla
>> bla" to launch the thing, instead of using --user=git --group=daemon,
>> but that's just a bandaid for the busted environment setup those
>> switches were supposed to make happen, no?
>
> Yeah, I think the bug here is that git-daemon should be setting $HOME
> when it switches privileges with --user. Does this patch fix it for you?
>
> diff --git a/daemon.c b/daemon.c
> index 6aeddcb..a4451fd 100644
> --- a/daemon.c
> +++ b/daemon.c
> @@ -1091,6 +1091,7 @@ static void drop_privileges(struct credentials *cred)
>  	if (cred && (initgroups(cred->pass->pw_name, cred->gid) ||
>  	    setgid (cred->gid) || setuid(cred->pass->pw_uid)))
>  		die("cannot drop privileges");
> +	setenv("HOME", cred->pass->pw_dir, 1);
>  }
>  
>  static struct credentials *prepare_credentials(const char *user_name,

Yeah, that sounds like the obvious fix to me.
