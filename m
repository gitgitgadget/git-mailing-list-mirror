From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git commit -v does not removes the patch
Date: Tue, 11 Nov 2008 09:13:18 -0800
Message-ID: <7v4p2e2nkg.fsf@gitster.siamese.dyndns.org>
References: <adf1fd3d0811100720n52ac1d47id9b7f402412aa0d3@mail.gmail.com>
 <20081110181023.GA22753@coredump.intra.peff.net>
 <adf1fd3d0811101434j658b2e8aj83d8cbe2293f5021@mail.gmail.com>
 <7vej1j40x5.fsf@gitster.siamese.dyndns.org>
 <20081111000706.GA26223@coredump.intra.peff.net>
 <adf1fd3d0811102356u6e671dcfj6491f81cf462ec2e@mail.gmail.com>
 <20081111102914.GA30330@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Santi =?utf-8?Q?B=C3=A9jar?= <santi@agolina.net>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Nov 11 18:15:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kzwpu-0005XD-Hq
	for gcvg-git-2@gmane.org; Tue, 11 Nov 2008 18:15:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752857AbYKKROO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Nov 2008 12:14:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752753AbYKKROO
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Nov 2008 12:14:14 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:64878 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752446AbYKKRON (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Nov 2008 12:14:13 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 2D59F7B529;
	Tue, 11 Nov 2008 12:14:10 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 016A57B528; Tue,
 11 Nov 2008 12:13:58 -0500 (EST)
In-Reply-To: <20081111102914.GA30330@coredump.intra.peff.net> (Jeff King's
 message of "Tue, 11 Nov 2008 05:29:15 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 27A1647A-B014-11DD-B8FF-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100655>

Jeff King <peff@peff.net> writes:

> But I have to wonder if there is some more robust solution. It seems
> like this can have false positives if you include diff output in your
> commit message, and a potential false negative if you delete the newline
> (e.g., delete everything up to "diff --git", making it the first line).

Actually, I recall (from my googling quite some time ago) people noticing
this, but they learnt to live with it.

We may want to change this.  We can say "# Everything under this line is
deleted." at the beginning of the "#" block we produce in the commit log
message editor, replacing the "Lines starting with '#' will be ignored, "
we currently have.  When reading back the editor result, make "git commit
-v" scan for the "# Everything ..." line.  We remove it and everything
that follows, but we do not touch anything above that line (including the
ones that begin with "diff" or "#") except the usual trailing whitespace
removal.  That way, people can leave a sample shell session with root
prompt, and sample diff, in their message.

If we do not see "# Everything ..." when we read it back, we can do what
we currently do as a fallback.
