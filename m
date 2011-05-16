From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 4/9] pack-objects: Teach new option --max-object-count,
 similar to --max-pack-size
Date: Sun, 15 May 2011 23:25:02 -0700
Message-ID: <7vmxinmabl.fsf@alter.siamese.dyndns.org>
References: <201105151942.29219.johan@herland.net>
 <1305495440-30836-1-git-send-email-johan@herland.net>
 <1305495440-30836-5-git-send-email-johan@herland.net>
 <BANLkTi=qtA=34=pdXuJ_cQu0pv6BnE2uSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Shawn Pearce <spearce@spearce.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon May 16 08:25:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLrF8-000312-Eh
	for gcvg-git-2@lo.gmane.org; Mon, 16 May 2011 08:25:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751333Ab1EPGZO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2011 02:25:14 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:64673 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751204Ab1EPGZN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2011 02:25:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B8E0637DE;
	Mon, 16 May 2011 02:27:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XQEFy2r3tfQO+Y9HiP/8zYJ3W2A=; b=RGgKSL
	VJSuFzQcrtFF9djcua/cKqzBSJniLJXD6xQ32j6ttMYqDGFFfCxQxEvuoTYzVGm5
	EIu5qF2sxWtSpXzjecx1udCHxXdcNqdo3V71y3RCw7bMMhHhFqmkutkfL48nPsR4
	pgUQ+XgxSYEVE7csbbF7FzWjv+lcRYvX1RnBs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ooHYcdd7QdXCQS2DbsBnCprdD/qp5so1
	LV1Gbq9LD18tc8rPOvujPCPpn4GHT21bJh0HFSql9S8r79PjLRPP8SiAkhl04rcn
	TXnG7fyJoR5+StXe9PvX54ZshGm6YdXfiFciF+ZcxrlKbHnwCQ2FD3DgWh15MjhL
	mVNo2KuvVRI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 86C6A37DD;
	Mon, 16 May 2011 02:27:15 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 5356837D7; Mon, 16 May 2011
 02:27:10 -0400 (EDT)
In-Reply-To: <BANLkTi=qtA=34=pdXuJ_cQu0pv6BnE2uSA@mail.gmail.com> (Shawn
 Pearce's message of "Sun, 15 May 2011 15:07:17 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8AA6E840-7F85-11E0-9B09-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173707>

Shawn Pearce <spearce@spearce.org> writes:

> On Sun, May 15, 2011 at 14:37, Johan Herland <johan@herland.net> wrote:
>> The new --max-object-count option behaves similarly to --max-pack-size,
>> except that the decision to split packs is determined by the number of
>> objects in the pack, and not by the size of the pack.
>
> Like my note about pack size for this case... I think doing this
> during writing is too late. We should be aborting the counting phase
> if the output pack is to stdout and we are going to exceed this limit.

Well, even more important is if this is even useful. What is the user
trying to prevent from happening, and is it a useful thing?

I am not interested in a literal answer "The user is trying to prevent a
push that pushes too many objects in a single push into a repository". I
am questioning why does anybody even care about the object count per-se.

I think "do not hog too much disk" (i.e. size) is an understandable wish,
and max-pack-size imposed on --stdout would be a good approximation for
that.

I would understand "this project has only these files, and pushing a tree
that has 100x leaves than that may be a mistake" (i.e. recursive sum of
number of entries of an individual tree). I would also sort-of understand
"do not push too deep a history at once" (i.e. we do not welcome pushing a
wildly diverged fork that has been allowed to grow for too long).

But I do not think max-object-count is a good approximation for either
to be useful.

Without a good answer to the above question, this looks like a "because we
could", not "because it is useful", feature.
