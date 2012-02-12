From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] strbuf: move strbuf_readline_fd() from bundle.c to
 strbuf.{c,h}
Date: Sun, 12 Feb 2012 09:20:55 -0800
Message-ID: <7vy5s8j7d4.fsf@alter.siamese.dyndns.org>
References: <CAMocUqRutwERQ64a=9t36Za6Lm8KxpseS0NYbdGKWbixbsXeyw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Cc: Git =?utf-8?B?6YKu5Lu25YiX6KGo?= <git@vger.kernel.org>
To: =?iso-2022-jp?B?GyRCPXltbBsoQg==?= <xudifsd@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 12 18:21:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rwd6l-0004ME-1D
	for gcvg-git-2@plane.gmane.org; Sun, 12 Feb 2012 18:21:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755567Ab2BLRU6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Feb 2012 12:20:58 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44898 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755537Ab2BLRU5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Feb 2012 12:20:57 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 33B247FB1;
	Sun, 12 Feb 2012 12:20:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5kMHyQ0eK9Yqe09Q5XzchHp1f/U=; b=d50DVn
	zDCiDehA1hVQ4Y/Vbf1DYruVNEB4CoCjeAjUvieufLWi2cgp1OVEJYNCSleK9Jsc
	3L+j9yFj76AbwpmLbAXo0vQgJGc7POi9SQSw1oK8AYb5iG3PLYb2bjV18cibCtTc
	HlEQQzHt9cyNRXiwNSbISK47KpD6a1MKVzEqM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IXc+2Hx3l6VlTiQEhwAoKZIAEJauEpyi
	0gXowx3wYH1UGjCIE5bhC4t+IAsU64LtZQZNsPWlNjyYpw7bhX/TZLg32m5gsXih
	GlTGyYpiwbuv8xBPJnfvmfPj2yaBa95gPQ74SSuTNqbTSTRIz1Q07CwYxb3vim6A
	J1ML2gmeZWA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2ABBE7FB0;
	Sun, 12 Feb 2012 12:20:57 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AC6F17FAF; Sun, 12 Feb 2012
 12:20:56 -0500 (EST)
In-Reply-To: <CAMocUqRutwERQ64a=9t36Za6Lm8KxpseS0NYbdGKWbixbsXeyw@mail.gmail.com>
 (=?iso-2022-jp?B?IhskQj15bWwbKEIiJ3M=?= message of "Sat, 11 Feb 2012 17:50:37
 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: ECB26B56-559D-11E1-8A74-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190582>

徐迪 <xudifsd@gmail.com> writes:

> -/* Eventually this should go to strbuf.[ch] */
> -static int strbuf_readline_fd(struct strbuf *sb, int fd)
> -{

Unlike other line-oriented input functions in strbuf.c, this hardcodes the
LF as the terminator, hence is not capable of reading -z output.  As an
internal function to the bundle reader implementation, that is perfectly
fine, because we know lines in bundle ends with '\n'.

But if we were to promote this to a generic API, that aspect of this
function needs to be reconsidered, and if we decide to allow non-LF line
terminator for consistency with other functions, the current callers in
this function have to pass an extra parameter "term" to it.

We simply do not have enough datapoint to see if it is worth it to promote
this to strbuf.c with such a change, especially when there is no other
caller to it.  That is why we said "Eventually" here when we introduced
this function at e9ee84c (bundle: allowing to read from an unseekable fd,
2011-10-13).

I do not think the situation changed yet in any way since then.
