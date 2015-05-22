From: Mike Hommey <mh@glandium.org>
Subject: Re: Occasional wrong behavior of rev-walking (rev-list, log, etc.)
Date: Fri, 22 May 2015 09:57:53 +0900
Message-ID: <20150522005753.GA2203@glandium.org>
References: <20150521061553.GA29269@glandium.org>
 <xmqq617llw6k.fsf@gitster.dls.corp.google.com>
 <20150521224956.GA23810@glandium.org>
 <CAPc5daVnrjdjoiq8-H7vs2WAre+Kt7J5re_kZ2YD9tF8dG8UUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 22 02:58:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvbHp-0002nw-I0
	for gcvg-git-2@plane.gmane.org; Fri, 22 May 2015 02:58:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755695AbbEVA6A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2015 20:58:00 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:35447 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754253AbbEVA6A (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2015 20:58:00 -0400
Received: from glandium by zenigata with local (Exim 4.85)
	(envelope-from <glandium@glandium.org>)
	id 1YvbHd-0001Ck-7p; Fri, 22 May 2015 09:57:53 +0900
Content-Disposition: inline
In-Reply-To: <CAPc5daVnrjdjoiq8-H7vs2WAre+Kt7J5re_kZ2YD9tF8dG8UUw@mail.gmail.com>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269681>

On Thu, May 21, 2015 at 03:59:48PM -0700, Junio C Hamano wrote:
> Depends on why you are running rev-list.
> 
> If you want to know if one commit is contained in another, the way
> that should work the most reliably is to use merge-base, as the
> traversal engine of that command was written not to trust the commit
> timestamps but go with the topology alone.

So, specifically, rev-list was just a side use-case that happened to
show the same problem (or at least appeared to) when I was looking at
what the hell was happening. I should probably have started with my
actual failure instead, sorry for that. So here it is in the form of
a testcase:

$ git clone https://github.com/mozilla/gecko-dev
$ cd gecko-dev
$ git checkout -b a 4d3f25020072867e19ad6d840a73c8d77ea040bd
$ git commit --allow-empty -m a
$ git checkout -b b e90de3e5e045428e8f2b732882736dc93ce05f14
$ git commit --allow-empty -m b
$ git merge a -m merge
$ git rebase -i e90de3e5e045428e8f2b732882736dc93ce05f14 b

This lists plenty of commits instead of just a and b, like what would
happen if there weren't timestamps skews.

I've frequently used this kind of rebase in the past. It works most of
the time because the situation with timestamps is generally not a
problem. The reason I'm doing this kind of merge+rebase business is
that I have multiple topic branches that I need to rebase on top of each
other before pushing them upstream, and it's actually simpler, command-
wise, than actually rebasing the topics on top of each other.

Mike
