From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] fill_textconv(): Don't get/put cache if sha1 is not
 valid
Date: Mon, 20 Dec 2010 00:42:27 -0800
Message-ID: <7v4oa8esy4.fsf@alter.siamese.dyndns.org>
References: <b714f1939ef4fc73cb5f55c1d7784a08a34d3c3d.1292681111.git.kirr@landau.phys.spbu.ru> <14308c2dd50037246e319649944d308b9f32fc39.1292681111.git.kirr@landau.phys.spbu.ru> <20101218161337.GB18643@sigill.intra.peff.net> <7vr5dddvrk.fsf@alter.siamese.dyndns.org> <20101220044214.GA5942@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Kirill Smelkov <kirr@landau.phys.spbu.ru>, git@vger.kernel.org,
	Axel Bonnet <axel.bonnet@ensimag.imag.fr>,
	=?utf-8?Q?Cl=C3=A9ment?= Poulain 
	<clement.poulain@ensimag.imag.fr>,
	Diane Gasselin <diane.gasselin@ensimag.imag.fr>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Dec 20 09:42:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PUbKW-0002eq-7l
	for gcvg-git-2@lo.gmane.org; Mon, 20 Dec 2010 09:42:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754387Ab0LTImr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Dec 2010 03:42:47 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:65480 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754259Ab0LTImq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Dec 2010 03:42:46 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4ED94240A;
	Mon, 20 Dec 2010 03:43:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Of7HiOhKaCVdhLnmp1HyA5dQzeU=; b=Hbpfln
	dv7mNo/Hu3W3z8Idpq5gUQtqjiOXlXzFKkSO8bKca5SwxuYQ/laHiPDVwRah4WMW
	evMRWHvntLs9/012/Q2JCL20kRfGoOStHQwuk1WNzYIEPgcinET+Fpm3GR1iB2do
	mW7viCDwQOCIQAh+b+rkVMW7WDYu/PXI766f4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=x1ljf9soIdZZ37V+KgJa3rRCpyTUfygV
	MQkoKDdvbTO9R1uf1PVMIg85tWcj3RF+QdY4uG+9L5Y0yJ+rDf6AM2w8uShhuWvy
	J9HvZJAISxAsacqqFJwrh+Idf+EQoOdgspS3cU934U92KV+QX0cZdbbjSN6nOyPd
	fv2pB+cTz28=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B34952408;
	Mon, 20 Dec 2010 03:43:06 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 512E82407; Mon, 20 Dec 2010
 03:42:57 -0500 (EST)
In-Reply-To: <20101220044214.GA5942@sigill.intra.peff.net> (Jeff King's
 message of "Sun\, 19 Dec 2010 23\:42\:15 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2A6E1310-0C15-11E0-85B6-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163988>

Jeff King <peff@peff.net> writes:

> On Sun, Dec 19, 2010 at 06:26:55PM -0800, Junio C Hamano wrote:
> ...
>> FILE_VALID() is about "does that side have a blob there, or is this
>> create/delete diff?", so the caller should be handling this properly as
>> you said, but your fill_textconv() already prepares for the case where the
>> caller for some reason calls this function with "no blob on this side" and
>> returns an empty string (see the precontext of your patch).
>> 
>> I think it is fine to be defensive to prepare for such a case, but then
>> dying like this patch does is inconsistent.  Perhaps we should move the
>> new check higher and remove the *outbuf = "" while at it?
>
> I'm not sure returning the empty string for a textconv is the right
> solution....
>
> So I stand by my thought that it should die(). But I don't think there
> _are_ any such bugs currently, so it probably doesn't matter much either
> way. I can live with "return 0", or even just leaving it alone.

I must have phrased it badly.  I am actually Ok either way (i.e. make this
function prepare for a future when we start passing the missing side to
the function, and have a special case for "if (!DIFF_FILE_VALID)" and
returning something like an empty string, or make this function refuse to
be fed the missing side by dying in "if (!DIFF_FILE_VALID)".  I was only
pointing out that the result of applying your patch does one in one case
and another in the other case, which is inconsistent.  And we do not know
in advance what is the reasonable fallback value for the missing side, so
we do not now "something like an empty string" is a reasonable thing to do
yet.  Hence "move the new check higher and remove ..." was my suggestion,
which would look like the attached, which would be consistent with your
message I am replying to.  IOW, I think we are on the same page.

 diff.c |   15 +++++++++++----
 1 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/diff.c b/diff.c
index 5422c43..a04ab2f 100644
--- a/diff.c
+++ b/diff.c
@@ -4401,11 +4401,18 @@ size_t fill_textconv(struct userdiff_driver *driver,
 {
 	size_t size;
 
+	/*
+	 * !DIFF_FILE_VALID(df) means this is a missing side of the
+	 * diff (preimage of creation, or postimage of deletion diff).
+	 * The caller should not try to textconv such a filespec, as
+	 * there is no such blob to begin with!
+	 */
+	
+	if (!DIFF_FILE_VALID(df))
+		die("Feeding missing side to fill_textconv?: '%s'",
+		    df->path);
+
 	if (!driver || !driver->textconv) {
-		if (!DIFF_FILE_VALID(df)) {
-			*outbuf = "";
-			return 0;
-		}
 		if (diff_populate_filespec(df, 0))
 			die("unable to read files to diff");
 		*outbuf = df->data;
