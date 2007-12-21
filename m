From: Jim Meyering <jim@meyering.net>
Subject: Re: [PATCH] Don't dereference NULL upon lookup_tree failure.
Date: Fri, 21 Dec 2007 23:54:02 +0100
Message-ID: <87hcibveut.fsf@rho.meyering.net>
References: <873atvwueq.fsf@rho.meyering.net>
	<7v4peb4qbj.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>,
	Matthew Farrellee <mfarrellee@redhat.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 21 23:54:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5qlA-000334-S6
	for gcvg-git-2@gmane.org; Fri, 21 Dec 2007 23:54:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755297AbXLUWyF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Dec 2007 17:54:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757603AbXLUWyF
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Dec 2007 17:54:05 -0500
Received: from smtp3-g19.free.fr ([212.27.42.29]:45891 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754947AbXLUWyE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Dec 2007 17:54:04 -0500
Received: from smtp3-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp3-g19.free.fr (Postfix) with ESMTP id D60EB17B550
	for <git@vger.kernel.org>; Fri, 21 Dec 2007 23:54:02 +0100 (CET)
Received: from mx.meyering.net (mx.meyering.net [82.230.74.64])
	by smtp3-g19.free.fr (Postfix) with ESMTP id BD7D517B544
	for <git@vger.kernel.org>; Fri, 21 Dec 2007 23:54:02 +0100 (CET)
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id 9718A371A6; Fri, 21 Dec 2007 23:54:02 +0100 (CET)
In-Reply-To: <7v4peb4qbj.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Fri, 21 Dec 2007 14:48:32 -0800")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69104>

Junio C Hamano <gitster@pobox.com> wrote:

> Jim Meyering <jim@meyering.net> writes:
>
>> When running on an x86_64 system (either debian unstable or rawhide)
>> I see only this:
>>
>>   0 blocks
>>   error: Object 0d57588da39d10795486bd5451bc2660832228e6 is a commit, not a tree
>>   fatal: The remote end hung up unexpectedly
>>...
>> diff --git a/object.c b/object.c
>> index 16793d9..eb59550 100644
>> --- a/object.c
>> +++ b/object.c
>> @@ -142,10 +142,14 @@ struct object *parse_object_buffer(const unsigned char *sha1, enum object_type t
>>  		obj = &blob->object;
>>  	} else if (type == OBJ_TREE) {
>>  		struct tree *tree = lookup_tree(sha1);
>> -		obj = &tree->object;
>> -		if (!tree->object.parsed) {
>> -			parse_tree_buffer(tree, buffer, size);
>> -			eaten = 1;
>> +		if (!tree)
>> +		    obj = NULL;
>> +		else {
>> +		    obj = &tree->object;
>> +		    if (!tree->object.parsed) {
>> +			    parse_tree_buffer(tree, buffer, size);
>> +			    eaten = 1;
>> +		    }
>>  		}
>>  	} else if (type == OBJ_COMMIT) {
>>  		struct commit *commit = lookup_commit(sha1);
>
> While this change may be a prudent safeguard, there is something
> else going on.  Can you provide the callchain that led to the
> parse_object_buffer() that gave SHA1 of a commit object with
> type set to OBJ_TREE?  Which caller does that bogus combination?

Sure.
Here's valgrind output from running this (from my reproducer):

    valgrind --trace-children=yes git clone . k
---------------
  error: Object 0d57588da39d10795486bd5451bc2660832228e6 is a commit, not a tree
  ==9483== Invalid read of size 1
  ==9483==    at 0x405C27: parse_object_buffer (object.c:146)
  ==9483==    by 0x405CE4: parse_object (object.c:187)
  ==9483==    by 0x403185: send_ref (upload-pack.c:561)
  ==9483==    by 0x408EEF: do_for_each_ref (refs.c:546)
  ==9483==    by 0x4036EC: main (upload-pack.c:587)
  ==9483==  Address 0x0 is not stack'd, malloc'd or (recently) free'd
  ==9483==
  ==9483== Process terminating with default action of signal 11 (SIGSEGV)
  ==9483==  Access not within mapped region at address 0x0
  ==9483==    at 0x405C27: parse_object_buffer (object.c:146)
  ==9483==    by 0x405CE4: parse_object (object.c:187)
  ==9483==    by 0x403185: send_ref (upload-pack.c:561)
  ==9483==    by 0x408EEF: do_for_each_ref (refs.c:546)
  ==9483==    by 0x4036EC: main (upload-pack.c:587)
  ...
  fatal: The remote end hung up unexpectedly
