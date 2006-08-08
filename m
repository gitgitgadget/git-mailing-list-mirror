From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: fast-import and unique objects.
Date: Tue, 8 Aug 2006 08:11:15 -0400
Message-ID: <9e4733910608080511t5aa96865p41d6bc1b85e236fa@mail.gmail.com>
References: <9e4733910608060532w51fca2c0r8038828df0d41eeb@mail.gmail.com>
	 <9e4733910608060853ua0eabc1w9b35b8414d3c9bae@mail.gmail.com>
	 <20060806180323.GA19120@spearce.org>
	 <9e4733910608062148u4341dabag451c3f49f1a792a1@mail.gmail.com>
	 <20060807050422.GD20514@spearce.org>
	 <9e4733910608070737k52aaea7clf871d716d16547c2@mail.gmail.com>
	 <20060808031240.GB19067@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Aug 08 14:11:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GAQQb-0003sy-Rv
	for gcvg-git@gmane.org; Tue, 08 Aug 2006 14:11:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932266AbWHHMLS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 Aug 2006 08:11:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932550AbWHHMLS
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Aug 2006 08:11:18 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:38889 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932266AbWHHMLR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Aug 2006 08:11:17 -0400
Received: by nf-out-0910.google.com with SMTP id q29so148863nfc
        for <git@vger.kernel.org>; Tue, 08 Aug 2006 05:11:16 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=g/Os/tdyfHfqVRZZJBobIW6lsVMOzTLQBqp8YIISgByIaRlGW7lE05uO3MyNSZ29oHngpJrjRNkJTkT6q4ib3zJ+nj4Vq+yvnVGEH1ECGNqgo2NCYd3J13Nl1gdx5wsZ48KdVZq/pOCybtX4lOkgL4LawE3c5Lvxfu34ZVN8zVo=
Received: by 10.78.128.11 with SMTP id a11mr2094913hud;
        Tue, 08 Aug 2006 05:11:15 -0700 (PDT)
Received: by 10.78.148.9 with HTTP; Tue, 8 Aug 2006 05:11:15 -0700 (PDT)
To: "Shawn Pearce" <spearce@spearce.org>
In-Reply-To: <20060808031240.GB19067@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25069>

On 8/7/06, Shawn Pearce <spearce@spearce.org> wrote:
> Knowing a little bit about SVN I would assume the current cvs2svn
> code would issue commands like:

We're designing a dumpfile format for git like the one SVN has.

>     svn copy A B;   # Make branch B starting from where A is now.
>     svn switch B;   # Make branch B the current branch.
>     svn add F;      # Add file F.
>     svn rm Y;       # Delete file Y.
>     svn commit;     # Commit current tree on current branch.
>     svn copy A T;   # Create tag T from where A is now.
>
> But I don't know how it would issue a merge commit.  Or even if it
> could find such a thing in the RCS files.

AFAIK the svn code doesn't do merge commits. We probably need a post
processing pass in the git repo that finds the merges and closes off
the branches. gitk won't be pretty with 1,500 open branches. This may
need some manual clues.

Another thing missing in cvs2svn is a sane way to handle unnamed
branches. Right now it is generating names. It's not real good at
detecting everything that belongs together in an unnamed branch so one
unnamed branches can turn into dozens of branches.

Once we get everything in a tool where it is possible to visualize the
repo errors like this will be more obvious. That should make it easier
to come up with a strategy to fix the import process.

> The above command set would be rather trivial to implement in a
> fast-import backend.  I'm thinking we extend the protocol so it
> looks something like the following:
>
>   stream ::= cmd*;
>
>   cmd ::= new_blob
>         | new_branch
>         | set_branch
>         | update
>         | commit
>         | tag
>         ;
>
>   new_blob    ::= 'blob' blob_data;
>   new_branch  ::= 'newb' branch_name source_branch;
>   set_branch  ::= 'setb' branch_name;
>   add_file    ::= update_file;
>   update_file ::= 'updf' file_update;
>   delete_file ::= 'delf' file_delete;
>   commit      ::= 'comt' author_committer_msg;
>   tag         ::= 'tagg' branch_name tagger_msg;
>
>   source_branch ::= branch_name
>                   | zero32
>                   ;
>   branch_name ::= len32 branch_name_str;
>   branch_name_str ::= # valid GIT branch name, should be relative
>                       # to .git/ (so include a refs/heads prefix)
>                     ;
>   file_update ::= len32 mode sp hexsha1 sp path;
>   file_delete ::= len32 path;
>
>   blob_data ::= len32 binary_data;
>
>   author_committer_msg ::= len32
>     'author' sp name '<' email '>' ts tz lf
>     'committer' sp name '<' email '>' ts tz lf
>     lf
>     binary_data;
>
>   tagger_msg ::= len32
>     'tagger' sp name '<' email '>' ts tz lf
>     lf
>     binary_data;
>
>   len32 ::= # unsigned 32 bit value, native format;
>   zero32 ::= # 32 bits, unset, aka '0';
>
>   mode ::= 'P'    # plain file
>          | 'X'    # executable file
>          ;
>
>   binary_data ::= # file content, not interpreted;
>   sp ::= # ASCII space character;
>   lf ::= # ASCII newline (LF) character;
>   path ::= # GIT style file path, e.g. "a/b/c";
>   hexsha1 ::= # SHA1 in hexadecimal format;
>   nullsha1 ::= # 40 '0's in sequence;
>   name ::= # valid GIT author/committer name;
>   email ::= # valid GIT author/committer email;
>   ts ::= # time since the epoch in seconds, ascii decimal;
>   tz ::= # GIT style timezone;
>
> This is a change from the current protocol as new blobs need to
> get prefixed by the command 'blob'.  Note that all commands are 4
> bytes wide and that any variable data portion of a command uses a
> "Pascal style" leading 32 bit length.  Although ugly it just makes
> it a tiny bit easier to code the stream parser.  :-)
>
> The commits and tags are half generated in the frontend and half
> in the backend.  The backend is producing and tracking the tree and
> the current SHA1 of each branch.  Consequently it will generate the
> 'tree' and 'parent' lines of a commit or the 'object', 'type' and
> 'tag' lines of a tag.  This is limited to only a linear development
> path, no merges...
>
> The backend would need to run inside of an existing GIT repository
> as it would output all tags and branch heads when it terminates.
> (Right now it runs from anywhere.)
>
> I don't know how many branches you would be asking the backend to
> hold at once, but I was thinking that the backend would just create
> a tree structure in memory when it receives a new_branch command,
> and consider one of those to be the current branch when a set_branch
> command is issued.  With all branches in memory at once switching
> would be very cheap, but if the number of branches is high it could
> eat memory like a pig...
>
> Right now I'm thinking that a file entry in a tree would cost:
>
>   29 bytes + length_of_name + malloc_overhead
>
> while a single tree would cost that plus:
>
>   36 bytes + 4*number_of_entries + 2*malloc_overhead + last_treesz
>
> where last_treesz is last content of that tree (uncompressed),
> so we can deltify against it quickly.

The file names are used over and over. Alloc a giant chunk of memory
and keep appending the file name strings to it. Then build a little
tree so that you can look up existing names. i.e. turn the files names
into atoms. Never delete anything.

You can do something similar with the 29 and 36 byte arrays. Alloc two
giant chunks of memory. Append new entries to the end. Maintain a list
of deleted entries for reuse (store the pointer to the next free entry
inside the unused blocks, don't use a separate structure). You have
three things to track, end of used memory, head of free list, end of
allocated memory.

Now there is no malloc overhead on millions of items.

> So what's your worst case number of files and directories in a
> single commit?  And how many branches are we talking about carrying
> around in the backend?

About 100,000 files in the initial change set that builds the repo.
FInal repo has 120,000 files.

There are 1,500 branches. I haven't looked at the svn dump file format
for branches, but I suspect that it sends everything on a branch out
at once and doesn't intersperse it with the trunk commits.


-- 
Jon Smirl
jonsmirl@gmail.com
