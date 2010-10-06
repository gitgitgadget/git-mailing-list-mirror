From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/7] lockfile: introduce alloc_lock_file() to avoid
 valgrind noise
Date: Wed, 06 Oct 2010 13:10:27 -0700
Message-ID: <7vocb7yte4.fsf@alter.siamese.dyndns.org>
References: <wes62zknmki.fsf@kanis.fr>
 <7v1va760ip.fsf@alter.siamese.dyndns.org> <20100810032647.GA2386@burratino>
 <20101002082752.GA29638@burratino> <20101002083216.GC29638@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Pierre Habouzit <madcoder@debian.org>,
	David Barr <david.barr@cordelta.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 06 22:10:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3aK8-0000E1-0T
	for gcvg-git-2@lo.gmane.org; Wed, 06 Oct 2010 22:10:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759587Ab0JFUKl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Oct 2010 16:10:41 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:56913 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756687Ab0JFUKk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Oct 2010 16:10:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 81157DC338;
	Wed,  6 Oct 2010 16:10:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PhAFwMqaSnP0LtFaW8TYKbvKIVA=; b=QZPKZv
	MbWS6Ry3+dx0n+rCtcEGdhgW43UKnXUjBrmIcEHKkKk7PyouoYEsnoCeQ0GQJUhE
	r1mLKGZ53rRUV+Evnccg0M3JI3l1PqevwWw8GOAdX4ovbejpWEn+qendDuLk/2cG
	Swr/jBtah3zEyBWDHO4gZhUhCYWsp4talrBfM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rpfHyKUaIaGhnF2jNjeAuIF5dPSJV4B9
	7a+fhlYDilmkWcdsWMuBtyWPT2Dvp7mgyh6fUbASOVA3yHgtPrf6R8SoVGB93wWr
	spkxXEP3yV5nuiHNRC/CfsMPVlWFmwHdwhkrFH3PeZBi2zXgVzzTls9FJKTVVyyz
	jV/2jz93NxE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D810CDC335;
	Wed,  6 Oct 2010 16:10:34 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E737FDC330; Wed,  6 Oct
 2010 16:10:29 -0400 (EDT)
In-Reply-To: <20101002083216.GC29638@burratino> (Jonathan Nieder's message of
 "Sat\, 2 Oct 2010 03\:32\:16 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C746D480-D185-11DF-B269-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158303>

Jonathan Nieder <jrnieder@gmail.com> writes:

> ...The
> ((optimize("-fno-optimize-sibling-calls"))) attribute is needed on
> platforms with GCC to ensure that the stack frame for
> alloc_lock_file() is not replaced by the stack frame for xcalloc().

Hmm, I am getting

    cc1: warnings being treated as errors
    lockfile.c:189: error: 'optimize' attribute directive ignored
    make: *** [lockfile.o] Error 1

from this patch with gcc (Debian 4.3.2-1.1) 4.3.2

Aren't "struct lock_file" instances supposed to be reachable from the
linked list, i.e. lock_file_list?  Why does valgrind consider that
elements on that list are leaked in the first place?

We keep loaded objects in *obj_hash[] and they sure are "leaked" by the
same definition of leakage, no?  How are we squelching valgrind on them?
