From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: Index format v5
Date: Thu, 3 May 2012 23:38:43 +0200
Message-ID: <CALgYhfMQMdtcNN2a_BwPMkb_aHGr9ivBpWOSEjkqjGiaVzgS_w@mail.gmail.com>
References: <CALgYhfMKdbv8TiT4ALDSvD3pSXHEPLWHM09DxYnRmRdBWRjh8Q@mail.gmail.com>
	<7vd36lf634.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, trast@student.ethz.ch, mhagger@alum.mit.edu,
	peff@peff.net, spearce@spearce.org, davidbarr@google.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 03 23:38:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQ3jf-000384-16
	for gcvg-git-2@plane.gmane.org; Thu, 03 May 2012 23:38:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758630Ab2ECViq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 May 2012 17:38:46 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:56382 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755623Ab2ECVip (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 May 2012 17:38:45 -0400
Received: by lbbgm6 with SMTP id gm6so1602382lbb.19
        for <git@vger.kernel.org>; Thu, 03 May 2012 14:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Zw3MXJz1UHDUKXrU4jYJJQHVYejnopFj+DBVru8dsqI=;
        b=A3CyDOaLo6dDuO3Ol0eK3hCJiNYElWjQtzXsc3E1XmbSh4BzcB3bT/1xC3s+ViIdau
         FJ7vzgFMUzVDNPNqPDO0IquLBrRVcAHoOtd6BOO8HNCQGEp1aGvbJAgdYbmkqe1mUlbg
         WfzHZJf7UzHNlEbnVn+tZY076+tdjIzMGfYu/LZj7l7/yIRJJ4g1+juNDb0jXPtvUTpM
         JgXpB4IEdqy/N7qY7c8d/mhBDd6B/sOSpe062Fc/LamdPj7OIbQHXdgg2pbmvOXs02MG
         RuKqrLan5EHSEX8RCdjZfQOn8hinf4q6P3b3ccoUH2M2tRjEsFDB7iDq8WYKAtA3+6Us
         97TQ==
Received: by 10.112.30.102 with SMTP id r6mr1779079lbh.0.1336081124005; Thu,
 03 May 2012 14:38:44 -0700 (PDT)
Received: by 10.152.37.201 with HTTP; Thu, 3 May 2012 14:38:43 -0700 (PDT)
In-Reply-To: <7vd36lf634.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196964>

On Thu, May 3, 2012 at 8:54 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Thomas Gummerer <t.gummerer@gmail.com> writes:
>
>> I have been drafting the Version 5 of the index format over the past
>> few days with the help of Thomas Rast, Michael Haggerty, cmn and
>> barrbrain on IRC.
>
> Hrm, so if there is anything glaringly wrong below, should I reduce the
> "trustable reviewer karma point" from these people?  Or did you forget to
> say "but remaining errors are mine" ;-)?

Heh yes most of the remaining errors are mine ;-) (And I hope nothing is
*that* wrong ;-) )

>> GIT index format
>> ================
>>
>> = The git index file has the following format
>>
>>   All binary numbers are in network byte order. Version 5 is described
>>   here.
>>
>>    - A 16-byte header consisting of
>>
>>      4-byte signature:
>>        The signature is { 'D', 'I', 'R', 'C' } (stands for "dircache")
>>
>>      4-byte version number:
>>        The current supported versions are 2, 3, 4 and 5.
>>
>>      32-bit number of directories.
>
>>      32-bit number of file entries.
>
> I take these two numbers mean "we have this many directory entries in the
> index" and "we have this many file entries in the index"; I found it
> unclear during my first scan.

Yes, that's exactly what they mean. I'll write this down more clearly in the
next version.

> Have you considered expressing these new "directories", "files" and
> associated data as a new (mandatory) extension?

Since they are the main part of the index, I don't consider them
extensions, unless we say "everything in the index is a extension"

>>    - Offset to the extensions.
>>
>>      32-bit number of extensions.
>
> Why is this necessary?  It means that the writer needs to enumerate how
> many extensions it is going to write before starting to write, unless it
> is willing to seek back and fill this.  And it is not like the reader will
> first allocate an array to hold uniformly sized extension and will be
> helped to have the number of entries upfront in order to do the
> allocation.
>
> What purpose does this serve?

It's to determine how many offsets the reader has to read (or to skip
to get to the first directory offset).

>>      32-bit number offset to the extension. (Possibly none, as many as
>>      indicated in the 4-byte number of extensions)
>
> Why is this needed?  It appears that there is no field that points at the
> beginning of array that stores "directory offsets", nor "file offsets", so
> I am assuming that you will be scanning the index file to find them.  Why
> can't the extensions be handled exactly the same way?

The offsets are necessary to quickly skip to the extension data, in case it
makes sense without knowing about the index/without reading the whole
index. The directories and files are different in the sense that the reader
needs to read to the first "directory offset" entry in any case, since it needs
to read the header in any case, then the number of extensions (and
if it doesn't know about any extensions skipping them), and then there come
the directory offsets. Those then have the pointer to the actual directory
data, which itself has the pointer to it's files. And since the files don't make
sense without knowing about the directory, there is no need for offsets for
the files.

>>    - A number of directory offsets (see below). [1]
>>
>>    - A number of sorted directories (see below). [2]
>>
>>    - 32-bit crc32 checksum for the header, extension offsets and directories.
>
> What does "32" in "crc32" stand for ? ;-)

32 bit I guess ;-) It's just standing there to make it clear on first
sight that there
is a 32-bit entry, since every other entry starts with the bit/byte count too.

>>    - A number of file offsets (see below). [1]
>>
>>    - A number of file entries (see below).
>>
>>    - A number of entries for conflicted data/resolved conflicts (see below).
>>
>>    - Extensions
>>
>>      Extensions are identified by signature. Optional extensions can
>>      be ignored if GIT does not understand them.
>>
>>      GIT supports an arbitrary number of extension, but currently none
>>      is implemented. [3]
>>
>>      4-byte extension signature. If the first byte is 'A'..'Z' the
>>      extension is optional and can be ignored.
>>
>>      32-bit size of the extension
>>
>>      32-bit crc32 checksum of the extension signature and size
>>
>>      Extension data
>>
>>
>> == Directory entry offsets
>
> The name "directory entry offset" does not seem to appear anywhere before
> this, so it is unclear what this section of the documentation is trying to
> describe.  Is this the same as "directory offsets" above?  In other words,
> "A number of directory offsets (see below)." above is an array of something,
> and this section is trying to describe what that something is?

Yes, exactly, it's the directory offsets above. I'll write this down more
clearly too.

>>   32-bit offset to the directory.
>
> I take it is "offset relative to the beginning of the file in the index".

Yes, that will be written more clearly too.

>>   This part is needed for making the directory entries bisectable and
>>     thus allowing a binary search.
>>
>> == Directory entry
>>
>>   Directory entries are sorted in lexicographic order by the name
>>   of their path starting with the root.
>>
>>   Path names (variable length) relative to top level directory (without the
>>     leading slash). '/' is used as path separator. '.' indicates the root
>>     directory. The special patch components ".." and ".git" (without quotes)
>>     are disallowed. Trailing slash is also disallowed.
>
> I understood "the root" to mean "the top level of the directory hierarchy"
> (i.e. the directory that corresponds to the top level of the working
> tree), but it needs to be explained better.  Using '.' for root sounds
> somewhat questionable, though.  Why not a string of length 0?

Yes, that's right. I thought about '.' for root since *nix environments do it
that way too. But the string of length 0 would also work better with the
lexicographic sorting.

> When an index represents a D/F conflict, some stages may have a directory
> D while others do not have D (but have a regular file at D).  Doesn't
> directory entry need to have a stage information?

I didn't think about that, I'll include that in the next version.

>>   1 nul byte to terminate the path.
>>
>>   32-bit offset to the first file of a directory
>
> What does this point at?  Does it point into the array of "file offsets"
> or the array of "file entries"?

It points to the "file offsets".

>>   32-bit offset to conflicted/resolved data at the end of the index.
>>     0 if there is no such data. [4]
>>
>>   4-byte number of subtrees this tree has
>
> Which is an undefined number unless you specify which stage you are
> talking about.

I'm talking about the number of subtrees, that are in the index. This
is used for further compressing the index, and not being redundant
with path components. E.g: we have a directory A/A then the index
saves it as

A...1Subtree...
A...0Subtrees...

(... is the rest of the data that's stored)

>>   4-byte number of entries in the index that is covered by the tree this
>>     entry represents. (entry_count) (-1 if the entry is invalid)
>>
>>   160-bit object name for the object that would result from writing
>>     this span of index as a tree.
>>
>>   The last 24 bytes are for the cache tree. An entry can be in an
>>     invalidated state which is represented by having -1 in the entry_count
>>     field. If an entry is in invalidated state, the next entry will begin
>>     after the number of subtrees, and the 160-bit object name is dropped.
>
> By "The last 24 bytes", do you mean the "4-byte number of entries..." and
> "160-bit object name"?

Yes, exactly.

>>   The entries are written out in the top-down, depth-first order. The
>>     first entry represents the root level of the repository, followed by
>>     the first subtree - let's call it A - of the root level, followed by
>>     the first subtree of A, ...
>>
>> == File entry offsets
>>
>>   32-bit offset to the directory.
>
> What directory?  The containing directory?  What does this point at?  Does
> it point into which array?

That's actually wrong it should say file entry, as it should below. That's what
I get from copy and pasting ;-)

>>   This part is needed for making the directory entries bisectable and
>>     thus allowing a binary search.
>>
>> == File entry
>>
>>   File entries are sorted in ascending order on the name field, after the
>>   respective offset given by the directory entries.
>>
>>   File name (variable length). Nul bytes are not allowed in file names and
>>     they have no leading slash. They are 7-bit ASCII encoded.
>
> Is this a name relative to its containing directory (i.e. without leading
> components)?  Or is it a full path relative to the top level of the
> working tree?

The path is relative to its containing directory, to save space, as in your
v4 index format.

> I have some UTF-8 encoded files in my repository.  Are they
> now disallowed?

Right I should have taken the old format there, and leave the
files in undefined encoding?

>>   1 nul byte to terminate the filename.
>>
>>   A 16-bit 'flags' field split into (high to low bits)
>>
>>     1-bit assume-valid flag
>
> Is this "assume unchanged"?

I have taken this from the old index format documentation, which
describes it as assume-valid flag, but I guess it's assume unchanged then.

>>     1-bit conflict flag
>>
>>     2-bit stage (during merge)
>
> Huh?  When stage #0 entry exists for a given path, no other stages for the
> same path can exist in the index.  By definition, that is how a conflicted
> path is resolved.  What is this separate "conflict flag" for?

I probably got this wrong, and the conflict flag isn't needed. So if I have a
stage #1 entry in the index, I'm sure that it's conflicted?

>>     2-bit mode (0 = 1000644 (regular file without execution
>>       permission), 1 = 1000755 (regular file with execution
>>       permission), 2 = 1010000 (symbolic link), 3 = 1110
>>       (gitlink)) [5]
>
> Don't penny-pinch bits like this.

Heh ok, I thought this saves 4-bytes per entry so it would be good,
but if it's better the other way we'll invest 16-bits for this.

>>     1-bit skip-worktree flag (used by sparse checkout)
>>
>>     1-bit intent-to-add flag (used by "git add -N")
>>
>>     8-bit unused, must be zero [6]
>>
>>   32-bit mtime seconds, the last time a file's data changed
>>     this is stat(2) data
>>
>>   32-bit mtime nanosecond fractions
>>     this is stat(2) data
>>
>>   32-bit crc32 checksum over ctime seconds, ctime nanoseconds,
>>     ino, file size, dev, uid, gid (All stat(2) data except mtime) [7]
>
> Giving occassional false positive to "did this change?" is acceptable, but
> any false negative is absolutely unacceptable.  How does this work with
> something like "racy git" situation (i.e. coming from "mtime happens to be
> the same as before") but due to crc32 collisions?
>
> If there is no good answer to the above question, I would have to say that
> anybody who suggested or passed this through review loses all the
> accumulated reviewer karma points (if s/he has accumulated any, that is).
>
>>   160-bit SHA-1 for the represented object
>>
>>   32-bit crc32 checksum for the file entry
>>
>> == Conflicted data
>
> I do not think the data described in this section should be conflicting.
> It ought to be data that describe conflicted state.  Perhaps you meant
> "Conflict data"?

Yes, it's conflict data. It's the data that used to have more entries in the
in the index, and it has been moved to the far end to avoid lots of rewrites
of the index, when a conflict is resolved.

>>   A conflict is represented in the index as a set of higher stage entries.
>>   These entries are stored at the end of the index. When a conflict is
>>   resolved (e.g. with "git add path"). A bit is flipped, to indicate that
>>   the conflict is resolved, but the entries will be kept, so that
>>   conflicts can be recreated (e.g. with "git checkout -m", in case users
>>   want to redo a conflict resolution from scratch.
>>
>>   - NUL-terminated filename of the entry
>
> Is this a name relative to its containing directory (i.e. without leading
> components)?  Or a full path relative to the top-level of the working
> tree?

This is again relative to it's containing directory. That's what the second
offsets in the directory entry part is about. (The offset is pointing to the
filename)

>>   - A 8-bit 'flags' field split into:
>>
>>     - 1-bit conflicted state (conflicted/resolved) (1 if conflicted)
>>
>>     - 7-bit unused
>>
>>   - Three 4-byte octal numbers, entry mode of entries in stage 1 to 3 (a
>>     missing stage is represented by "0" in this field);
>>     and
>>
>>   - At most three 160-bit object names of the entry in stages from 1 to 3
>>     (nothing is written for a missing stage).
>
> It is allowed to have more than 1 entries in stage #1 to represent
> multiple merge-base, so this needs to be rethought.

Ok, I'll rethink this. Thought it's this way, because it currently
works this way
in the resolve undo extension.

>>   - 32-bit crc32 checksum over one conflicted entry.
>
> There is no definition of "one conflicted entry"; be consistent and say
> "Conflicted data" as what the section header claims to describe.

Ok, I'll change that.


>> == Design explanations
>>
>> [1] The directory and file offsets are included in the index format
>>     to enable bisectability of the index, for binary searches.Updating
>>     a single entry and partial reading will benefit from this.
>>
>> [2] The directories are saved in their own block, to be able to
>>     quickly search for a directory in the index. They include a
>>     offset to the (lexically) first file in the directory.
>>
>> [3] The data of the cache-tree extension and the resolve undo
>>     extension is now part of the index itself, but if other extensions
>>     come up in the future, there is no need to change the index, they
>>     can simply be added at the end.
>>
>> [4] To avoid rewrites of the whole index when there are conflicts or
>>     conflicts are being resolved, conflicted data will be stored at
>>     the end of the index. To mark the conflict resolved, just a bit
>>     has to be flipped. The data will still be there, if a user wants
>>     to redo the conflict resolution.
>>
>> [5] Since only 4 modes are effectively allowed in git but 32-bit are
>>     used to store them, having a two bit flag for the mode is enough
>>     and saves 4 byte per entry.
>>
>> [6] The length of the file name was dropped, since each file name is
>>     nul terminated anyway.
>
> This is micronit, but I think we do this to save one strlen() for each
> read of the entry, except for unusually long paths where we fall back to
> strlen(). A change like this needs to be justified better than simply
> saying "because we _could_ compute in a different way by spending extra
> cycles".
