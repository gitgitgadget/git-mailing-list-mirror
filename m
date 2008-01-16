From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: git-commit fatal: Out of memory? mmap failed: Bad file descriptor
Date: Wed, 16 Jan 2008 08:53:20 +0100
Message-ID: <478DB7F0.2020108@viscovery.net>
References: <4787E981.7010200@nrlssc.navy.mil>	<478C1D7A.6090103@nrlssc.navy.mil>	<alpine.LFD.1.00.0801142140560.2806@woody.linux-foundation.org>	<478CECAB.2030906@nrlssc.navy.mil>	<alpine.LFD.1.00.0801150931260.2806@woody.linux-foundation.org>	<478CFAFF.6010006@nrlssc.navy.mil>	<alpine.LFD.1.00.0801151036110.2806@woody.linux-foundation.org> <7vzlv6d6sa.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	Git Mailing List <git@vger.kernel.org>, drafnel@gmail.com,
	Alex Riesen <raa.lkml@gmail.com>,
	=?ISO-8859-1?Q?Kristian_H=F8gsberg?= <krh@redhat.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 08:54:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JF361-0000pL-1D
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 08:54:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753901AbYAPHx1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 02:53:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752880AbYAPHx1
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 02:53:27 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:55938 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752429AbYAPHx0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2008 02:53:26 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1JF35H-0007kS-Rl; Wed, 16 Jan 2008 08:53:16 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 4F02F546; Wed, 16 Jan 2008 08:53:20 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <7vzlv6d6sa.fsf@gitster.siamese.dyndns.org>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70646>

Junio C Hamano schrieb:
> While I think the ones that are immediately followed by
> commit_locked_index() can drop the close(fd) safely, I am not
> sure about Kristian's changes to the other ones that we
> currently close(fd) but do not commit nor rollback immediately.
> These indices are now shown to the hook with open fd to it if
> you choose not to close them.  Is that okay for Windows guys?  I
> somehow had an impression that the other process may have
> trouble accessing a file that is still open elsewhere for
> writing.

The trouble is that on Windows open files cannot be deleted or renamed.
Hence, if an index file remains open, the hooks won't be able to modify
them (because of the create-new-file-then-rename-over-old tactics).

> So I think the approach along the lines of your "hack" to close
> and tell lockfile API not to double-close is more appropriate.
> We would perhaps want "close_lock_file(struct lock_file *)" that
> calls close(lk->fd) and does lk->fd = -1 without rename/unlink,
> and replace these close() with that.

Yes!

-- Hannes
