From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: git svn error "Not a valid object name"
Date: Sat, 16 Mar 2013 15:13:15 +0100
Message-ID: <87y5dnv3es.fsf@pctrast.inf.ethz.ch>
References: <CAJKLP9ZQBXf5ZZY9FccOAL5QU+q1b5SnAfvP9BpARdqvzPuWeg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>, Dannes Wessels <dannes@exist-db.org>,
	"Wolfgang Meier" <wolfgang@exist-db.org>,
	=?utf-8?Q?Leif-J=C3=B6ran?= Olsson <ljo@exist-db.org>,
	Eric Wong <normalperson@yhbt.net>
To: Adam Retter <adam@exist-db.org>
X-From: git-owner@vger.kernel.org Sat Mar 16 15:14:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGrs4-0004RY-ED
	for gcvg-git-2@plane.gmane.org; Sat, 16 Mar 2013 15:14:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932128Ab3CPONh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Mar 2013 10:13:37 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:18411 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755846Ab3CPONg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Mar 2013 10:13:36 -0400
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Sat, 16 Mar
 2013 15:13:29 +0100
Received: from pctrast.inf.ethz.ch.ethz.ch (213.55.184.218) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.2.298.4; Sat, 16 Mar
 2013 15:13:32 +0100
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [213.55.184.218]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218306>

[+Cc Eric]

Adam Retter <adam@exist-db.org> writes:

> $ git svn init -t tags -b stable -T trunk
> file:///home/ec2-user/svn-rsync/code new-git-repo
> $ cd new-git-repo
> $ git config svn-remote.svn.preserve-empty-dirs true
> $ git config svn-remote.svn.rewriteRoot https://svn.code.sf.net/p/exist/code
> $ git svn fetch -A /home/ec2-user/.svn2git/authors.txt
>
> It all started well and was running away for quite some hours, when
> the following error occurred:
>
> fatal: Not a valid object name
> ls-tree -z  ./webapp/api/: command returned error: 128

The important observation is that the object name is missing; the error
is misleading in that it simply tells us that what is *taken* for the
object name is invalid.

There appear to be only two uses of ls-tree -z without further options
in git-svn, namely:

SVN/Fetcher.pm:165:     my ($tree) = (command('ls-tree', '-z', $self->{c}, "./$gpath")
SVN/Fetcher.pm:197:     ($mode, $blob) = (command('ls-tree', '-z', $self->{c}, "./$gpath

In either one, $self->{c} is empty if they fail in this way.  And that
seems to come from 'sub new', which says

	if (exists $git_svn->{last_commit}) {
		$self->{c} = $git_svn->{last_commit};
		$self->{empty_symlinks} =
		                  _mark_empty_symlinks($git_svn, $switch_path);
	}

So for some reason new() thinks it's okay to leave $self->{c}
uninitialized, but delete_entry() and open_file() expect it to be set.

It does seem that the ls-tree $self->{c} usage in both of those routines
is from approximately the beginning of time.  See these two, if you
compiled your git with log -L:

  git log -L:delete_entry:git-svn.perl a6180325^
  git log -L:open_file:git-svn.perl a6180325^

Unfortunately that's pretty much where my git-svn knowledge ends.  Maybe
Eric can help?

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
