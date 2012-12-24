From: Junio C Hamano <gitster@pobox.com>
Subject: [LHF] making t5000 "tar xf" tests more lenient
Date: Mon, 24 Dec 2012 12:49:10 -0800
Message-ID: <7vwqw7mb09.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 24 21:54:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TnF2I-0002Ge-Qx
	for gcvg-git-2@plane.gmane.org; Mon, 24 Dec 2012 21:54:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753348Ab2LXUtX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Dec 2012 15:49:23 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51025 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753330Ab2LXUtW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Dec 2012 15:49:22 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 35BEBA44D;
	Mon, 24 Dec 2012 15:49:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=v
	YlT97ol/aeHN7Q//OZRqnHepqk=; b=MXv7DLTpQxAiQRm88/gJWFvOG1/PP+rnI
	xEv0Mcddbn0Q3WdOIbV/IuM2MO2NP1pNrJWXFQiBY+m18yHed4NTfqzkXTcCX969
	9vM7qeVo3UiJZ7LMPDVQw94oKoRZ1FhqnWqgEOXU7nD+FZ+vVhifZ3dmMlWgK5Cm
	Rf2ls0+kJI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=ply
	bX4bCsMOQ+urYEinKykpPie/Y6EQi1Mb1iJZo+e6SN0Pce+fyRXzQdTFwZPiEH/9
	UrHiyYFxm3mnAfpl9tInIkvMz/SEbVAu/VYMrpni2OsW5k0jh76DGMyN/HUgdkWG
	ivKyyTSP72l6BcDYo686fs/aSdRkL6NJbrQh0K6k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 20B27A449;
	Mon, 24 Dec 2012 15:49:14 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8084EA436; Mon, 24 Dec 2012
 15:49:12 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5FB05B02-4E0B-11E2-88E8-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212118>

I've been running testsuite on a few platforms that are unfamiliar
to me, and was bitten by BSD implementation of tar that do not grok
the extended pax headers.  I've already fixed one in t9502 [*1*]
where we produce a tarball with "git archive" and then try to
validate it with the platform implementation of "tar" so that the
test won't barf when it sees the extended pax header.

t5000 is littered with similar tests that break unnecessarily with
BSD implementations.  I think what it wants to test are:

 - "archive" produces tarball, and "tar" can extract from it.  If
   your "tar" does not understand pax header, you may get it as an
   extra file that shouldn't be there, but that should not cause the
   test to fail---in real life, people without a pax-aware "tar"
   will just ignore and remove the header and can go on.

 - "get-tar-commmit-id" can inspect a tarball produced by "archive"
   to recover the object name of the commit even on a platform
   without a pax-aware "tar".

Perhaps t5000 can be restructured like so:

 - create a tarball with the commit-id and test with
   "get-tar-commit-id" to validate it; also create a tarball out of
   a tree to make sure it does not have commit-id and check with
   "get-tar-commit-id".  Do this on any and all platform, even on
   the ones without a pax-aware "tar".

 - check platform implementation of "tar" early to see if extracting
   a simple output from "git archive" results in an extra pax header
   file.  If so, remember this fact and produce any and all tarballs
   used in the remainder of the test by forcing ^{tree}.

so that people on platforms without pax-aware "tar" do not have to
install GNU tar only to pass this test.

It would be a good exercise during the holiday week for somebody on
BSD (it seems NetBSD is more troublesome than OpenBSD) to come up
with a patch to help users on these platforms.

Thanks.


[Footnote]

*1* http://thread.gmane.org/gmane.comp.version-control.git/211803
