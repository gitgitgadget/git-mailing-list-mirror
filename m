From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 2/8 v2] git_remote_helpers: fix input when running
 under Python 3
Date: Tue, 15 Jan 2013 14:04:29 -0800
Message-ID: <7vy5fu14sy.fsf@alter.siamese.dyndns.org>
References: <cover.1358018078.git.john@keeping.me.uk>
 <a8c3aabfab64f49fa0cbb2d45bda79997a875ee8.1358018078.git.john@keeping.me.uk>
 <50F2296F.8030909@alum.mit.edu> <20130113161724.GK4574@serenity.lan>
 <50F38E12.6090207@alum.mit.edu> <20130114094721.GQ4574@serenity.lan>
 <20130115194809.GU4574@serenity.lan>
 <7vbocq2mri.fsf@alter.siamese.dyndns.org>
 <20130115215412.GX4574@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	"Eric S. Raymond" <esr@thyrsus.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Tue Jan 15 23:05:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvEcn-0001Ba-GE
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jan 2013 23:04:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755807Ab3AOWEd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2013 17:04:33 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47079 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754012Ab3AOWEc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2013 17:04:32 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B5C40AB8C;
	Tue, 15 Jan 2013 17:04:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zpm/XCcw0D7qZVvZ1RsKT7v+wr4=; b=ehPa9z
	yoJwJeu8Sx3Jt0io0En8XCyjdcIEBfl1FvmztsbDC/JrscRHG6aV+iNutsw5R3O4
	0DCt2ft5HmHn6x190a9WmsagCBcqSvI0X2v0L9x7LUFhv8BB1f5E/zncYpEl+C/I
	xue/NyRl4Dw4D+kTijim87hB1YoVTRZIZW1Ys=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cJGjf7uwxOzIKrXaqzumqEO0qxhAxekV
	DlfOO02qbuaIDve5Uog6ARC7kSQi+i7201KhJ1f7qyoU/UOILyaP4e+0FW8DDJQn
	X3kujuLp1/oI3V7XZ5jaPJf93ONJx+FaoS0p1QeVupFnn+OsewCQepnl9Q9nTjQG
	AjeLlOPgkYo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A449FAB8B;
	Tue, 15 Jan 2013 17:04:31 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E2715AB87; Tue, 15 Jan 2013
 17:04:30 -0500 (EST)
In-Reply-To: <20130115215412.GX4574@serenity.lan> (John Keeping's message of
 "Tue, 15 Jan 2013 21:54:12 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 899AA2C8-5F5F-11E2-B438-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213680>

John Keeping <john@keeping.me.uk> writes:

>> That really feels wrong.  Displaying is a separate issue and it is
>> the _right_ thing to punt the problem at the lower-level machinery
>> level.
>
> But the display will require decoding the ref name to a Unicode string,
> which depends on the encoding of the underlying ref name, so it feels
> like it should be decoded where it's read (see [1]).

If you botch the decoding in a way you cannot recover the original
byte string, you cannot create a ref whose name is the original byte
string, no?  Keeping the original byte string internally (this
includes where you use it to create new refs or update existing
refs), and attempting to convert it to Unicode when you choose to
show that string as a part of a message to the user (and falling
back to replacing some bytes to '?' if you cannot, but do so only in
the message), you won't have that problem.
