From: Junio C Hamano <gitster@pobox.com>
Subject: [BUG] "git fetch --tags" seems to be broken with recent change on
 'master'
Date: Mon, 28 Mar 2011 19:22:04 -0700
Message-ID: <7vzkoeu0mr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: spearce@spearce.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 29 04:22:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4OZZ-0002LY-Qw
	for gcvg-git-2@lo.gmane.org; Tue, 29 Mar 2011 04:22:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755276Ab1C2CWP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2011 22:22:15 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:43552 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753103Ab1C2CWO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2011 22:22:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 311444F8B;
	Mon, 28 Mar 2011 22:23:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=O
	vPbQVjaMO/019PwUKZO7O5Hd3E=; b=Lobp88ZA/AcJ/jBPB+C+LDZ/NCtXyonaG
	dVbybLKUd4zSqluiEV2zm3My2k0UvWD0GGDzgAnX6o9K03+p2Sy9Q9vtl52Ruc8L
	osatfdCwU5Lbdr2AwrkBFY2UivvuXffbC9y5EDzvqfjRZaRP+l/2FG0RGoD3wsK+
	31GwkV3YBo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; q=dns; s=
	sasl; b=J3LlQRBJHN/xZeIzpxao/XJJJ0RS31gkwEEKO9ALtFZGBVzOLOreIa6h
	hYEdwJBCI9qEFB4HrWWF+brIRL1NiLsa4/iSrEoHXiwgzZ2LmXgqxqg7i1Bo5QS5
	7+eU6OUqFSUQq+p7JP7dtMuUwShtk60Ii+gdnnEVRQ2BepVHHx8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0FA6C4F87;
	Mon, 28 Mar 2011 22:23:55 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 1AB804F84; Mon, 28 Mar 2011
 22:23:51 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9841A76A-59AB-11E0-AED9-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170219>

I haven't started digging this through, but just a heads-up.

One of the recent changes we made on 'master' (either Shawn's protocol
tweak or my progressive common commit discovery) seems to have broken "git
fetch --tags" and possibly other forms of fetch, failing with SIGPIPE.
From the stack trace I am guessing that the server side might be closing
the connection prematurely while the client still wants to say something
to it.

#0  0x000000362d80e470 in __write_nocancel () from /lib64/libpthread.so.0
#1  0x00000000005064de in xwrite (fd=9, buf=0x896480, len=804) at wrapper.c:137
#2  0x00000000004c6570 in safe_write (fd=9, buf=0x896480, n=804) at pkt-line.c:68
#3  0x000000000042ada5 in send_request (fd=9, buf=0x7fffffffdd40)
    at builtin/fetch-pack.c:219
#4  0x000000000042b458 in find_common (fd=0x7c6740, 
    result_sha1=0x7fffffffde20 "\200\203}", refs=0x0) at builtin/fetch-pack.c:368
#5  0x000000000042c48c in do_fetch_pack (fd=0x7c6740, orig_ref=0x7d8460, nr_match=1, 
    match=0x7d8380, pack_lockfile=0x7c6700) at builtin/fetch-pack.c:765
#6  0x000000000042cd23 in fetch_pack (my_args=0x7fffffffdfc0, fd=0x7c6740, conn=0x7d83a0, 
    ref=0x7d8460, dest=0x7f86d0 "/pub/scm/git/git.git", nr_heads=1, heads=0x7d8380, 
    pack_lockfile=0x7c6700) at builtin/fetch-pack.c:985
#7  0x00000000004f83d0 in fetch_refs_via_pack (transport=0x7c66a0, nr_heads=1, 
    to_fetch=0x7f8600) at transport.c:542
#8  0x00000000004f9c5c in transport_fetch_refs (transport=0x7c66a0, refs=0x7e5610)
    at transport.c:1112
#9  0x000000000042e3aa in fetch_refs (transport=0x7c66a0, ref_map=0x7e5610)
    at builtin/fetch.c:513
#10 0x000000000042eb97 in do_fetch (transport=0x7c66a0, refs=0x7c6b80, ref_count=0)
    at builtin/fetch.c:712
#11 0x000000000042f431 in fetch_one (remote=0x7c6420, argc=0, argv=0x7fffffffe4e8)
    at builtin/fetch.c:895
#12 0x000000000042f6c6 in cmd_fetch (argc=1, argv=0x7fffffffe4e0, prefix=0x0)
    at builtin/fetch.c:947
#13 0x000000000040484c in run_builtin (p=0x771de8, argc=3, argv=0x7fffffffe4e0)
    at git.c:290
#14 0x00000000004049e8 in handle_internal_command (argc=3, argv=0x7fffffffe4e0)
    at git.c:448
#15 0x0000000000404ae2 in run_argv (argcp=0x7fffffffe3cc, argv=0x7fffffffe3c0) at git.c:492
#16 0x0000000000404c6a in main (argc=3, argv=0x7fffffffe4e0) at git.c:565
