From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 0/3] Teach Git about the patience diff algorithm
Date: Thu, 1 Jan 2009 12:00:10 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0901011151440.5086@localhost.localdomain>
References: <20081104004001.GB29458@artemis.corp> <alpine.DEB.1.00.0811040627020.24407@pacific.mpi-cbg.de> <20081104083042.GB3788@artemis.corp> <alpine.DEB.1.00.0811041447170.24407@pacific.mpi-cbg.de> <20081104152351.GA21842@artemis.corp>
 <alpine.DEB.1.00.0901011730190.30769@pacific.mpi-cbg.de> <alpine.LFD.2.00.0901011134210.5086@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Pierre Habouzit <madcoder@debian.org>, davidel@xmailserver.org,
	Francis Galiegue <fg@one2team.net>,
	Git ML <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jan 01 21:02:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LITkC-0007MS-8j
	for gcvg-git-2@gmane.org; Thu, 01 Jan 2009 21:02:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751036AbZAAUAz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Jan 2009 15:00:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750974AbZAAUAy
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Jan 2009 15:00:54 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:47711 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750722AbZAAUAy (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Jan 2009 15:00:54 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n01K0A2w030634
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 1 Jan 2009 12:00:11 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n01K0AHg006925;
	Thu, 1 Jan 2009 12:00:10 -0800
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.LFD.2.00.0901011134210.5086@localhost.localdomain>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.924 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104314>



On Thu, 1 Jan 2009, Linus Torvalds wrote:
> 
> So could we have some actual real data on it?

.. and some testing. I tried to get some limited data for the kernel 
myself, by doing

	git log --patience -p v2.6.28.. > ~/patience

but I just got a core-dump instead.

Pinpointing it to a specific commit shows a smaller failure case:

	git show -p --patience 05d564fe00c05bf8ff93948057ca1acb5bc68e10

which might help you debug this.

			Linus

---
#0  0x00000000004cce73 in xdl_get_rec (xdf=0x7fffcb1e08d0, ri=-9, rec=0x7fffcb1e0778) at xdiff/xemit.c:36
#1  0x00000000004cced1 in xdl_emit_record (xdf=0x7fffcb1e08d0, ri=-9, pre=0x4eef79 "-", ecb=0x7fffcb1e0bc0)
    at xdiff/xemit.c:46
#2  0x00000000004cd4e6 in xdl_emit_diff (xe=0x7fffcb1e08d0, xscr=0x1111daf0, ecb=0x7fffcb1e0bc0, 
    xecfg=0x7fffcb1e0b80) at xdiff/xemit.c:179
#3  0x00000000004caa2c in xdl_diff (mf1=0x7fffcb1e0a40, mf2=0x7fffcb1e0a30, xpp=0x7fffcb1e0bd0, 
    xecfg=0x7fffcb1e0b80, ecb=0x7fffcb1e0bc0) at xdiff/xdiffi.c:559
#4  0x00000000004c088d in xdi_diff (mf1=0x7fffcb1e0c00, mf2=0x7fffcb1e0bf0, xpp=0x7fffcb1e0bd0, 
    xecfg=0x7fffcb1e0b80, xecb=0x7fffcb1e0bc0) at xdiff-interface.c:137
#5  0x00000000004c0914 in xdi_diff_outf (mf1=0x7fffcb1e0c00, mf2=0x7fffcb1e0bf0, fn=0x475448 <fn_out_consume>, 
    consume_callback_data=0x7fffcb1e0b40, xpp=0x7fffcb1e0bd0, xecfg=0x7fffcb1e0b80, xecb=0x7fffcb1e0bc0)
    at xdiff-interface.c:154
#6  0x00000000004780dc in builtin_diff (name_a=0x25cf6f0 "fs/nfs/nfs4xdr.c", name_b=0x25cf6f0 "fs/nfs/nfs4xdr.c", 
    one=0x25cf690, two=0x26ae110, xfrm_msg=0xf659900 "index 7dde309..29656c5 100644", o=0x7fffcb1e1088, 
    complete_rewrite=0) at diff.c:1486
#7  0x00000000004796e4 in run_diff_cmd (pgm=0x0, name=0x25cf6f0 "fs/nfs/nfs4xdr.c", other=0x0, 
    attr_path=0x25cf6f0 "fs/nfs/nfs4xdr.c", one=0x25cf690, two=0x26ae110, 
    xfrm_msg=0xf659900 "index 7dde309..29656c5 100644", o=0x7fffcb1e1088, complete_rewrite=0) at diff.c:2024
#8  0x0000000000479e2e in run_diff (p=0xaffece0, o=0x7fffcb1e1088) at diff.c:2158
#9  0x000000000047b959 in diff_flush_patch (p=0xaffece0, o=0x7fffcb1e1088) at diff.c:2743
#10 0x000000000047c942 in diff_flush (options=0x7fffcb1e1088) at diff.c:3184
#11 0x0000000000488b75 in log_tree_diff_flush (opt=0x7fffcb1e0f40) at log-tree.c:451
#12 0x0000000000488d17 in log_tree_diff (opt=0x7fffcb1e0f40, commit=0x2673198, log=0x7fffcb1e0ec0) at log-tree.c:503
#13 0x0000000000488da4 in log_tree_commit (opt=0x7fffcb1e0f40, commit=0x2673198) at log-tree.c:526
#14 0x000000000043218d in cmd_log_walk (rev=0x7fffcb1e0f40) at builtin-log.c:201
#15 0x0000000000432bae in cmd_log (argc=4, argv=0x7fffcb1e14b0, prefix=0x0) at builtin-log.c:423
#16 0x000000000040486b in run_command (p=0x70c7b0, argc=4, argv=0x7fffcb1e14b0) at git.c:243
#17 0x0000000000404a1c in handle_internal_command (argc=4, argv=0x7fffcb1e14b0) at git.c:387
#18 0x0000000000404c6e in main (argc=4, argv=0x7fffcb1e14b0) at git.c:484
