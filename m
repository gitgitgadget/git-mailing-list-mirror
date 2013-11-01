From: Junio C Hamano <gitster@pobox.com>
Subject: Re* [BUG?] "error: cache entry has null sha1"
Date: Fri,  1 Nov 2013 15:44:52 -0700
Message-ID: <1383345895-23341-1-git-send-email-gitster@pobox.com>
References: <20131031172116.GA19428@sigill.intra.peff.net>
Cc: Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 01 23:45:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VcNT2-0002Ft-8K
	for gcvg-git-2@plane.gmane.org; Fri, 01 Nov 2013 23:45:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755773Ab3KAWpF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Nov 2013 18:45:05 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51920 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753905Ab3KAWpD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Nov 2013 18:45:03 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B0C374D126;
	Fri,  1 Nov 2013 18:45:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=3juH
	KZ+Fks/G9PB4VQ2xN6uUGPk=; b=MWQ9h9vcstMBlMan3/3wucRvVzIccLVjFmRz
	bVdHzSn9bXAheRyXAn68FB77g6PdEWr1BJN50iZ7UmQVhj8Cnti5HX2GdU2ewQCG
	kOAHA1ynzm6Au1o7KT7dbsQxmWn3QfxK3N4eDBWLifC9S0iXgBSKlS5IY0mp9Zpt
	UTP9Hss=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	nhB7tYN5HjPq2rnbLsOlcZz2eOjDELj2fkD7U+ZxKqOIuya0F1m0D/UXesrs5Pl7
	3Lkj+CAlWfKx0lhCkI92PrgO+79T1c3qhTSwSRD/xck8AG2ttZMOFRFIEsjFz0vm
	oqAJbOmAcMMoaRBLcoIiO/rj96YgTV2YHfa4L7N5Ryo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A2A684D124;
	Fri,  1 Nov 2013 18:45:00 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0ED0D4D11D;
	Fri,  1 Nov 2013 18:44:57 -0400 (EDT)
X-Mailer: git-send-email 1.8.5-rc0-281-g8951339
In-Reply-To: <20131031172116.GA19428@sigill.intra.peff.net>
X-Pobox-Relay-ID: 3C103154-4347-11E3-BB8B-1FFB7F2839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237227>

Jeff King <peff@peff.net> writes:

> On Thu, Oct 31, 2013 at 01:15:39PM -0400, Jeff King wrote:
>
>> On Thu, Oct 31, 2013 at 10:11:49AM -0700, Junio C Hamano wrote:
>> 
>> >  - Try to discard
>> > 
>> >    $ git am --abort
>> >    error: cache entry has null sha1: remote-curl.c
>> >    fatal: unable to write new index file
>> > 
>> >    This should not happen, no?
>> > 
>> > "git reset --hard" will remove the funnies, but still...
>> 
>> I ran into this recently, too. Isn't it just the twoway_merge bug we
>> were discussing here:
>> 
>>   http://thread.gmane.org/gmane.comp.version-control.git/202440/focus=212316
>> 
>> I don't think we ever actually applied a fix.
>
> Also, the followup:
>
>   http://thread.gmane.org/gmane.comp.version-control.git/217172

OK, so it appears that we sort of agreed that the pieces of patches
in the thread was good at $gmane/217300, but somehow I ended up
veering into a tangent from there and forgot about the topic X-<?

Here is a proposed endgame for the topic in a patch form, then.

I've added a test for low-level "read-tree --reset -u A B", and
tried the "am --abort" I saw the problem with manually, but other
than that, I haven't (re)thought about the issue hard enough to be
comfortable with this change yet.

To be applied on top of c479d14, but the result should be mergeable
cleanly all the way up to 'pu'.

Jeff King (1):
  unpack-trees: fix "read-tree -u --reset A B" with conflicted index

Junio C Hamano (2):
  t1005: reindent
  t1005: add test for "read-tree --reset -u A B"

 t/lib-read-tree.sh         |  52 ++++++++---------
 t/t1005-read-tree-reset.sh | 141 +++++++++++++++++++++++++--------------------
 unpack-trees.c             |  25 +++++---
 3 files changed, 121 insertions(+), 97 deletions(-)

-- 
1.8.5-rc0-281-g8951339
