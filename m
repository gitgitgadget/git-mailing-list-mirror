From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] [RFC] Design for pathname encoding gitattribute [RESEND]
Date: Tue, 22 Jan 2008 01:16:15 -0800
Message-ID: <7vbq7erzj4.fsf@gitster.siamese.dyndns.org>
References: <20080122050215.DE198200A2@wilber.wgtn.cat-it.co.nz>
	<7vlk6iv0ik.fsf@gitster.siamese.dyndns.org>
	<7vr6gatidd.fsf@gitster.siamese.dyndns.org>
	<fn48bp$ff8$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mark Junker <mjscod@web.de>
X-From: git-owner@vger.kernel.org Tue Jan 22 10:17:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHFFc-0002th-Fd
	for gcvg-git-2@gmane.org; Tue, 22 Jan 2008 10:17:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755478AbYAVJQb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2008 04:16:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755426AbYAVJQ3
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jan 2008 04:16:29 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:63254 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755404AbYAVJQ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jan 2008 04:16:28 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 306C8388A;
	Tue, 22 Jan 2008 04:16:26 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 86CE33889;
	Tue, 22 Jan 2008 04:16:22 -0500 (EST)
In-Reply-To: <fn48bp$ff8$1@ger.gmane.org> (Mark Junker's message of "Tue, 22
	Jan 2008 09:09:33 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71435>

Mark Junker <mjscod@web.de> writes:

> Just to sum up what you wrote and to be sure that I understand you
> correctly:
>
> Lets have two encodings:
> - Encoding for path names stored in the repository
> - Encoding for path names from/to file systems
>
> Do conversion only if they are different. Both encodings are configurable.

Not really.

 1. Encoding for the project does not have to be specified at
    all.  The project participants are expected to know about it
    out of band.

 2. Conversion for path names between filesystems and the
    project (i.e. "paths in tree objects") can be specified per
    repository (i.e. "a particular clone of the project").  We
    could even allow the conversion function to be different
    per-path-component but I suspect that would be a much
    future addition that nobody would use in practice.

 3. Suggest use of UTF-8-NFC as the project encoding as a BCP,
    but never enforce it.  It is a responsibility of the owner
    of the particular repository to make sure that the
    conversions used in a particular repository (again, "a
    particular clone of the project") produces the desired
    encoding in the tree objects.

But please take these with a moderately large grain of salt, as
I was more or less handwaving and pretending to know what I was
talking about ;-).  I think this should work in theory, but I at
the same time suspect that there are many more places than just
readdir(3) that need to be wrapped if we take this approach, and
the intrusiveness factor might make this infeasible in practice.

The difference between your version and my 1. and 2. is very
subtle, but comes primarily from my desire not to have to use
the word "canonical".  Yours define "this canonical encoding is
used in the repository, and we convert back and forth to that
local encoding", as opposed to my saying "here are to and from
conversion functions".  The latter is more in line with how we
define smudge/clean filters for blob contents conversion, in
that the "encoding" used in in-repository blob does not have to
even have a name.
