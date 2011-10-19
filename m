From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How to verify that lines were only moved, not edited?
Date: Wed, 19 Oct 2011 10:07:46 -0700
Message-ID: <7vvcrkdi59.fsf@alter.siamese.dyndns.org>
References: <4E9EDFEC.3040009@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Oct 19 19:07:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RGZcQ-0003Du-JD
	for gcvg-git-2@lo.gmane.org; Wed, 19 Oct 2011 19:07:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756760Ab1JSRHu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Oct 2011 13:07:50 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41166 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755659Ab1JSRHt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Oct 2011 13:07:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9B142480E;
	Wed, 19 Oct 2011 13:07:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8a6FyRYZhJsBik/hR2KtlmqFnxY=; b=WYqFkv
	mMj9Ireb/C6hgoM+lnWjOLubcbtQnbfUJ4yXX+h7GRpmmgT+8f6nAgW9HIpEFAGA
	surLTXCHL9I5x3Kc/xH9cWTJjefmvM6g6GFiM551Zoxa7ED5PgnSHZcZC26BsmEu
	j7PkzDY9/LojHUNE5usEnajUsJgfAr0zUtN2I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wFaErzXsKC19kWuh6xqusurru7IW1INO
	MEQnRsmBWYZbC6CTFsaOsQ/q+uxZJAx+Aghxmx4yscxPKq2jvZpqY3KjCQvcCkh+
	YEu/uwbVR8vqDfoknncqGF0h8yCTC7kZeusV8AUwBU9G5YAFFMpyIVWfiaK1umXN
	yfnwvkA4jp4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 91E8B480D;
	Wed, 19 Oct 2011 13:07:48 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 27733480C; Wed, 19 Oct 2011
 13:07:48 -0400 (EDT)
In-Reply-To: <4E9EDFEC.3040009@viscovery.net> (Johannes Sixt's message of
 "Wed, 19 Oct 2011 16:34:20 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DEC51694-FA74-11E0-8046-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183936>

Johannes Sixt <j.sixt@viscovery.net> writes:

> I thought there was a way to use git-blame to find out whether a change
> only shuffled lines, but otherwise did not modify them. I tried "git blame
> -M -- the/file",...

You said "a change" and I somehow expected that such a blame would be done
with a revision range, e.g. "git blame -M HEAD^..HEAD -- the/file".

If the two endpoints you are comparing have other commits in between that
make changes then revert them in such a way that the end result cancels
out, "git diff A B -- the/file" won't see such intermediate changes, but
they may interfere with "git blame A..B -- the/file", i.e. when A is not a
direct parent of B.

> ... nor with a 5000+ lines file (with 55 lines moved).

> ... while this produces the same as with just -M:
> $ git blame -M2 -s -- foo

Yes, blame tries to omit matches that consists only of non words, so that
you won't see "all those lines with a single "}" on them that close
definitions for your 100 new functions were copied from the closing brace
of one function you originally had in the file" symptom, and -M<level>
controls it.

> But neither helps with my 5000+ lines file. Does it mean that the lines
> were changed? But I'm sure they were just moved! Please help!

When reviewing a "supposedly move-only" change, I typically just grab +/-
blocks from the patch, remove the +/- prefix and run comparison between
them.
