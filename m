From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: Re: [msysGit] Re: MinGW port pull request
Date: Sat, 21 Jun 2008 23:18:47 +0200
Message-ID: <200806212318.47745.johannes.sixt@telecom.at>
References: <485B6510.3080201@viscovery.net> <7vskv79l37.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: msysGit <msysgit@googlegroups.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 21 23:19:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAAUt-0008V5-O3
	for gcvg-git-2@gmane.org; Sat, 21 Jun 2008 23:19:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752194AbYFUVSw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Jun 2008 17:18:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752116AbYFUVSw
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jun 2008 17:18:52 -0400
Received: from smtp1.srv.eunet.at ([193.154.160.119]:41801 "EHLO
	smtp1.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752103AbYFUVSv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jun 2008 17:18:51 -0400
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp1.srv.eunet.at (Postfix) with ESMTP id A740D33B51;
	Sat, 21 Jun 2008 23:18:48 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 6D824118F7;
	Sat, 21 Jun 2008 23:18:48 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <7vskv79l37.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85724>

On Samstag, 21. Juni 2008, Junio C Hamano wrote:
> Johannes Sixt <j.sixt@viscovery.net> writes:
> > please pull the MinGW (Windows) port patch series from
> >
> > git://repo.or.cz/git/mingw/j6t.git for-junio
>
> Took a look.  A quick impression.
>
>  * Too many whitespace breakages in borrowed compat/regex.[ch] are very
>    distracting.

Will fixup, no problem.

>  * It is a very nice touch to rename sample templates to make sure they
>    are not executable (after all they are just samples).

Note that they are only renamed on Windows. Do you think it makes sense to 
rename them on every platform?

I think I'll have to add a note in Documentation/githooks.txt for Windows that 
mentions that the '.noexec' part must be removed.

>  * Shouldn't my_mktime() if exported out of date.c be named a bit better?

How about tm_to_time_t()?

>  * The ifdef block in git.c::main() introduces decl-after-stmt which we
>    tend to avoid, but it is much worse to solve it by adding another ifdef
>    block just to enclose decl of char *bslash at the beginning of the
>    function.  Perhaps enclose it in an extra block?

It does not in my version. IIRC, I was careful that it does not.

>  * In sanitary_path_copy(), you left "break;" after /* (1) */ but now that
>    "break" is not inside a switch() anymore, so you are breaking out of
>    something else, aren't you?  -- Ah, the clean-up phase will be no-op in
>    that case because src points at '\0'.  Tricky but looks correct ;-)

I'm pretty certain that it is an omission. I'll remove the 'break' in the next 
round. It's just unnecessarily tricky.

>  * There seem to be an unrelated general fix in upload-pack.c

Yes, indeed. It's the fflush(pack_pipe) that could make a difference. I wonder 
why this ever worked without it. Notice that traverse_commit_list calls 
show_object() last, but show_object() never flushes pack_pipe. Are fdopen()ed 
pipes line-buffered or unbuffered?

>  * There are still too many ifdefs.  I am wondering if the changes to
>    pager and process stuff is easier to manage in the longer term if they
>    are made into completely separate files (i.e. instead of linking
>    pager.o you would link mingw-pager.o).  I dunno.

I think that would not be helpful. Both parts need to be maintained, whether 
they are in the same file or in different files. If they are in one file, and 
someone needs to make a change, then there is a chance that a corresponding 
change is made in the MINGW32 arm. If not then there is another chance that 
the person would at least say "I don't know how to do it for MINGW32". But if 
you separate the implementations completely, then both chances are missed 
much easier.

To reduce #ifdef in other places I have some proposals. Please tell me which 
you like or dislike:

* The #ifdef STRIP_EXTENSION can be removed with a conditional like this:

	static const char ext[] = STRIP_EXTENSION; // "" or ".exe"
	if (sizeof(ext) > 1) {
		...
	}

* The #ifdef in main() of git.c can be removed with a custom loop that checks 
for is_dir_sep():

	slash = cmd + strlen(cmd);
	while (slash > cmd && !is_dir_sep(*--slash))
		;
	if (slash >= cmd) {	// was: if (slash) {
		...

* We could wrap getenv(), so that the getenv("TEMPDIR") in path.c does not 
need to be followed up with getenv("TMP") and getenv("TEMP"). I'll do that.

* The #ifdef in setup.c, prefix_filename() could easily be removed by using 
the MINGW32 arm everywhere. This would penalize non-Windows, however, 
prefix_filename() is not performance critical.

>  * There is an interaction with dr/ceiling topic that is already in 'next'
>    that needs to be resolved before we merge this in 'next'.

How do you want me to proceed? Rebase on top of dr/ceiling? Wait until 
dr/ceiling is in master and rebase again? Merge it into my series? (I would 
make the merge the last commit in my series.) I'm asking because support of 
dr/ceiling was not overwhelming.

-- Hannes
