From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 02/14] trailer: process trailers from file and arguments
Date: Mon, 10 Feb 2014 12:51:41 -0800
Message-ID: <xmqq38jqsnc2.fsf@gitster.dls.corp.google.com>
References: <xmqqr47fx001.fsf@gitster.dls.corp.google.com>
	<20140209.145205.1882309246743951569.chriscool@tuxfamily.org>
	<xmqq61omu96d.fsf@gitster.dls.corp.google.com>
	<20140210.205936.813126606054805390.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, johan@herland.net, josh@joshtriplett.org,
	tr@thomasrast.ch, mhagger@alum.mit.edu, sunshine@sunshineco.com,
	dan.carpenter@oracle.com, greg@kroah.com, peff@peff.net
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Mon Feb 10 21:51:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WCxpY-0006o7-2t
	for gcvg-git-2@plane.gmane.org; Mon, 10 Feb 2014 21:51:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753332AbaBJUvr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Feb 2014 15:51:47 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48721 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752402AbaBJUvq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Feb 2014 15:51:46 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8EC7E6BFDF;
	Mon, 10 Feb 2014 15:51:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UIAdLXT+tkswf4Rs0NivA3D0YeQ=; b=sEiwq6
	av0+jnJ8zeWZH4WnR24wxgp2D1FuBdeme5jfh+2fRVEaKFjs4PWcpxkClqcvuYNN
	k82YhhBGiDh4VHWTQvwDfe3IwmW3gdrPM5TW+4j6t28s3JppdHWMaRr48XxJziEa
	DzrAfICK/Sl5QH5n7G5t1Fhw+E+t/SS4wsAWg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=v1jAW4TOTWJHV1nYtdCJyfoarab6Ciq7
	UBqkN4zyVxuIGLnJQq/TU/UpL/xbVdKFgaq6gs+/wohAsDGqq5syUUDCyTNuXeRf
	UICrP91ECd569yJXIuK9W4ICeBh3GBtYCzy7RcVyMNCMqQmgEvFNJXUpEKZObFQx
	nCo7AZuu31Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 78B196BFDE;
	Mon, 10 Feb 2014 15:51:45 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 705E06BFDC;
	Mon, 10 Feb 2014 15:51:44 -0500 (EST)
In-Reply-To: <20140210.205936.813126606054805390.chriscool@tuxfamily.org>
	(Christian Couder's message of "Mon, 10 Feb 2014 20:59:36 +0100
	(CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 2688FE68-9295-11E3-8183-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241929>

Christian Couder <chriscool@tuxfamily.org> writes:

> Many entries with the same key but distinct values can be configured
> using:
>
> if_exists = add_if_different
> if_missing = add
>
> Many entries with the same key but values that can be the same can be
> configured using:
>
> if_exists = add
> if_missing = add

While the above certainly can express the combinations, I am still
puzzled about the value of having "under this condition" (i.e.
if-exists/if-missing) and "do this" (i.e. add/add-if-different) as
two separate concepts.

If you do not have an existing entry with the same key, no new entry
can be the same as an existing one---therefore, the former "allow
only distinct values for the same key" can just say

  trailer."Fixes".action = add_if_different

or something, without any if_exists/if_missing.  In a similar way,
the latter "duplicated values allowed for the same key" can say

  trailer."Sob".action = add

You can throw into the mix other actions like "add_if_missing", you
can also express "only one value allowed for the same key---the
first one wins", "replace" to mean "replace if there is one with the
same key", and "replace_or_add" to mean "same as 'replace', but add
if there is no existing entries with the same key".  Will we lose
expressiveness by simplifying the semantics, getting rid of this
"under this condition" part and instead making "do this" part more
intelligent?

Even if we assume, for the sake of discussion, that it *is* a good
idea to separate "under this condition" part and "do this" part, I
do not think the above is the only or the best way to express
"distinct values allowed for the same key".  How do we argue that
this from your example

  if_exists = add_if_different
  if_missing = add

is a better design than this, for example?

  if_key_value_exists = ignore ; exact matching <key,val> exists
  if_key_exists = add          ; otherwise
  if_missing = add

The latter splits remaining conditional logic from "do this" part
(no more "add_if_different" that causes "add" action to see if there
is the same key and act differently) and moves it to "under this
condition" part.

I am trying to illustrate that the line to split the "under this
condition" and "do this" looks arbitrary and fuzzy here, and because
of this arbitrary-ness and fuzziness, it is not very obvious to me
why it is a good idea to have "under this condition" as a separate
concept from "do this" settings.

What is the advantage of having such an extra axis?  Does it make it
easier to manage?  Does it allow us to express more?

I can see that the location where a new entry (or a duplicated one)
is added (i.e. do we prepend? do we append?) can be orthogonal to
any of the above; no need to bring up 'where' in the discussion.
