From: David Kastrup <dak@gnu.org>
Subject: Strange code in diff-delta.c
Date: Thu, 23 Aug 2007 02:59:01 +0200
Organization: Organization?!?
Message-ID: <85k5rnjcbu.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 23 02:59:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IO12l-00070k-KD
	for gcvg-git@gmane.org; Thu, 23 Aug 2007 02:59:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753312AbXHWA7Z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Aug 2007 20:59:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753263AbXHWA7Y
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Aug 2007 20:59:24 -0400
Received: from main.gmane.org ([80.91.229.2]:36444 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752501AbXHWA7Y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2007 20:59:24 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IO12U-0005Kr-EZ
	for git@vger.kernel.org; Thu, 23 Aug 2007 02:59:10 +0200
Received: from dslb-084-061-060-116.pools.arcor-ip.net ([84.61.60.116])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 23 Aug 2007 02:59:10 +0200
Received: from dak by dslb-084-061-060-116.pools.arcor-ip.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 23 Aug 2007 02:59:10 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: dslb-084-061-060-116.pools.arcor-ip.net
X-Face: 2FEFf>]>q>2iw=B6,xrUubRI>pR&Ml9=ao@P@i)L:\urd*t9M~y1^:+Y]'C0~{mAl`oQuAl
 \!3KEIp?*w`|bL5qr,H)LFO6Q=qx~iH4DN;i";/yuIsqbLLCh/!U#X[S~(5eZ41to5f%E@'ELIi$t^
 Vc\LWP@J5p^rst0+('>Er0=^1{]M9!p?&:\z]|;&=NP3AhB!B_bi^]Pfkw
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Cancel-Lock: sha1:zukyME4Xp14v3H3AaixwU8JmA74=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56442>


I am currently looking what can be done to speed up deltaing.  The
following code can be found here:

	for (i = 0; i < hsize; i++) {
		if (hash_count[i] < HASH_LIMIT)
			continue;
		entry = hash[i];
		do {
			struct index_entry *keep = entry;
			int skip = hash_count[i] / HASH_LIMIT / 2;
			do {
				entry = entry->next;
			} while(--skip && entry);
			keep->next = entry;
		} while(entry);
	}

If I analyze what happens for various values of hash_count[i], I get
the following (the first case is by far the worst):

HASH_LIMIT <= hash_count[i] < 2*HASH_LIMIT:
  skip = 0;
  do .. while terminates with negative skip and entry == 0, keep->next
  is set to 0 -> all hashes except the first one get dropped.
  Result is new_hash_count = 1.  Ugh, ugh, ugh.

2*HASH_LIMIT <= hash_count[i] < 4*HASH_LIMIT
  skip = 1;
  do .. while does one iteration, every second value is skipped,
  result is that HASH_LIMIT <= new_hash_count < 2*HASH_LIMIT

4*HASH_LIMIT <= hash_limit[i] < 6*HASH_LIMIT
  skip = 2;
  do .. while does two iterations, two of three values are skipped,
  result is that 4*HASH_LIMIT/3 <= new_hash_count < 2*HASH_LIMIT

And so on.  It would appear that if HASH_LIMIT is supposed to do what
it is seemingly intended for, the skip calculation has to be just

			int skip = hash_count[i] / HASH_LIMIT;

Otherwise, there is completely broken behavior for values between
HASH_LIMIT and 2*HASH_LIMIT (where only a single hash survives), and
for larger values, the limit will be 2*HASH_LIMIT rather than
HASH_LIMIT as was probably intended.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
