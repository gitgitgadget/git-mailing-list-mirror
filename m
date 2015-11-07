From: Lukas Fleischer <lfleischer@lfos.de>
Subject: Re: [PATCH] receive-pack: avoid sending duplicate "have" lines
Date: Sat, 07 Nov 2015 10:04:31 +0100
Message-ID: <20151107090431.576.3746@typhoon.lan>
References: <1446851773-32390-1-git-send-email-lfleischer@lfos.de>
 <xmqq8u6a3dif.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 07 10:04:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZuzQR-00074a-UK
	for gcvg-git-2@plane.gmane.org; Sat, 07 Nov 2015 10:04:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752569AbbKGJEj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Nov 2015 04:04:39 -0500
Received: from elnino.cryptocrack.de ([46.165.227.75]:36698 "EHLO
	elnino.cryptocrack.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752318AbbKGJEf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Nov 2015 04:04:35 -0500
Received: by elnino.cryptocrack.de (OpenSMTPD) with ESMTPSA id c2eb8566;
	TLS version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO;
	Sat, 7 Nov 2015 10:04:32 +0100 (CET)
In-Reply-To: <xmqq8u6a3dif.fsf@gitster.mtv.corp.google.com>
User-Agent: alot/0.3.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281016>

On Sat, 07 Nov 2015 at 00:38:00, Junio C Hamano wrote:
> [...]
> I suspect that many of these that turn into ".have"s point the same
> object as those sit at the tip of our refs (e.g. tags in alternates
> we borrow from, which are the folks of the same project that copy
> the same tags from the same upstream).  I wonder if it easy to filter
> them out?  After all, if we say object X sits at refs/tags/v1.0
> there is no point showing ".have" for that same object X.
> [...]

It is certainly doable but we would need a better infrastructure. The
easiest implementation (i.e. the one that is closest to what we
currently do) is adding a second SHA1 array to collect all the hashes we
already advertised. We could then pass a struct of both SHA1 arrays as
second parameter to for_each_ref() and always insert the object
identifier into either of the arrays in show_ref_cb(), depending on
whether we immediately advertise it as a ref or decide convert it into a
"have" line. To transmit "have" lines, instead of calling
sha1_array_for_each_unique(), we would then call some function that
prints unique entries from the first array that do not appear in the
second array. Something like this (fully untested):

-- 8< --
void sha1_array_for_each_diff(struct sha1_array *array1,
			      struct sha1_array *array2,
			      for_each_sha1_fn fn,
			      void *data)
{
	int i, j;

	if (!array1->sorted)
		sha1_array_sort(array1);
	if (!array2->sorted)
		sha1_array_sort(array2);

	for (i = j = 0; i < array1->nr; i++) {
		if (i > 0 && !hashcmp(array1->sha1[i], array1->sha1[i - 1]))
			continue;
		while (j < array2->nr && hashcmp(array1->sha1[i], array2->sha1[j]) > 0)
			j++;
		if (j < array2->nr && !hashcmp(array1->sha1[i], array2->sha1[j]))
			continue;
		fn(array1->sha1[i], data);
	}
}
-- >8 --

If we decide to implement all that, however, I wonder whether we should
use a more sophisticated data structure instead. Currently, if there are
n refs outside the current namespace pointing all to the same object, we
append n entries to the SHA1 array and sort them afterwards which
requires O(n) space. If we would maintain a set of hashes instead of an
array in the first place, we could reduce space usage significantly by
only storing what is needed (O(1) in the scenario I mentioned). We could
also add markers to those object identifiers we already advertised
instead of maintaining two separate lists.

Unfortunately, in order to keep the running time of O(n log n), we would
probably need something like self-balancing binary search trees.
Alternatively, a hash map based approach could be taken. Is something
like this already used anywhere in the Git source tree such that we can
borrow the required data structures and functions?
