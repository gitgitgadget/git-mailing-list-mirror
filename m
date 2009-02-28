From: Kjetil Barvik <barvik@broadpark.no>
Subject: Re: [PATCH 0/6] "git repack -a -d" improvements
Date: Sat, 28 Feb 2009 13:29:12 +0100
Organization: private
Message-ID: <8663iuwxrb.fsf@broadpark.no>
References: <alpine.LFD.2.00.0902191318310.21686@localhost.localdomain>
 <cover.1235812035.git.gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 28 13:36:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LdOQW-0006H2-Hb
	for gcvg-git-2@gmane.org; Sat, 28 Feb 2009 13:36:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751423AbZB1M3S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Feb 2009 07:29:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751307AbZB1M3S
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Feb 2009 07:29:18 -0500
Received: from osl1smout1.broadpark.no ([80.202.4.58]:53684 "EHLO
	osl1smout1.broadpark.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750942AbZB1M3R (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Feb 2009 07:29:17 -0500
Received: from osl1sminn1.broadpark.no ([80.202.4.59])
 by osl1smout1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KFS00B7X00Q4950@osl1smout1.broadpark.no> for
 git@vger.kernel.org; Sat, 28 Feb 2009 13:29:14 +0100 (CET)
Received: from localhost ([80.203.106.184]) by osl1sminn1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KFS003AU00PCS10@osl1sminn1.broadpark.no> for
 git@vger.kernel.org; Sat, 28 Feb 2009 13:29:14 +0100 (CET)
In-reply-to: <cover.1235812035.git.gitster@pobox.com>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111764>

* Junio C Hamano <gitster@pobox.com> writes:
| [2/6] refactors public interface has_sha1_pack() that takes an optional
| "ignore_packed" list.  Most callers pass NULL, so it introduces a new
| function has_sha1_kept_pack() and migrate the minority caller to this
| interface while losing the argument from the original function and callers
| that currently pass NULL.
  [...]
| [4/6] identifies three places that use "ignore_packed" list to tell if a
| pack is on the list or not, and introduces a helper function to do so.
| The helper is conveniently called is_kept_pack(), even though at this
| stage the list does not necessarily mean a list of "unkept" packs yet.

  OK, patch 2/6 failed for me when I was doing 'git am' to import the
  patch-series, so sorry if do not see all bits of the patch correctly.

  Would it be an improvment to change the signature of the currently
  find_sha1_pack() function to:

    struct packed_git *
    find_pack_entry(const unsigned char *sha1, off_t *sha1_pack_offset,
                    struct packed_git *packs)

    - The currently existing 'struct pack_entry *e' parameter is only
      used to retrn the offset, so make it more clear.  The struct
      pack_entry can probably be deleted from the sha1_file.c file.

    - When the 'git repack -a -d' command is used, one has to compute
      the list of allowed pack-files to look into, and give this list to
      find_pack_entry().

    - The currently named find_sha1_pack() function can then be deleted.

    - For example, when this function is now used in sha1_object_info()
      it can be called like this:

          found_pack = find_pack_entry(sha1, &offset, packed_git);

  -- kjetil
