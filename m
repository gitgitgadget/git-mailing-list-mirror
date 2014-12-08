From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 07/23] expire_reflog(): use a lock_file for rewriting
 the reflog file
Date: Mon, 08 Dec 2014 11:07:45 +0100
Message-ID: <54857871.5090805@alum.mit.edu>
References: <1417734515-11812-1-git-send-email-mhagger@alum.mit.edu> <1417734515-11812-8-git-send-email-mhagger@alum.mit.edu> <20141205002331.GJ16345@google.com> <20141205021931.GA29570@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>, git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 08 11:08:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XxvEe-00069F-31
	for gcvg-git-2@plane.gmane.org; Mon, 08 Dec 2014 11:08:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752976AbaLHKIA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Dec 2014 05:08:00 -0500
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:62069 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752144AbaLHKH7 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Dec 2014 05:07:59 -0500
X-AuditID: 1207440d-f79976d000005643-78-54857874ac98
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id CD.2F.22083.47875845; Mon,  8 Dec 2014 05:07:48 -0500 (EST)
Received: from [192.168.69.130] (p5DDB0B15.dip0.t-ipconnect.de [93.219.11.21])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id sB8A7kfU000497
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Mon, 8 Dec 2014 05:07:47 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.2.0
In-Reply-To: <20141205021931.GA29570@google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAKsWRmVeSWpSXmKPExsUixO6iqFtS0Rpi8OGAhUXXlW4mi4beK8wW
	b28uYbTo7fvEarF5czuLA6vHzll32T0WbCr1uHhJ2ePzJrkAlihum6TEkrLgzPQ8fbsE7ozF
	0z+zFxwVqJix5ShjA+N03i5GTg4JAROJ1b/+sUPYYhIX7q1n62Lk4hASuMwocfnWQ1YI5yyT
	xP95C5lAqngFtCWOfv/BDGKzCKhKPLv7FKybTUBXYlFPM1iNqECQxMk919kh6gUlTs58wgJi
	iwj4SCzqPQ9WwyxQINF85xXYHGGBaIk7P5qhlh1llGjbcwsswSlgIPHxxwJmiAY9iR3Xf7FC
	2PISzVtnM09gFJiFZMcsJGWzkJQtYGRexSiXmFOaq5ubmJlTnJqsW5ycmJeXWqRrpJebWaKX
	mlK6iRES2rw7GP+vkznEKMDBqMTDu+BBS4gQa2JZcWXuIUZJDiYlUd4zxa0hQnxJ+SmVGYnF
	GfFFpTmpxYcYJTiYlUR4E+OAcrwpiZVVqUX5MClpDhYlcV61Jep+QgLpiSWp2ampBalFMFkZ
	Dg4lCV7ucqBGwaLU9NSKtMycEoQ0EwcnyHAuKZHi1LyU1KLE0pKMeFC0xhcD4xUkxQO0dwZI
	O29xQWIuUBSi9RSjopQ4rxFIQgAkkVGaBzcWlrBeMYoDfSnMuxWkigeY7OC6XwENZgIa/CIR
	bHBJIkJKqoExcbuVqmSL+boKb6NPtv0R+9ZdXiu1Qb9ai+Fe1r9j564sWPn45a7Dx0yenjYQ
	F2GV+DGr+uhSRdObK7V8DWv++CzkWeM+uS599yTmitZ9BmZd0vZvzeLdhe5y3q5M 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261004>

On 12/05/2014 03:19 AM, Stefan Beller wrote:
> On Thu, Dec 04, 2014 at 04:23:31PM -0800, Jonathan Nieder wrote:
>> Michael Haggerty wrote:
>>
>>> We don't actually need the locking functionality, because we already
>>> hold the lock on the reference itself, which is how the reflog file is
>>> locked. But the lock_file code still does some of the bookkeeping for
>>> us and is more careful than the old code here was.
>>
>> As you say, the ref lock takes care of mutual exclusion, so we do not
>> have to be too careful about compatibility with other tools that might
>> not know to lock the reflog.  And this is not tying our hands for a
>> future when I might want to lock logs/refs/heads/topic/1 while
>> logs/refs/heads/topic still exists as part of the implementation of
>> "git mv topic/1 topic".
>>
>> Stefan and I had forgotten about that guarantee when looking at that
>> kind of operation --- thanks for the reminder.
> 
> I did not forget about it, I did not know about that in the first hand.
> We don't seem to have documentation on it?
> 
> So sorry for heading in a direction, which would have been avoidable.

This isn't documented very well. I thought I saw a comment somewhere in
the code that stated it explicitly, but I can't find it now. In any
case, my understanding of the locking protocol for reflogs is:

    The reflog for "$refname", which is stored at
    "$GIT_DIR/logs/$refname", is locked by holding
    "$GIT_DIR/refs/$refname.lock", *even if the corresponding
    reference is packed*.

This implies that readers, who don't pay attention to locks, have to be
prepared for the possibility that the reflog is in the middle of an
update and that the last line is incomplete. This is handled by
show_one_reflog_ent(), which discards incomplete lines.

This protocol avoids the need to rewrite the reflog from scratch for
each reference update.

Given how poorly-documented this point is, I wonder whether other
implementations of Git (e.g., libgit2, JGit, Dulwich, ...) got it right.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
