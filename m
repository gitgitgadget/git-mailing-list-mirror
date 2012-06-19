From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH 0/9] Extending the shelf life of "git describe" output
Date: Tue, 19 Jun 2012 09:14:51 +0200
Message-ID: <877gv34vtg.fsf@thomas.inf.ethz.ch>
References: <1340057139-8311-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 19 09:15:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sgsed-0007zR-0q
	for gcvg-git-2@plane.gmane.org; Tue, 19 Jun 2012 09:15:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752829Ab2FSHOx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jun 2012 03:14:53 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:32487 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752005Ab2FSHOx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2012 03:14:53 -0400
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 19 Jun
 2012 09:14:51 +0200
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS20.d.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 19 Jun
 2012 09:14:51 +0200
In-Reply-To: <1340057139-8311-1-git-send-email-gitster@pobox.com> (Junio
	C. Hamano's message of "Mon, 18 Jun 2012 15:05:29 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200183>

Junio C Hamano <gitster@pobox.com> writes:

> This series teaches the sha1_name machinery to only look for
> unambigous commit object names when the caller knows that the name
> must refer to a commit object.
[...]
>  - You will further be able to extend the lifetime of uniqueness of
>    "git describe" output if you take advantage of the "tagname" or
>    "number". The current parser does not do this.
>
>    There are a number of ways to do this, but probably the cleanest
>    would be to (you only can do this when you have "tagname" tag
>    locally; you may not have it) pass the tag and the number down to
>    the find_short_*() routines with commit_only set, and when they
>    find a commit that match the prefix, inside is_commit_object()
>    test, check also that the commit reaches the given tag object in
>    the given number steps (otherwise discard it as it is not the one
>    you are looking for).
>
>  - Some callers that are involved in the get_sha1_1() callpath know
>    that the name they have must be referring to commit objects (e.g.
>    get_parent() and get_nth_ancestor()).  It might be worthwhile to
>    let get_sha1_1() know that the caller knows the name it is
>    feeding must refer to a commit object, and have the uniqueness
>    logic take advantage of it.
>
>    I think that most of these callers are expecting to parse a
>    committish and the user may have given them the name of a a tag
>    object that peels to a commit, so you would need to add a new
>    GET_SHORT_COMMITTISH that allows any committish, in addition to
>    the GET_SHORT_COMMIT_ONLY this series adds, if you want to do
>    this.

Two random thoughts:

* The commit_only flag is only one thing you may "know" about the
  parsing, as you state above.  E.g., we may know the distance from a
  certain tag.  Given this, wouldn't it be cleaner to patch a struct
  things_we_know into the call chain instead of only a flag?

* The treeish:path syntax also "knows" that the left side must be or
  peel to a tree, so it makes no sense to go looking for a blob.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
