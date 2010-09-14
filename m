From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/8] tree_entry_interesting(): remove dependency on
 struct diff_options
Date: Tue, 14 Sep 2010 16:20:25 -0700
Message-ID: <7veicv7w06.fsf@alter.siamese.dyndns.org>
References: <1283961023-4491-1-git-send-email-pclouds@gmail.com>
 <1283961023-4491-4-git-send-email-pclouds@gmail.com>
 <7vr5gw8geb.fsf@alter.siamese.dyndns.org>
 <AANLkTimHykY5V=C7vmDoA-HCWYLJT_p4MEyfdMqXgB6+@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>, Elijah Newren <newren@gmail.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 15 01:20:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ovens-0003oU-90
	for gcvg-git-2@lo.gmane.org; Wed, 15 Sep 2010 01:20:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755670Ab0INXUj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Sep 2010 19:20:39 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:62544 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755002Ab0INXUi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Sep 2010 19:20:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3AE0BD6D51;
	Tue, 14 Sep 2010 19:20:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sqHO5JAarbl42vaG5sYx7gaN5MM=; b=uc2LdV
	YclI4oIBIXoTm92L0PcPbbTzMGxO/Eo2WtBMUo70J8hDPNR6o5nYHC1JB2eo1Sxp
	8qbrjwFhlLV3Z1kv9PhKMMe8u4CLQiorzDN2jNmTGw8HVtqvZsn3w1JNsExDDnnl
	WQySbr0uQIoau9GnuiLKXNQsrF/mk0eLbIQss=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MNpRMt3cLOedmCqo4vTBvk/3gJMMc510
	SJsfbfx7YJFqCPKCDDDgmJVFAUgTP0zdlPZ+Ft/yr5VGMwPtl4naKxzTlWZsBAps
	7HPsB4LrYzZvXaDV+ojm8z4Udit5nPsWuux+QQpMi4OPWhKD+HcdaT8hEk9upLfy
	iupU4+wgPoA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 07ECAD6D50;
	Tue, 14 Sep 2010 19:20:31 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 27490D6D4C; Tue, 14 Sep
 2010 19:20:27 -0400 (EDT)
In-Reply-To: <AANLkTimHykY5V=C7vmDoA-HCWYLJT_p4MEyfdMqXgB6+@mail.gmail.com>
 (Nguyen Thai Ngoc Duy's message of "Wed\, 15 Sep 2010 08\:33\:41 +1000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: AAD2621E-C056-11DF-AE77-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156218>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

>> About naming.  Where else other than "tree" (in the "hierarchical
>> namespace" sense) context do you see pathspec?  Does the struct really
>> need to be called TREE_pathspec_list?
>
> Pathspecs are usually stored in a list, const char ** and I don't want
> to take the generic name "pathspec_list", unless we convert all to use
> this struct. Any suggestions of other names?

I was hoping [*1*] that in the longer term we would have a unified
machinery to handle pathspecs across ls-tree, ls-files, diff-tree,
diff-files and grep.  These commands more or less share the same idea of
what purpose a pathspec serves, but take quite different codepaths, and
the biggest problem is that some know globbing while others don't.

The problem arising from the two semantics [*2*] is visible when you run
"git add" with pathspec where add_files_to_cache() updates the index only
at changed paths (found using diff-files machinery, that implements "diff"
family of pathspec semantics to match only directory prefix) and then
add_files() adds the paths that are untracked (found using the ls-files
machinery, that knows about globbing).

Once we have a unified machinery to handle pathspec, the data structure
that holds the pathspec should naturally be called "struct pathspec",
while an element on that list would be "struct pathspec_elem" or perhaps
"struct pathspec_pattern" [*3*].

I would imagine that "struct exclude" (in dir.[ch]) that is contained in
"struct exclude_list" might be a good place to start from, in the sense
that it shows how a match pattern can be pre-parsed to optimize the
matching operation [*4*].  It however may not know about one particular
kind of optimization that is essential when dealing with tree objects: the
ability to ask "is this subtree worth descending into?".  That logic is
necessary to avoid opening unnecessary tree objects in diff-tree and grep.


[Footnote]

*1* https://git.wiki.kernel.org/index.php/SoC2010Ideas#Unify_Pathspec_Semantics

*2* As the maintainer, I do consider it also is a problem that each
of these semantics has multiple codepaths to implement it, but that is a
secondary issue.  Having two semantics is visible to the end user and is a
bigger problem.

*3* I personally tend to consider the whole set as _a_ "path specification"
even when you give more than one patterns to match on the command line,
but it may be just me.  I am Ok with "struct pathspec_set" that holds a
set of "struct pathspec", too.  Unlike exclude-list where the order of
elements in it has a meaning, the matching patterns in a pathspec are
unordered, so even if we may end up implementing it as a list, it would be
incorrect to call that "struct pathspec_list".

*4* "struct exclude_list" is somewhat special in that it is a dynamic data
source where you learn more matching rules as you dig deeper.  We do not
need that aspect of the dir.[ch] codepath for unified pathspec handling.
