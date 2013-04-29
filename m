From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git merge/rebase ref -P ref
Date: Sun, 28 Apr 2013 20:46:38 -0700
Message-ID: <7vvc76ngm9.fsf@alter.siamese.dyndns.org>
References: <CAKkAvawit0L4JKKNs7Di46B=Y0VjPohKNbjnS=r07VhafXu4kQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: ryenus <ryenus@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 29 05:46:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWf3I-0004b0-A8
	for gcvg-git-2@plane.gmane.org; Mon, 29 Apr 2013 05:46:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756808Ab3D2Dqm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Apr 2013 23:46:42 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63298 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756773Ab3D2Dql (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Apr 2013 23:46:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1424812642;
	Mon, 29 Apr 2013 03:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rh1JbxCjMWzLsWwWIxzkzoojTSc=; b=PqbOt6
	6OmwxpyLoraEhgvTLx0NIiskcIXPxnlQAtroB5JEAn5FmYXtKIk7Gf7O2N+sFRlQ
	S1z9le2W9HH+TIAhIkWTiBPsCRrvAaZpG/7sQaYDrXIwIQGs3zwKgHxAgAN3SbI1
	WYD9PtoNx0SM+Md4r6vSEHQNHjKG8M3Kck8eQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GBCZ8HbkDF8CkRe307NEK1yXj8o5Pz3I
	/kb7ep6fip21+oUqFFOLuyPNKT7jUux7udnKWwcVkhl6EY5lgnvJIdf+rp1Po7+W
	kRKZl09jsWiNV7DPH19smim88vVYfBqTLJgh+lP/VreQ/Pm+M4B4XlKuhvY9Rupq
	k7+ncJMky/I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0666712641;
	Mon, 29 Apr 2013 03:46:41 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 586F51263F;
	Mon, 29 Apr 2013 03:46:40 +0000 (UTC)
In-Reply-To: <CAKkAvawit0L4JKKNs7Di46B=Y0VjPohKNbjnS=r07VhafXu4kQ@mail.gmail.com>
	(ryenus@gmail.com's message of "Sun, 28 Apr 2013 23:35:50 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 66A0E888-B07F-11E2-974F-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222763>

ryenus <ryenus@gmail.com> writes:

> The inverted meaning of {ours,theirs} for rebase could be very
> confusing to some, especially to new uses, for me every time I
> merge/rebase I need to think about it to make sure I've made it right.

The key point to remember is "git rebase origin master" is *not*
about integrating other people's changes to your work.  It is a way
to replay your work on top of others' work.

When I try to rebase a topic, e.g.

    git checkout jc/format-patch
    git rebase 8ee3860
    
The conflicts in pretty.c looks like this:

    <<<<<<< HEAD
    static const char *show_ident_date(const struct ident_split *ident,
                                       enum date_mode mode)
    {
    ...
            return show_date(date, tz, mode);
    =======
    static int is_current_user(const struct pretty_print_context *pp,
                               const char *email, size_t emaillen,
                               const char *name, size_t namelen)
    {
    ...
                    !memcmp(myname, name, namelen));
    >>>>>>> format-patch: --inline-single
    }

We are replaying the commits on "jc/format-patch" topic on a history
that leads to 8ee3860, and the line ">>>>>" shows what commit we are
replaying

    $ git log --oneline 8ee3860..jc/format-patch
    be1a07f format-patch: --inline-single
    47d6c5f format-patch: rename "no_inline" field

On the other hand, when I try to do the same integration with a
merge, e.g.

    git checkout 8ee3860
    git merge jc/format-patch

We would see the same conflicts like this:

    <<<<<<< HEAD
    static const char *show_ident_date(const struct ident_split *ident,
                                       enum date_mode mode)
    {
    ...
            return show_date(date, tz, mode);
    =======
    static int is_current_user(const struct pretty_print_context *pp,
                               const char *email, size_t emaillen,
                               const char *name, size_t namelen)
    {
    ...
                    !memcmp(myname, name, namelen));
    >>>>>>> jc/format-patch
    }

Again, the name of the branch that is merged appears on ">>>>>"
line.
