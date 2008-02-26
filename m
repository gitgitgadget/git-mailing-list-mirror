From: Johan Herland <johan@herland.net>
Subject: Re: [RFC] Build in clone
Date: Tue, 26 Feb 2008 14:37:18 +0100
Message-ID: <200802261437.18950.johan@herland.net>
References: <alpine.LNX.1.00.0802251604460.19024@iabervon.org> <200802261319.41862.johan@herland.net> <200802261358.33357.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Kristian =?utf-8?q?H=C3=B8gsberg?= <krh@redhat.com>,
	Santi =?utf-8?q?B=C3=A9jar?= <sbejar@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 26 14:39:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JU01C-00037B-Uq
	for gcvg-git-2@gmane.org; Tue, 26 Feb 2008 14:38:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753082AbYBZNiM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Feb 2008 08:38:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753139AbYBZNiM
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Feb 2008 08:38:12 -0500
Received: from sam.opera.com ([213.236.208.81]:35942 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753082AbYBZNiK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Feb 2008 08:38:10 -0500
Received: from pc107.coreteam.oslo.opera.com (pat-tdc.opera.com [213.236.208.22])
	by smtp.opera.com (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id m1QDbJi9031412
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 26 Feb 2008 13:37:19 GMT
User-Agent: KMail/1.9.7
In-Reply-To: <200802261358.33357.johan@herland.net>
Content-Disposition: inline
X-Virus-Scanned: ClamAV 0.91.1/6003/Tue Feb 26 11:34:31 2008 on smtp.opera.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75136>

On Tuesday 26 February 2008, Johan Herland wrote:
> Running this test with GDB, I get the following backtrace:
> 
> #0  0x0000000000474b87 in is_null_sha1 (sha1=0x100000008 <Address 0x100000008 out of bounds>) at cache.h:464
> #1  0x0000000000474ad3 in do_one_ref (base=0x4dc8ff "refs/", fn=0x419471 <setup_tmp_ref>, trim=0, cb_data=0x7498d0, entry=0xffffffff) at refs.c:474
> #2  0x0000000000474e28 in do_for_each_ref (base=0x4dc8ff "refs/", fn=0x419471 <setup_tmp_ref>, trim=0, cb_data=0x7498d0) at refs.c:558
> #3  0x0000000000474ecd in for_each_ref (fn=0x419471 <setup_tmp_ref>, cb_data=0x7498d0) at refs.c:580
> #4  0x0000000000419706 in setup_reference (repo=0x745070 "C/.git") at builtin-clone.c:211
> #5  0x0000000000419fce in cmd_clone (argc=2, argv=0x7fff7a282fa0, prefix=0x0) at builtin-clone.c:422
> #6  0x0000000000404ba3 in run_command (p=0x6ff710, argc=7, argv=0x7fff7a282fa0) at git.c:248
> #7  0x0000000000404d55 in handle_internal_command (argc=7, argv=0x7fff7a282fa0) at git.c:378
> #8  0x0000000000404ebe in main (argc=7, argv=0x7fff7a282fa0) at git.c:442
> 
> Seems the "loose" ref_list in do_for_each_ref() becomes corrupted.

...and the corruption is done when setup_tmp_ref() calls write_ref_sha1()
which calls invalidate_cached_refs() (which frees the ref_list that
do_for_each_ref() is iterating over).

Not sure how to best solve this. Maybe setup_tmp_ref() shouldn't use
write_ref_sha1(), but write the ref file directly instead, as hinted
at in a comment in setup_tmp_ref()?


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
