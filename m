From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Don't dereference NULL upon lookup_tree failure.
Date: Fri, 21 Dec 2007 15:25:23 -0800
Message-ID: <7vzlw33a1o.fsf@gitster.siamese.dyndns.org>
References: <873atvwueq.fsf@rho.meyering.net>
	<7v4peb4qbj.fsf@gitster.siamese.dyndns.org>
	<87hcibveut.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>,
	Matthew Farrellee <mfarrellee@redhat.com>
To: Jim Meyering <jim@meyering.net>
X-From: git-owner@vger.kernel.org Sat Dec 22 00:25:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5rFb-0004Ul-GC
	for gcvg-git-2@gmane.org; Sat, 22 Dec 2007 00:25:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753675AbXLUXZb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Dec 2007 18:25:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755358AbXLUXZb
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Dec 2007 18:25:31 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:57654 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753583AbXLUXZb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Dec 2007 18:25:31 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 7603C57BF;
	Fri, 21 Dec 2007 18:25:29 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 4F6B157BD;
	Fri, 21 Dec 2007 18:25:25 -0500 (EST)
In-Reply-To: <87hcibveut.fsf@rho.meyering.net> (Jim Meyering's message of
	"Fri, 21 Dec 2007 23:54:02 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69108>

Jim Meyering <jim@meyering.net> writes:

>> While this change may be a prudent safeguard, there is something
>> else going on.  Can you provide the callchain that led to the
>> parse_object_buffer() that gave SHA1 of a commit object with
>> type set to OBJ_TREE?  Which caller does that bogus combination?
>
> Sure.
> Here's valgrind output from running this (from my reproducer):
>
>     valgrind --trace-children=yes git clone . k
> ---------------
>   error: Object 0d57588da39d10795486bd5451bc2660832228e6 is a commit, not a tree
>   ==9483== Invalid read of size 1
>   ==9483==    at 0x405C27: parse_object_buffer (object.c:146)
>   ==9483==    by 0x405CE4: parse_object (object.c:187)
>   ==9483==    by 0x403185: send_ref (upload-pack.c:561)
>   ==9483==    by 0x408EEF: do_for_each_ref (refs.c:546)
>   ==9483==    by 0x4036EC: main (upload-pack.c:587)

Sorry, I asked for a wrong thing.  parse_object() reads and
finds out the type, so type there is presumably the right type
of the object (which is OBJ_TREE).  Then parse_object_buffer()
checks if it has already seen the object of the same SHA-1 and
finds that somebody had earlier told that SHA-1 name is of a
commit object.  Either you found a SHA-1 collision (highly
unlikely) or the earlier caller had lied.  And I think what
really needs to be fixed is that lying caller.  That is not in
the above call chain.
