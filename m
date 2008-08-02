From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] hash-object --no-filters
Date: Sat, 02 Aug 2008 10:28:13 -0700
Message-ID: <7vmyjvnx76.fsf_-_@gitster.siamese.dyndns.org>
References: <200807231544.23472.litvinov2004@gmail.com>
 <200807311257.49108.litvinov2004@gmail.com>
 <20080731104529.GE7008@dpotapov.dyndns.org>
 <200808011023.32139.litvinov2004@gmail.com>
 <37fcd2780808010047t4ae20168y65103e90897dd3f8@mail.gmail.com>
 <7vbq0dtawp.fsf@gitster.siamese.dyndns.org>
 <37fcd2780808010224l68c2c717y5334a34d9de1de8d@mail.gmail.com>
 <7vmyjwserv.fsf@gitster.siamese.dyndns.org>
 <20080801220932.GK7008@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alexander Litvinov <litvinov2004@gmail.com>, git@vger.kernel.org,
	Eric Wong <normalperson@yhbt.net>
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 02 19:29:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPKuw-0002NT-Js
	for gcvg-git-2@gmane.org; Sat, 02 Aug 2008 19:29:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751785AbYHBR2V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Aug 2008 13:28:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751555AbYHBR2V
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Aug 2008 13:28:21 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:48059 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751440AbYHBR2V (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Aug 2008 13:28:21 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 1DA594815D;
	Sat,  2 Aug 2008 13:28:20 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id E886648143; Sat,  2 Aug 2008 13:28:14 -0400 (EDT)
In-Reply-To: <20080801220932.GK7008@dpotapov.dyndns.org> (Dmitry Potapov's
 message of "Sat, 2 Aug 2008 02:09:32 +0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 668367C0-60B8-11DD-9784-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91158>

Dmitry Potapov <dpotapov@gmail.com> writes:

> The --no-filters option makes git hash-object to work as there were no
> input filters. This option is useful for importers such as git-svn to
> put new version of files as is even if autocrlf is set.

I think this is going in the right direction, but I have to wonder a few
things.

First, on hash-object.

 (1) "hash-object --stdin" always hashes literally.  We may want to be
     able to say "The contents is this but pretend it came from this path
     and apply the usual input rules", perhaps with "--path=" option;

 (2) "hash-object temporaryfile" may want to honor the same "--path"
     option;

 (3) "hash-object --stdin-paths" may want to get pair of paths (i.e. two
     lines per entry) to do the same.

If we want to do the above, the existing low-level interface needs to be
adjusted.

index_pipe() and index_fd() can learn to take an additional string
parameter for attribute lookup to implement (1) and (2) above.  Perhaps
the string can be NULL to signal --no-filter behaviour, in which case the
HASH_OBJECT_LITERALLY change may not be necessary for this codepath.

index_path() is a healper for add_to_index() which is used for normal
addition of working tree entities, and I do not see an immediate need to
teach it about this "use this different path for attribute lookup" at
least for now.

By the way, why do we have index_pipe() and index_fd() to begin with?  Is
it because users of index_pipe() do not know what the path it is hashing
and also the fd being a pipe we cannot mmap it?

If these two are the only reasons, then I wonder if we can:

 - accept NULL as path and stat parameters for callers without a filename
   (which automatically implies we are doing a regular blob and we hash
   literally); and

 - first try to mmap(), and if it fails fall back to the "read once into
   strbuf" codepath to solve mmap-vs-pipe issue.

I am not sure if such a unification of these two functions is useful,
though.
