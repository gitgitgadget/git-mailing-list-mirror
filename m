From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] pretty=format: Avoid some expensive calculations when not needed
Date: Wed, 07 Nov 2007 12:43:49 -0800
Message-ID: <7vhcjxaire.fsf@gitster.siamese.dyndns.org>
References: <Pine.LNX.4.64.0711041912190.4362@racer.site>
	<Pine.LNX.4.64.0711041915290.4362@racer.site>
	<7v8x5cqxn0.fsf@gitster.siamese.dyndns.org>
	<472F7B2F.4050608@lsrfire.ath.cx>
	<7vejf4kwry.fsf@gitster.siamese.dyndns.org>
	<4730EB4E.4080903@lsrfire.ath.cx> <4730F5FA.3030705@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Wed Nov 07 21:44:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IprlF-0005mh-5N
	for gcvg-git-2@gmane.org; Wed, 07 Nov 2007 21:44:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755461AbXKGUn5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Nov 2007 15:43:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755408AbXKGUn4
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 15:43:56 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:43845 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755374AbXKGUnz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Nov 2007 15:43:55 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 4613B2FC;
	Wed,  7 Nov 2007 15:44:17 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id AD77B933BF;
	Wed,  7 Nov 2007 15:44:13 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63857>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> I haven't seen any comments on strbuf_expand.  Is it too far out?
> Here it is again, adjusted for current master and with the changes
> to strbuf.[ch] coming first:

Numbers talk ;-).

In your previous round, you alluded that the strbuf_expand()
interface could allow caching of the return value of fn(), but I
do not think strbuf_expand() in this patch has anything to
directly support that notion.

Nor I would expect to --- fn() could keep the really expensive
information cached, keyed with context value, if it wanted to,
but in practice for the purpose of format_commit_item() I do not
offhand see anything cacheable and reusable, unless the user did
stupid things (e.g. use more than one %h in the format string).

I added a few paragraphs to describe the API in the commit log
message, and rewrote "# master" to "(master)" etc.

-- >8 --
pretty=3Dformat: Avoid some expensive calculations when not needed

This rewrites the custom format prettyprinter for commit objects
by introducing a new strbuf API function "strbuf_expand()".

The function takes a format string, list of placeholder strings,
a user supplied function 'fn', and an opaque pointer 'context'
to tell 'fn' what thingy to operate on.

The function 'fn' is expected to accept a strbuf, a parsed
placeholder string and the 'context' pointer, and append the
interpolated value for the 'context' thingy, according to the
format specified by the placeholder.

Here my measurements of most of Paul's test cases (best of
three runs):

(master)
$ time git log --pretty=3Doneline >/dev/null

=2E..
