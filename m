From: Michael J Gruber <michaeljgruber+gmane@fastmail.fm>
Subject: Re: [PATCH] allow user aliases for the --author parameter
Date: Fri, 22 Aug 2008 10:27:24 +0200
Message-ID: <48AE786C.20201@fastmail.fm>
References: <g8jbvd$18k$1@ger.gmane.org> <20080821200255.GB27705@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Alex Riesen <fork0@users.sourceforge.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 22 10:28:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWS0j-0006mL-BZ
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 10:28:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752816AbYHVI1k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2008 04:27:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751115AbYHVI1j
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 04:27:39 -0400
Received: from main.gmane.org ([80.91.229.2]:37374 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751989AbYHVI1f (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2008 04:27:35 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KWRzX-0008HF-K9
	for git@vger.kernel.org; Fri, 22 Aug 2008 08:27:31 +0000
Received: from whitehead.math.tu-clausthal.de ([139.174.44.12])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 22 Aug 2008 08:27:31 +0000
Received: from michaeljgruber+gmane by whitehead.math.tu-clausthal.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 22 Aug 2008 08:27:31 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: whitehead.math.tu-clausthal.de
User-Agent: Thunderbird 2.0.0.16 (X11/20080707)
In-Reply-To: <20080821200255.GB27705@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93274>

First of all: Thanks for all your responses. I think I've learned a lot
through them, and hopefully I'll be able to give evidence with an
upcoming patch...

Jeff King venit, vidit, dixit 21.08.2008 22:02:
> On Thu, Aug 21, 2008 at 11:19:41AM +0200, Michael J Gruber wrote:
> 
>> This allows the use of author abbreviations when specifying commit 
>> authors via the --author option to git commit. "--author=$key" is 
>> resolved by looking up "user.$key.name" and "user.$key.email" in
>> the config.
> 
> This seems like a reasonable feature to me, though two high-level 
> questions:
> 
> - Is it worth supporting external alias sources, as Alex mentioned? I
>  think that would make more sense for many people. Even if you are 
> not personally interested in writing it, it would be nice to keep it 
> in mind as a future expansion when doing this work. For example, 
> maybe it makes more sense for the config to point to a (type, file) 
> pair instead of placing directly into the config. Or maybe this 
> should just live in conjunction with that feature, if somebody cares 
> to implement it.
> 
> - Is user.$key the right namespace? It precludes a few particular 
> aliases, and it might clash with future user.* config. Perhaps 
> user.alias.* would be a better place (or, as above, just referencing 
> an external file).
> 
> - git-send-email already looks at some alias files. Maybe this is an 
> opportunity to refactor and centralize (although perhaps it is not 
> worth the effort, because of the different implementation languages).

There's also git svn.
I think all of these serve different purposes, and have different
typical numbers of entries.

- mailmap maps email addresses to full names, for display purposes only.
Typically a long list.

- git svn's author file maps usernames to fullname <email>. But for
every svn repo I need a file following their chosen keys (usernames),
rather than abbreviations I would remember.

- alias files for send-email map keys to fullname <email>. That indeed
is a mapping and a purpose similar to my intention for git commit
--author. Problem here is that it's in perl and supports various
different formats.

I think for send-email you would typically use your mua's alias file.

For git commit --author abbreviations at least I would typically need
only very few entries (be it per repo or globally), which means they can
be much shorter (than my mua aliases) in order to be unique, and I don't
really want an extra file for that.

So, while in fact I wouldn't have been able to implement it differently
anyways, there are other good reasons as well. :)

>> --- In an ideal word, all my collaborators would exchange changes
>> as git patches (or even via pull/push). In the real world, they
>> send new versions which I integrate (after dealing with their
>> whitespace and encoding changes...). Therefore, being able to say 
>> "git commit --author=mickey" and having git translate "mickey" into
>> "Mickey Mouse <mickey@ducktown.us>" is a real time saver. The patch
>> accomplishes this by reading config keys "user.mickey.name" and
>> "user.mickey.email" when encountering an --author argument without
>> "<>".
> 
> This justification should probably go into the commit message, not
> the cover letter. When you are writing it, think about the reader who
> will bisect or blame to your commit a year from now. Will they want
> to see just _what_ you did, or _why_ you did it?

OK. I think I'm still thinking in terms of "change log style" commit
messages. I haven't completely switched from svn to git yet, neither
technically nor intellectually, it seems. Read "brain rotten" ;)

>> If there's interest in this patch I'll follow up with a
>> documentation patch.
> 
> I think Miklos already yelled at you for this. The message he
> referenced doesn't quite apply, because you did include some
> discussion of the "why".

He didn't mean to yell, we corresponded off-list, all is well.

[snip]

> final patch" then that would have gone over very well. But as it 
> happens, you chose the magic pet peeve words. ;)

Newcomer's luck, I'm fine with that.

> 
>> The "--committer" argument to git commit is not treated because I
>> don't consider it worthwhile.

I managed to fool everyone, including myself. There is no --committer
option. I feel in good company now ;)

There is GIT_COMMITTER_NAME and GIT_COMMITTER_EMAIL, and likewise for
author. My patch does not use any of these, it only deals with (the)
option argument(s). Explicitely set *_{NAME,EMAIL} should be respected
as is.

> If you are introducing a new source of alias mappings, it would make 
> sense to me to support it everywhere for the sake of consistency.
> That means --committer should look at it, too (and should only be a
> few lines, I would think), and probably git-send-email.
>> P.S.: That's my first patch here. Yes, I've read
>> Doc/SubmittingPatches. So, if something's wrong, please be gentle
>> but not overly so ;)
> 
> I hope this is the right amount of gentleness. ;)
> 
>> --- a/builtin-commit.c +++ b/builtin-commit.c @@ -53,6 +53,12 @@
>> static char *author_name, *author_email, *author_date; static int
>> all, edit_flag, also, interactive, only, amend, signoff; static int
>> quiet, verbose, no_verify, allow_empty; static char
>> *untracked_files_arg; +struct user { +	char *name, *full_name,
>> *email; +};
> 
> Others may disagree, but style-wise I think we usually put each
> struct member on its own line.
> 
>> if (force_author) { const char *lb = strstr(force_author, " <"); 
>> const char *rb = strchr(force_author, '>');
>> 
>> +		if (!lb && !rb) { +			for (i=0; i < users_nr; i++) {
> 
> Style: "i = 0"
> 
>> +				if (!strcmp(force_author, users[i]->name)) { +					author_name
>> = users[i]->full_name; +					author_email = users[i]->email; +
>> return; +				}
> 
> 
> I haven't traced all of the uses of author_name and author_email, but
>  all of the other codepaths seem to allocate a new string, whereas

..because they need to make a local (for the function) string global
(for the file)...

> this uses the existing strings.

...because they are (file) global already.

> Is this going to accidentally free()
> from the users list, or are we just leaking those other strings now?

Same as branches in remote.c, see below. They're not freed accidentally
in builtin-commit.c

> 
>> +	ALLOC_GROW(users, users_nr + 1, users_alloc);
> 
> Yay, a first-time submitter bothered to use ALLOC_GROW! :)
> 
>> +	ret = xcalloc(1, sizeof(struct user)); +	users[users_nr++] = ret;
>>  +	if (len) +		ret->name = xstrndup(name, len); +	else +		ret->name
>> = xstrdup(name); + +	return ret; +}
> 
> This is the not the most git-ish way of using the config[1]. Usually
> we avoid reading big lists into memory, but rather just call
> git_config with the appropriate callback when we find we need to look
> up the user alias.
> 
> [1] However, I don't necessarily agree with this. We can end up
> parsing the config (which may be split across 3 files) several times
> per command, so it is probably better to just parse and store it in
> one go. So I will let Junio comment on the preferred method.

I was looking all over the existing code for a function which would do
what "git config --get $key" does, and didn't find any. I ended up
copying the logic (and code) from remote.c's parsing of "branch.*.*".
[Should I have attributed this somehow? ]

I understand there are good reasons for this (the way the config is
parsed): a generic central config parser wouldn't be able to verify the
entries when reading the config.
OTOH, verifying an entry when using it wouldn't be that much later. So,
reading the complete config once and storing it in a global struct
should be an alternative which would provide a central place for all
parsing. Judging the implications is way above my current understanding
of the codebase, not to mention implementing it.

Cheers
Michael

P.S.: I should have split this up. Next post will be shorter.
