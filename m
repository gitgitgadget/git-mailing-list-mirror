From: Jim Meyering <jim@meyering.net>
Subject: Re: [PATCH] Don't dereference NULL upon lookup_tree failure.
Date: Sat, 22 Dec 2007 00:33:15 +0100
Message-ID: <87bq8jvd1g.fsf@rho.meyering.net>
References: <873atvwueq.fsf@rho.meyering.net>
	<7v4peb4qbj.fsf@gitster.siamese.dyndns.org>
	<87hcibveut.fsf@rho.meyering.net>
	<7vzlw33a1o.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>,
	Matthew Farrellee <mfarrellee@redhat.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 22 00:33:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5rN8-0006dQ-Uw
	for gcvg-git-2@gmane.org; Sat, 22 Dec 2007 00:33:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756022AbXLUXdS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Dec 2007 18:33:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756690AbXLUXdS
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Dec 2007 18:33:18 -0500
Received: from smtp3-g19.free.fr ([212.27.42.29]:51277 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754308AbXLUXdR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Dec 2007 18:33:17 -0500
Received: from smtp3-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 5D01717B551
	for <git@vger.kernel.org>; Sat, 22 Dec 2007 00:33:16 +0100 (CET)
Received: from mx.meyering.net (mx.meyering.net [82.230.74.64])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 45F5417B548
	for <git@vger.kernel.org>; Sat, 22 Dec 2007 00:33:16 +0100 (CET)
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id E8EEE38096; Sat, 22 Dec 2007 00:33:15 +0100 (CET)
In-Reply-To: <7vzlw33a1o.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Fri, 21 Dec 2007 15:25:23 -0800")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69109>

Junio C Hamano <gitster@pobox.com> wrote:
> Jim Meyering <jim@meyering.net> writes:
>
>>> While this change may be a prudent safeguard, there is something
>>> else going on.  Can you provide the callchain that led to the
>>> parse_object_buffer() that gave SHA1 of a commit object with
>>> type set to OBJ_TREE?  Which caller does that bogus combination?
>>
>> Sure.
>> Here's valgrind output from running this (from my reproducer):
>>
>>     valgrind --trace-children=yes git clone . k
>> ---------------
>>   error: Object 0d57588da39d10795486bd5451bc2660832228e6 is a commit, not a tree
>>   ==9483== Invalid read of size 1
>>   ==9483==    at 0x405C27: parse_object_buffer (object.c:146)
>>   ==9483==    by 0x405CE4: parse_object (object.c:187)
>>   ==9483==    by 0x403185: send_ref (upload-pack.c:561)
>>   ==9483==    by 0x408EEF: do_for_each_ref (refs.c:546)
>>   ==9483==    by 0x4036EC: main (upload-pack.c:587)
>
> Sorry, I asked for a wrong thing.  parse_object() reads and
> finds out the type, so type there is presumably the right type
> of the object (which is OBJ_TREE).  Then parse_object_buffer()
> checks if it has already seen the object of the same SHA-1 and
> finds that somebody had earlier told that SHA-1 name is of a
> commit object.  Either you found a SHA-1 collision (highly
> unlikely) or the earlier caller had lied.  And I think what
> really needs to be fixed is that lying caller.  That is not in
> the above call chain.

I haven't debugged it enough to find/fix the bug in parsecvs.

I presume that parsecvs is the culprit, in constructing
an invalid repository -- especially, since inserting the
single missing tag into the ,v file is enough to make it so
parsecvs creates a repository that no longer triggers the git bug.
