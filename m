From: Junio C Hamano <junkio@cox.net>
Subject: Re: git + ssh + key authentication feature-request
Date: Wed, 08 Feb 2006 14:56:15 -0800
Message-ID: <7v4q39o3xs.fsf@assigned-by-dhcp.cox.net>
References: <43EA73C3.2040309@iaglans.de>
	<7vhd79o6m5.fsf@assigned-by-dhcp.cox.net>
	<43EA7D57.7040409@iaglans.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 08 23:56:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F6yEW-0005E8-Nf
	for gcvg-git@gmane.org; Wed, 08 Feb 2006 23:56:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030265AbWBHW4S (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Feb 2006 17:56:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030274AbWBHW4S
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Feb 2006 17:56:18 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:3580 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1030265AbWBHW4R (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Feb 2006 17:56:17 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060208225357.DQNE17006.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 8 Feb 2006 17:53:57 -0500
To: Nicolas Vilz 'niv' <niv@iaglans.de>
In-Reply-To: <43EA7D57.7040409@iaglans.de> (Nicolas Vilz's message of "Thu, 09
	Feb 2006 00:23:03 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15759>

Nicolas Vilz 'niv' <niv@iaglans.de> writes:

> in my case it would be only one system-user which has full access to
> several repositories. At this time, the users which use that account,
> have to give a password, which isn't that bad... it would be easier
> and more secure for me, not to give a password, but ask the users for
> the ssh pubkey..

I do not know where you are getting the password idea.

The conclusion of that thread is that it is not worth trying to
co-mingle more than one physical developer into one home
directory, and does not have much to do with use of password or
public key authentication.

That thread describes:

 - you can use ssh public key authentication for developers;

 - you do not have to give them full shell access by using
   git-shell;
   
 - HOWEVER you cannot tell each developers apart if you add one
   key per developer to the same $HOME/.ssh/authorized_keys file.

The last point is not about git at all, but comes from how ssh
daemon operates.  It roughly goes like this:

 - The client says "I am me at the remote host, use this public
   key to prove that to the other end".  Often you do not have
   to give -l and -i but when you fully spell out the command
   line, it would be something like:

	$ ssh -l me -i identity-file remote.host.example.com

   Your client sends "me" and the public key to the remote end.

 - The ssh daemon running on the remote site says, "Hmph, let's
   see if you are really "me" as you claim."  It does the
   following things:

    1. Look "me" up from its user database (be it /etc/passwd,
       NIS or LDAP) to find out the user's home directory.
       Let's say the "struct passwd.pw_dir" says it is
       "/home/me".

    2. Check to see if /home/me/.ssh/authorized_keys exists, all
       the elements in the path to the file is secure (e.g. if
       /home/me/.ssh can be modified by somebody other than
       "me", what is in authorized_keys is not trustworthy).
       That means /home/me/.ssh/authorized_keys must be owned by
       "me" and at least mode 0644 or stricter.

    3. Reads the keys in that file, and finds what is sent as
       the public key from the client.

    4. Uses that public key to challenge the client to make sure
       the client has the corresponding private key.

What this implies is that sharing the home directory among
multiple UNIX users would not work with ssh daemon the way you
expect.  The check in step 2 would fail for all but one user.

Being able to list more than one key in authorized_keys is so
that you can use more than one key to become the _same_ user,
and does not give you the ability to become a user other than
the one that owns that home directory on that remote host.

So while you could make a repository "/pub/project.git" the home
directory of _one_ UNIX user, and store her key in the file
"/pub/project.git/.ssh/authorized_keys", that would not work
very well for a shared repository setup if you want to be able
to tell more than one physical users apart.

You _could_ tell them to use the same -l option and log-in as
the same UNIX user with their own keys, though.  But that way
you cannot tell which developer pushed into the repository (of
course if you trust the commits, commit log message would say
the committer ident).
