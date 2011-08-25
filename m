From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's the difference between `git show branch:file | diff -u -
 file` vs `git diff branch file`?
Date: Thu, 25 Aug 2011 14:10:05 -0700
Message-ID: <7vy5yhi4eq.fsf@alter.siamese.dyndns.org>
References: <loom.20110823T091132-107@post.gmane.org>
 <4E537AF0.9070604@drmicha.warpmail.net>
 <1314096731.15017.2.camel@n900.home.ru>
 <4E53C89A.9000604@drmicha.warpmail.net>
 <7vk4a4rqvb.fsf@alter.siamese.dyndns.org>
 <4E54088F.7050700@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marat Radchenko <marat@slonopotamus.org>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Aug 25 23:10:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QwhBu-00084I-E5
	for gcvg-git-2@lo.gmane.org; Thu, 25 Aug 2011 23:10:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754146Ab1HYVKP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Aug 2011 17:10:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47380 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753627Ab1HYVKN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Aug 2011 17:10:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DC8804A95;
	Thu, 25 Aug 2011 17:10:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CFa+Q49l33Fg+t4RyFdTUbA3Ewk=; b=OtuBxO
	NHHmBynmtj4EVFsmhvf+9vdGqIQMtouL+85VJRJFWs9GiYp4Ua6zOZjNUeaQSsdD
	qwvug7EsXcMsa5qaEdAsNyzss1jIaoAxsdgxSQHZz4FKsYDAoV4T3dyaBA6omDTj
	X53yVhU0W2zO90NXM3ehPtzrh0mnklb4YxLsA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=x1tHjUL+eGXPpqXRIRup7NwT0ENXvO+e
	lLoW0nYlz9+xpunFUX9eCAZF2aSMWlQmRO6pelJpXuCcK8l+oZFsumctbbKqi4k6
	LaCOFuhWcTvWgMclixJTVvaQOOJYztMHdhIh4W/tzRyqCIKr82fW/x9fHnlTUvEI
	6js+IJXgrNg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D434F4A94;
	Thu, 25 Aug 2011 17:10:12 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8FECB4A93; Thu, 25 Aug 2011
 17:10:06 -0400 (EDT)
In-Reply-To: <4E54088F.7050700@drmicha.warpmail.net> (Michael J. Gruber's
 message of "Tue, 23 Aug 2011 22:07:43 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9BA102A6-CF5E-11E0-BDE0-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180118>

Michael J Gruber <git@drmicha.warpmail.net> writes:

>> The default diff backend tries to come up with minimal changes by spending
>> extra cycles, so it is not so surprising if the file compared is large-ish
>> and/or has very many similar lines in itself (in which case there are many
>> potential matching line pairs between the preimage and the postimage to be
>> examined to produce a minimal diff).
>
> But the file in this case is not that large, and "git diff" spends 30s!

If the difference was literally between

 $ git diff branch -- file
 $ git show branch:file | diff -u - file

that is, "file" is the name of a file in the top-level directory, I would
expect that former would open the top-level tree object for the branch,
read it thru until it finds "file", grabs a single blob and deflate it in
core, and compare that with the contents of a single file read from the
filesystem.

An interesting comparison may be to run this once:

   $ git show branch:file >fileI

and then compare between these two:

    $ diff -u fileI file
    $ git diff --no-index fileI file

If the latter is slower than the former in the same way as the original
experiment, that would mean that the tree traversal time does not have
anything to do with it (iow, your "The way 'git diff' is now, it does
that" is not just incorrect---we don't read the full tree to begin
with---but irrelevant).

If the "we try to come up with minimal changes by spending extra cycles" I
mentioned in my messages is indeed the cause, you may see diffferences
running the "git diff --no-index" version with backend options, e.g.

    $ git diff --no-index --patience fileI file
    $ git diff --no-index --histogram fileI file

Another thing to try may be to run the version from "next" that has
27af01d (xdiff/xprepare: improve O(n*m) performance in xdl_cleanup_records(),
2011-08-17), without any backend options.
