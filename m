From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] cherry: cache patch-ids to avoid repeating work
Date: Thu, 10 Jul 2008 23:54:04 -0700
Message-ID: <7v3amglxmb.fsf@gitster.siamese.dyndns.org>
References: <7f9d599f0807082053w4603d0bbgfead9127c33b78b5@mail.gmail.com>
 <7vfxqjmyg2.fsf@gitster.siamese.dyndns.org>
 <7f9d599f0807082226oee83bedrf13d254ae12be274@mail.gmail.com>
 <7vprpnlglh.fsf@gitster.siamese.dyndns.org>
 <7f9d599f0807092034n438f0976pf44d4c9305871087@mail.gmail.com>
 <7f9d599f0807100709u778f0ab1y28776d7efb831b61@mail.gmail.com>
 <alpine.DEB.1.00.0807101526380.18205@racer>
 <7f9d599f0807100733s4435a9bga89749f2f6e10cf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Junio C Hamano" <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: "Geoffrey Irving" <irving@naml.us>
X-From: git-owner@vger.kernel.org Fri Jul 11 08:55:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHCXD-0001D6-1R
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 08:55:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753840AbYGKGyQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2008 02:54:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753360AbYGKGyQ
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jul 2008 02:54:16 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:63254 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753350AbYGKGyP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2008 02:54:15 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 79E6F31203;
	Fri, 11 Jul 2008 02:54:13 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 8E26831202; Fri, 11 Jul 2008 02:54:06 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 2BDEA3CC-4F16-11DD-8F90-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88086>

"Geoffrey Irving" <irving@naml.us> writes:

>>> Oops: avoiding the infinite loop only requires reading expected O(1)
>>> entries on load, so I can fix that if you like.  It would only be all of
>>> them if it actually did detect the infinite loop.
>>
>> I have to admit that you lost me there.  AFAIR the patch-id cache is a
>> simple commit->patch_id store, right?  Then there should be no way to get
>> an infinite loop.
>
> If every entry is nonnull, find_helper loops forever.

Isn't it sufficient to make this part check the condition as well?

+	if (cache->count >= cache->size)
+	{
+		warning("%s is corrupt: count %"PRIu32" >= size %"PRIu32,
+			filename, cache->count, cache->size);
+		goto empty;
+	}

At runtime you keep the invariants that hashtable always has at most 3/4
full and whoever wrote the file you are reading must have honored that as
well, or there is something fishy going on.

>> Besides, this is a purely local cache, no?  Never to be transmitted...  So
>> not much chance of a malicious attack, except if you allow write access to
>> your local repository, in which case you are endangered no matter what.
>
> Yep, that's why it's only a hole in quotes, and why I didn't fix it.

You might want to protect yourself against file corruption, though.
Checksumming the whole file and checking it at opening defeats the point
of mmap'ed access, but at least the header may want to be checksummed?
