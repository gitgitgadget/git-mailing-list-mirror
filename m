From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/7] enforce `xfuncname` precedence over `funcname`
Date: Wed, 23 Jul 2014 15:34:19 -0700
Message-ID: <xmqqtx67bt78.fsf@gitster.dls.corp.google.com>
References: <1406140978-9472-1-git-send-email-tanayabh@gmail.com>
	<1406140978-9472-6-git-send-email-tanayabh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 24 00:34:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XA57I-0002Qf-KM
	for gcvg-git-2@plane.gmane.org; Thu, 24 Jul 2014 00:34:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934037AbaGWWe3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2014 18:34:29 -0400
Received: from smtp.pobox.com ([208.72.237.35]:53516 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933856AbaGWWe2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2014 18:34:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6C2162A2D2;
	Wed, 23 Jul 2014 18:34:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ohf3rUtsc9i3hk6CimaE2aRAaDM=; b=UYUcZF
	3AlJx9bjs7FQlD0AzTJP+kh4l7louPsZ0gJg/pM1rwl1DWbzt6oKtqtp/Pa7ulEu
	j+ylMtMYZrfU4yP6nzkgBHrgssnNbMnE8eH8frjktBjJWU/X6Br+10Gl+KnXMyQ2
	Yudycs066m1CUzX7f4Orvo26Tt9qvREjTeYSQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Mr5sbMl/iQxmckiGbXUPVEH+QHmitndR
	yUxs5a6PJnEafgmriEF89U0QBEUKEq0cjbBihGJYPx0o1ECJxu6mpTuExyqoJQFx
	o6KCJAww3qy246MeZTKibTOV6Mo27rfBbHluVSD37L8UaMUmySWfWBkau5pmGQta
	XOLlItINgOc=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 61F522A2D0;
	Wed, 23 Jul 2014 18:34:27 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 63A512A2CA;
	Wed, 23 Jul 2014 18:34:21 -0400 (EDT)
In-Reply-To: <1406140978-9472-6-git-send-email-tanayabh@gmail.com> (Tanay
	Abhra's message of "Wed, 23 Jul 2014 11:42:56 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 7DA5828A-12B9-11E4-86D0-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254136>

Tanay Abhra <tanayabh@gmail.com> writes:

> t4018-diff-funcname.sh fails for the new `git_config()` which uses the
> configuration files caching layer internally.
> The test introduced in commit d64d6cdc checks that whether `xfuncname` takes
> precedence over `funcname` variable which was not guaranteed by config API
> previously and worked only because values were parsed and fed in order.

The above is hard to understand.  Do you mean that the old code and
test used whichever (between funcname and xfuncname) appeared last
in the configuration file?

For example, if I had

	diff.foo.xfuncname "Beer$"

in my ~/.gitconfig and then for a particular project I wanted to use
a custom pattern in its .git/config but it was sufficient to define
the pattern without using extended regexp, I would be tempted to say

	diff.foo.funcname "Wine$"

With the "last one of xfuncname or funcname wins" rule, I do not
have to worry about having xfuncname in ~/.gitconfig when I do so,
but with "xfuncname is stronger than funcname" rule, it suddenly
forces me to go back and check if I have something stronger in my
lower-precedence configuration file (i.e. ~/.gitconfig) when I am
trying to override with a higher-precedence configuration file
(i.e. the project-specific .git/config).

If that is what this patch is trying to change, I am not sure if I
agree that is a good change.  They are two ways to spell the same
information, and I would find it more natural if a later funcname
spelled in BRE allowed me to override an earlier xfuncname spelled
in ERE.
