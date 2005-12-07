From: Junio C Hamano <junkio@cox.net>
Subject: Re: type_size_sort
Date: Tue, 06 Dec 2005 18:28:22 -0800
Message-ID: <7vmzjdy721.fsf@assigned-by-dhcp.cox.net>
References: <118833cc0512061319l3726fdfbs8286e7b3f5ab0713@mail.gmail.com>
	<439604DF.5010603@op5.se>
	<118833cc0512061651y57ddcdc7pd26996b40c08d225@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 07 03:29:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ejp33-0007DO-Jt
	for gcvg-git@gmane.org; Wed, 07 Dec 2005 03:28:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965051AbVLGC2Z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Dec 2005 21:28:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964855AbVLGC2Z
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Dec 2005 21:28:25 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:63225 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S965051AbVLGC2Z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Dec 2005 21:28:25 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051207022640.BNXI20050.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 6 Dec 2005 21:26:40 -0500
To: Morten Welinder <mwelinder@gmail.com>
In-Reply-To: <118833cc0512061651y57ddcdc7pd26996b40c08d225@mail.gmail.com>
	(Morten Welinder's message of "Tue, 6 Dec 2005 19:51:44 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13316>

Morten Welinder <mwelinder@gmail.com> writes:

>> It's perfectly correct. If the same list was to be passed to
>> create_sorted_list() twice it will come out exactly the same the second
>> time as it did the first. The only thing to remark on is that the return
>> above could be written as below instead:
>>
>>         return a - b;
>
> That is not what the part  of the standard I quoted says.  It very
> clearly forbids the sorting function from depending on the pointers'
> values.  I can even see an implementation actually using this
> requirement.

What you say is correct, and people should be careful when using
qsort(), but it does not apply to this case.  The patch I posted
is not necessary.  Andreas' rewrite quoted above, however, is
invalid when ptrdiff_t (a-b) overflows int range.

The code as written by Linus back on June 25 is correct, but
that sort callchain is written in an unusual way to confuse us
(you were, and I was initially after seeing your message).

(1) The caller look like this.  It prepares an array of pointers
    in list[], calls qsort with sort_comparator() as the
    function to sort this list[].  Each element in this list[]
    is a pointer to struct object_entry.

	for (i = 0; i < nr_objects; i++)
		list[i] = objects + i;
	current_sort = sort;
	qsort(list, nr_objects, sizeof(struct object_entry *), sort_comparator);

(2) sort_comparator() is called by qsort() with the standard
    calling convention -- two pointers pointing into the array
    being sorted.  It calls current_sort() function set up by
    (1), giving it the pointers *FETCHED* *FROM* the locations
    these two incoming pointers are pointing at.

        static entry_sort_t current_sort;
        static int sort_comparator(const void *_a, const void *_b)
        {
                struct object_entry *a = *(struct object_entry **)_a;
                struct object_entry *b = *(struct object_entry **)_b;
                return current_sort(a,b);
        }

(3) Then type_size_sort() uses compariosn of these two pointers
    as the tiebreaker.

Notice?  The comparison of two pointers you originally pointed
out is not about the location in list[].  They are values stored
there.
