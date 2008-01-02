From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Optimize prefixcmp()
Date: Wed, 02 Jan 2008 10:52:13 -0800
Message-ID: <7v1w90xdpe.fsf@gitster.siamese.dyndns.org>
References: <e5bfff550712291001q5f246ceah6700b98308fb96f1@mail.gmail.com>
	<Pine.LNX.4.64.0712292019450.14355@wbgn129.biozentrum.uni-wuerzburg.de>
	<477BC2DA.6000105@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Marco Costalba <mcostalba@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Wed Jan 02 19:52:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JA8hw-0005Uv-NL
	for gcvg-git-2@gmane.org; Wed, 02 Jan 2008 19:52:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752549AbYABSw0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Jan 2008 13:52:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752542AbYABSw0
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jan 2008 13:52:26 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:47696 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752175AbYABSwZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Jan 2008 13:52:25 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 93621310E;
	Wed,  2 Jan 2008 13:52:22 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id EA00830A9;
	Wed,  2 Jan 2008 13:52:16 -0500 (EST)
In-Reply-To: <477BC2DA.6000105@lsrfire.ath.cx> (=?utf-8?Q?Ren=C3=A9?=
 Scharfe's message of
	"Wed, 02 Jan 2008 17:59:06 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69483>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> prefixcmp() was already optimized before -- only for a different use
> case.  At a number of callsites the prefix is a string literal, which
> allowed the compiler to perform the strlen() call at compile time.
>
> The patch increases the text size considerably: the file "git" is
> 2,620,938 without and 2,640,450 with the patch in my build (there are
> 136 callsites in builtin*.c).  The new version of prefixcmp() shouldn=
't
> be inlined any more, as the benefit of doing so is gone.

Yuck, you are absolutely right.  The late thread may have been
well intentioned but resulted in this regression.  Sorry about
that.

I presume that all callers with constant prefix are outside
performance critical parts?  Can we simply uninline the function
in that case?
