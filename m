From: "George Spelvin" <linux@horizon.com>
Subject: Re: [PATCH 07/11] object: try naive cuckoo hashing
Date: 13 Aug 2011 15:12:06 -0400
Message-ID: <20110813191206.25129.qmail@science.horizon.com>
References: <20110813102244.9033.qmail@science.horizon.com>
Cc: git@vger.kernel.org
To: gitster@pobox.com, linux@horizon.com
X-From: git-owner@vger.kernel.org Sat Aug 13 21:12:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QsJd1-0000AR-UE
	for gcvg-git-2@lo.gmane.org; Sat, 13 Aug 2011 21:12:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751932Ab1HMTML (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Aug 2011 15:12:11 -0400
Received: from science.horizon.com ([71.41.210.146]:54166 "HELO
	science.horizon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751529Ab1HMTMJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Aug 2011 15:12:09 -0400
Received: (qmail 25130 invoked by uid 1000); 13 Aug 2011 15:12:06 -0400
In-Reply-To: <20110813102244.9033.qmail@science.horizon.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179290>

I've been doing a lot of reading on Cuckoo hashing.

Yes, the single-table variant is described and used.  However, the
insertion procedure is not the way you do it.

Also, d-ary Cuckoo hashing (also called d-Cuckoo hashing) where you use
more than 2 hash functions is also used.

The insertion algorithm, however, is not really agreed on.

One algorithm (mostly proposed for hardware) uses d separate tables.
Every entry displaced from table i is displaced to table i+1 (mod d).
http://infoscience.epfl.ch/record/164147/files/cuckoo_dir_hpca2011_camera_ready.pdf

In the single-table case, and in general, however, a displaced entry
has more than one possible new location.  This leads to the question of how
to choose.

One proposal is to do a breadth-first search looking for a path to
a free slot.  It's provable that this will succeed with high probability
before the exponential growth of the breadth of the search tree
gets too bad.
See "Space Efficient Hash Tables with Worst Case Constant Access Time"
http://www.itu.dk/people/pagh/papers/d-cuckoo-jour.pdf

Another suggested tehcnique is to just pick an alternative at random
and proceed.  This is recommended in e.g.
"Efficient Hash Probes on Modern Processors"
http://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.67.1189&rep=rep1&type=pdf

Both of these lead to rather complex implementations.  The random number
generator is probably simpler than the breadth-first search, but either way
there's a bunch of auxiliary code.

Sticking with two hash functions, but using multi-entry buckets is
definitely an attractive possibility.
