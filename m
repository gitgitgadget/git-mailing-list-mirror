From: Bill Lear <rael@zopyra.com>
Subject: Re: Git push failure with update hook success
Date: Wed, 7 Mar 2007 11:25:08 -0600
Message-ID: <17902.62836.920473.810183@lisa.zopyra.com>
References: <17902.59497.831409.218529@lisa.zopyra.com>
	<17902.60536.5890.608883@lisa.zopyra.com>
	<20070307170904.GB27922@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Mar 07 18:31:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOzz5-00068K-Jc
	for gcvg-git@gmane.org; Wed, 07 Mar 2007 18:31:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422894AbXCGR0B (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Mar 2007 12:26:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422877AbXCGRZ7
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Mar 2007 12:25:59 -0500
Received: from mail.zopyra.com ([65.68.225.25]:60840 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422910AbXCGRZQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Mar 2007 12:25:16 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l27HPCD15147;
	Wed, 7 Mar 2007 11:25:12 -0600
In-Reply-To: <20070307170904.GB27922@spearce.org>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41680>

On Wednesday, March 7, 2007 at 12:09:04 (-0500) Shawn O. Pearce writes:
>Bill Lear <rael@zopyra.com> wrote:
>> On Wednesday, March 7, 2007 at 10:29:29 (-0600) Bill Lear writes:
>> >...
>> >whether it might be better to call the update hook after everything
>> >had actually been written, including the log file.
>> 
>> I dug into the code: in receive-pack.c, the command 'update(struct
>> command *cmd)', calls write_ref_sha1() after run_update_hook()
>> and does not check the return code of write_ref_sha1().
>
>Please see the patch I just posted (and CC'd you on).  We should
>have caught the return error of write_ref_sha1, the patch now
>does that.  :)

Ok, thank you for fixing this.  I guess the call run_update_hook()
should not in fact come after the write_ref_sha1() block, and just
before the 'return 0' line, because you don't want to run the
write_ref_sha1() at all if the update hook complains.

>You probably want to use the post-update hook to send email.
>This hook will always run if it exists and is executable, but it
>won't be given a ref that failed to be updated.
>
>Of course an unfortunate downside to the post-update hook is it
>does not receive the old SHA-1 of the ref; it just gets the ref name.

Hmm, I agree that this sounds like the better place, logically
speaking, for the email report to be generated, but unfortunate since
I'm lame with git, so writing a post-update hook from scratch will
probably be beyond my abilities, but since I just watched "Touching
the Void" last night, I might be inspired to brave it.

Since it just gets the ref name, would one (of sufficient skill) be
able to reconstruct the same sort of report that the "pre" update hook
does?  That is, from the ref name can I get the old SHA-1?  If I try
to write this, what I think I would like to do is just call the
existing update hook from the post-update hook, with the post update
hook figuring out the proper arguments to pass along.

Also, I do notice in refs.c:create_symref() that it does not
check the return code of log_ref_write().  I don't know if that
is done explicitly or not ...


Bill
