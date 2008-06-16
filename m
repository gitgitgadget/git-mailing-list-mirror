From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-rerere observations and feature suggestions
Date: Mon, 16 Jun 2008 14:37:56 -0700
Message-ID: <7viqw99i2z.fsf@gitster.siamese.dyndns.org>
References: <20080616110113.GA22945@elte.hu> <20080616112709.GG12260@mit.edu>
 <20080616195252.GA18848@elte.hu> <7v4p7tb00l.fsf@gitster.siamese.dyndns.org>
 <20080616204630.GA552@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Theodore Tso <tytso@mit.edu>, git@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Mon Jun 16 23:39:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8MPs-0002a4-Q6
	for gcvg-git-2@gmane.org; Mon, 16 Jun 2008 23:39:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756029AbYFPViO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2008 17:38:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755915AbYFPViO
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jun 2008 17:38:14 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:64629 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755419AbYFPViO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2008 17:38:14 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 3A016D583;
	Mon, 16 Jun 2008 17:38:12 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 75731D582; Mon, 16 Jun 2008 17:38:04 -0400 (EDT)
In-Reply-To: <20080616204630.GA552@elte.hu> (Ingo Molnar's message of "Mon,
 16 Jun 2008 22:46:30 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 851803D0-3BEC-11DD-8DE5-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85236>

Ingo Molnar <mingo@elte.hu> writes:

> * Junio C Hamano <gitster@pobox.com> wrote:
>
>> Ingo Molnar <mingo@elte.hu> writes:
>> 
>> > right now that is simply not possible technically - it's even very 
>> > hard to share a .git/rr-cache with a co-maintainer whom i can trust 
>> > with my index file. (which is an otherwise unsafe private binary 
>> > cache that i'd not put into a public repository as it could in 
>> > theory contain lots of unrelated data and is not endian-safe, etc.)
>> 
>> Where did you get the idea that .git/index is involved in any way, I 
>> wonder...
>
> so it's only the rr-cache metadata that is involved?

The binary part of the index should be in network byte order and endian
safe.  But it is not necessary to share the index.  Well, if you think
about it, it would be mighty silly if index had any long term effect on
the operation of rerere, which is all about "I've done many conflict
resolutions in the past.  My work tree state (including the index) came
back to a state similar to the conflicted state I saw some time ago.
Let's reuse the previous resolution if we can."  You might have switched
branches, ran "reset --hard" and did 47 thousands different things to your
index since you resolved the conflict you are about to re-resolve ;-).

The replay and conflict recoding codepath of rerere goes like this:

 * read the index, list the paths that have conflicts;

 * inspect the conflicted blob to compute the conflict signature $sig and
   store the sig and path in MERGE_RR;

 * look into rr-cache/$sig; does it have already a conflict resolution
   recorded?

   - If so, modify the file in the working tree the same way to bring
     rr-cache/$sig/preimage to rr-cache/$sig/postimage by 3-way merge.

   - if not, record the file in the working tree as rr-cache/$sig/preimage

The resolution recording codepath goes like:

 * see if any paths listed in MERGE_RR is resolved in the index;

 * look into rr-cache/$sig for such resolved path.  Does it already record
   a resolution?

   - If not, we have a new resolution we can use.  Record it as
     rr-cache/$sig/postimage for later use.

So rerere _does_ look at the index to decide what entries in rr-cache are
relevant and applicable.  But other than that, it is not used.  I do not
think there is no reason copy index to be able to reuse rr-cache.
