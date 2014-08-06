From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug v1.9.3: Spurious whitespace warnings when using git apply with the --exclude option
Date: Wed, 06 Aug 2014 13:12:21 -0700
Message-ID: <xmqq8un1ml7e.fsf@gitster.dls.corp.google.com>
References: <332C033B-7809-45A9-9F91-CC3A92090B86@apple.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Peyton Randolph <prandolph@apple.com>
X-From: git-owner@vger.kernel.org Wed Aug 06 22:12:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XF7Zg-0004xi-By
	for gcvg-git-2@plane.gmane.org; Wed, 06 Aug 2014 22:12:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753282AbaHFUMg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Aug 2014 16:12:36 -0400
Received: from smtp.pobox.com ([208.72.237.35]:58160 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751908AbaHFUMf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2014 16:12:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 297B32F209;
	Wed,  6 Aug 2014 16:12:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zMMPQGeBB3sODbVjZDKWL5WmiTQ=; b=XIWSck
	CR8EudtggiFeAqXg/ie4J9PKC5jYGQTJNpn5D3sAR+mZ2hFEc1wxw6uolZdE72wa
	fpg43l5tgZtXHQzxn4ZWGZuRCrg0lO5PY8RVpyI2iB6QFB2yRFWTzZQM4VMZQetU
	c1G6vesF+NziCzRANGzjv7KNA/zO9bXJYgruA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=l+2JjLv9EYWeIY2kk0PHNQ6F7lWQMY7b
	P+V3ws3wILOWquZX4dDsqM5+SCb3Q0iwnvYIUS+kQmf0CjmpYtVIwlGUza+1uy55
	PLnygA1/5MtXzhbgsP8NcVb95G9iKoQ3B1RRaJFWu116788SdvkixhqCTSrIpHLf
	/pnNwRHyhoE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 201842F208;
	Wed,  6 Aug 2014 16:12:35 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 30CC52F1E0;
	Wed,  6 Aug 2014 16:12:23 -0400 (EDT)
In-Reply-To: <332C033B-7809-45A9-9F91-CC3A92090B86@apple.com> (Peyton
	Randolph's message of "Wed, 06 Aug 2014 10:13:34 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: FA2E16FE-1DA5-11E4-AB7D-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254898>

Peyton Randolph <prandolph@apple.com> writes:

> Bug v1.9.3: Spurious whitespace warnings when using git apply with the --exclude option
> ...
> EXPECTED RESULT:
> No warning about adding whitespace errors because no whitespace
> errors are added to the tree since A is excluded and B has no
> whitespace errors.

By reading the way the code is structured, I would expect (I didn't
check) that all versions of apply that supports whitespace error
detection with include/exclude option to share this symptom, and
this bug is not specific to 1.9.3.

In order to decide if a hunk with a new whitespace error should be
reported, the program needs to parse the patch input to at least
find out what path the part being parsed is to be applied, and the
whitespace error detection and reporting is done when the patch
input is parsed.  After the part that applies to one path is fully
parsed, it then checks to see if the path is included/excluded and
omits it from the --stat output and also actual application.

That part of the code needs to be restructured so that at least
error reporting (and preferrably error detection) is not done when
the path is known to be excluded.  Let me see if this can be easily
done.

Thanks.
