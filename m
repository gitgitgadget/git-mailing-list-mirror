From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Should notes handle replace commits?
Date: Fri, 08 Jan 2016 17:04:03 -0800
Message-ID: <xmqqmvsfzhq4.fsf@gitster.mtv.corp.google.com>
References: <20160108012830.GA2110@glandium.org>
	<xmqqh9in25py.fsf@gitster.mtv.corp.google.com>
	<20160108214939.GA22801@glandium.org>
	<xmqqziwfzl2s.fsf@gitster.mtv.corp.google.com>
	<20160109002510.GA30050@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Sat Jan 09 02:04:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aHhwz-0000PH-6J
	for gcvg-git-2@plane.gmane.org; Sat, 09 Jan 2016 02:04:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753675AbcAIBEI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jan 2016 20:04:08 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:60624 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751859AbcAIBEG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jan 2016 20:04:06 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D80D23B072;
	Fri,  8 Jan 2016 20:04:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=c5N9QfZ92CpeBDKMF+7VTInxTpg=; b=FlMrVy
	zExDu+d68bR7WThCFtCqzE76+QjC4Woom+36pBR5AbEK/E6Fewsv4Y6fXTFgMUxB
	aBIc9dpSDN+S4j9kKr0TCt2mSKdcanrh84q7LzyrJ4wQ6T4XsyEAl6ExzIHv05Nd
	A+pXcau+q3h7k7+f5MV8/cG1UBSp2JtIn8NwI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JPHa3pL5vY1zS00zyySOV7g4H88XrZqY
	RaxS0gZABmBVNmGtGSs8xt18rs4/rJMI3dRCJJIpvJRNSNkRIKwlAJgl38EgDi78
	vM6J2FpgjjaTuLLqEUxJ4xuTrVgtoohLxnd7IDwXQenTVUWOzYX0z1UXCM0CTx5J
	JVIgkOr64HY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CF7643B071;
	Fri,  8 Jan 2016 20:04:04 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 5236E3B070;
	Fri,  8 Jan 2016 20:04:04 -0500 (EST)
In-Reply-To: <20160109002510.GA30050@glandium.org> (Mike Hommey's message of
	"Sat, 9 Jan 2016 09:25:10 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E07A064E-B66C-11E5-9336-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283593>

Mike Hommey <mh@glandium.org> writes:

> So while `cat-file commit A` gives you what `cat-file commit Z` would,
> `notes show A` doesn't give you what `notes show Z` would. And that's
> this "inconsistency" that bothers me.

In any case, 'notes' being a way to add extra information to an
existing object means that with your original "replace" that tells
Git to keep A in the history (and give Z's contents when contents of
A was asked), it is absolutely correct that notes for A is shown.
It would make no sense if notes for Z "followed", because as long as
Git is concerned, you told Git to show A when your "git log master"
followed the history down thru B to its parent, which you did not
rewrite to be Z but kept to be A.  With the approach to replace B
with B' that has Z as its parent, when "git log master" follows the
history down thru C to its parent, Git thinks it is showing B but
reads B', and finds out its parent is Z and goes down to Z, and
notes for these two commits B and Z (not B' and Z) would be shown;
there is no need to "follow".

The true source of your confusion, I think, is that there is a
misunderstanding of what "replace A with Z" does.

It is not "whenever somebody refers to A, pretend as if it is
referring to Z".  If that _were_ the case, then I'd agree that
"whenever somebody else asks notes attached to A, pretend as if
notes attached to Z were asked" might make sense, but that does not
match the reality.

It is not graft vs replace.  It is about what you replace with what
other thing: "replace" is a content replacement mechanism, not
identity replacement mechanism.
