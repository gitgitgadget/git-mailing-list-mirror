From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] diffcore-break: don't divide by zero
Date: Tue, 02 Apr 2013 15:41:10 -0700
Message-ID: <7va9pga73t.fsf@alter.siamese.dyndns.org>
References: <cover.1364931627.git.john@keeping.me.uk>
 <a2b6c61371ac6ff1e180c6600e57499ff94b2fd2.1364931627.git.john@keeping.me.uk>
 <7vvc84ab2y.fsf@alter.siamese.dyndns.org>
 <20130402213651.GG2222@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Wed Apr 03 00:41:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UN9tt-0003yc-0b
	for gcvg-git-2@plane.gmane.org; Wed, 03 Apr 2013 00:41:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757057Ab3DBWlY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 18:41:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34783 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751729Ab3DBWlU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 18:41:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EADE0121E1;
	Tue,  2 Apr 2013 22:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sgW6fA2un5MJR/q8wCJkU6c1bdo=; b=QYjgkd
	lZQkKTMI+aySdzEdN2cGNSNnEJAVhGOtSzKVKAlhwiJjtAdFKype4eBCJOZWyDyP
	0+EFFCfDCHpTN/kUKLgmw52vKD+mQuCsafKf+qw/k5V8vTg20QmWcTQbTWeoQF8F
	tLugjv1SQZz6sgzQVYHQk7mTr0gr0h06lul2o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=u/iox2ecUW2ymFuLL7Sr9wh+cc2SvNfi
	7Bq9rW3f3QkRK1ddx5KIsKHDBoJsBOqpiPxqw4ZOVWIL8ATyHPOKRjSkzNhP0eEb
	2aktl3hsMP89l4W/P4jEHK+y94PFzT9JFByGMCJD5HfVIVTWmh5ZviZZTKxGgJ62
	ILDL5YM3OJo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DFA52121E0;
	Tue,  2 Apr 2013 22:41:19 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 562CD121DB; Tue,  2 Apr
 2013 22:41:19 +0000 (UTC)
In-Reply-To: <20130402213651.GG2222@serenity.lan> (John Keeping's message of
 "Tue, 2 Apr 2013 22:36:51 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6FB79DB6-9BE6-11E2-9FFE-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219900>

John Keeping <john@keeping.me.uk> writes:

> The message for commit 6dd4b66 (Fix diffcore-break total breakage)
> indicates that "don't bother to break small files" is wrong in some
> cases, but it I wonder if "don't bother to break empty files" is okay.

This has a rather subtle ramifications, and we would need to think
carefully.  "break" does two very different things, and the criteria
you would want to use to decide to "break" a filepair depends on
which one you are interested in.

The very original motivation of "break" was to show a patch that
rewrites an existing file completely in a way different from the
usual "diff -u" output, which will try to minimize the output by
finding (rare) lines that happen to be the same between the preimage
and postimage, intersparsed in many lines of "-" (deletion) and "+"
(addition).  Such a change is often easier to understand when shown
as a single block of "-" (deletion) of the entire original contents,
followed by a single block of "+" (addition) of the entire new
contents.

A totally separate motivation of "break" is the one Linus talks
about in the log message of the said commit.  A path filename.h was
moved to filename_32.h, and a new (and much smaller) filename.h was
introduced, that "#include"s filename_32.h.  "diff -M" that pairs
deleted files with created files to compute renames in such a case
would not consider the original filename.h as a possible source of
filename_32.h that was created.  You want to break modification of
filename.h into (virtual) deletion and addition of filename.h.

For the purpose of the former, you would want not to break a file
too aggressively.  If you started from a file with 1000 lines in it,
and deleted 910 lines and added 10 lines to result in a file with
100 lines, you still have 90 lines of shared contents between the
preimage and the postimage, and you do not want to show it as
"delete 1000 lines and add 100 lines".  You would want to base your
decision on how much common material exists between the two.

For the purpose of the latter, however, it is better to err on the
side of breaking than not breaking.  After breaking a suspicious
modification into addition and deletion, if rename comparison does
not find a suitable destination for the virtual deletion, the broken
halves will be merged back, so breaking too little can hurt by
missing potential renames, but breaking too much will not.  You do
want to break the "900 deleted out of 1000 and then added 10" case,
as that 900 lines may have gone to another file that was created in
the same commit.  "But we have 90 lines of common material" does not
matter for the decision to break.

In today's code, the return value of should_break() is about the
latter, while the score it stores in *merge_score is about the
former.
