From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] diff: fix textconv error zombies
Date: Wed, 31 Mar 2010 00:17:24 +0200
Message-ID: <201003310017.24979.j6t@kdbg.org>
References: <20100328145301.GA26213@coredump.intra.peff.net> <201003301936.03394.j6t@kdbg.org> <7vk4stv5y5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 31 00:20:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nwjn3-0003bV-HF
	for gcvg-git-2@lo.gmane.org; Wed, 31 Mar 2010 00:20:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754274Ab0C3WTj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 30 Mar 2010 18:19:39 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:55644 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750938Ab0C3WTj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Mar 2010 18:19:39 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id F34FBCDF83;
	Wed, 31 Mar 2010 00:19:32 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 136BF19F6BF;
	Wed, 31 Mar 2010 00:17:25 +0200 (CEST)
User-Agent: KMail/1.9.10
In-Reply-To: <7vk4stv5y5.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143610>

On Dienstag, 30. M=E4rz 2010, Junio C Hamano wrote:
> In "if necessary; see below", I tried to find something to help me ju=
dge
> why you said "That's really not _that_ important in this case", but I
> think I failed.  Perhaps we would want a bit more detailed discussion=
 in
> the document there?

The "if necessary; see below" refers to the cases where the caller requ=
ests a=20
file descriptor from start_command(). It is safe to follow the recipe. =
But I=20
actually would not want to expand on the special case like we have in=20
run_textconv, where it is not strictly necessary to close the fd before=
=20
finish_command(), namely when we know that the writer will exit after i=
t has=20
closed its end of the pipe and the reader reads until EOF.

This could deadlock in the theoretical case that the read() in the pare=
nt=20
returns an error even though the child is still writing data; the child=
 would=20
hang while waiting for the pipe being drained by the parent; but the pa=
rent=20
would wait for the child to exit, which never happens. Doing the close(=
)=20
before finish_command() avoids this situation because the child dies of=
=20
SIGPIPE.

But since the communication is via a pipe, and read failures are highly=
=20
unlikely (and a read failure in a way that the writer does not fail, to=
o, is=20
even more unlikely, I think), the close() before finish_command() is "n=
ot=20
important".

-- Hannes
