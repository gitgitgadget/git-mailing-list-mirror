From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: >4GiB source delta assertion failure
Date: Thu, 22 Jul 2010 02:16:35 +0300
Message-ID: <20100721231635.GA6387@LK-Perkele-V2.elisa-laajakaista.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 22 01:16:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ObiWT-0000YJ-Mk
	for gcvg-git-2@lo.gmane.org; Thu, 22 Jul 2010 01:16:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758336Ab0GUXQK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jul 2010 19:16:10 -0400
Received: from emh06.mail.saunalahti.fi ([62.142.5.116]:54461 "EHLO
	emh06.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754907Ab0GUXQH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jul 2010 19:16:07 -0400
Received: from saunalahti-vams (vs3-12.mail.saunalahti.fi [62.142.5.96])
	by emh06-2.mail.saunalahti.fi (Postfix) with SMTP id A7946C8176
	for <git@vger.kernel.org>; Thu, 22 Jul 2010 02:16:04 +0300 (EEST)
Received: from emh06.mail.saunalahti.fi ([62.142.5.116])
	by vs3-12.mail.saunalahti.fi ([62.142.5.96])
	with SMTP (gateway) id A079F7784FA; Thu, 22 Jul 2010 02:16:04 +0300
Received: from LK-Perkele-V2 (a88-112-50-174.elisa-laajakaista.fi [88.112.50.174])
	by emh06.mail.saunalahti.fi (Postfix) with ESMTP id 9A12CE51A2
	for <git@vger.kernel.org>; Thu, 22 Jul 2010 02:16:03 +0300 (EEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151432>

Yes, I know trying to delta-compress with 4GiB files is insane, but OTOH,
assertion failures are bugs by defintion.

Delta source: <4GiB of zeroes> <random 64KiB block>
Delta destination: <the same 64KiB block>

This was created using:
$ dd if=/dev/urandom of=test-delta-target bs=64k count=1
$ dd if=test-delta-target of=test-delta-source bs=64k seek=64k

Now running

$ ./test-delta -d test-delta-source test-delta-target test-delta-delta

Crashes with (v1.7.2):

test-delta: diff-delta.c:285: create_delta_index: Assertion `packed_entry - (struct index_entry *)mem == entries' failed.
Aborted


As note: The delta compression format does not allow delta compression to 
properly work in this case (since source offset would need to be 2^32 and
biggest possible offset is 2^32-1), and thus the size of output should be on
order of 66kB.

-Ilari
