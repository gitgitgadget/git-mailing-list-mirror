From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: mingw, windows, crlf/lf, and git
Date: Mon, 12 Feb 2007 09:20:43 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702120839490.8424@woody.linux-foundation.org>
References: <45CFA30C.6030202@verizon.net> <20070212042425.GB18010@thunk.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Mark Levedahl <mlevedahl@verizon.net>,
	Git Mailing List <git@vger.kernel.org>
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Mon Feb 12 18:21:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGerO-000411-7Y
	for gcvg-git@gmane.org; Mon, 12 Feb 2007 18:21:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965014AbXBLRU6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Feb 2007 12:20:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965021AbXBLRU6
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Feb 2007 12:20:58 -0500
Received: from smtp.osdl.org ([65.172.181.24]:34239 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965014AbXBLRU4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Feb 2007 12:20:56 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l1CHKjUI017542
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 12 Feb 2007 09:20:45 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l1CHKiuT005301;
	Mon, 12 Feb 2007 09:20:44 -0800
In-Reply-To: <20070212042425.GB18010@thunk.org>
X-Spam-Status: No, hits=-0.43 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.116__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39418>



On Sun, 11 Feb 2007, Theodore Tso wrote:
> 
> So this is something that I've tried proposing to the Mercurial
> developers, but it's never been implemented in hg.  It'll be
> interesting to see what the git community thinks.  :-)
> 
> My proposal does require adding a file type to each file, as tracked
> metadata, which may doom it from the start.  If you add a file type,
> then you have to support mutating the file type, and some way of
> handling merge conflicts (generally, picking one type or another).

I agree that a file-type approch would work, but I personally think it's 
too inflexible (just cr/lf vs lf? There are tons of other interesting 
issues that are valid). I also think it falls down on another (and in some 
ways much more fundamental problem): these things exist EVEN WHEN THE FILE 
ITSELF DOES NOT EXIST!

In other words, a policy about cr/lf is *not* a policy about actual 
content. It's something much more: it's a policy about representation in 
general, which includes *potential* content. It should obviously take 
effect on "git add" even with content that didn't exist before, and to 
work well, it should do so without the user having to think about it.

Equally importantly, this happens with content that was added by people 
who simply DO NOT CARE. In other words, I think a "file type" thing 
fundamentally cannot work, because under UNIX, it would be stupid and 
pointless, so any project that is maintained under UNIX might _add_ the 
file types, but since they won't matter, they'll inevitably be wrong (ie 
people forgot to mark a binary thing binary, or a text thing as text).

So: file types or attributes are broken. They cannot work well.

But enough on the negative rambling, I do have a positive and constructive 
suggestion, because I actually think I have a great model for it. But I've 
never cared enough (and since the main target would be some windows issue, 
I suspect I never really _will_ care enough) to really worry about it.

Anyway, if somebody really wants to look at this, and wants to create 
something that is actually _usable_, my suggestion is to simply extend on 
the ".gitignore" file approach. The great thing about .gitignore is that

 (a) you can track it like you track any other file

     This makes merges a *lot* easier. You see it as conflicts, you can 
     fix it up, and in general, you can use all the same tools with it as 
     you use with anything else. In contrast, explicit per-file filetypes 
     are _horrible_ for maintenance.

 (b) you can add to it with *patterns*, which is exactly what you want for 
     file types.

     You can do things like

	*.bin: binary
	*: text

     to say "everythgn that matches *.bin is binary, the rest is text", 
     and solves the maintenance issue trivially. Everybody will like it. 
     For the kernel, for example, we'd have a really easy

	Documentation/logo.gif: binary
	*: text

     and that would probably take care of it.

     You can also have a few default file patterns built in, which would 
     take care of it for 99% of all projects without anybody ever having 
     to even think about it - even under DOS.

 (c) it doesn't actually affect database representation, it only changes 
     behaviour for programs, which is also  exactly what you want (if you 
     have per-file "file types", you end up having serious problems at 
     merge time: when I say "affect database representation", I don't mean 
     that I think git cannot change its database, I literally mean at a 
     "higher" level: represening per-file attributes is a DISASTER from a 
     merge situation)

     So not only is it backwards-compatible with traditional git usage, 
     it's much more fundamentally simple: it doesn't add any new core data 
     structures or rules. All the core stays exactly as it is, and it just 
     affects higher-level behaviour. And that's important: one reason git 
     has been so stable is that the really core data structures are really 
     really stable and simple.

     Even when we did *really* core changes like the whole packfile thing, 
     the fundamental data structures didn't change at all *conceptually*.

 (d) it's actually a lot more flexible than file types.

     Merge stategies, anybody? We can easily have the default merge 
     strategy be the normal three-way merge (which is obviously the right 
     thing for almost anything), but how about something like

	*.doc: binary,merge=doc-merge

     which tells git that it should use a separate "doc-merge" program to 
     merge those kinds of files when it needs to do a nontrivial merge..

 (e) exactly like ".gitignore", you should also be able to have a 
     ".git/info/exclude" file that is your _private_ rules, and 
     per-directory ".gitignore" files that are the _hierarchical_ rules.

     This just makes maintenance much simpler. Not one big file that has 
     everything, and that clashes. Make the top-level one contain all the 
     generic default rules, and then lower down we can have more specific 
     rules for very specific things, exactly like the kernel .gitignore 
     files do. The top-level file should *not* have to know all the 
     details of some architecture- or sub-project specific file behaviour.

     Similarly, having an untracked file (.git/info/exclude) allows people 
     to have rules that make sense for *them*, but that might not make 
     sense for the upstream developers (say, somebody crazy enough to 
     develop Linux under Windows). So people can have their purely local 
     rules without forcing them on others.

Anyway, that would be my suggestion. Call it ".gitattributes" or 
something. Make it a nice ASCII format, exactly like .gitignore, and make 
all the rules exactly the same, except it has a ": <attributelist>" at the 
end for each line.

Start off supporting just "binary" and "text", but keep in mind that 
people may want other things. Individualized merge strategies etc.

Also, keep in mind that a *lot* of git operations will work purely on a 
SHA1 level, and those operations fundamentally *will*not*care* about file 
types. So when you merge a file, for example, the initial merge will be 
done purely on SHA1's, and git would do all the normal "if it didn't 
change in branch 1, take the branch 2 version directly" without ever even 
*looking* at any file rules.

This is important, because this is what makes git efficient for large 
projects, and which would allow git to _remain_ efficient even in the face 
of having to read all those comples .gitattributes files. When we merge 
two repositories with 20,000+ files, we usually really only "merge" a 
couple of the files. 

Same goes for "text" mode. The "text" thing would only affect things like 
"git add" etc that use "git-update-index" to calculate the new SHA1. We'd 
never use it "normally". "git diff" would still be instantaneous, because 
the git index shows the file still matches, and that is all done on a SHA1 
only level. So only when you do a "git add" or when it needs to refresh 
the index because the file changed, and it reads in the file, will it 
actually care about whether it's a text or a binary file.

This is actually *exactly* what you want. Not just for performance, but 
simply because this is also how you can take something like the Linux 
archive, and "just use it" under Windows, even if your editor adds (or 
wants) CR/LF.

Btw, how would I implement this? If I really were energetic enough to 
implement it, I would do:

 (a) Add a flag to "git-ls-files" logic to add "type information" in 
     front.

     Not only do you want this *anyway* for other reasons, but for
     binary/text, the thing you actually care most about is "git add", and 
     it already basically just does "take this file pattern, feed it 
     through git-ls-files, and add those files". So you'd get it basically 
     for free.

     It is also fairly easy to add at this stage, because you can simply 
     look for all the places that work with "info/exclude" and 
     ".gitignore", and you know that "Ahh, I need to teach these exact 
     places to understand about attributes". So you'd add an 
     "add_attributes_from_file()" function etc etc.

     Quite straightforward. In fact, you might be able to use the 
     gitignore parsing *as*is*, and just teach it about more flags that 
     just "ignore": both in "struct dir_entry" and in "struct exclude".

 (b) Teach the git-update-index logic about hashing text blobs.

 (c) Profit!

It really should be fairly straightforward. I'm sure it wouldn't be 
*entirely* trivial, but I'm also fairly sure that somebody reasonably 
competent could do it in a couple of days (with testing) if they were just 
sufficiently motivated to get started.

Anybody?

		Linus
