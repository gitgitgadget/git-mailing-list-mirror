From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC v2 06/16] t3700: sleep for 1 second, to avoid
 interfering with the racy code
Date: Wed, 08 Aug 2012 13:16:29 -0700
Message-ID: <7vr4rhrvfm.fsf@alter.siamese.dyndns.org>
References: <1344203353-2819-1-git-send-email-t.gummerer@gmail.com>
 <1344203353-2819-7-git-send-email-t.gummerer@gmail.com>
 <7vsjc023sr.fsf@alter.siamese.dyndns.org> <20120807165947.GD913@tgummerer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, trast@student.ethz.ch, mhagger@alum.mit.edu,
	pcouds@gmail.com, robin.rosenberg@dewire.com
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 08 22:16:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SzCgI-0002jb-Le
	for gcvg-git-2@plane.gmane.org; Wed, 08 Aug 2012 22:16:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759198Ab2HHUQe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Aug 2012 16:16:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55269 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753822Ab2HHUQd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2012 16:16:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3097D88D5;
	Wed,  8 Aug 2012 16:16:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7tOsfx3UP39E+DcQ8Pu/qXeqPWE=; b=DHtKJ6
	28walFC+rbqNGvjz0a3dLGvUsK3KjNbawCH+vSuFSLR9MCJZfqxoFNwvnIqcs9cd
	vCFV5hxbRw4uZozbnDP5XmIQ4r9ho/ehR1EQVzGix4quml8UmfJKVU3LxE1sB3UW
	7NzW341c8+C7PdLAcCJG+zvn7whors9xM8Uo8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Kc93MXuEMiSRzcnevH7t4faUWF7OgSPS
	nQaqfnejD22pMOJccmIuVWYdJnByBX+k0ajFgeyPmX7PrGdDK/GgfBO32Q/KKFGJ
	2ixflmmodJ242LNrcorQkkc3MoyFN+JUpgWpqPuf45yf++TbSZ+trAVKkwK5Uaq2
	4sj7oy24hmU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1E66688D3;
	Wed,  8 Aug 2012 16:16:31 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 817AA88D0; Wed,  8 Aug 2012
 16:16:30 -0400 (EDT)
In-Reply-To: <20120807165947.GD913@tgummerer> (Thomas Gummerer's message of
 "Tue, 7 Aug 2012 18:59:47 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F0E370C4-E195-11E1-B471-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203122>

Thomas Gummerer <t.gummerer@gmail.com> writes:

> On 08/05, Junio C Hamano wrote:
>> Thomas Gummerer <t.gummerer@gmail.com> writes:
>> 
>> > The new git racy code uses the mtime of cache-entries to smudge
>> > a racy clean entry, and loads the work, of checking the file-system
>> 
>> -ECANTPARSE.
>
> The git racy code for index-v5 uses the mtime of the cache-entries as
> smudge markers. The work of checking the file-system is loaded of to
> the reader.

OK, now I can parse, perhaps with either s/is loaded of/&f/ or
s/is loaded of/is offloaded/.

Thanks for clarifying the grammar.

But doesn't the current code make it the responsibilty of the reader
to check the contents with ce_modified_check_fs() already?  You may
have switched st_size to st_mtime as the field to mark a racily
clean entry, but it is unclear how that change affects anything.

>> > if the entry has really changed, off to the reader. This interferes
>> > with this test, because the entry is racily smudged and thus has
>> > mtime 0. We wait 1 second to avoid smudging the entry and getting
>> > correct test results.
>> 
>> Mild NAK, especially it is totally unclear why you even need to muck
>> with racy-git check in the current format of the index in the first
>> place, and even if it were necessary, it is unclear why this cannot
>> be done with test-chmtime.
>
> The racy-git code needs to be changed, to avoid problems when implementing
> the partial writing for index-v5. Otherwise it could cause problems, when
> we have entries that should be smudged, but are not due to the different
> racy algorithms.

Hrmph.  But if racy detection and checking is now a responsibility
of the later reader, the overall end result should be the same, no?
Perhaps the existing test was checking a wrong thing?

We should not care if the index still has a racily clean entries, or
how that fact is marked in the index entry.  The primary thing we
care about is that we do not mistake an actual change as no change
due to raciness.

So whether done with "sleep" or "test-chmtime", avoiding a racily
clean situation sounds like sweeping a bug in the v5 code in racy
situation under the rug to me (unless I am misunderstanding what
you are doing with this change and in your explanation, or the test
was checking a wrong thing, that is).

Even more confused....
