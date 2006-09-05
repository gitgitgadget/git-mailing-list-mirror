From: Junio C Hamano <junkio@cox.net>
Subject: Re: remote_get_heads: reference length limit
Date: Tue, 05 Sep 2006 09:01:39 -0700
Message-ID: <7v64g2i9p8.fsf@assigned-by-dhcp.cox.net>
References: <44FD729D.4020208@shadowen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 05 18:02:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GKdMe-0006Jv-OX
	for gcvg-git@gmane.org; Tue, 05 Sep 2006 18:01:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965050AbWIEQBM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Sep 2006 12:01:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965127AbWIEQBM
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Sep 2006 12:01:12 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:398 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S965050AbWIEQBK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Sep 2006 12:01:10 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060905160108.CPUT4015.fed1rmmtao09.cox.net@fed1rmimpo02.cox.net>;
          Tue, 5 Sep 2006 12:01:08 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Jg181V00u1kojtg0000000
	Tue, 05 Sep 2006 12:01:09 -0400
To: Andy Whitcroft <apw@shadowen.org>
In-Reply-To: <44FD729D.4020208@shadowen.org> (Andy Whitcroft's message of
	"Tue, 05 Sep 2006 13:50:37 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26477>

Andy Whitcroft <apw@shadowen.org> writes:

> I've been having trouble with git push apparently resending the entire
> commit trace for the branch each and every time I push.  Poking at the
> source it seems this is due to a length limit on reference names as
> pulled from the remote repository.
>
> When we are building the pack to send we are sent a list of remote
> heads.  get_remote_heads() reads these in, validates them and finally
> adds them to the remote_refs list.  Part of the validation is a simple
> check for size and form; check_ref().
>
> static int check_ref(const char *name, int len, unsigned int flags)
> {
>         if (!flags)
>                 return 1;
>
>         if (len > 45 || memcmp(name, "refs/", 5))
>                 return 0;
> [...]
> }
>
> With the refs/heads/ prefix included this limits the head names to 34
> characters.  From what I can see there is no good reason for this limit
> to be so low.  I can see we don't want the remote end bloating us out of
> control, but we are already limiting the lines which contain these
> references to 1000 bytes and making no attempt to limit the number of
> them the remote server can send us.  There seems to be no limits imposed
> on the name length other than MAX_PATHLEN.
>
> Can anyone see a reason to keep this (len > 45) check?

Yes, it was a mis-conversion done with commit 2718ff0.
The data this part (and the caller) is dealing with are
peek-remote output (40-byte hex object name, tab and
"refs/...").  Before that commit we had a check like this:

+		if (ignore_funny && 45 < len && !memcmp(name, "refs/", 5) &&
+		    check_ref_format(name + 5))
+			continue;

That is, "if we are ignoring funny fake refs, continue when the
name begins with refs/ and is magic (e.g. refs/heads/master^{});
by the way that can only happen if the entire line length is
more than 45 bytes (because of 40-byte hex plus tab, anything
shorter than that cannot even fit "refs/" at the beginning of
the name).

But when the check_ref() function was written it was made to
take the name length as "len", so I do not think there is a
reason to check the name against 45 at all.  Also the direction
of the comparison is wrong in the new code.  It was meant to be
"line must be at least this long otherwise it is not right".

I think you can just drop "len > 45 || " part.
