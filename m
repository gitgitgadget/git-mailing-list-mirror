From: Yuval Kogman <nothingmuch@woobling.org>
Subject: Re: [PATCH] Don't try to reclose in command_close_bidi_pipe
Date: Fri, 30 Jan 2009 17:06:11 +0200
Message-ID: <a891e1bd0901300706h4fdffe24m78c418f8c1ae7cd8@mail.gmail.com>
References: <1233291570-23295-1-git-send-email-nothingmuch@woobling.org>
	 <be6fef0d0901300635v4e6009f1n7da405ebc4c8dd68@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 30 16:07:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSuy7-000471-9D
	for gcvg-git-2@gmane.org; Fri, 30 Jan 2009 16:07:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752394AbZA3PGR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jan 2009 10:06:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756607AbZA3PGQ
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jan 2009 10:06:16 -0500
Received: from fg-out-1718.google.com ([72.14.220.157]:1683 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752390AbZA3PGP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jan 2009 10:06:15 -0500
Received: by fg-out-1718.google.com with SMTP id 16so39831fgg.17
        for <git@vger.kernel.org>; Fri, 30 Jan 2009 07:06:11 -0800 (PST)
Received: by 10.86.100.19 with SMTP id x19mr733232fgb.18.1233327971525; Fri, 
	30 Jan 2009 07:06:11 -0800 (PST)
In-Reply-To: <be6fef0d0901300635v4e6009f1n7da405ebc4c8dd68@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107830>

Resending, forgot to CC

2009/1/30 Tay Ray Chuan <rctay89@gmail.com>
> From this message, you seem to intend this as a fix. Can you tell us
> how one might go about to reproduce this issue?

Here is an example:
http://github.com/yanick/git-cpan-patch/blob/ed67d3f86f371764935fd0da3e7f08536c95b606/git-cpan-import#L190

Since git-commit-tree requires the message to be written before it can
write the sha1 of the new commit object, the handle has to be closed
already, which makes command_close_bidi_pipe die with an error.
The workaround in the linked code reopens a fake handle so that
close() will not error.
For what it's worth, I've been poking at t/t9700/test.pl but since
it's pretty sparse I figured I should contribute this fix
independently.

> Is "unless defined(fileno($fh))" a reliable way to check if the handle
> is closed?

Yes, since the handle is expected to be the result of a pipe open. The
documentation refers to this case:

    open my $fh, "<", \$buffer;

in which case the filehandle $fh has no associated file descriptor.

fileno() is not a universal check, but it is applicable in this situation.
