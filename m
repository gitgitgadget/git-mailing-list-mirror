From: Junio C Hamano <junkio@cox.net>
Subject: Re: git rev-list
Date: Thu, 26 Jan 2006 23:35:28 -0800
Message-ID: <7vvew62ke7.fsf@assigned-by-dhcp.cox.net>
References: <cc723f590601261946h101d7000oa1990c31c5b642fc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 27 08:35:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F2O8s-0004sf-IS
	for gcvg-git@gmane.org; Fri, 27 Jan 2006 08:35:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964788AbWA0Hfb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Jan 2006 02:35:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964820AbWA0Hfb
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jan 2006 02:35:31 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:976 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S964788AbWA0Hfa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jan 2006 02:35:30 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060127073320.FEPU17838.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 27 Jan 2006 02:33:20 -0500
To: Aneesh Kumar <aneesh.kumar@gmail.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15178>

Aneesh Kumar <aneesh.kumar@gmail.com> writes:

> ... I use
> git-rev-list to get the revision list. What i found is  that from the
> second commit on wards i am finding some control character at the
> beginning of the first line with respect to each commit.

If you are using "git-rev-list --header" format, it uses an
ASCII NUL (0) to delimit each record.  Technically, it is not
"beginning of the first line starting from the second commit",
but "at the end of each commit".

With Perl, you would read such NUL separated record by:

	local $/ = "\0";
	my $item = <>;

Admittedly my Python is quite rusty, and I do not offhand recall
there was no such "line separator is NUL instead of normal LF"
configuration on readable file objects.  You may need to do
something ugly like this:

-- >8 --
import os

def rev_list(rev_range):
    revlist = os.popen('git rev-list --header %s' % rev_range)
    stash = []
    while 1:
        line = revlist.readline()
        if line == '':
            break
        if line[0] == '\0':
            yield ''.join(stash)
            stash = []
            line = line[1:]
            if line == '':
                break
        stash.append(line)
    if len(stash):
        yield ''.join(stash)

for commit in rev_list('master..pu'):
    # Use commit which is from a single record..
    print "*<*", commit, "*>*"
