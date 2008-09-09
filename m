From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] is_directory(): a generic helper function
Date: Tue, 09 Sep 2008 07:51:06 -0700
Message-ID: <7vprnd8jad.fsf@gitster.siamese.dyndns.org>
References: <1220948830-3275-1-git-send-email-gitster@pobox.com>
 <1220948830-3275-2-git-send-email-gitster@pobox.com>
 <48C6508B.1080600@viscovery.net>
 <20080909123207.GA25799@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Sep 09 16:53:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kd4Zr-0001W6-7B
	for gcvg-git-2@gmane.org; Tue, 09 Sep 2008 16:52:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753270AbYIIOvQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2008 10:51:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752898AbYIIOvQ
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Sep 2008 10:51:16 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:44012 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751176AbYIIOvP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2008 10:51:15 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 7BFA356DE9;
	Tue,  9 Sep 2008 10:51:13 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id C2FBA56DE8; Tue,  9 Sep 2008 10:51:09 -0400 (EDT)
In-Reply-To: <20080909123207.GA25799@coredump.intra.peff.net> (Jeff King's
 message of "Tue, 9 Sep 2008 08:32:07 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: BF826874-7E7E-11DD-B0DE-D0CFFE4BC1C1-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95393>

Jeff King <peff@peff.net> writes:

> On Tue, Sep 09, 2008 at 12:31:39PM +0200, Johannes Sixt wrote:
>
>> Junio C Hamano schrieb:
>> > +/*
>> > + * Do not use this for inspecting *tracked* content.  When path is a
>> > + * symlink to a directory, we do not want to say it is a directory.
>> 
>> I though stat(2) checks the thing that a symlink points to. Then either
>> this comment is not correct or you want to use lstat(2), no?
>
> I assume he meant "do not use this for tracked content, because in that
> case...". But I had to read it twice to make sense.

Sorry, I can't type, but you assumed correctly.  When we are tracking a
path "a/b" where "b" is a submodule, we want to notice the change made by
the user to rmdir "a/b" and replace it with a symbolic link that points
elsewhere, so we shouldn't be using is_directory() in such a codepath.
Worse yet, we also want to catch the case where you "rm -fr a" and make a
symlink that points at a directory that may (or may not) have a
subdirectory "b".  If we were tracking "a/b", then we have to say that the
directory "a/b" does not exist anymore.  It shows that is_directory() is a
wrong function to use while inspecting the tracked content (aka worktree).
