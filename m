From: Jonathon Mah <jmah@me.com>
Subject: Re: [PATCH] parse_object: clear "parsed" when freeing buffers
Date: Wed, 23 Jan 2013 15:36:51 -0800
Message-ID: <1C90CE32-F559-4E76-915E-93642F614552@me.com>
References: <8988071A-1DF3-463E-8AF9-AE4EA200D786@me.com> <7vsj5rfspy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 24 00:37:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ty9sd-0003YP-Ha
	for gcvg-git-2@plane.gmane.org; Thu, 24 Jan 2013 00:37:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752504Ab3AWXg4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2013 18:36:56 -0500
Received: from ipmail05.adl6.internode.on.net ([150.101.137.143]:52701 "EHLO
	ipmail05.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752356Ab3AWXg4 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jan 2013 18:36:56 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ApMBAAtzAFHHU908/2dsb2JhbAANN75XgxEBAQEDAScTPwULC0ZXBhOIFKork1WQUmEDiGGWeIoS
Received: from coffeebar.static.monkeybrains.net (HELO [10.0.18.121]) ([199.83.221.60])
  by ipmail05.adl6.internode.on.net with ESMTP; 24 Jan 2013 10:06:53 +1030
In-Reply-To: <7vsj5rfspy.fsf@alter.siamese.dyndns.org>
X-Mailer: Apple Mail (2.1499)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214378>

[Adding Jeff King to CC; I meant to copy you in the original but forgot, sorry]

On 2013-01-23, at 14:19, Junio C Hamano <gitster@pobox.com> wrote:

> Jonathon Mah <jmah@me.com> writes:
> 
>> Add a new function "free_object_buffer", which marks the object as
>> un-parsed and frees the buffer. Only trees and commits have buffers;
>> other types are not affected. If the tree or commit buffer is already
>> NULL, the "parsed" flag is still cleared so callers can control the free
>> themselves (index-pack.c uses this).
>> 
>> Several areas of code would free buffers for object structs that
>> contained them ("struct tree" and "struct commit"), but without clearing
>> the "parsed" flag. parse_object would clear the flag for "struct tree",
>> but commits would remain in an invalid state (marked as parsed but with
>> a NULL buffer). Because the objects are uniqued (ccdc6037fee), the
>> invalid objects stay around and can lead to bad behavior.
>> 
>> In particular, running pickaxe on all refs in a repository with a cached
>> textconv could segfault. If the textconv cache ref was evaluated first
>> by cmd_log_walk, a subsequent notes_cache_match_validity call would
>> dereference NULL.
> 
> Conceptually this is a right thing to do, but it is unclear why this
> conversion is safe in the existing code.
> 
> A codepath that used to free() and assign NULL to a buffer without
> resetting .parsed would have assumed that it can find out the parsed
> properties of the object (e.g. .parents) without re-parsing the
> object, and much more importantly, the modifications made by that
> codepath will not be clobbered by later call to parse_object().
> 
> IIRC, revision traversal machinery rewrites commit->parents but
> discards buffer when it knows that the log message is not needed
> (save_commit_buffer controls this behaviour).  I do not offhand know
> if there are other instances of existing code that depend on the
> current behaviour, but have you audited all the codepaths that are
> affected by this patch and codepaths that work on objects this patch
> unmarks their .parsed field will not have such a problem?

No, I haven't audited the code paths (I have only the loosest familiarity with the source). Indeed, I found that clearing the 'parsed' flag in fsck.c (traverse_one_object()) is incorrect and causes test failures.

With the object cache, isn't modifying the object unsafe in general? Instead of auditing code paths, it's now necessary to audit _all_ code that uses "struct object", which seems infeasible.

Anyway, I don't care about the implementation (Junio does that extremely well), I'm just trying to fix the segfault demonstrated in the test attached to the patch.



Jonathon Mah
me@JonathonMah.com
