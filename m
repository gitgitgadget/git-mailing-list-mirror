From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/5] refactor userdiff textconv code
Date: Fri, 24 Oct 2008 14:12:17 -0700
Message-ID: <7v3ail3dfy.fsf@gitster.siamese.dyndns.org>
References: <20081024024631.GA20365@coredump.intra.peff.net>
 <20081024025330.GC2831@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 24 23:13:57 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KtTye-0008U5-Ds
	for gcvg-git-2@gmane.org; Fri, 24 Oct 2008 23:13:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753801AbYJXVMe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Oct 2008 17:12:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753488AbYJXVMe
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Oct 2008 17:12:34 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:36515 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753254AbYJXVMe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Oct 2008 17:12:34 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 7602873CEE;
	Fri, 24 Oct 2008 17:12:32 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 75F6E73CED; Fri, 24 Oct 2008 17:12:24 -0400 (EDT)
In-Reply-To: <20081024025330.GC2831@coredump.intra.peff.net> (Jeff King's
 message of "Thu, 23 Oct 2008 22:53:30 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 7907BC18-A210-11DD-B6B0-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99066>

Jeff King <peff@peff.net> writes:

> I think this is much cleaner. I have a nagging worry that a
> text-converted filespec might live longer than I expect. Maybe it wou=
ld
> make sense to free the filespec data after the diff has been generate=
d
> (and then further populate_filespec calls would just restore the
> original data).

Either that or drop data_is_textconv and have two sets of <ptr,size> pa=
ir
in filespec, one for real data and another purely for diff text
generation.

But I have a very na=C3=AFve question.

Why isn't this just primarily a patch to diff.c::builtin_diff() functio=
n?

That is, you let fill_mmfile() to fill the real data in mf1 and mf2 as
before, ask one/two if they have textconv, and if so, convert mf1 and m=
f2
in place, and let xdl work on it, like...


	if (fill_mmfile(&mf1, one) < 0 || fill_mmfile(&mf2, two) < 0)
		die("unable to read files to diff");

+	if (has_textconv(one))
+		apply_textconv(one, &mf1);
+	if (has_textconv(two))
+		apply_textconv(two, &mf2);

	if (!DIFF_OPT_TST(o, TEXT) &&
-	    (diff_filespec_is_binary(one) || diff_filespec_is_binary(two))) {
+	    ( (diff_filespec_is_binary(one) && !has_textconv(one)) ||
+	      (diff_filespec_is_binary(two) && !has_textconv(two)) )) {
		/* Quite common confusing case */
		...
	}
	else {
		/* Crazy xdl interfaces.. */
		const char *diffopts =3D getenv("GIT_DIFF_OPTS");
		...
