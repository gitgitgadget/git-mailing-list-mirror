From: Shawn Pearce <spearce@spearce.org>
Subject: Re: fast-import and unique objects.
Date: Mon, 7 Aug 2006 23:12:41 -0400
Message-ID: <20060808031240.GB19067@spearce.org>
References: <9e4733910608060532w51fca2c0r8038828df0d41eeb@mail.gmail.com> <9e4733910608060853ua0eabc1w9b35b8414d3c9bae@mail.gmail.com> <20060806180323.GA19120@spearce.org> <9e4733910608062148u4341dabag451c3f49f1a792a1@mail.gmail.com> <20060807050422.GD20514@spearce.org> <9e4733910608070737k52aaea7clf871d716d16547c2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Aug 08 05:12:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GAI1T-0000mr-BQ
	for gcvg-git@gmane.org; Tue, 08 Aug 2006 05:12:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751232AbWHHDMs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 Aug 2006 23:12:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751235AbWHHDMs
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Aug 2006 23:12:48 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:46259 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751232AbWHHDMr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Aug 2006 23:12:47 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GAI1B-00086n-TC; Mon, 07 Aug 2006 23:12:34 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id A3DD020FB77; Mon,  7 Aug 2006 23:12:41 -0400 (EDT)
To: Jon Smirl <jonsmirl@gmail.com>
Content-Disposition: inline
In-Reply-To: <9e4733910608070737k52aaea7clf871d716d16547c2@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25058>

Jon Smirl <jonsmirl@gmail.com> wrote:
> the change sets. That takes about four days to finish. Doing a
> fast-import backend should fix that.

Shouldn't be a problem.  :-)
 
> >Any thoughts yet on how you might want to feed trees and commits
> >to a fast pack writer?  I was thinking about doing a stream into
> >fast-import such as:
> 
> The data I have generates an output that indicates add/change/delete
> for each file name. Add/change should have an associated sha-1 for the
> new revision. cvs/svn have no concept of trees.
> 
> How about sending out a stream of add/change/delete operations
> interspersed with commits? That would let fast-import track the tree
> and only generate tree nodes when they change.
> 
> The protocol may need some thought. I need to be able to handle
> branches and labels too.

Knowing a little bit about SVN I would assume the current cvs2svn
code would issue commands like:

    svn copy A B;   # Make branch B starting from where A is now.
    svn switch B;   # Make branch B the current branch.
    svn add F;      # Add file F.
    svn rm Y;       # Delete file Y.
    svn commit;     # Commit current tree on current branch.
    svn copy A T;   # Create tag T from where A is now.

But I don't know how it would issue a merge commit.  Or even if it
could find such a thing in the RCS files.

The above command set would be rather trivial to implement in a
fast-import backend.  I'm thinking we extend the protocol so it
looks something like the following:

  stream ::= cmd*;

  cmd ::= new_blob
        | new_branch
        | set_branch
        | update
        | commit
        | tag
        ;

  new_blob    ::= 'blob' blob_data;
  new_branch  ::= 'newb' branch_name source_branch;
  set_branch  ::= 'setb' branch_name;
  add_file    ::= update_file;
  update_file ::= 'updf' file_update;
  delete_file ::= 'delf' file_delete;
  commit      ::= 'comt' author_committer_msg;
  tag         ::= 'tagg' branch_name tagger_msg;

  source_branch ::= branch_name
                  | zero32
                  ;
  branch_name ::= len32 branch_name_str;
  branch_name_str ::= # valid GIT branch name, should be relative
                      # to .git/ (so include a refs/heads prefix)
                    ;
  file_update ::= len32 mode sp hexsha1 sp path;
  file_delete ::= len32 path;

  blob_data ::= len32 binary_data;

  author_committer_msg ::= len32
    'author' sp name '<' email '>' ts tz lf
    'committer' sp name '<' email '>' ts tz lf
    lf
    binary_data;

  tagger_msg ::= len32
    'tagger' sp name '<' email '>' ts tz lf
    lf
    binary_data;

  len32 ::= # unsigned 32 bit value, native format;
  zero32 ::= # 32 bits, unset, aka '0';

  mode ::= 'P'    # plain file
         | 'X'    # executable file
         ;

  binary_data ::= # file content, not interpreted;
  sp ::= # ASCII space character;
  lf ::= # ASCII newline (LF) character;
  path ::= # GIT style file path, e.g. "a/b/c";
  hexsha1 ::= # SHA1 in hexadecimal format;
  nullsha1 ::= # 40 '0's in sequence;
  name ::= # valid GIT author/committer name;
  email ::= # valid GIT author/committer email;
  ts ::= # time since the epoch in seconds, ascii decimal;
  tz ::= # GIT style timezone;

This is a change from the current protocol as new blobs need to
get prefixed by the command 'blob'.  Note that all commands are 4
bytes wide and that any variable data portion of a command uses a
"Pascal style" leading 32 bit length.  Although ugly it just makes
it a tiny bit easier to code the stream parser.  :-)

The commits and tags are half generated in the frontend and half
in the backend.  The backend is producing and tracking the tree and
the current SHA1 of each branch.  Consequently it will generate the
'tree' and 'parent' lines of a commit or the 'object', 'type' and
'tag' lines of a tag.  This is limited to only a linear development
path, no merges...

The backend would need to run inside of an existing GIT repository
as it would output all tags and branch heads when it terminates.
(Right now it runs from anywhere.)

I don't know how many branches you would be asking the backend to
hold at once, but I was thinking that the backend would just create
a tree structure in memory when it receives a new_branch command,
and consider one of those to be the current branch when a set_branch
command is issued.  With all branches in memory at once switching
would be very cheap, but if the number of branches is high it could
eat memory like a pig...

Right now I'm thinking that a file entry in a tree would cost:

  29 bytes + length_of_name + malloc_overhead

while a single tree would cost that plus:

  36 bytes + 4*number_of_entries + 2*malloc_overhead + last_treesz

where last_treesz is last content of that tree (uncompressed),
so we can deltify against it quickly.

So what's your worst case number of files and directories in a
single commit?  And how many branches are we talking about carrying
around in the backend?

-- 
Shawn.
