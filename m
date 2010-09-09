From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git's use of mkdir(2)
Date: Thu, 09 Sep 2010 11:56:31 -0700
Message-ID: <7v62yen3ts.fsf@alter.siamese.dyndns.org>
References: <201009081936.PAA07078@Sparkle.Rodents-Montreal.ORG>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: der Mouse <mouse@Rodents-Montreal.ORG>
X-From: git-owner@vger.kernel.org Thu Sep 09 20:56:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OtmIh-0002dI-07
	for gcvg-git-2@lo.gmane.org; Thu, 09 Sep 2010 20:56:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753108Ab0IIS4n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Sep 2010 14:56:43 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:33288 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751261Ab0IIS4l (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Sep 2010 14:56:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8B616D45AE;
	Thu,  9 Sep 2010 14:56:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8HWE2QbMKvVTugw20edPNM3Gv/g=; b=q2wiP8
	d35MQKLc4Dr7gINl9D+RuT01Ey3w5s/UNjrxznPqywTS7UDEzD8yk/GhkRVZcatO
	ezmp10JqOjIKT9CYvFBp+/YY1B2o7uzkxCgdfENUcm5/lQ4qP5Elf5tRxsT08FBc
	91gPMF0jQtlLnRl14Tg9ZB7JQAQOAc9ZYAsjM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mzyivKkalMQL+bM3c98uomr5yTZs6a4B
	DxC2N5ezIYnq9U5XkyuvQoGT1d4M/IZ8eyvQuv6Flu7Eh3ho2OcLpoj32yAgdDAJ
	CMAU0uqUxj9vVL1a7anj33gzGLrSoRTXPneB4lVmVvyj0Lkt6H3uW/8p/akdbPSr
	0C115up8Aio=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 678F0D45AD;
	Thu,  9 Sep 2010 14:56:36 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 747BFD45A7; Thu,  9 Sep
 2010 14:56:33 -0400 (EDT)
In-Reply-To: <201009081936.PAA07078@Sparkle.Rodents-Montreal.ORG> (der
 Mouse's message of "Wed\, 8 Sep 2010 15\:36\:43 -0400 \(EDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F8985A38-BC43-11DF-A1A3-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155876>

der Mouse <mouse@Rodents-Montreal.ORG> writes:

> I've been trying to convince git to run on some of the systems I use.
> Of particular relevance at the moment are two BSD systems which have an
> important behavioural difference.
>
> Specifically, if /foo/bar does not exist but /foo does,
> mkdir("/foo/bar/",...) works on one and fails showing ENOENT on the
> other.  (Without the trailing slash, it works on both.)

What vintage of BSD do you have that exhibits the problem?  It smells like
a POSIX violation, considering what "4.12 Pathname Resolution" says on the
matter:

  A pathname that contains at least one non-<slash> character and that
  ends with one or more trailing <slash> characters shall not be resolved
  successfully unless the last pathname component before the trailing
  <slash> characters names an existing directory or a directory entry that
  is to be created for a directory immediately after the pathname is
  resolved.

Not that I am saying that such a system does not deserve to be supported,
but I am curious to know how widespread the damage is.

> here to ask (a) if this is a known issue and fixed in something more
> recent (I had a look at 1.7.2 and a quick read of the code makes me
> think it still does this, but I could have missed something)

I don't think so---we seem to have a compat/ replacement "mkdir(2)" for
MinGW (but that doesn't trim the trailing slash so I would imagine MinGW
does not suffer from such a violation), but not for the flavor of BSD you
have.  It shouldn't be hard to add one, though.
