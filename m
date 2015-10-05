From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v5 2/3] path: optimize common dir checking
Date: Mon, 05 Oct 2015 05:00:01 +0200
Message-ID: <5611E7B1.3090001@alum.mit.edu>
References: <1441073591-639-1-git-send-email-dturner@twopensource.com> <1441073591-639-3-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>
To: David Turner <dturner@twopensource.com>, git@vger.kernel.org,
	Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 05 05:07:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ziw7P-0003AN-9Y
	for gcvg-git-2@plane.gmane.org; Mon, 05 Oct 2015 05:07:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751959AbbJEDHI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Oct 2015 23:07:08 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:44846 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751495AbbJEDHH (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 Oct 2015 23:07:07 -0400
X-Greylist: delayed 423 seconds by postgrey-1.27 at vger.kernel.org; Sun, 04 Oct 2015 23:07:07 EDT
X-AuditID: 1207440f-f79df6d000007c0f-97-5611e7b4be3a
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 95.26.31759.4B7E1165; Sun,  4 Oct 2015 23:00:04 -0400 (EDT)
Received: from [192.168.69.130] (p4FC96E0C.dip0.t-ipconnect.de [79.201.110.12])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t953028K018696
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Sun, 4 Oct 2015 23:00:03 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.8.0
In-Reply-To: <1441073591-639-3-git-send-email-dturner@twopensource.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFKsWRmVeSWpSXmKPExsUixO6iqLvluWCYwdGVXBa3Z7YwW8zfdILR
	outKN5NFQ+8VZgcWj52z7rJ7XLyk7LHg+X12j8+b5AJYorhtkhJLyoIz0/P07RK4M75/ucte
	sE6s4sbJHpYGxmahLkYODgkBE4nr/xO7GDmBTDGJC/fWs3UxcnEICVxmlLjR9pMdwjnHJPHy
	wlwWkAZeAW2J6wusQRpYBFQlVsx/ygRiswnoSizqaQazRQWCJFYsf8EIYvMKCEqcnPmEBcQW
	EaiQWPH1HjuIzSygJnFoySOwGmEBO4lL935BLW5klNj3/ApYA6eAu0TD7ZvMEA16Ejuu/2KF
	sOUlmrfOZp7AKDALyY5ZSMpmISlbwMi8ilEuMac0Vzc3MTOnODVZtzg5MS8vtUjXRC83s0Qv
	NaV0EyMknPl3MHatlznEKMDBqMTDeyBeMEyINbGsuDL3EKMkB5OSKG+oGlCILyk/pTIjsTgj
	vqg0J7X4EKMEB7OSCO/rx0A53pTEyqrUonyYlDQHi5I4r/oSdT8hgfTEktTs1NSC1CKYrAwH
	h5IE76NnQI2CRanpqRVpmTklCGkmDk6Q4VxSIsWpeSmpRYmlJRnxoEiNLwbGKkiKB2ivBUg7
	b3FBYi5QFKL1FKOilDjvDZCEAEgiozQPbiwsSb1iFAf6Uph3E0gVDzDBwXW/AhrMBDR4gSEf
	yOCSRISUVAPjhgTLo0ZPrl89Y9i9vv7beeYjfJt1XOz/ON6u3/HjXdjmnK8Hy6Nv2UpOjt7L
	eI+h4h+LvyHD22d7WsXmGTs4hax69VxX4MjD8qmzEjKPK4YE5h0ou3+o9+Vm1xu8 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279028>

On 09/01/2015 04:13 AM, David Turner wrote:
> Instead of a linear search over common_list to check whether
> a path is common, use a trie.  The trie search operates on
> path prefixes, and handles excludes.

Here I am, coming late to the discussion as usual. Sorry for that.

I dug into this code yesterday and got all nerd-tingly and started
refactoring and optimizing it. But after I slept on it I realized that
I'm a bit hazy on its justification. A trie is a beautiful data
structure and all, but have there been any benchmarks showing (1) that
this lookup is a bottleneck and (2) that the trie is an improvement on
something simpler, like, say, a sorted string_list? Or is there a
realistic hope that the trie might be generally useful for other purposes?

The latter seems unlikely, at least with the current implementation,
because it is very wasteful of space. It allocates one or two (usually
two) `struct trie` for every single string that is added to it. Each
`struct trie` contains an array of 256 pointers and usually needs two
malloc calls to instantiate. So *each entry* stored in the trie costs
something like 4 kilobytes on a 64-bit system, plus usually 4 calls to
malloc. The large memory footprint, in turn, will cause access
non-locality and might impact the lookup performance. So it is pretty
clear that the current code would be unusable for a large number of strings.

For this particular application, where we only have 19 strings to store,
I suppose we could tolerate the use of approximately 64k of RAM to store
174 characters worth of strings *if* it would bring us big time savings.
But I think we need some evidence of the time savings.

If this lookup is really a bottleneck, I bet there are other
alternatives that are just as fast as this trie and use less code,
especially given that there are only 19 strings that need checking.

With respect to the implementation, it looks correct to me. I would make
the following three suggestions:

* Please document that the `contents` field of `struct trie` is not
NUL-terminated, because that would otherwise be a common assumption. (It
is clearly not NUL-terminated because of the way it is initialized using
xmalloc and memcpy in make_trie_node() and because of the way its length
is adjusted in add_to_trie().)
* But in add_to_trie(), you set `contents` using xstrdup(), which *does*
NUL-terminate the string. It would be more consistent to set it using
xmalloc and memcpy here.
* Please use size_t instead of int for indexing into strings, at least
in the trie_find() function, where the input is likely to be under the
control of users.

If we expected to use the trie for other purposes, then I would suggest
a raft of other improvements. Ask me if you are interested.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
