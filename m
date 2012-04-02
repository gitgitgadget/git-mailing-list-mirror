From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: Bug: bad errno report from lock_ref_sha1_basic() when contents bad
Date: Mon, 2 Apr 2012 20:12:05 +0200
Message-ID: <87bonam2a2.fsf@thomas.inf.ethz.ch>
References: <878viephzm.fsf@thomas.inf.ethz.ch>
	<7vhax2ghy1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 02 20:12:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SEljk-0004uu-15
	for gcvg-git-2@plane.gmane.org; Mon, 02 Apr 2012 20:12:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752875Ab2DBSMK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Apr 2012 14:12:10 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:49061 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752391Ab2DBSMJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Apr 2012 14:12:09 -0400
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.283.3; Mon, 2 Apr
 2012 20:12:05 +0200
Received: from thomas.inf.ethz.ch.ethz.ch (80.219.159.2) by CAS21.d.ethz.ch
 (172.31.51.111) with Microsoft SMTP Server (TLS) id 14.1.355.2; Mon, 2 Apr
 2012 20:12:07 +0200
In-Reply-To: <7vhax2ghy1.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 02 Apr 2012 10:30:14 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [80.219.159.2]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194544>

Junio C Hamano <gitster@pobox.com> writes:

> Thomas Rast <trast@inf.ethz.ch> writes:
>
>> But in general, the "errno may
>> be crucial or worthless" interface of lock_ref_sha1_basic() seems a bit
>> broken...
>
> Sorry, but I am not sure what you mean by this.  The function is fairly
> careful using errno to base its decision and even saves errno when it
> calls helpers that may overwrite it, so the "interface" does not want "may
> be crucial or worthless".  The implementation may have been broken over
> time by many patches, but that is a different issue.  Which codepaths
> clobber errno, and is it something you can easily fix with a patch or two?

I meant something else, sorry for being so unclear and confused.  In
particular my comment was supposed to be about resolve_ref_unsafe().

It has two different failure modes:

* Some FS syscall went wrong, and errno is crucial for the user to debug
  it (e.g., ENOENT).

* Reading went fine, but we failed to parse the resulting buffer.  errno
  has some unknown value.

The user of the function needs to be aware of this distinction, and
handle it accordingly.  Otherwise it risks emitting outright wrong error
messages, e.g., in my case I got

  thomas@thomas:~/g(next u+107)$ echo garbage >.git/refs/remotes/origin/master
  thomas@thomas:~/g(next u+107)$ g fetch
  error: unable to resolve reference refs/remotes/origin/master: No such file or directory
  From git://git.kernel.org/pub/scm/git/git
   ! [new branch]      master     -> origin/master  (unable to update local ref)

(The IRC user who asked about this was lucky because "Success"
immediately told us that it was an error path not related to syscalls.)

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
