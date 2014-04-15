From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v3 00/25] Lockfile correctness and refactoring
Date: Tue, 15 Apr 2014 20:40:46 +0200
Message-ID: <534D7D2E.7060100@web.de>
References: <1397483695-10888-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>,
	Jeff King <peff@peff.net>,
	=?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 15 20:44:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wa8LY-0008LW-15
	for gcvg-git-2@plane.gmane.org; Tue, 15 Apr 2014 20:44:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754959AbaDOSoc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Apr 2014 14:44:32 -0400
Received: from mout.web.de ([212.227.17.12]:62289 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755165AbaDOSlO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Apr 2014 14:41:14 -0400
Received: from [192.168.209.26] ([78.72.74.102]) by smtp.web.de (mrweb002)
 with ESMTPSA (Nemesis) id 0MBCYn-1WhW8P2UiL-00ABSD; Tue, 15 Apr 2014 20:40:52
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
In-Reply-To: <1397483695-10888-1-git-send-email-mhagger@alum.mit.edu>
X-Provags-ID: V03:K0:+vnTUnf3nBDeCD58SaTfkxcK4cHex8cy+rOsmfNuerLXo35A5fv
 6Y+Gu529M7X4HbXsync1MUqO/bEL9Q0NdAnIjWWPfDmuflZaP6tIwJaBhjjq6Y60S7xeqyy
 0ah8otRljVaB6UE4/zeUWr4ZBEEG3Ewtu4+Nlw7emAFSrJ2gETC5/ro1Y2o+SbhR4RrKQ8C
 xb/v0QSYnqYMzQxOoTNuw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246294>

refs.c:
int close_ref(struct ref_lock *lock)
{
	if (close_lock_file(lock->lk))
		return -1;
	lock->lock_fd = -1;
	return 0;
}

When the close() fails, fd is still >= 0, even if the file is closed.

Could it be written like this ?

int close_ref(struct ref_lock *lock)
{
	return close_lock_file(lock->lk);
}
=====================
lockfile.c, line 49
 *   - filename holds the filename of the lockfile

I think we have a strbuf here? (which is a good thing),
should we write:
 *   - strbuf filename holds the filename of the lockfile
----------
(and at some places filename[0] is mentioned,
should that be filename.buf[0] ?)



=========================
int commit_lock_file(struct lock_file *lk)
{
	static struct strbuf result_file = STRBUF_INIT;
	int err;

	if (lk->fd >= 0 && close_lock_file(lk))
		return -1;
##What happens if close() fails and close_lock_file() returns != 0?
##Is the lk now in a good shaped state?
I think the file which had been open by lk->fd is in an unkown state,
and should not be used for anything.
When I remember it right, an error on close() can mean "the file could not
be written and closed as expected, it can be truncated or corrupted.
This can happen on a network file system like NFS, or probably even other FS.
For me the failing of close() means I smell a need for a rollback.

	if (!lk->active)
		die("BUG: attempt to commit unlocked object");

	/* remove ".lock": */
	strbuf_add(&result_file, lk->filename.buf,
		   lk->filename.len - LOCK_SUFFIX_LEN);
	err = rename(lk->filename.buf, result_file.buf);
	strbuf_reset(&result_file);
	if (err)
		return -1;
	lk->active = 0;
	strbuf_reset(&lk->filename);
	return 0;
}

================
Please treat my comments more than questions rather than answers,
thanks for an interesting reading
