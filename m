From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2] git-mv: Keep moved index entries inact
Date: Mon, 28 Jul 2008 22:23:27 -0700
Message-ID: <7vfxptmfg0.fsf@gitster.siamese.dyndns.org>
References: <20080721002354.GK10151@machine.or.cz>
 <20080721002508.26773.92277.stgit@localhost>
 <7v8wvpm9cl.fsf@gitster.siamese.dyndns.org> <20080728142023.GC6701@neumann>
 <alpine.DEB.1.00.0807281605330.8986@racer>
 <7vwsj5rf48.fsf@gitster.siamese.dyndns.org>
 <20080729001751.GH10151@machine.or.cz>
 <7vod4ho6uq.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	SZEDER =?utf-8?Q?G?= =?utf-8?Q?=C3=A1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Tue Jul 29 07:24:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNhhP-00055s-Ck
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 07:24:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751976AbYG2FXk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2008 01:23:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751875AbYG2FXj
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 01:23:39 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:55418 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751821AbYG2FXj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2008 01:23:39 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id C6D7F41EA1;
	Tue, 29 Jul 2008 01:23:36 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 6C63141E9F; Tue, 29 Jul 2008 01:23:30 -0400 (EDT)
In-Reply-To: <7vod4ho6uq.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 28 Jul 2008 17:46:05 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 7EC8489C-5D2E-11DD-B4D9-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90574>

Junio C Hamano <gitster@pobox.com> writes:

> Petr Baudis <pasky@suse.cz> writes:
>
>> On Mon, Jul 28, 2008 at 12:19:19PM -0700, Junio C Hamano wrote:
>>> We need to refresh the entry to pick up potential ctime changes.
>>> 
>>>  read-cache.c       |    7 ++++++-
>>>  builtin-ls-files.c |   21 +++++++++++++++------
>>>  2 files changed, 21 insertions(+), 7 deletions(-)
>>> 
>>> diff --git a/read-cache.c b/read-cache.c
>>> index 1cae361..834096f 100644
>>
>> Oops, silly me. Sorry for being slower than you at fixing this. ;-)
>
> I did think about ctime issues when I applied the patch.

Actually I changed my mind.

I think it is wrong for something as low-level as rename_index_entry_at()
to unconditionally look at the working tree and try refreshing the entry.
The next caller of this function may not even require a working tree.

I think Dscho is correct; expecting the saved cacheinfo to stay fresh
across rename does not make much sense.  What we care about with "git mv"
is that we keep what the user staged, i.e. kind of blob and the contents.
It cannot be guaranteed if the index entry is stat clean or not, as
st_ctime may or may not be updated across rename(2) according to POSIX.

So let's do this instead.

-- >8 --
t7001: fix "git mv" test 

The test assumed that we can keep the cached stat information fresh across
rename(2); many filesystems however update st_ctime (and POSIX allows them
to do so), so that assumption does not hold.  We can explicitly refresh
the index for the purpose of the test, as the only thing we are interested
in is the staged contents and the mode bits are preserved across "mv".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t7001-mv.sh |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
index b0fa407..910a28c 100755
--- a/t/t7001-mv.sh
+++ b/t/t7001-mv.sh
@@ -185,6 +185,7 @@ test_expect_success 'git mv should overwrite symlink to a file' '
 	! test -e moved &&
 	test -f symlink &&
 	test "$(cat symlink)" = 1 &&
+	git update-index --refresh &&
 	git diff-files --quiet
 
 '
@@ -202,6 +203,7 @@ test_expect_success 'git mv should overwrite file with a symlink' '
 	git mv -f symlink moved &&
 	! test -e symlink &&
 	test -h moved &&
+	git update-index --refresh &&
 	git diff-files --quiet
 
 '
