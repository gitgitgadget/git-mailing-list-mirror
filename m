From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Git.pm: Fix internal git_command_bidi_pipe() users
Date: Mon, 04 Aug 2008 01:37:06 -0700
Message-ID: <7vhca12n2l.fsf@gitster.siamese.dyndns.org>
References: <be6fef0d0808032149p651309a8o773dca5f16923ee1@mail.gmail.com>
 <20080804075313.21325.28396.stgit@localhost>
 <7vtze12oij.fsf@gitster.siamese.dyndns.org>
 <20080804082117.GI10151@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: ams@toroid.org, git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Mon Aug 04 10:38:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPva8-0007qM-1R
	for gcvg-git-2@gmane.org; Mon, 04 Aug 2008 10:38:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753599AbYHDIhS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2008 04:37:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753582AbYHDIhR
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Aug 2008 04:37:17 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:46177 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752269AbYHDIhP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2008 04:37:15 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id A56A2499B3;
	Mon,  4 Aug 2008 04:37:13 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 7A625499B2; Mon,  4 Aug 2008 04:37:09 -0400 (EDT)
In-Reply-To: <20080804082117.GI10151@machine.or.cz> (Petr Baudis's message of
 "Mon, 4 Aug 2008 10:21:17 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 896DD0B0-6200-11DD-A1F6-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91328>

Petr Baudis <pasky@suse.cz> writes:

> On Mon, Aug 04, 2008 at 01:05:56AM -0700, Junio C Hamano wrote:
>> Petr Baudis <pasky@suse.cz> writes:
>> 
>> > The hash_and_insert_object() and cat_blob() helpers were using
>> > an incorrect slice-from-ref Perl syntax. This patch fixes that up
>> > in the _close_*() helpers and make the _open_*() helpers use the
>> > same syntax for consistnecy.
>> >
>> > Signed-off-by: Petr Baudis <pasky@suse.cz>
>> > ---
>> >
>> >   Wow, the command_bidi_pipe API really is dirty. Of course, it is
>> > my fault as anyone's since I didn't get around to review the patches
>> > introducing it.
>> 
>> Sorry, delete is still broken with your patch, isn't it?
>
> Oh, right - I forgot that one and it didn't occur to me to test this
> part.
>
>> The earlier patch from Abhijit Menon-Sen does this properly for
>> close_hash_and_insert and close_cat_blob, which I've queued already.
>
> Abhijit, can you please tag your Git.pm patches so that I actually have
> a chance to see and review it?

It is $gmane/91316, Message-ID: <20080804050247.GA13539@toroid.org>

After queueing it, I actually had to revert it, because it seems to break
git-svn (t9106-git-svn-commit-diff-clobber.sh, test #8), and I am about to
go to bed.  If you did not see the same breakage with your patch that does
not "fix" delete, it could be that the git-svn uses some of the resources
that are released by the delete actually doing what it is asked to do.

---

At 2008-08-04 12:49:27 +0800, rctay89@gmail.com wrote:
>
> $self->{@vars} evaluates to undef. i can't find any mention of using
> arrays to dereference objects in the manual and elsewhere; is this a
> mistake?

Yes, @vars would be interpreted in scalar context, which certainly isn't
the intended effect.

-- ams

 perl/Git.pm |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/perl/Git.pm b/perl/Git.pm
index 087d3d0..2ef437f 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -839,8 +839,8 @@ sub _close_hash_and_insert_object {
 
 	my @vars = map { 'hash_object_' . $_ } qw(pid in out ctx);
 
-	command_close_bidi_pipe($self->{@vars});
-	delete $self->{@vars};
+	command_close_bidi_pipe(@$self{@vars});
+	delete @$self{@vars};
 }
 
 =item cat_blob ( SHA1, FILEHANDLE )
@@ -928,8 +928,8 @@ sub _close_cat_blob {
 
 	my @vars = map { 'cat_blob_' . $_ } qw(pid in out ctx);
 
-	command_close_bidi_pipe($self->{@vars});
-	delete $self->{@vars};
+	command_close_bidi_pipe(@$self{@vars});
+	delete @$self{@vars};
 }
 
 =back
-- 
1.6.0.rc0.43.g2aa74
