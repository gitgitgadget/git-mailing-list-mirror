From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] parse_object: clear "parsed" when freeing buffers
Date: Wed, 23 Jan 2013 14:19:05 -0800
Message-ID: <7vsj5rfspy.fsf@alter.siamese.dyndns.org>
References: <8988071A-1DF3-463E-8AF9-AE4EA200D786@me.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jonathon Mah <jmah@me.com>
X-From: git-owner@vger.kernel.org Wed Jan 23 23:19:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ty8fL-00047z-Gi
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jan 2013 23:19:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751388Ab3AWWTK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2013 17:19:10 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56031 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750899Ab3AWWTI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jan 2013 17:19:08 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 99417B108;
	Wed, 23 Jan 2013 17:19:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xg9aXNiF5fymksDWBiGqMQnSglo=; b=C/gUFM
	r4InIIG6FXcMMTbwRPRI7iGIk4FZBJpA79YdJbhK+ReOWB5MawtCAeZSrfnuhmse
	q9B8WFktQ/3CNLsECxf4eqVGsEBPvSgmg7eBVsLfggYS/+h4/3gDTlUQHKWJFn6f
	KFaw/EmMD9jiXX7xIomXqZlk9ZM2dDnSu1pFs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jcu24EMiO86fmQOqb9xvOyzwTs9pxw82
	epeM8HBN6xFgJmSUi01YOkSu0H8/1zp/xN19dh2D+zVEgs/XCXVC0AYMFP6g8beW
	xktYGO/J5f8pWnqpJySCakgzuc5rAPfW/m+WFiH2JCxQjX9D6+1YI2fS2wNNGjzV
	znenJB/QM/I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8DAEDB107;
	Wed, 23 Jan 2013 17:19:07 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E20B0B104; Wed, 23 Jan 2013
 17:19:06 -0500 (EST)
In-Reply-To: <8988071A-1DF3-463E-8AF9-AE4EA200D786@me.com> (Jonathon Mah's
 message of "Wed, 23 Jan 2013 13:25:04 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E7065EE2-65AA-11E2-B64A-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214372>

Jonathon Mah <jmah@me.com> writes:

> Add a new function "free_object_buffer", which marks the object as
> un-parsed and frees the buffer. Only trees and commits have buffers;
> other types are not affected. If the tree or commit buffer is already
> NULL, the "parsed" flag is still cleared so callers can control the free
> themselves (index-pack.c uses this).
>
> Several areas of code would free buffers for object structs that
> contained them ("struct tree" and "struct commit"), but without clearing
> the "parsed" flag. parse_object would clear the flag for "struct tree",
> but commits would remain in an invalid state (marked as parsed but with
> a NULL buffer). Because the objects are uniqued (ccdc6037fee), the
> invalid objects stay around and can lead to bad behavior.
>
> In particular, running pickaxe on all refs in a repository with a cached
> textconv could segfault. If the textconv cache ref was evaluated first
> by cmd_log_walk, a subsequent notes_cache_match_validity call would
> dereference NULL.

Conceptually this is a right thing to do, but it is unclear why this
conversion is safe in the existing code.

A codepath that used to free() and assign NULL to a buffer without
resetting .parsed would have assumed that it can find out the parsed
properties of the object (e.g. .parents) without re-parsing the
object, and much more importantly, the modifications made by that
codepath will not be clobbered by later call to parse_object().

IIRC, revision traversal machinery rewrites commit->parents but
discards buffer when it knows that the log message is not needed
(save_commit_buffer controls this behaviour).  I do not offhand know
if there are other instances of existing code that depend on the
current behaviour, but have you audited all the codepaths that are
affected by this patch and codepaths that work on objects this patch
unmarks their .parsed field will not have such a problem?
