From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [GSoC] Designing a faster index format
Date: Thu, 29 Mar 2012 17:21:53 +0200
Message-ID: <5CE5AEC7-22C8-4911-A79E-11F2F3D902A2@gmail.com>
References: <F9D452C3-B11E-4915-A0F2-B248F92CE5DE@gmail.com> <CACsJy8CKqv2P2Co9MKpePfOTwe4fu-wxAYiigbYt3YHTxZ6wWQ@mail.gmail.com> <8D287169-1AD9-4586-BDBC-F820220328FC@gmail.com> <CACsJy8D2RwG-Nr5btcQj0f9=JACvH6mf7LNi=Jnb_y+j4_2u0A@mail.gmail.com> <871uomrubl.fsf@thomas.inf.ethz.ch> <8901F6B5-7396-44E1-9687-20BF95114728@gmail.com> <871uomq64c.fsf@thomas.inf.ethz.ch> <BDFA27C9-C999-4C95-8804-5E7B3B3D1BFD@gmail.com> <878virfx11.fsf@thomas.inf.ethz.ch> <2A61C352-5C71-4EDF-9DBE-01CC09AE03A5@gmail.com> <87r4we9sfo.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Mar 29 17:22:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDHAw-0006cW-VN
	for gcvg-git-2@plane.gmane.org; Thu, 29 Mar 2012 17:22:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933564Ab2C2PWF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Mar 2012 11:22:05 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:47789 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933538Ab2C2PWB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Mar 2012 11:22:01 -0400
Received: by pbcun15 with SMTP id un15so253788pbc.19
        for <git@vger.kernel.org>; Thu, 29 Mar 2012 08:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        bh=LUBHgHbQW+4oJC7kNJDATASCh4plcqOKb+QY8JxPt1w=;
        b=YNZeivyB2UXD3yi4tvhMnnBmJzzgef0rqJi8cC6ZoL9uYrdlCMBdJ9DYtYDl/LpB51
         NayeoSCt/u5V6fgOADACiGzc8PJdCvxkdz3RxfXgcJCAxdyl3pI5pCtMPYSrSAR92qBx
         pKmCHeObUfsd920XS35JZ9gHPbDiZAnSScwl2xA6Gqy+KnprkC9L6+njtjk6sP1qH+ZK
         HPJPbvuj2nmJgmD+NRYHStTktC9sGQ6m5hpIVsE3wy9jeLN6+rA2tIvtvFgkreIbEPCU
         xkGNuJyC255W26GV52OjjkecJI4AHGr+vyM2j9i5M1I/KpLcFOfUn/9VFwGppIQxchqb
         gsAw==
Received: by 10.68.202.167 with SMTP id kj7mr867710pbc.9.1333034520776;
        Thu, 29 Mar 2012 08:22:00 -0700 (PDT)
Received: from [10.9.26.196] ([216.18.212.218])
        by mx.google.com with ESMTPS id l6sm5225918pbp.33.2012.03.29.08.21.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 29 Mar 2012 08:21:59 -0700 (PDT)
In-Reply-To: <87r4we9sfo.fsf@thomas.inf.ethz.ch>
X-Mailer: Apple Mail (2.1257)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194261>

After the discussion on IRC and the taking your suggestions into account
I've rewritten my proposal draft as follows.

(@Thomas Rast: Since you asked, here are the courses I'm currently 
taking: 
Team Work Management
Communication and Presentation skills
(Those are general skills, we have to do two of them)

Introduction to Artificial Intelligence
Functional and Logic Programming Languages)

Designing a faster index format

-- Problem --
The current git index is pretty slow when working with large git repositories,
because the whole index has to be rewritten for nearly every operation. For
example for adding a single file with git add, even though logically only one 
single blob sha-1 is changed in the index, git has to recompute the hash over 
the whole index and rewrite the index file.

-- Proposed solution --
The proposed solution is to rework the index, using a append-only data
structure. That shall allow for changes to the index in O(k) time, with k being
the number of files that changed. To reach this goal, the first part of the
index will be sorted and changes will always be written to the end, in the order
in which the changes occured. This last part of the index will be merged with
the rest using a heuristic, which will be the execution of git commit and git
status.

To make sure the index isn't corrupted, without calculating the sha-1 hash for
the whole index file every time something is changed. The hash is always
calculated for the whole index when merging, but when a file is changed the
sha-1 hash is only calculated for the last entry. This has some cost when
reading the index, but the performance improvements when writing the index
should more then make up for that. 

The index format shall also save on file size, by storing the paths only once,
which currently are stored for every file. This can make a big difference
especially for repositories with deep directory structures. (e.g. in the webkit
repository this change can save about 10MB on the index). In addition to that it
can also give the index a structure, which in turn makes it easier to search
through. Except for the appended part, but that will never grow big enough to
make going through it costly.

This structure in the index could also help implement fast partial loading, from
which git status and git diff could benefit from. This benefit would be fully
explored by a implementation with inotify, which Thomas Rast is working on.

In order to be able to only rewrite a part the way the lock file currently works
has to be changed. Currently the new index is always written into the lock file,
which then is renamed once the writing is complete. Since we now change to an
append only format, if the operation fails, only the last record in the index
is corrupted and we can easily recover by removing the corrupt record. When the
is merged the old lock file algorithm will be used.

To maintain the speed even if a file is already in the index, git will always
append a new record on the end, instead of finding the record in the index and
changing it. This will give us a lot of benefit in terms of speed, since
otherwise we would have to search the record (log(n)), change it (1) and update
the sha-1 hash over the whole file (n).

The current in-memory structure of git would only have to be slightly changed,
adding a flag or keeping a list of the changed files. The rest of it could be
changed in an other step, to better represent the new structure of the index.

The extensions (cache-tree and resolve undo at the moment) will be handled the
same way, adding changes to the end and merging at the same time when the rest
of the index is merged. This will give changing extension entries a complexity
of O(1) and will not be much slower when reading. Because merging will happen
at the same time as merging the rest of the index, it won't affect performance
a lot either.

To ensure backward compatibility, git shall keep the ability able to read 
version 2/3 of the index. The user shall also have the possibility to configure
git to write the index in either the new or the old format. While this will
produce some code overhead, it will make the life of git users which don't use 
core git exclusively easier in the transition phase. If the user sets the write 
format to the new format and the repository is a already existing version 2/3 
repository, the old index will be transformed to the new format. 

Backward compatibility will be broken (at least for write) once the in-memory
structure is changed. Git could still keep compatibility for reading the index
and converting it to the new in-memory format, but keeping write compatibility
would slow down the operation and mess up the code.

There were also other formats considered for the usage in the index, which I
will list below with their advantages and disadvantages.

- Database format
Having the index in a database format would be very efficient in terms of speed.
The integrity check also wouldn't be neccessary or rather could be handled by
the database. The disadvantage of using the database format however would be the
need to use a external library (or writing one, but that wouldn't make any
sense). Another problem with the database are programs like jgit and libgit2 
would probably more problems implementing it and it would make backward
compatibility unreasonably hard and mess up source code at the same time.

- Tree structure
The advantage of the tree structure over the append-only data structure that was
proposed would be that it would not require any merge or other maintainance work
work after a change of a file. The disadvantage however is that changing a file
would always require log(n) changes to the index, where n is the number of
entries in the index. Another problem might be the integrity check, which would
need either to use a hash over the whole index file or a hash on the tree,
which would however take more time for checking.

- Padded structure
Another index format that was taken into consideration was to create a padded
structure. Basically that would be an append-only like structure, but split into
section, where every section would leave some space at the end for appending.
This structure would not bring many advantages (probably the only advantage
being a bit speed up on merging and maybe slightly faster for partial-reading)
compared to the append-only structure. In the meanwhile it would probably lead
to messier code and it would be harder to parse for other programs that use
.git.

To make the project feasible for Google Summer of Code, all the features above
will be implemented, except for the partial-reading and the current in-memory
structure will be kept, ecept for the changes necessary to keep track of the
changes.

-- Timeline --
24/04 - 29/04: Document the new index format.
30/04 - 15/05: Map the current internal structure to the new index format.
16/05 - 02/06: Change the current in-memory structure to keep track of the
changed files.
02/06 - 16/06: Write the index to disk in both the old and the new format
depending on the choice of the user and make sure only the changed parts are 
really written to disk in the new format.
17/06 - 21/07: Parse the index from disk to the current in-memory format.
/* Development work will be a bit slower from 18/06 to 21/07 because at my
 * University there are exams in this period. I probably will only be able to
 * work half the hours. I'll be back up to full speed after that. */
22/07 - 10/08: Merge appended changes with the rest of the index.
11/08 - 13/08: Test the new index and profile the gains compared to the old
format.

-- Why git --
I'm using git since about 2-3 years and wanted to contribute to it earlier, but
couldn't find the time to do it. I would also like to continue contributing
once the Summer of Code is over.

-- About me --
I'm Thomas Gummerer (@tgummerer on Twitter, tgummerer on IRC), 21 years old
from Italy. I'm currently a 3rd year Bachelor student in Applied Computer 
Science at the Free University of Bolzano. I started programming in High School 
about 8 years ago with Pascal and then learned C and Java. For some of my
projects you can visit my homepage (http://tgummerer.com/projects), most of them
were for university and some personal projects I did in my free time. My blog is
also on the same homepage, but not really active. Unfortunately I couldn't yet 
participate in any bigger open source project, although I'm interested in
it basically since I started programming. 
