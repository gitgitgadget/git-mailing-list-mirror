From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] diff: Add diff.orderfile configuration variable
Date: Mon, 09 Dec 2013 11:23:05 -0800
Message-ID: <xmqqiouxzv52.fsf@gitster.dls.corp.google.com>
References: <CADsOX3DBmNituJsiYEBRENQeosASXtV_hd0zUW13cBoDZWHRhg@mail.gmail.com>
	<1386312508-7421-1-git-send-email-naesten@gmail.com>
	<xmqqhaal3l3x.fsf@gitster.dls.corp.google.com>
	<CAJYzjmdg8v6-kZ+xtD9GT=vVTs7AEX_iEoroxdi4F4rjoTogWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Anders Waldenborg <anders@0x63.nu>
To: Samuel Bronson <naesten@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 09 20:23:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vq6QI-0004XO-Er
	for gcvg-git-2@plane.gmane.org; Mon, 09 Dec 2013 20:23:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755939Ab3LITXO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Dec 2013 14:23:14 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57422 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755823Ab3LITXM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Dec 2013 14:23:12 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 35F6C59147;
	Mon,  9 Dec 2013 14:23:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=udtX6mxzRSdysUV0GFZMWRixIC4=; b=bYni6K
	rBZsRsot7thRVfq2lQhdxks/Kzyr2Xm8BcBkj7iT1li71CQxGnGNisBPj1bj8L5x
	PWYFQxDrmUSrHZN54Aa8knTXpk1sbtpoK1fqBmnsJNRuJAqOO4Txwj9s/iZWrehA
	Tq3noamN6hQk5tKJJh/2rWwVr1k/o/ufZqLFA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kpcBXpWL517qOnpI5GnHdMIjNoDILzAM
	1zAjw9FH/fjcQcSnRS8Xs/82La2x4+2BLKyTh3mBLDx+zIy/KZm5rJEgwTl1uQa9
	PuqZOnPAHoHRnyV0HtELWpZinC2A/sg8JVTYM8SjcbU8PVCDWSbkRtpnxfEqaALG
	Tofz+BUPyGw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 184B359146;
	Mon,  9 Dec 2013 14:23:11 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3A5AE59143;
	Mon,  9 Dec 2013 14:23:10 -0500 (EST)
In-Reply-To: <CAJYzjmdg8v6-kZ+xtD9GT=vVTs7AEX_iEoroxdi4F4rjoTogWw@mail.gmail.com>
	(Samuel Bronson's message of "Fri, 6 Dec 2013 21:43:22 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 56F01362-6107-11E3-89EE-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239081>

Samuel Bronson <naesten@gmail.com> writes:

>> If somebody has diff.orderfile configuration that points at a custom
>> ordering, and wants to send out a patch (or show a diff) with the
>> standard order, how would the "overriding" command line look like?
>> Would it be "git diff -O/dev/null"?
>
> It looks like that works ... and so do files that don't exist.  What
> do you think should happen with -O file-that-does-not-exist, and how
> do you suppose it should be tested?

I think the original code is too loose on diagnosing errors.
Perhaps something like this is needed.

diff --git a/diffcore-order.c b/diffcore-order.c
index 23e9385..dd103e3 100644
--- a/diffcore-order.c
+++ b/diffcore-order.c
@@ -20,8 +20,11 @@ static void prepare_order(const char *orderfile)
 		return;
 
 	fd = open(orderfile, O_RDONLY);
-	if (fd < 0)
+	if (fd < 0) {
+		if (errno != ENOENT || errno != ENOTDIR)
+			die(_("orderfile '%s' does not exist."));
 		return;
+	}
 	if (fstat(fd, &st)) {
 		close(fd);
 		return;

> After having fixed this, will /dev/null still work everywhere, or will
> we want a new diff flag to unset the option?  (I see that "git diff
> /dev/null some-file" works fine with msysgit, which doesn't seem to
> actually be linked with MSYS, but I don't know *why* it works, and I
> don't know what other non-POSIXoid ports exist.)

I *think* it should be OK to use "-O/dev/null" for that purpose, but
the primary thing I was hinting at with the rhetoric question was
that it probably needs to be documented there.

> Also, I'm starting to wonder if I shouldn't split this into two patches:
>
>     1.  diff: Add tests for -O flag
>     2.  diff: Add diff.orderfile configuration variable
>
> (If so, I would obviously want to rewrite the above test to avoid the
> configuration option.)

Surely, and thanks.

>>                 EOF
>>                 cat >order_file_2 <<-\EOF &&
>
> I'd kind of prefer to keep a blank line between one EOF and the next
> cat, if that's okay with you.

Alright.  Making it easier to spot the grouping, it would make it
easier to read.

>> Quoting the EOF like the above will help the readers by signaling
>> them that they do not have to wonder if there is some substitution
>> going on in the here text.
>
> Perhaps, but probably only after they've scrutinized their shell
> manuals to figure out what the - and the \ are for.  (I had to check
> two: dash(1) wasn't clear enough for me about the quoting ...)

Yes and no.  The no primarily comes from that nobody will stay to be
novice forever.
