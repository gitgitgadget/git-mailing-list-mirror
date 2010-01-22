From: David Rydh <dary@math.berkeley.edu>
Subject: Re: [PATCH] git-mv: Fix error with multiple sources.
Date: Fri, 22 Jan 2010 09:30:09 -0800
Message-ID: <CB7104C1-EB96-426F-8280-E33105378B18@math.berkeley.edu>
References: <718290.769818367-sendEmail@darysmbp> <7vd412ac8c.fsf@alter.siamese.dyndns.org> <7vr5pi8x6z.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 22 18:30:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYNKx-0003El-6c
	for gcvg-git-2@lo.gmane.org; Fri, 22 Jan 2010 18:30:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755693Ab0AVRaR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jan 2010 12:30:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753733Ab0AVRaQ
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jan 2010 12:30:16 -0500
Received: from cm03fe.IST.Berkeley.EDU ([169.229.218.144]:35748 "EHLO
	cm03fe.IST.Berkeley.EDU" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751554Ab0AVRaP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Jan 2010 12:30:15 -0500
Received: from [10.136.1.127]
	by cm03fe.ist.berkeley.edu with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.69)
	(auth plain:dary@math.berkeley.edu)
	(envelope-from <dary@math.berkeley.edu>)
	id 1NYNKl-0000u3-Cq; Fri, 22 Jan 2010 09:30:13 -0800
In-Reply-To: <7vr5pi8x6z.fsf@alter.siamese.dyndns.org>
X-Mailer: Apple Mail (2.1077)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137768>

On Jan 21, 2010, at 10:34 PM, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
>> Given that basename(3) is allowed to modify its parameter, I think the
>> above code is still not portable.  casting constness away and feeding
>> result[i], especially when we didn't obtain our own copy by calling
>> xmemdupz(), is especially problematic.
>> 
>> Perhaps something ugly like this?
>> 
>> 	for (i = 0; i < count; i++) {
>> 		int length = strlen(result[i]);
>> 		int to_copy = length;
>>                while (to_copy > 0 && is_dir_sep(result[i][to_copy - 1]))
>> 			to_copy--;
>> 		if (to_copy != length || basename) {
>>                	char *it = xmemdupz(result[i], to_copy);
>>                        result[i] = base_name ? strdup(basename(it)) : it;
>> 		}
>> 	}

This looks fine. Currently we have the odd behavior

> git mv -n dir/ new-dir
Checking rename of 'dir' to 'new-dir'
Checking rename of 'dir/a.txt' to 'new-dir/a.txt'
Checking rename of 'dir/b.txt' to 'new-dir/b.txt'

> git mv -n dir// new-dir
Checking rename of 'dir/' to 'new-dir'
fatal: source directory is empty, source=dir/, destination=new-dir

Note that at the end of copy_pathspec we call get_pathspec which squashes multiple slashes (even if prefix=NULL) but does not remove a trailing slash so it is necessary to squash them all as above.
