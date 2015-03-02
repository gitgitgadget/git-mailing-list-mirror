From: Junio C Hamano <gitster@pobox.com>
Subject: Re: weaning distributions off tarballs: extended verification of git tags
Date: Mon, 02 Mar 2015 12:08:39 -0800
Message-ID: <xmqqwq2z9n7c.fsf@gitster.dls.corp.google.com>
References: <1425134885.3150003.233627665.2E48E28B@webmail.messagingengine.com>
	<CANv4PNmF9sTh8od9xT5tYTOF1Cv0Mev2Muf-qxQDS_6kE7EnOw@mail.gmail.com>
	<1425316197.895196.234425829.536E6C06@webmail.messagingengine.com>
	<20150302181230.GA31798@kitenet.net> <54F4BC18.5060702@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Joey Hess <id@joeyh.name>, GIT Mailing List <git@vger.kernel.org>
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Mon Mar 02 21:08:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YSWe0-0005fI-0W
	for gcvg-git-2@plane.gmane.org; Mon, 02 Mar 2015 21:08:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755160AbbCBUIo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Mar 2015 15:08:44 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:56998 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754404AbbCBUIn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Mar 2015 15:08:43 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8F9DB3D6B8;
	Mon,  2 Mar 2015 15:08:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1nh35G9c5CSpQbPsgZS7ABrzGxU=; b=FibY1R
	5PCgrTHj7zNL5+fB/zzFEC5rIfWPtekxEi0VVU+P0r+wmHaof2dNuMD4hM7e3WC8
	70tNTnhUTsmXZEBX3dYNcH3EtND+pL1VgtFTmxK8OC023JtDAiRQ3G3ApurPBZsT
	UL5mA6mDwOSsajB0JVqtFyqFCwpGCAUoc0YUw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rb3nyxV4np+Zv9+S3c0SDvjNOGdsFElo
	XCAagNJJ3JaWtd8HkTRasOyLf+ZfuTdg4lNpHQSuxj5Xc+BVsUgguuvKfPjwX3gQ
	oPv3hZUQvx41q+/hsbM18oJu43iX2ReNnM0ao5Zz050pRK9dxFrE4KfypqVVaG/C
	PZBkPzxDUGM=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 84E363D6B7;
	Mon,  2 Mar 2015 15:08:42 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4BD633D6B4;
	Mon,  2 Mar 2015 15:08:40 -0500 (EST)
In-Reply-To: <54F4BC18.5060702@vilain.net> (Sam Vilain's message of "Mon, 02
	Mar 2015 11:38:00 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: EB40BBE0-C117-11E4-983B-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264617>

Sam Vilain <sam@vilain.net> writes:

>> As to the implementation, checksumming the collection of raw objects is
>> certainly superior to tar. Colin had suggested sorting the objects by
>> checksum, but I don't think that is necessary. Just stream the commit
>> object, then its tree object, followed by the content of each object
>> listed in the tree, recursing into subtrees as necessary. That will be a
>> stable stream for a given commit, or tree.
>
> I would really just do it exactly the same way that git does: checksum
> the objects including their headers with the new hashes.

I tend to agree that it is a good idea.  I also suspect that would
make the implementation simpler by allowing it to share more code,
but I didn't look into it too deeply.

> I have a
> hazy recollection of what it would take to replace SHA-1 in git with
> something else; it should be possible (though tricky) to do it lazily,
> where a tree entry has bits (eg, some of the currently unused file
> mode bits) to denotes which hash algorithm is in use for the entry.
> However I don't think that got past idea stage...

I think one reason why it didn't was because it would not work well.
That "bit that tells this is a new object or old" would mean that a
single tree can have many different object names, depending on which
of its component entries are using that bit and which aren't.  There
goes the "we know two trees with the same object name are identical
without recursing into them" optimization out the window.

Also it would make it impossible to do what you suggest to Joey to
do, i.e. "exactly the same way that git does", once you start saying
that a tree object can be encoded in more than one different ways,
wouldn't it?
