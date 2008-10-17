From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Detached checkout will clobber branch head when using symlink
 HEAD
Date: Fri, 17 Oct 2008 16:08:42 -0700
Message-ID: <7vfxmuhlad.fsf@gitster.siamese.dyndns.org>
References: <1224095087.5366.19.camel@localhost>
 <20081016191751.GB14707@coredump.intra.peff.net>
 <1224187863.2796.15.camel@localhost>
 <20081016203916.GB9487@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matt Draisey <matt@draisey.ca>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Oct 18 01:10:12 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqySR-0000ME-2p
	for gcvg-git-2@gmane.org; Sat, 18 Oct 2008 01:10:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757340AbYJQXI5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Oct 2008 19:08:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757342AbYJQXI5
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Oct 2008 19:08:57 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:54972 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757332AbYJQXI4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Oct 2008 19:08:56 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 7A61670D4F;
	Fri, 17 Oct 2008 19:08:55 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id DB18870D4E; Fri, 17 Oct 2008 19:08:50 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 9257442E-9CA0-11DD-9153-1E1F86D30F62-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98495>

I do not think that is a correct approach.

The offending callchain is:

  update_ref(..., "HEAD", REF_NODEREF, ...);
  -> lock_any_ref_for_update("HEAD", ..., REF_NODEREF);
   -> lock_ref_sha1_basic("HEAD", ..., REF_NODEREF, ...);
      . calls resolve_ref() to read HEAD to arrive at
        refs/heads/master
      . however, it notices REF_NODEREF and adjusts the ref to be updated
        back to "HEAD";
    -> hold_lock_file_for_update(..., "HEAD", 1);
     -> lock_file(..., "HEAD");
        . resolves symlink "HEAD" to "refs/heads/master", and
          locks it!  This creates "refs/heads/master.lock", that is
          then renamed to "refs/heads/master" when unlocked.

In other words, the breakage is in lock_file() and not in resolve_ref().
The latter gives the same output to the caller whether the HEAD is
symbolic link or textual symref -- at least it should.

The behaviour of lock_file() to resolve symlink at this point in the code
comes from d58e8d3 (When locking in a symlinked repository, try to lock
the original, 2007-07-25), and as explained in the log message of that
commit, we cannot unconditionally remove it.

Three patches to fix this issue, that come on top of the fix to t7201
(--track from detached HEAD should fail) I sent out last night, will
follow.
