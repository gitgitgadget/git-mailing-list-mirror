From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] git-merge-recursive-{ours,theirs}
Date: Sat, 21 Jun 2008 02:46:22 -0700
Message-ID: <7vy74z9l3l.fsf@gitster.siamese.dyndns.org>
References: <93c3eada0806152116v2cef4035u272dc1a26005661a@mail.gmail.com>
 <20080616092554.GB29404@genesis.frugalware.org>
 <48563D6C.8060704@viscovery.net>
 <bd6139dc0806161521p3667a44ble8573be1569986a0@mail.gmail.com>
 <93c3eada0806161545m5c6e1073q5522ce31f72be9f0@mail.gmail.com>
 <7vve076d6t.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0806181618070.6439@racer>
 <alpine.DEB.1.00.0806181627260.6439@racer>
 <7viqw6zovi.fsf@gitster.siamese.dyndns.org>
 <7vfxr8o8sx.fsf_-_@gitster.siamese.dyndns.org>
 <7vbq1wo8ck.fsf_-_@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0806201351370.6439@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: geoffrey.russell@gmail.com, sverre@rabbelier.nl,
	Johannes Sixt <j.sixt@viscovery.net>,
	Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jun 21 11:47:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9zh4-0006R4-ID
	for gcvg-git-2@gmane.org; Sat, 21 Jun 2008 11:47:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752812AbYFUJqk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Jun 2008 05:46:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752781AbYFUJqk
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jun 2008 05:46:40 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:39017 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752760AbYFUJqj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jun 2008 05:46:39 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 6DBC7A710;
	Sat, 21 Jun 2008 05:46:37 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 66EFCA70F; Sat, 21 Jun 2008 05:46:29 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F1151A18-3F76-11DD-9769-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85701>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> @@ -1379,11 +1401,18 @@ int cmd_merge_recursive(int argc, const char **argv, const char *prefix)
>>  	struct lock_file *lock = xcalloc(1, sizeof(struct lock_file));
>>  	int index_fd;
>>  
>> +	merge_recursive_variants = 0;
>>  	if (argv[0]) {
>>  		int namelen = strlen(argv[0]);
>>  		if (8 < namelen &&
>>  		    !strcmp(argv[0] + namelen - 8, "-subtree"))
>> -			subtree_merge = 1;
>> +			merge_recursive_variants = MERGE_RECURSIVE_SUBTREE;
>> +		else if (5 < namelen &&
>> +			 !strcmp(argv[0] + namelen - 5, "-ours"))
>> +			merge_recursive_variants = MERGE_RECURSIVE_OURS;
>> +		else if (7 < namelen &&
>> +			 !strcmp(argv[0] + namelen - 7, "-theirs"))
>> +			merge_recursive_variants = MERGE_RECURSIVE_THEIRS;
>
> This just cries out loud for a new function suffixcmp().

Actually, I think "git-merge-recursive-theirs" is a mistake.  We should
bite the bullet and give "git-merge" an ability to pass backend specific
parameters to "git-merge-recursive".  The new convention could be that
anything that begins with -X is passed to the backend.

E.g.

	git merge -Xfavor=theirs foo
        git merge -Xsubtree=/=gitk-git paulus

As you noticed already, subtree is just a funny optional behaviour
attached to recursive, so are theirs and ours.  The above two would invoke
git-merge-recursive like so:

	git merge-recursive -Xfavor=theirs <base> -- HEAD MERGE_HEAD
	git merge-recursive -Xsubtree=/=gitk-git <base> -- HEAD MERGE_HEAD

We could even mix these two if we are ambitious.
