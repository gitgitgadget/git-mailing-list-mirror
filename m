From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] merge-recursive: Fix multiple file rename across D/F
 conflict
Date: Wed, 18 Aug 2010 16:17:27 -0700
Message-ID: <7v8w438q9k.fsf@alter.siamese.dyndns.org>
References: <1282089199-17253-1-git-send-email-newren@gmail.com>
 <1282089199-17253-3-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 19 01:17:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Olrt7-0005LX-W7
	for gcvg-git-2@lo.gmane.org; Thu, 19 Aug 2010 01:17:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751480Ab0HRXRh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Aug 2010 19:17:37 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:33342 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751030Ab0HRXRg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Aug 2010 19:17:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E6C41CE132;
	Wed, 18 Aug 2010 19:17:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NWlHXAOY/p8zRdyEsS6Izfw60oY=; b=IBM+9O
	MpZ3JUomkTGq7j5qwNEG31qb5Fu7L3BwijPJtyBkABn7wNu7cGDH7nVzdynf/3wU
	U0wHSyBNcFVEsTN0qDEgklYEOyP0rKIn2xFIiZ+O6tAV0iy3bo+RGrSb5CZvziIN
	B0/vaSrh7q8MYiPk4dXygYMvwosH/wKtCEH14=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=to8/2bAaQjFl7JONlqIIclnsMJ7zNn38
	UU1xDyjQ31MRkJ580VXl85MWxKaIHgchTl4Qk1G00b0fXqGt10PY+CD7g7UcNV3x
	Ah4PkxS+CVHZbzCgc3Yt1KNHKse9LJgGu4Ce3uxqqEEtQ6YBrARK1QKDMw31vdYf
	8FGL5SFANgc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C290ACE131;
	Wed, 18 Aug 2010 19:17:31 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0D7B2CE130; Wed, 18 Aug
 2010 19:17:28 -0400 (EDT)
In-Reply-To: <1282089199-17253-3-git-send-email-newren@gmail.com> (Elijah
 Newren's message of "Tue\, 17 Aug 2010 17\:53\:19 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C6D60D46-AB1E-11DF-9280-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153895>

Elijah Newren <newren@gmail.com> writes:

> I'm really embarrased about this one...  :-/

Let's embarrass you even more ;-)

After 5a2580d, the merge has become very noisy, and I don't see a good
reason for that change.

With a version of git built from 5a2580d^, for example, merging
sp/fix-smart-http-deadlock-on-error into maint would give me this:

----------------
$ git merge sp/fix-smart-http-deadlock-on-error
Auto-merging remote-curl.c
Merge made by recursive.
 remote-curl.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)
----------------

With 5a2580d, it has become this:

----------------
$ git merge sp/fix-smart-http-deadlock-on-error
Adding builtin/add.c
Auto-merging remote-curl.c
Merge made by recursive.
 remote-curl.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)
----------------

And with this patch on top, it will make it a disaster:

----------------
$ git merge sp/fix-smart-http-deadlock-on-error
Adding builtin/add.c
... similar 97 Adding lines omitted ...
Adding gitweb/static/gitweb.js
Auto-merging remote-curl.c
Adding t/lib-t6000.sh
Adding t/t7810-grep.sh
Adding t/t9350-fast-export.sh
Merge made by recursive.
 remote-curl.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)
----------------
