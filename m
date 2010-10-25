From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 1/3] Introduce bulk-move detection in diffcore.
Date: Mon, 25 Oct 2010 01:08:46 -0700
Message-ID: <7veibeitip.fsf@alter.siamese.dyndns.org>
References: <1287868022-24872-1-git-send-email-ydirson@altern.org>
 <1287868022-24872-2-git-send-email-ydirson@altern.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Yann Dirson <ydirson@free.fr>
To: Yann Dirson <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Mon Oct 25 10:09:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PAI7i-00032Z-EQ
	for gcvg-git-2@lo.gmane.org; Mon, 25 Oct 2010 10:09:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753523Ab0JYII6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Oct 2010 04:08:58 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:33652 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752155Ab0JYII4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Oct 2010 04:08:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9FD91E1561;
	Mon, 25 Oct 2010 04:08:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6HoAAyNg85g00Gvew7OfPQrug+k=; b=ADMlh2
	xRPmQGRxfmGaBqcsatTBNKyf1aJ+mT/VN4bd/S8+u9hN5LIWV2wIZJ0lc8L1H4fL
	myy7bCQHoEZ9qsdeUyP1j0cVddcziq2iwHGVYrAp7ynLYCWdTVMSAoAYXSYz27GL
	3YIhY5YDrbUNUXVlptXms73BcgqXX8AGPsr2w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aUFX5EKW8YXJY/9ijtnbqXlE2nVqyLyc
	ZojVxNoKgwjvuhNoVlcLy+Eg0PVOMya03ezAPo83paZXP2F2OIyQg1a8UFsHUfbt
	SjT/rNX/7lpnI3n/3/EjkPBW0Wt6DdPM+GrehAxHEpX1QkvUNiFMnaItiG9SRIZE
	AItk9AzxllA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5E3E2E155E;
	Mon, 25 Oct 2010 04:08:52 -0400 (EDT)
Received: from pobox.com (unknown [76.102.169.49]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8B01EE1556; Mon, 25 Oct
 2010 04:08:48 -0400 (EDT)
In-Reply-To: <1287868022-24872-2-git-send-email-ydirson@altern.org> (Yann
 Dirson's message of "Sat\, 23 Oct 2010 23\:07\:00 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 1AD2BD48-E00F-11DF-B1A7-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159934>

Yann Dirson <ydirson@altern.org> writes:

> The output of raw diff is displayed as "Rnnn a/* b/".  Those cannot be
> confused with renames of files named "whatever/*" with a literal star
> character, from the full-zero SHA1's.

I do not particularly like this asterisk here.  It is ambiguous with the
case where you renamed a directory whose name is '*' below a/ to a new
directory whose name is 'b', isn't it?  Using 0{40} as a differentiator
like you did is probably a good idea, but then I do not see a sound reason
you would need nor want that asterisk.

> +Bulk move of all files of a directory into a different one can get
> +detected using the `\--detect-bulk-moves` option.  This adds an
> +additional pass on top of the results of per-file rename detection.
> +They are reported with NULL SHA1 id, in addition to the file renames:
> +
> +------------------------------------------------
> +:040000 040000 0000000... 0000000... R100	a/*	b/
> +:100644 100644 0123456... 1234567... R90	a/file0	b/file3
> +:100644 100644 0123456... 1234567... R100	a/file1	b/file1
> +:100644 100644 0123456... 1234567... R100	a/file2	b/file2

This is kind of interesting.  Let's address two issues that should be
uncontroversial:

 (1) please do not use a/ and b/, as the reader can easily be confused and
     mistakenly think you are referring to the pre-/post- indicator we use
     when writing textual diffs (e.g. "diff --git a/frotz b/frotz").  You
     are illustrating rename between a directory to another directory,
     both of which are tracked paths.

 (2) The last two lines are R100 but with different object names between
     pre- and post-images, which is wrong and unnecessarily puzzling.
     Please make them match.

These obvious two complaints behind us, there is one more interesting
thing in the above, which is _not_ a complaint.

What about renaming of a/file0 to b/file3?  Is this part of "all files
from directory A moved to directory B"?  IOW, is the goal of this series
to use the "A/* -> B/" to label the change as bulk directory rename, if
the preimage has A/{1,2,3} and the postimage has their moved contents in
B/{one,two,three}?

I am wondering about the utility of such an extra information.  If there
were no "a/file0 -> b/file3" entry in the example, I would imagine that we
could use this "a/* -> b/" information to move "a/file5" to "b/file5" when
rebasing this patch to apply to a different preimage that had files other
than file{1,2} in directory "a", and I would further imagine that might be
a wonderful thing.

But if the new "a/* -> b/" hint only gives "things from A/ have migrated
to B/ but I can give no information on what name they took under their new
home", that may probably reduce the utility of this feature.

I dunno.
