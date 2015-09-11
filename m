From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Bloom filters for have/want negotiation
Date: Fri, 11 Sep 2015 23:13:25 +0200
Message-ID: <55F343F5.6010903@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: Wilhelm Bierbaum <bierbaum@gmail.com>, Jeff King <peff@peff.net>
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Sep 11 23:13:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZaVdh-0004jF-JN
	for gcvg-git-2@plane.gmane.org; Fri, 11 Sep 2015 23:13:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753922AbbIKVNl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Sep 2015 17:13:41 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:62632 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752890AbbIKVNl (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Sep 2015 17:13:41 -0400
X-AuditID: 1207440d-f79136d00000402c-64-55f343f70cb9
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 65.84.16428.7F343F55; Fri, 11 Sep 2015 17:13:27 -0400 (EDT)
Received: from [192.168.69.130] (p4FC96DD6.dip0.t-ipconnect.de [79.201.109.214])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t8BLDPrv015150
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Fri, 11 Sep 2015 17:13:26 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.8.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFIsWRmVeSWpSXmKPExsUixO6iqPvd+XOowcVF4hZTn81it+i60s1k
	8aOlh9mB2WPnrLvsHs969zB6fN4kF8AcxW2TlFhSFpyZnqdvl8Cd8a7rF2vBA6WKUzuOMjYw
	/pXuYuTkkBAwkTi84wg7hC0mceHeerYuRi4OIYHLjBIX+h8xQTgXmCTajs5nAaniFdCWWLtu
	JhuIzSKgKrGrfREziM0moCuxqKeZCcQWFQiSWLH8BSNEvaDEyZlPwHpFgGp2PbsK1sss4CJx
	9eIGsM3CAgYSK9//ZYeIq0v8mXeJGcKWl2jeOpt5AiPfLCSjZiEpm4WkbAEj8ypGucSc0lzd
	3MTMnOLUZN3i5MS8vNQiXSO93MwSvdSU0k2MkHDk3cH4f53MIUYBDkYlHl4L1U+hQqyJZcWV
	uYcYJTmYlER5TRw+hwrxJeWnVGYkFmfEF5XmpBYfYpTgYFYS4S0WBsrxpiRWVqUW5cOkpDlY
	lMR51Zao+wkJpCeWpGanphakFsFkZTg4lCR4jzkBNQoWpaanVqRl5pQgpJk4OEGGc0mJFKfm
	paQWJZaWZMSDYi++GBh9ICkeoL2rQdp5iwsSc4GiEK2nGBWlxHl3gyQEQBIZpXlwY2FJ5hWj
	ONCXwrxfQap4gAkKrvsV0GAmoMHviz+BDC5JREhJNTDWicpf1oudGXLMtNLjpcKzp3L1h+ZN
	vmhQWzH72oXGz2Fyjyre8h0R0HvXcUlcNvqTnN78zb5ystGimw91K665tPZ0+rm/i3/wNUo1
	r2vpu25zu6MqZU1YvPCGUlb3IzECDnUOrmErM04s5L9//qTzd+apN1y2Nryf0p70 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277696>

I have been thinking about Wilhelm Bierbaum's talk at the last GitMerge
conference [1] in which he describes a scheme for using Bloom filters to
make the initial reference advertisement less expensive.

In his scheme (if I understand correctly) the client starts off the
conversation by passing the server a Bloom filter that indicates what
(refname, SHA-1) pairs the client already has. This makes it unnecessary
for the server to advertise those references, thereby reducing the cost
of incremental fetches dramatically if the server has very many references.

Because Bloom filters have false positives, this scheme is not 100%
reliable. Therefore I don't think we would want Git to depend on it.

But it got me thinking about how the client could use a Bloom filter in
a later stage of the negotiation, when telling the server what objects
it already has, while preserving 100% reliability.

The idea is to use connectivity information to correct mistakes caused
by reliance on the Bloom-filter:

1. The server advertises the references that it has in the way that it
is currently done.
2. The client advertises the objects that it has (or some subset of
them; see below) via a Bloom filter.
3. The server sends the client the packfile that results from assuming
that the Bloom filter is giving correct answers. (This might mean that
too few objects are sent to the client.)
4. The client does a connectivity check on the packfile. If any objects
are missing, it asks the server for them via a reliable
(non-Bloom-filter-based) request.

How would one construct the Bloom filter for step 2? (Remember that a
properly-configured Bloom filter requires about 5 bits of space per
value stored for each factor of 0.1 in the false-positive rate. So, for
example, to store 5000 values with a 1% false-positive rate, the Bloom
filter would need to be approximately 5000 * 10 bits = 6.2 kB in size.)

Here are some possible schemes:

* Record *all* objects in the Bloom filter. The Git repo has
approximately 200k objects, so, supposing that we could live with a 10%
false-positive rate (see below), the Bloom filter would need to be about
125 kB.

* Record all commit objects in the Bloom filter. For the Git repo that
is about 40k commits, so for a 10% error rate the Bloom filter would
have to be about 25 kB.

* Record some subset of commits; for example, all unique branch and tag
tips, the peeled tags, plus some sparse subsets of commits deeper in the
history. The ls-remote for the Git repo lists 1730 unique SHA-1s, so,
supposing we choose 10x that number with a 1% error rate, the Bloom
filter would be about 20 kB.

* Record only the branch and tag tips and peeled tags. Please note that
for situations where the client has fetched from the server before and
still has the remote-tracking references from that fetch, this scheme
might work surprisingly well. For the Git repository, with a 1% error
rate, this would be about 2 kB.

For the first two schemes, we could tolerate a pretty high error rate
because the server could perform additional consistency checks to reduce
the error rate. For example, if the Bloom filter reports that the client
has commit X, but that the client does *not* have a parent of X, then
the server can assume that the check of X was a false positive and
discard it. Such consistency checks would not be possible with the third
or fourth schemes, so I have chosen lower false-positive rates for those
schemes.

Additional points:

* The client can decide what to include in the Bloom filter. For
example, if it has done a recent fetch from the server, it might want to
send only the remote-tracking branch tips. But if it has never fetched
from this server before, it might want to send all commits.

* A Bloom filter could be computed at repack time rather than at each
fetch. On fetch, the precomputed Bloom filters could be loaded, any
loose objects added to it, and the result sent to the server.

I don't have a gut feeling about the cost of this phase of the
negotiation, so I don't know whether this would be a net savings, let
alone one that is worth the added complexity. But I wanted to document
the idea in case somebody thinks it has promise. (I have no plans to
pursue it.)

Michael

[1] http://git-merge.com/videos/scaling-git-at-twitter-wilhelm-bierbaum.html

-- 
Michael Haggerty
mhagger@alum.mit.edu
