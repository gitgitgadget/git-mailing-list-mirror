From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [Btrfs-devel] btrfs and git-reflog
Date: Fri, 25 Jan 2008 23:52:16 -0800
Message-ID: <7v7ihx2fdb.fsf@gitster.siamese.dyndns.org>
References: <873asmcodd.fsf@burly.wgtn.ondioline.org>
	<200801251050.16697.chris.mason@oracle.com>
	<alpine.LFD.1.00.0801250905570.14161@hp.linux-foundation.org>
	<7vmyqt657t.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Chris Mason <chris.mason@oracle.com>, btrfs-devel@oss.oracle.com,
	Paul Collins <paul@burly.ondioline.org>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Jan 26 08:53:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JIfqh-0004gw-KR
	for gcvg-git-2@gmane.org; Sat, 26 Jan 2008 08:53:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752514AbYAZHw1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jan 2008 02:52:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752490AbYAZHw1
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Jan 2008 02:52:27 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:38646 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752484AbYAZHw0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jan 2008 02:52:26 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id D47DA2F14;
	Sat, 26 Jan 2008 02:52:23 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 1E48E2F13;
	Sat, 26 Jan 2008 02:52:17 -0500 (EST)
In-Reply-To: <7vmyqt657t.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Fri, 25 Jan 2008 12:05:42 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71764>

Junio C Hamano <gitster@pobox.com> writes:

> I agree that this is a broken assumption on git's part.  When we
> have this loop:
>
> 	while (ent = readdir()) {
>         	... do something in that directory ...
> 	}
>
> we should expect readdir() may return new entries and cope with
> it, as "If a file is removed from or added to the directory
> after the most recent call to opendir() or rewinddir(), whether
> a subsequent call to readdir() returns an entry for that file is
> unspecified." [*1*]

Here is a result of a mini-audit.

* builtin-prune-packed.c::prune_dir() loops and unlinks (some
  of) returned paths while in the loop.  This should not
  interfere with readdir(3).  I am presuming that we can declare
  readdir(3) implementation buggy if this happens:

	* opendir();
	* readdir() gives $P;
        * unlink($P);
        * readdir() later gives $P again.

  Otherwise we need to lose check for return value from
  unlink().

* builtin-prune.c::prune_dir() has a similar construct and the
  same (non-)issue.

* dir.c::remove_dir_recursively() -- likewise.

* entry.c::remove_subtree() -- likewise.  We might want to unify
  this with the previous one.

A patch to "reflog-expire --all" will follow in a separate
message.
