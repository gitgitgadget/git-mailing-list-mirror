From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 7/9] sparse: Fix errors due to missing target-specific
 variables
Date: Thu, 07 Apr 2011 16:18:23 -0700
Message-ID: <7vfwpt6474.fsf@alter.siamese.dyndns.org>
References: <4D9E06EE.9090803@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing-list <git@vger.kernel.org>, bebarino@gmail.com
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Fri Apr 08 01:18:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7yTH-0005g6-NP
	for gcvg-git-2@lo.gmane.org; Fri, 08 Apr 2011 01:18:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757156Ab1DGXSf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Apr 2011 19:18:35 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:39791 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756288Ab1DGXSe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Apr 2011 19:18:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id ACADF59CC;
	Thu,  7 Apr 2011 19:20:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DvOtlTFnlo0aT0B4G+IP2J6WRsA=; b=acjR1F
	Xu3aceACevgkOPA7U6PXTPkQRtfpTTUERJVDDMY8nKK0MUtzV4XG9BTZnkBQEPd1
	EqY1vgNJwJ4fNIsO4naM4+aa/coAD1lRkrrALFBFhWwAOiyLZsO1SlIT4uDyspb3
	lrbADoPIXwXVg3K+u85+7CiX5frgeRK4BssDA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=v0ICRWTbnyIgC67FEfupA7/qhXRwxt//
	Hle9HW8qGVvPitsnKy994iUCJ5OJvmFA8Ia4xXSCFgktDw4omjqyQQMvdVBCH9iF
	c4oAQDlY1+Slna86gfNVS3Lu5pbDW4kYjCl+IR/uhNnYHyzJRQM27Q/x2CZuc9Nu
	T/WL32Uevls=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 785C059CB;
	Thu,  7 Apr 2011 19:20:25 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 2520659CA; Thu,  7 Apr 2011
 19:20:20 -0400 (EDT)
In-Reply-To: <4D9E06EE.9090803@ramsay1.demon.co.uk> (Ramsay Jones's message
 of "Thu, 07 Apr 2011 19:48:14 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9E2BAB34-616D-11E0-B8DF-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171094>

Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:

> In particular, sparse issues the following errors:
>
>     attr.c:472:43: error: undefined identifier 'ETC_GITATTRIBUTES'
>     config.c:821:43: error: undefined identifier 'ETC_GITCONFIG'
>     exec_cmd.c:14:37: error: undefined identifier 'PREFIX'
>     exec_cmd.c:83:28: error: undefined identifier 'GIT_EXEC_PATH'
>     builtin/help.c:328:46: error: undefined identifier 'GIT_MAN_PATH'
>     builtin/help.c:374:40: error: undefined identifier 'GIT_INFO_PATH'
>     builtin/help.c:382:45: error: undefined identifier 'GIT_HTML_PATH'
>     git.c:96:42: error: undefined identifier 'GIT_HTML_PATH'
>     git.c:241:35: error: invalid initializer
>     http.c:293:43: error: undefined identifier 'GIT_HTTP_USER_AGENT'
>
> which is caused by not passing the target-specific additions to
> the EXTRA_CPPFLAGS variable to cgcc.
>
> In order to fix the problem, we define a new sparse target which
> depends on an a set of non-existent "sparse object" files (*.sp)
> which correspond to the set of C source files. In addition to the
> new target, we also provide a new pattern rule for "creating" the
> sparse object files from the source files by running cgcc.  This
> allows us to add '*.sp' to the rules setting the target-specific
> EXTRA_CPPFLAGS variable, which is then included in the new pattern
> rule to run cgcc.

Hmm, shouldn't this be part of [1/9]?  I don't think I saw these with
"make check" before applying that patch.

Also shouldn't you be marking .sp suffix as .PHONY?
