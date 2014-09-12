From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v4 00/32] Lockfile correctness and refactoring
Date: Fri, 12 Sep 2014 16:21:09 +0200
Message-ID: <54130155.90707@alum.mit.edu>
References: <1409989846-22401-1-git-send-email-mhagger@alum.mit.edu> <20140910081358.GB16413@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Sep 12 16:21:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XSRjC-0002K2-1g
	for gcvg-git-2@plane.gmane.org; Fri, 12 Sep 2014 16:21:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753727AbaILOV3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Sep 2014 10:21:29 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:55410 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752047AbaILOV2 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Sep 2014 10:21:28 -0400
X-AuditID: 12074414-f79446d000001f1d-04-54130167041e
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id C2.58.07965.76103145; Fri, 12 Sep 2014 10:21:27 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB1EE6.dip0.t-ipconnect.de [93.219.30.230])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s8CEL9HK004860
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Fri, 12 Sep 2014 10:21:11 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.0
In-Reply-To: <20140910081358.GB16413@peff.net>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEKsWRmVeSWpSXmKPExsUixO6iqJvOKBxisPuBmkXXlW4mi4beK8wW
	T+beZbb40dLDbNHZ8ZXRgdXj4asudo9nvXsYPS5eUvb4vEnO4/azbSwBrFHcNkmJJWXBmel5
	+nYJ3BkHzm1hKfgrXtG5aDVzA2OvcBcjJ4eEgInE+21HmSBsMYkL99azdTFycQgJXGaUmNRx
	ihXCOc8ksbWhnx2kildAU2LVltusIDaLgKrEuxWXwbrZBHQlFvU0g9miAgESHzofMELUC0qc
	nPmEBcQWEZCV+H54IyPIUGaBpYwS6xtfMIMkhAWcJP78vA5mCwmkSbTs/QO2jFNAT+LJ43Ng
	NrOAusSfeZeYIWx5ieats5knMArMQrJjFpKyWUjKFjAyr2KUS8wpzdXNTczMKU5N1i1OTszL
	Sy3StdDLzSzRS00p3cQICXORHYxHTsodYhTgYFTi4a1gEQwRYk0sK67MPcQoycGkJMqbd08o
	RIgvKT+lMiOxOCO+qDQntfgQowQHs5II741XQDnelMTKqtSifJiUNAeLkjjvt8XqfkIC6Ykl
	qdmpqQWpRTBZGQ4OJQlebQbhECHBotT01Iq0zJwShDQTByfIcC4pkeLUvJTUosTSkox4ULTG
	FwPjFSTFA7TXGqSdt7ggMRcoCtF6ilGXY13nt34mIZa8/LxUKXFeXZAiAZCijNI8uBWwpPaK
	URzoY2FeL5AqHmBChJv0CmgJE9CSd3NAnisuSURISTUwys95+XLf9c8LZYIOBQYdC/e6apZm
	FvTuAW/uLoey2bwB67dsfpW+13zryifaMkpTrfKdZx26U7q11TvpyEEH2fPXlorf 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256922>

On 09/10/2014 10:13 AM, Jeff King wrote:
> [...]
> I did coincidentally have an interesting experience with our lockfile
> code earlier today, which I'd like to relate.
> 
> I was running pack-refs on a repository with a very large number of
> loose refs (about 1.8 million). [...] Each call to lock_ref_sha1_basic
> allocates a "struct lock_file", which then gets added to the global
> lock_file list. Each one contains a fixed PATH_MAX buffer (4K on this
> machine). After we're done updating the ref, we leak the lock_file
> struct, since there's no way to remove it from the list.
> 
> As a result, git tried to allocate 7G of RAM and got OOM-killed (the
> machine had only 8G). In addition to thrashing the disk even harder,
> since there was no room left for disk cache while we touched millions of
> loose refs. :)
> 
> Your change in this series to use a strbuf would make this a lot better.
> But I still wonder how hard it would be to just remove lock_file structs
> from the global list when they are committed or rolled back. That would
> presumably also make the "avoid transitory valid states" patch from your
> series a bit easier, too (you could prepare the lockfile in peace, and
> then link it in fully formed, and do the opposite when removing it).
> 
> I think with your strbuf patch, this leak at least becomes reasonable.
> So maybe it's not worth going further. But I'd be interested to hear
> your thoughts since you've been touching the area recently.

I've thought about this too, but it didn't seem to be worth the effort.
(Though your use case certainly adds a bit of justification.)

To make that change, we would have to remove entries from the list of
lock_file objects in a way that the code can be interrupted at any time
by a signal while leaving it in a state that is traversable by the
signal handler.

I think that can be done pretty easily with a singly-linked list. But
with a singly-linked list, we would have to iterate through the list to
find the node that needs to be removed. This could get expensive if
there are a lot of nodes in the list (see below).

So we would probably want to switch to using a doubly-linked list. I
think this would also be fairly simple, given that the signal handler
only needs to iterate through the list in a single direction. You'd just
have to be careful about adjusting the pointers in the right order to
let (say) a forwards traversal always work.

Then the callers who use heap-allocated lock_file objects would have to
be changed to free them when they're done with them, probably using a
special function that releases the strbufs, too. Callers using
statically-allocated lock_file objects would probably not have to be
changed.

But...

The ref-transaction code is, I think, moving in the direction of
updating all references in a single transaction. This means that we
would need to hold locks for all of the references at once anyway. So it
might be all for naught.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
