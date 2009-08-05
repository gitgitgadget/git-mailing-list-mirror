From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git index: how does it work?
Date: Wed, 05 Aug 2009 11:00:27 -0700
Message-ID: <7v7hxi9m4k.fsf@alter.siamese.dyndns.org>
References: <loom.20090805T160528-69@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Shaun Cutts <shaun@cuttshome.net>
X-From: git-owner@vger.kernel.org Wed Aug 05 20:00:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYkn2-0001mo-9b
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 20:00:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751319AbZHESAc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 14:00:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751189AbZHESAc
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 14:00:32 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:63370 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751177AbZHESAb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2009 14:00:31 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 3DBFB21981;
	Wed,  5 Aug 2009 14:00:32 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 91D662197D; Wed, 
 5 Aug 2009 14:00:29 -0400 (EDT)
In-Reply-To: <loom.20090805T160528-69@post.gmane.org> (Shaun Cutts's message
 of "Wed\, 5 Aug 2009 16\:21\:38 +0000 \(UTC\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: DE2AFEAC-81E9-11DE-ACA4-F699A5B33865-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124934>

Shaun Cutts <shaun@cuttshome.net> writes:

> I am wondering if someone could explain and/or point me to an explanation of how
> the git index works.
>
> For instance, suppose I have a tracked file: "foo.c"
>
> 1) [I modify "foo.c"]
> 2) git add foo.c
> 3) [modify again]
> 4) git commit -m "blah blah"
>
> Since I don't include the "-a" switch, the version I added on step 2 is
> committed. But how does the index keep track of these changes? Does the index
> file actually contain the hunks of "foo.c" that have been modified? Or is there
> a "temporary" blob created, which the index points to? 

Step 2 hashes foo.c and creates a blob object and registers it to the
index.  Step 4 writes out the index as a tree and makes a commit out of
it.

Running this sequence might be instructive.

	1$ edit foo.c
        2$ git add foo.c
        2a$ git ls-files -s foo.c
	2b$ git diff foo.c
        2c$ git diff --cached foo.c
        3$ edit foo.c
        3a$ git ls-files -s foo.c
	3b$ git diff foo.c
        3c$ git diff --cached foo.c
        4$ git commit -m 'half-edit of foo.c'
        4a$ git ls-files -s foo.c
	4b$ git ls-tree HEAD foo.c
        4c$ git diff foo.c
        4d$ git diff --cached foo.c

 - 2a shows the actual blob object that was created out of foo.c in step 2.

 - 2b shows the difference between that blob (now in the index) and foo.c,
   which should be empty.

 - 2c shows the difference between the HEAD commit and the index, which
   should show your edit in step 1.

 - 3a shows the blob in the index; you haven't added, so it should show
   the same as 2a.

 - 3b shows the difference between the index and foo.c, which should show
   the edit in step 3.

 - 3c shows the difference between the HEAD commit and the index, which
   should show your edit in step 1.

 - 4a shows the blob in the index; you haven't added, so it should show
   the same as 2a.

 - 4b shows the blob in the committed tree and the blob object should be
   identical to 2a.

 - 4c shows the difference between the index and foo.c, which should show
   the edit in step 3.

 - 4d shows the difference between the HEAD commit and the index, which
   should now be empty.
