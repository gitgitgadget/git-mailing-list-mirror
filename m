From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [GSoC] Designing a faster index format - Progress report
Date: Tue, 29 May 2012 15:29:09 +0200
Message-ID: <87vcjfi09m.fsf@thomas.inf.ethz.ch>
References: <20120523122135.GA58204@tgummerer.unibz.it>
	<CACsJy8As2SQwEi2vHAQA+OeH+TjoCzzcknFbQ2tGXaWX7zsHVA@mail.gmail.com>
	<20120525201547.GB86874@tgummerer>
	<CACsJy8BRWmqz+2_A5_=1S9_sxOQa9GXnPQ7J1Y6id0_vh2-=+Q@mail.gmail.com>
	<20120527090407.GD86874@tgummerer>
	<7vbolaotwj.fsf@alter.siamese.dyndns.org>
	<CACsJy8D+WgEr4i2H-1oiBLY5oLurM0aNxGovbVEZDvr7OGgknw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, <git@vger.kernel.org>,
	<mhagger@alum.mit.edu>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 29 15:29:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZMUA-0007f8-NS
	for gcvg-git-2@plane.gmane.org; Tue, 29 May 2012 15:29:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751666Ab2E2N3O convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 May 2012 09:29:14 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:54416 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751319Ab2E2N3N convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 May 2012 09:29:13 -0400
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 29 May
 2012 15:29:10 +0200
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 29 May
 2012 15:29:10 +0200
In-Reply-To: <CACsJy8D+WgEr4i2H-1oiBLY5oLurM0aNxGovbVEZDvr7OGgknw@mail.gmail.com>
	(Nguyen Thai Ngoc Duy's message of "Sun, 27 May 2012 19:23:07 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198739>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> On Sun, May 27, 2012 at 4:27 PM, Junio C Hamano <gitster@pobox.com> w=
rote:
>> Thomas Gummerer <t.gummerer@gmail.com> writes:
>>
>>> Ah ok, thanks for the clarification, I understand what you meant no=
w.
>>> I think however, that it's not very beneficial to do this conversio=
n
>>> now. git ls-files needs the whole index file anyway, so it's probab=
ly
>>> not a very good test.
>>
>> Think about "git ls-files t/" and "git ls-files -u".
>
> Or harder things like "ls-files -- 't/*.sh'"
>
>> The former obviously does *not* have to look at the whole thing, eve=
n
>> though the current code assumes the in-core data structure that has =
the
>> whole thing in a flat array. =C2=A0IIRC, you had unmerged entries tu=
cked at the
>> end outside the main index data, so the latter is also an interestin=
g
>> demonstration of how wonderful the new data format could be.
>
> and "ls-files -uc" can show how you combine unmerged entries back.
> There's also entry existence check deep in "ls-files -o" that you can
> show how good bsearch on trees is, though that might be going too far
> for an experiment because the call chain is really deep, way outside
> ls-files.c:
>a
> show_files (builtin/ls-files.c)
>  fill_directory (dir.c)
>   read_directory
>    read_directory_recursive
>     treat_path
>      treat_one_path
>       treat_directory
>        directory_exists_in_index
>         cache_pos_name (read-cache.c)
>
> I just want to make sure that by exercising the new format with some
> real problems, we are certain we don't overlook anything in designing
> the format (or else could be fixed before finalizing it).

I envision an index API that more strictly controls access to the index=
=2E
Right now the API consists largely of read_index, write_index and the
flat the_index->cache array of entries.  Eventually it will have to be =
a
family of calls that support the v5 format, and boil down to suitable
wrappers for older ones.  For example (just tossing up ideas):

  index_open(struct index_state *index, int fd):
    initialization, checking, leaves the "real" data fields empty

  index_load_filtered(..., const char **pathspec):
    load everything needed to satisfy queries filtered by 'pathspec'

  index_for_each_entry(..., void (*callback)(struct cache_entry *ent)):
    like the current hand-rolled looping

  index_for_each_entry_filtered(..., void (*callback)(struct cache_entr=
y *ent), char **pathspec):
    ditto but for a pathspec lookup

etc.

Then I will twist Duy's words to mean that you should make git-ls-files
the poster child of this new API for development and profiling purposes
:-)

Actually converting the rest of the git code base to such an API is too
big an undertaking for the summer, so please don't stray on that path.

--=20
Thomas Rast
trast@{inf,student}.ethz.ch
