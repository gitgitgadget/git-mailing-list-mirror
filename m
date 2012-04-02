From: Thomas Rast <trast@inf.ethz.ch>
Subject: Bug: bad errno report from lock_ref_sha1_basic() when contents bad
Date: Mon, 2 Apr 2012 12:04:29 +0200
Message-ID: <878viephzm.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Junio C Hamano <gitster@pobox.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 02 12:04:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SEe7u-0001Hd-Ha
	for gcvg-git-2@plane.gmane.org; Mon, 02 Apr 2012 12:04:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751659Ab2DBKEe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Apr 2012 06:04:34 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:33697 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751465Ab2DBKEd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Apr 2012 06:04:33 -0400
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.283.3; Mon, 2 Apr
 2012 12:04:30 +0200
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS20.d.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.1.355.2; Mon, 2 Apr
 2012 12:04:30 +0200
User-Agent: Notmuch/0.3.1-59-g676d251 (http://notmuchmail.org) Emacs/23.3.1 (x86_64-suse-linux-gnu)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194504>

Hi Junio,

User "mbrochh" on IRC reported a result along the lines of

  error: unable to resolve reference refs/remotes/origin/master: Success
  ! [new branch] master -> origin/master (unable to update local ref)

from 'git fetch' (or pull actually, but clearly it's the fetch part
failing).  This error message is from lock_ref_sha1_basic(), and
suggests a confused error exit taken with errno=0.

I can reproduce the problem by writing a bit of garbage to a remote ref
and then fetching, though I usually get some other error in the message
(usually ENOENT, which is equally wrong).

As far as I can tell it's caused by resolve_ref_unsafe() returning NULL
when the content checks fail:

	if (get_sha1_hex(buffer, sha1) || (buffer[40] != '\0' && !isspace(buffer[40]))) {
		if (flag)
			*flag |= REF_ISBROKEN;
		return NULL;
	}

This used to warn before your 5595635 (resolve_ref(): report breakage to
the caller without warning, 2011-10-19), but otherwise suffered from the
same problem.

As far as I can see lock_ref_sha1_basic() needs a similar check for
REF_ISBROKEN (and presumably the only fix is to nuke it so maybe it
should even suggest that to the user).  But in general, the "errno may
be crucial or worthless" interface of lock_ref_sha1_basic() seems a bit
broken...

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
