From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix update-index --refresh for submodules if stat(2)
 returns st_size 0
Date: Tue, 22 Jul 2008 01:07:49 -0700
Message-ID: <7vbq0qnxyi.fsf@gitster.siamese.dyndns.org>
References: <20080721173511.GB5387@steel.home>
 <alpine.DEB.1.00.0807211917440.8986@racer>
 <20080721194322.GA4013@blimp.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 22 10:09:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLCvh-0002wI-V4
	for gcvg-git-2@gmane.org; Tue, 22 Jul 2008 10:09:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751108AbYGVIIE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 04:08:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750899AbYGVIIE
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 04:08:04 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:48065 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750756AbYGVIIB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 04:08:01 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id A61073696C;
	Tue, 22 Jul 2008 04:07:58 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 6C0D73696B; Tue, 22 Jul 2008 04:07:54 -0400 (EDT)
In-Reply-To: <20080721194322.GA4013@blimp.local> (Alex Riesen's message of
 "Mon, 21 Jul 2008 21:43:22 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 4C0733A0-57C5-11DD-99A5-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89469>

Alex Riesen <raa.lkml@gmail.com> writes:

> Johannes Schindelin, Mon, Jul 21, 2008 20:20:43 +0200:
>> Hi,
>> 
>> On Mon, 21 Jul 2008, Alex Riesen wrote:
>> 
>> > For example - Cygwin.
>> 
>> Please enhance: your oneline is too long, and your commit message body too 
>> short.
>
> Well, I'm really not sure. I just found this difference between linux
> and cygwin (st_stat is 0 for dirs on cygwin). Than I noticed that the
> routine where I made the change explicitely checks for st_size not
> being 0. I must admit I can't make much out of comment, and hope this
> discussion will help to clear the check up.

The cached stat information in the index is used to speed up comparison
between "the last staged data" and what is in the working tree.
ie_match_stat() compares ce_xxx fields with the result from lstat(2) we
just did, and if there are differences, we take it as a sign that what's
in the working tree is different from what we saw when we updated the
index entry.

But there is a twist.

Ordinarily, when an entry enteres the index, the hash of the blob contents
goes along with the lstat(2) information taken from the file that supplied
the contents.  However there are some cases we populate the index without
lstat(2).  update-index --cacheinfo, update-index --index-info are two
examples, and when they add index entries, they leave ce_size field to
zero.  ie_match_stat() will compare that zero ce_size with the size
information obtained from the working tree, and declare (falsely) that
"what's in the working tree is different -- it can never match, and there
is no point trying to re-index to see if they actually match", even though
the reason ce_size is zero is *not* because we observed the size of the
working tree file *was* zero when we indexed it the last time (it is zero
merely because we haven't looked at it yet).  The ce_modified_check_fs()
call is there to deal with this "we cannot trust the ce_xxx fields" case.

I however have to wonder if you also need to touch the end of
ce_match_stat_basic() that checks for zero sized cache entry.
