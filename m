From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/8] Introduce new static function real_path_internal()
Date: Thu, 27 Sep 2012 14:27:03 -0700
Message-ID: <7vk3vfp36g.fsf@alter.siamese.dyndns.org>
References: <1348688090-13648-1-git-send-email-mhagger@alum.mit.edu>
 <1348688090-13648-2-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Lea Wiemann <lewiemann@gmail.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Sep 27 23:27:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THLc5-0004ft-I1
	for gcvg-git-2@plane.gmane.org; Thu, 27 Sep 2012 23:27:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754760Ab2I0V1H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2012 17:27:07 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36472 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752697Ab2I0V1G (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2012 17:27:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8B77D99B4;
	Thu, 27 Sep 2012 17:27:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=c+ymUDRor6Bvg6F/4UO2YZRbXqE=; b=crb6R7
	zcKPzYojFoAus3SlJIcPD1SvbA1Yrb/m4F2rN/GyabT5Mdz8qjKF49px08jTSTo9
	gTEo46iiSPQiWWlBjb3SilOWzZaPh9l8BmJIb5Q3zsi78CQnlBHmWl51cpWb5OIH
	s+N+YhZSfNNwB9S8J21fAs0o2Bq1Twn+QTZcY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=I4C92+OAp1wSeSjH5NH9TIYHrAOfFSLp
	enpkUs7AygRAEC1vlTp5oHBRp4h+sO7/P4N2F8TAWidNXPTg62SIT2wCFamogjUg
	6aXt4DudAg65e1KD+PAALBqTR012DxLAzPbTpmaEuPY3AWklL6K7Zfbm/FNsp2RX
	7zVHNNC5lUs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7896C99B3;
	Thu, 27 Sep 2012 17:27:05 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DD41C99B2; Thu, 27 Sep 2012
 17:27:04 -0400 (EDT)
In-Reply-To: <1348688090-13648-2-git-send-email-mhagger@alum.mit.edu>
 (Michael Haggerty's message of "Wed, 26 Sep 2012 21:34:43 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1569867E-08EA-11E2-99E3-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206520>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> @@ -54,20 +73,36 @@ const char *real_path(const char *path)
>  		}
>  
>  		if (*buf) {
> -			if (!*cwd && !getcwd(cwd, sizeof(cwd)))
> -				die_errno ("Could not get current working directory");
> +			if (!*cwd && !getcwd(cwd, sizeof(cwd))) {
> +				if (die_on_error)
> +					die_errno("Could not get current working directory");
> +				else
> +					goto error_out;
> +			}
>  
> -			if (chdir(buf))
> -				die_errno ("Could not switch to '%s'", buf);
> +			if (chdir(buf)) {
> +				if (die_on_error)
> +					die_errno("Could not switch to '%s'", buf);
> +				else
> +					goto error_out;
> +			}
> +		}

The patch makes sense, but while you are touching this code, I have
to wonder if there is an easy way to tell, before entering the loop,
if we have to chdir() around in the loop.  That would allow us to
hoist the getcwd() that is done only so that we can come back to
where we started outside the loop, making it clear why the call is
there, instead of cryptic "if (!*cwd &&" to ensure we do getcwd()
once and before doing any chdir().
