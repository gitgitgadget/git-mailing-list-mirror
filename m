From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 11/19] dir.c: use a single struct exclude_list per
 source of excludes
Date: Sun, 06 Jan 2013 12:25:48 -0800
Message-ID: <7v7gnqnjn7.fsf@alter.siamese.dyndns.org>
References: <1356575558-2674-1-git-send-email-git@adamspiers.org>
 <1356575558-2674-12-git-send-email-git@adamspiers.org>
 <7v1ue0veww.fsf@alter.siamese.dyndns.org>
 <20130106152039.GA2396@pacific.linksys.moosehall>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Adam Spiers <git@adamspiers.org>
X-From: git-owner@vger.kernel.org Sun Jan 06 21:26:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TrwnM-0003Qq-RC
	for gcvg-git-2@plane.gmane.org; Sun, 06 Jan 2013 21:26:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752360Ab3AFUZx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jan 2013 15:25:53 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37694 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752142Ab3AFUZw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jan 2013 15:25:52 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 98EA6AC9C;
	Sun,  6 Jan 2013 15:25:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3KqYIlhZgIlQcAeadq3aF3lKrJQ=; b=jwYR9V
	3NL++T6FoDIN+6DU179ykibEgrXeRWvI/75SQaVdti7zPOEFVBDAjVtdaaxi1oip
	CphvpFrSdDOB8c6Bu4cOETV46JuHATfuBUZ952cRoo/uPlKC/DHRD1B+ooNX933e
	cPlQPep021uC3+fzoYhjYM3DGj6hFbTLtcMoQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VpIuf0n4O+i5iuhV7EteX3/il8wOHa5q
	bdPZSBFupGDhF9PAdusRodiCVFx9F+S4lkgzzL8JkkL48u57+AP/3K18dcxRSFxU
	PeWUUHkVxWpIaDy+QU/Ish6smZG+u02lZV1EpzRMnzlxcV5nm5eqzGTe3AHWwOeQ
	psC+fQTxceM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8A0B1AC9B;
	Sun,  6 Jan 2013 15:25:51 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CBD76AC98; Sun,  6 Jan 2013
 15:25:50 -0500 (EST)
In-Reply-To: <20130106152039.GA2396@pacific.linksys.moosehall> (Adam Spiers's
 message of "Sun, 6 Jan 2013 15:20:39 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 43374C7C-583F-11E2-8B76-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212836>

Adam Spiers <git@adamspiers.org> writes:

> On Fri, Jan 04, 2013 at 01:03:59PM -0800, Junio C Hamano wrote:
>> Adam Spiers <git@adamspiers.org> writes:
>> 
>> > diff --git a/builtin/clean.c b/builtin/clean.c
>> > index 0c7b3d0..bd18b88 100644
>> > --- a/builtin/clean.c
>> > +++ b/builtin/clean.c
>> > @@ -97,9 +97,10 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
>> >  	if (!ignored)
>> >  		setup_standard_excludes(&dir);
>> >  
>> > +	add_exclude_list(&dir, EXC_CMDL);
>> >  	for (i = 0; i < exclude_list.nr; i++)
>> >  		add_exclude(exclude_list.items[i].string, "", 0,
>> > -			    &dir.exclude_list[EXC_CMDL]);
>> > +			    &dir.exclude_list_groups[EXC_CMDL].ary[0]);
>> 
>> This looks somewhat ugly for two reasons.
>> 
>>  * The abstraction add_exclude() offers to its callers is just to
>>    let them add one pattern to the list of patterns for the kind
>>    (here, EXC_CMDL); why should they care about .ary[0] part?
>
> Because the caller has to decide which exclude list the new exclude
> should be added to; that is how it has been for a long time, and I am
> not proposing we change that.

Unless I was mistaken, I never objected to the EXC_CMDL, etc
appearing in the text of the calling site of add_exclude().

The objection was about the .ary[0] bit.  From the point of view of
a caller of the API, it:

    - calls add_exclude_list() to declare "I now start adding new
      patterns that come from a new source of patterns"; then

    - calls add_exclude() repeatedly to add the patterns that come
      from that source.

no?  Why does the latter has to keep repeating "Here is the new
pattern for the EXC_CMDL group; it comes from the latest source I
earlier declared, by the way", instead of just "Here is the new
pattern for the EXC_CMDL group"?  The ary[0] part always using "0"
(not "4" or "ix") is what repeats that "by the way".

>>    Are
>>    there cases any sane caller (not the implementation of the
>>    exclude_list_group machinery e.g. add_excludes_from_... function)
>>    may want to call it with .ary[1]?
>
> Effectively yes, although it is not written like ".ary[1]".  For
> example prep_exclude() calls add_excludes_from_file_to_list() for each
> new .gitignore file

That is part of the "implementation of the machinery".  If the API
for the outside callers are to call add_exclude_list() to declare
that patterns added by subsequent calls to add_exclude() are from
one new source of the patterns (e.g. .gitignore file in a new
directory level), and then call add_exclude() to add each pattern,
then the callers to add_exclude() shouldn't have to care about the
implementation detail that individual sources in exclude_list_group
is implemented as an array in that sructure, and the latest ones
should go to its ->array[0].

The implementation of the machinery may find it more convenient if
they can add one or more "sources" to an exclude_list_group before
starting to add patterns to ->array[0] or ->array[1] or ->array[2],
and a finer grained internal API that lets the caller pass an
instance of "struct exclude_list" regardless of where in an
exclude_list_group's ary[] that instance sits may be necessary to do
so.

But that does not mean other existing callers has to be aware of
such inner detail.  If the implementation of the machinery needs a
helper function that adds an element to any struct exclude_list, not
necessarily the one at the tip of an exclude_list_group, we can
still do that by having the bulk of the logic in the internal, finer
grained helper, say, add_pattern_to_exclude_list(), and keep the
external API simpler by making it a thin wrapper around it, perhaps
like:

   static void add_pattern_to_exclude_list(const char *pattern,
   		    const char *base, int baselen,
                    struct exclude_list *el);

   void add_exclude(const char *pattern,
   		    const char *base, int baselen,
                    struct exclude_list_group *group) {
	add_pattern_to_exclude_list(pattern, base, baselen, &group->ary[0]);
   }    

no?
