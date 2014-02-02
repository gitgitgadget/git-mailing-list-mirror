From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] init-db.c: honor case on case preserving fs
Date: Sun, 02 Feb 2014 10:08:46 -0800
Message-ID: <xmqq7g9dgzf5.fsf@gitster.dls.corp.google.com>
References: <1391246067-30499-1-git-send-email-reubenhwk@gmail.com>
	<52ECE5EB.6090304@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, dpotapov@gmail.com
To: Reuben Hawkins <reubenhwk@gmail.com>,
	Torsten =?utf-8?Q?B=C3=B6gersha?= =?utf-8?Q?usen?= 
	<tboegi@web.de>
X-From: git-owner@vger.kernel.org Sun Feb 02 19:09:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WA1Ta-00083f-2X
	for gcvg-git-2@plane.gmane.org; Sun, 02 Feb 2014 19:09:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751974AbaBBSI5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 2 Feb 2014 13:08:57 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47919 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751882AbaBBSI4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Feb 2014 13:08:56 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4DDA966B13;
	Sun,  2 Feb 2014 13:08:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=CkQ2NUBZM4OB
	fPV5CFlZuLE184Q=; b=RcEMPHTZkt2sZoouPa/RQEVq4rWqp5sBcqIacfQ8k2Ju
	tfLIA1fIQvDvIVnPKUFHiGWp0Y0eZJdHNn4Wccu1WCBWpRnbr2bpc+1GAhnL7QB8
	cL09X0dNcT4ZEk5jpztHZjini6RJDkTp20+r3mUIpOa1cBHls3i5NJ85OHUOXz8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=KJfnsw
	ECmLd/QalbZMG00AiLZfLCMQPynV1pqeXEGfteiKRhwwrRvAObLtqtP18H6rAzuY
	ILkY6jIaDJkN7pHh863Ty/NeEl6df6+P5aEdupXQKkDeUWksH9+bf/Q6SxTFYcHu
	5PPEfmwTCUI4qAb5o7gdrukALJn87olxWLDTQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3C74766B12;
	Sun,  2 Feb 2014 13:08:50 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8454E66B0E;
	Sun,  2 Feb 2014 13:08:49 -0500 (EST)
In-Reply-To: <52ECE5EB.6090304@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of
	"Sat, 01 Feb 2014 13:17:47 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 10DFF208-8C35-11E3-872B-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241380>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> On 2014-02-01 10.14, Reuben Hawkins wrote:
>> Most case-insensitive filesystems are case-preserving. In these
>> filesystems (such as HFS+ on OS X) you can name a file Filename.txt,
>> then rename the file to FileName.txt.  That file will be accessible
>> by both filenames, but the case is otherwise honored.  We don't want
>> to have git ignore case on these case-preserving filesystem
>> implementations.
>
> Yes, we want.
> Because the file system will treat "Filename.txt" and "FileName.txt"
> the same.

Another important thing to remember is that we cannot have these two
files at the same time on such a filesystem.

Somebody may have Filename.txt in the commit at the tip of the
history, you clone/fetch and check it out, and you will have
=46ilename.txt with the original contents.  We do not try to corrupt
the filename on core.ignorecase filesystem by any canonicalization.

But then you may edit that file, and you either deliberately or
without knowing (because some of your tools do this behind your
back) may end up saving the result as FileName.txt.  What happens?

When we ask "what is the contents of Filename.txt now?" (using the
original name still in the index) to the underlying system, we will
be given what you placed in FileName.txt.  We won't see "You do not
have Filename.txt, but you now have FileName.txt".

And that is the behaviour the end users (of not Git, but of a
platform with such a filesystem) do expect from their tools.  They
do not want to see "You no longer have Filename.txt, and you have a
new file FileName.txt".

Now think what "git add Filename.txt" should do at that point?  It
should not say "I was told to add Filename.txt, but there is no such
file, so I'll add nothing".  If you run "git add -u Filename.txt",
it should not say "I was told to add Filename.txt, but there is no
such file, so I'll remove existing Filename.txt from the index".

It must pick up the updated contents from your new FileName.txt,
update the index entry "Filename.txt", and the next "git commit"
must record it as an update to the same file.

If you are on the other hand trying to correct an earlier mistake of
having named the file "Filename.txt" but you now want to rename it
"FileName.txt", the above behaviour by core.ignorecase may make it a
bit cumbersome to do.  You can first remove it from the index and
then re-add it, I would think, as a workaround.  Having to do a
"workaround" is unfortunate but it is an unavoidable consequence of
having to choose between the two and having to pick one.  Most of
the time you do not want such a rename (or rather, the loss of the
file Filename.txt and the creation of the unrelated FileName.txt)
and a change from Filename.txt to FileName.txt is most likely to be
a mistake in the platform tool that mucked with the files on your
filesystem, so we choose to make it easy for the user not to be
disturbed by such a change.
