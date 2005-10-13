From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add git-findtags
Date: Wed, 12 Oct 2005 22:18:00 -0700
Message-ID: <7vbr1u6lmf.fsf@assigned-by-dhcp.cox.net>
References: <1129087169926-git-send-email-martin@catalyst.net.nz>
	<7vek6rmhw5.fsf@assigned-by-dhcp.cox.net>
	<46a038f90510122117mb466722n531dc66bac141ea1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 13 07:19:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EPvU2-0007vK-UP
	for gcvg-git@gmane.org; Thu, 13 Oct 2005 07:18:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932131AbVJMFSE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 13 Oct 2005 01:18:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932135AbVJMFSE
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Oct 2005 01:18:04 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:33208 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S932131AbVJMFSC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Oct 2005 01:18:02 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051013051740.NILB11356.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 13 Oct 2005 01:17:40 -0400
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90510122117mb466722n531dc66bac141ea1@mail.gmail.com>
	(Martin Langhoff's message of "Thu, 13 Oct 2005 17:17:23 +1300")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10061>

Martin Langhoff <martin.langhoff@gmail.com> writes:

> On 10/12/05, Junio C Hamano <junkio@cox.net> wrote:
>> Martin Langhoff <martin@catalyst.net.nz> writes:
>
> I'm preparing a better patch based on your comments, but File::Find is
> _not_ my friend, really. I really feel stupid after failing for 1hr to
> use it.

Something like this?

    use strict;
    use File::Find qw(find);

    my $git_dir = $ENV{GIT_DIR} || '.git';

    my @tagfiles = ();
    find({
        follow => 1,
        wanted => sub {
            if (-f _) {
                push @tagfiles, $File::Find::name;
            }
        } }, "$git_dir/refs/tags");

    for (@tagfiles) {
        print "$_\n";
    }

>> BTW, wouldn't it be easier for this particular script, and more
>> useful in general, if something like what 'git-rev-parse' does
>> for commit objects when given "REV^0" is supported for tags?
>
> I don't quite follow...

What I meant is this.

There is an existing notation "^0" which is a postfix
"dereference until you get a commit" operator.

	git-rev-parse --verify refs/tags/v0.99^0
	git-cat-file -t refs/tags/v0.99^0

does:

	1. reads SHA1 from "refs/tags/v0.99", finds the object;

        2. if it is a tag object, find the object pointed by it;
           if the result is still a tag object, then dereference
           it repeatedly;

        3. if the resulting object is a commit, let the caller
           to use it; otherwise barf.

What _might_ be useful for your application is a similar
operator, say, "refs/tags/junio-gpg-pub%", that does:

	1. reads SHA1 from "refs/tags/junio-gpg-pub", finds the
           object;

        2. if it is a tag object, find the object pointed by it;
           if the result is still a tag object, then dereference
           it repeatedly;

	3. do not worry about the type of the result.  Just
           output it.

Instead of reserving yet another letter '%', it might be better
to use something like "refs/tags/junio-gpg-pub^{tag}" as a
notation for this.  If you had something like this, you would
not have to read tag objects yourself and dereference them by
hand.
