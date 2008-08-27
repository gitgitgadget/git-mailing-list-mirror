From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: [PATCH] be paranoid about closed stdin/stdout/stderr
Date: Wed, 27 Aug 2008 01:01:00 -0400
Message-ID: <32541b130808262201v4d7c1aa5r781720a80b79fcd0@mail.gmail.com>
References: <quack.20080825T0128.lthr68djy70@roar.cs.berkeley.edu>
	 <48B28CF8.2060306@viscovery.net> <48B29C52.8040901@gnu.org>
	 <E1KXawS-0001gg-Ty@fencepost.gnu.org> <48B2AFC2.20901@viscovery.net>
	 <7vbpzgb94q.fsf@gitster.siamese.dyndns.org>
	 <E1KXsL9-0004ef-Co@fencepost.gnu.org> <48B3A948.3080800@viscovery.net>
	 <20080826074044.GA22694@cuci.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Sixt" <j.sixt@viscovery.net>,
	"Paolo Bonzini" <bonzini@gnu.org>,
	"Karl Chen" <quarl@cs.berkeley.edu>,
	"Git mailing list" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>
To: "Stephen R. van den Berg" <srb@cuci.nl>
X-From: git-owner@vger.kernel.org Wed Aug 27 07:02:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYDAX-0007eg-Hn
	for gcvg-git-2@gmane.org; Wed, 27 Aug 2008 07:02:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751383AbYH0FBE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 01:01:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751277AbYH0FBD
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 01:01:03 -0400
Received: from yx-out-2324.google.com ([74.125.44.28]:36548 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751214AbYH0FBB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 01:01:01 -0400
Received: by yx-out-2324.google.com with SMTP id 8so1254381yxm.1
        for <git@vger.kernel.org>; Tue, 26 Aug 2008 22:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=sNYm+DQd+VoFeM5cwPxuTAKPzL2P4B7PTD+Wtk4ByZU=;
        b=QG6h0O4lWk5bui8Z5fJNbjCnTj2rFQGTl3CNr1k/DBiWEZcyFHB7rgbHNPpZ50PYy4
         H/DukPkLG/spR93fq1JHP/19HY0eNEavXszVtbrsdv4o71VhAxyAUQCYmB61BQ4iVVpu
         87/t2IlDtZ72wYeOjADsk607YCb4GzQtdcPTA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=CW9CLYK5iUvDKV5hZ3GQEYo++wpUqDOEZLXUikGSjI9GPemce8fYriSomRI62DTCxz
         7+HaESowTrfma45n4R+b18bBYpMin0ui89yrF7hHh4ARmg8THWK34nKjf/ZEQ8diKckc
         uCuqWRP5TXqu0++zz3CzxAHl+0+i5MhKtVvIw=
Received: by 10.151.84.12 with SMTP id m12mr10522720ybl.11.1219813260324;
        Tue, 26 Aug 2008 22:01:00 -0700 (PDT)
Received: by 10.150.98.19 with HTTP; Tue, 26 Aug 2008 22:01:00 -0700 (PDT)
In-Reply-To: <20080826074044.GA22694@cuci.nl>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93855>

On 8/26/08, Stephen R. van den Berg <srb@cuci.nl> wrote:
> Well, in general the policy I've used in all the tools I created is that:
>
>  a. If it's a setuid tool, then you need to make sure that you don't step
>    on anything unintendedly.  I.e. for setuid-something programs this is
>    desirable and necessary in order to prevent securityleaks.
>
>  b. Anything else is started in an environment controlled by the user,
>    and if this environment is broken, then that is the user's fault.

In general I'd mostly agree with you, but fd 0/1/2 are super-special
and I've personally been bitten by insane, rare problems that occur
when programs are started with one or more of those fds closed.

The usual case is that you're writing a new daemon.  The generally
accepted behaviour for a daemon is to chdir("/') and then close all
unnecessary open fds, in order to minimize the chance that it will be
holding open any directories or files that would prevent unmounting a
filesystem.  On the other hand, if the daemon then needs to run git
for some reason (who knows! maybe it's a git auto-commit daemon as was
discussed earlier on the list), it needs to open file descriptors
instead.  Such a program might work 99% of the time when git doesn't
happen to print any output.  But if there's ever an error, git would
print to fd#2 on die(), and that could corrupt some random file that
the daemon *or* git was using.  Remember, the situations where the
daemon leaves fd#2 open pointing at *the wrong thing* aren't the real
problem - you could easily say that's the daemon leaving the
environment in an insane state.  The problem situation is when git
opened some random file, and it *happened* to get assigned fd#2, and
then git incorrectly assumed that writing to fd#2 would not corrupt a
file that it opened.

Does this sound rare?  It is!  But it's also hellish to debug when it
happens, precisely because of its rarity.  For example, in one case, I
had this problem because an sfdisk process started by my custom
/sbin/init ran into a minor warning, and printed it to fd#2.
Unfortunately, because /sbin/init had opened sfdisk with fds 0/1/2
closed, fd#2 ended up being the very disk it was partitioning.  The
boot sector ended up getting overwritten with a warning message in
something like 1 out of 100 cases, and the computer wouldn't boot.
ARGH.  Easy to debug, once you think to read the boot sector as
plaintext.  But that's not the first thing you think to do.

Anyway, I personally think that given how incredibly cheap this
operation is to do, and how startlingly painful it is to debug when it
*is* a problem, that it would be nice if every program just did this
by default.  I would personally feel fine if such a thing ended up in
libc or the kernel, although presumably that would violate POSIX.

Yes, it would also be fine to have every *daemon* make sure it opens
/dev/null instead of just closing fd 0/1/2.  But it's harmless to have
both.

(As for the non-builtin git commands, isn't this an advantage of
having everything get run through the main /usr/bin/git wrapper?)

Have fun,

Avery
