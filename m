From: Junio C Hamano <junkio@cox.net>
Subject: Re: Merge with git-pasky II.
Date: Thu, 14 Apr 2005 11:12:35 -0700
Message-ID: <7vll7lqlbg.fsf@assigned-by-dhcp.cox.net>
References: <20050414002902.GU25711@pasky.ji.cz>
	<20050413212546.GA17236@64m.dyndns.org>
	<20050414004504.GW25711@pasky.ji.cz>
	<Pine.LNX.4.58.0504132020550.7211@ppc970.osdl.org>
	<7vfyxtsurd.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0504140051550.7211@ppc970.osdl.org>
	<7v64ypsqev.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0504140201130.7211@ppc970.osdl.org>
	<7vvf6pr4oq.fsf@assigned-by-dhcp.cox.net>
	<20050414121624.GZ25711@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 14 20:12:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DM8p3-0004dt-8i
	for gcvg-git@gmane.org; Thu, 14 Apr 2005 20:12:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261598AbVDNSO5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Apr 2005 14:14:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261152AbVDNSOO
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Apr 2005 14:14:14 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:49133 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S261588AbVDNSMk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2005 14:12:40 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050414181237.YMUH22013.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 14 Apr 2005 14:12:37 -0400
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050414121624.GZ25711@pasky.ji.cz> (Petr Baudis's message of
 "Thu, 14 Apr 2005 14:16:24 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "PB" == Petr Baudis <pasky@ucw.cz> writes:

PB> Bah, you outran me. ;-)

Just being in a different timezone, I guess.

PB> I'll change it to use the cool git-pasky stuff (commit-id etc) and its
PB> style of committing - that is, it will merely record the update-caches
PB> to be done upon commit, and it will read-tree the branch we are merging
PB> to instead of the ancestor. (So that git diff gives useful output.)

Sorry, I have not seen what you have been doing since pasky 0.3,
and I have not even started to understand the mental model of
the world your tool is building.  That said, my gut feeling is
that telling this script about git-pasky's world model might be
a mistake.  I'd rather see you consider the script as mere "part
of the plumbing".  Maybe adding an extra parameter to the script
to let the user explicitly specify the common ancestor to use
would be needed, but I would prefer git-pasky-merge to do its
own magic (converting symbolic commit names into raw commit
names and such) before calling this low level script.

That way people like me who have not migrated to your framework
can still keep using it.  All the script currently needs is a
bare git object database; i.e., nothing other than what is in
.git/objects and a couple of commit record SHA1s as its
parameters.  No .git/heads/, no .git/HEAD.local, no .git/tags,
are involved for it to work, and I would prefer to keep things
that way if possible.

>> * show-diff updates to add -r flag to squelch diffs for files not in
>> the working directory.  This is mainly useful when verifying the
>> result of an automated merge.

PB> -r traditionally means recursive - what's the reasoning behind the
PB> choice of this letter?

Well, '-r' is not necessarily recursive. "ls -r" is reverse, "sort
-r" is reverse.  "less -r" is raw.  "cat -r" is reversible.
"nethack -r" is race ;-).  You are thinking as an SCM person so
it may look that way.  "diff -r" is recursive.  "darcs add -r"
is recursive.  But even in the SCM world, "cvs add -r" is not
(it means read-only) neither "co -r" (explicit revision) ;-).

I would rather pick '-q' if I were doing the patch today, but I
was too tired and did not think of a letter when I wrote it.  I
guess '-r' stood for removed, but I agree it is a bad choice.
Any objections to '-q'?

PB> use strict?

Not in this iteration but eventually yes.

PB> It'd be simpler to do just

PB> 	my @common = (map { $common{$_} }
PB> 	              sort { $b <=> $a }
PB> 	              keys %common)

Well, actually you spotted a bug between the implementation and
what I wanted to do.  It should have been:

map { $_->[0] }
    sort { $b->[1] <=> $a->[1] }
        map { [ $common{$_} => $_ ] } keys %common

That is, sort [anscestor => number of times it appears] tuple by
the "number of times it appears" in decreasing order, and
project the resulting list to a list of ancestors.  It is trying
to deal with the following pattern in rev-tree output:

TIMESTAMP1 EDGE1:1 ANCESTOR1:3 ANCESTOR2:3
TIMESTAMP2 EDGE2:2 ANCESTOR1:3

and when the above happens I wanted to pick up ANCESTOR1, but
that was without no sound reason.

PB> But I really think this is a horrible heuristic. I believe you should
PB> take the latest commit in the --edges output, and from that choose the
PB> base whose rev-tree --edges the_base merged_branch has the least lines
PB> on output. (That is, the path to it is shortest - ideally it's already
PB> part of the merged_branch.)

I'll try something along that line.  Honestly the ancestor
selection part was what I had most trouble with.  Thanks.

PB> What about

PB> sub OLDMODE { 0 }
PB> sub NEWMODE { 1 }
PB> sub NEWSHA { 2 }

PB> and then using that when accessing the tuple? Would make the code
PB> much more readable.

Totally agreed; readability cleanup is needed, just as "use
strict" you mentioned, before it is ready for public
consumption.  Remember, however, the primary purpose of the
message was to share it with Linus so that I can ask his opinion
while the script was still slushy; the contents that array
contained was still changing then and was too early for symbolic
constants.  I'll do that in the next round.

PB> It is a good idea to check merge's exit code and give a notice at the
PB> end if there were any conflicts.

In principle yes, but I noticed that merge already gave me a
nice warning message when it found conflicts, so there was no
need to do so myself in this case.  See sample output:

    $ perl ./git-merge.perl \
        71796686221a0a56ccc25b02386ed8ea648da14d \
        bb95843a5a0f397270819462812735ee29796fb4 
    Common ancestor: 9f02d4d233223462d3f6217b5837b786e6286ba4
    O - COPYING
    O - README
    ...
    O - write-tree.c
    A M write-blob.c
    A M show-diff.c
    ...
    A M update-cache.c
    A M git-merge.perl
    B M merge-tree.c
    MRG Makefile
    merge: warning: conflicts during merge
    $ 

>> +# Create a temporary directory and go there.
>> +system 'rm', '-rf', ',,merge-temp';

PB> Can't we call it just ,,merge?

I'd rather have a command line option '-o' (scrapping the
current '-o' and renaming it to something else; as you can see I
am terrible at picking option names ;-)) to mean "output to this
directory".  I am not really an Arch person so I do not
particulary care about /^,,/.  How about "git~merge~$$"?

>> +for ((',,merge-temp', '.git')) { mkdir $_; chdir $_; }
>> +symlink "../../.git/objects", "objects";
>> +chdir '..';
>> +
>> +my $ancestor_tree = read_commit_tree($common);
>> +system 'read-tree', $ancestor_tree;
>> +
>> +my %tree0 = read_diff_tree($ancestor_tree, read_commit_tree($ARGV[0]));
>> +my %tree1 = read_diff_tree($ancestor_tree, read_commit_tree($ARGV[1]));
>> +
>> +my @ancestor_file = read_show_files();
>> +my %ancestor_file = map { $_ => 1 } @ancestor_file;
>> +
>> +for (@ancestor_file) {
>> +    if (! exists $tree0{$_} && ! exists $tree1{$_}) {
>> +	if ($full_checkout) {
>> +	    system 'checkout-cache', $_;
>> +	}
>> +	print STDERR "O - $_\n";

PB> Huh, what are you trying to do here? I think you should just record
PB> remove, no? (And I wouldn't do anything with my read-tree. ;-)

At this moment in the script, we have run "read-tree" the
ancestor so the dircache has the original.  %tree0 and %tree1
both did not touch the path ($_ here) so it is the same as
ancestor.  When '-f' is specified we are populating the output
working tree with the merge result so that is what that
'checkout-cache' is about.  "O - $path" means "we took the
original".

The idea is to populate the dircache of merge-temp with the
merge result and leave uncertain stuff as in the common ancestor
state, so that the user can fix them starting from there.

Maybe it is a good time for me to summarize the output somewhere
in a document.

    O - $path	Tree-A and tree-B did not touch this; the result
                is taken from the ancestor (O for original).

    A D $path	Only tree-A (or tree-B) deleted this and the other
    B D $path   branch did not touch this; the result is to delete.

    A M $path	Only tree-A (or tree-B) modified this and the other
    B M $path   branch did not touch this; the result is to use one
                from tree-A (or tree-B).  This includes file
                creation case.

    *DD $path	Both tree-A and tree-B deleted this; the result
                is to delete.

    *DM $path   Tree-A deleted while tree-B modified this (or
    *MD $path   vice versa), and manual conflict resolution is
                needed; dircache is left as in the ancestor, and
                the modified file is saved as $path~A~ in the
                working directory.  The user can rename it to $path
                and run show-diff to see what Tree-A wanted to do
                and decide before running update-cache.

    *MM $path   Tree-A and tree-B did the exact same
                modification; the result is to use that.

    MRG $path   Tree-A and tree-B have different modifications;
                run "merge" and the merge result is left as
                $path in the working directory.

In cases other than *DM, *MD, and MRG, the result is trivial and
is recorded in the dircache.  Without '-o' (to be renamed ;-)
nor '-f' there will not be a file checked out in the working
directory for them.  The three merge cases need human attention.
The dircache is not touched in these cases and left as the
ancestor version, and the working directory gets some file as
described above.

NOTE NOTE NOTE: I am not dealing with a case where both branches
create the same file but with different contents.  In such a
case the current code falls into MRG path without having a
common ancestor, which is nonsense---I can use /dev/null as the
common ancestor, I guess.  Also NOTE NOTE NOTE I need to detect
the case where one branch creates a directory while the other
creates a file.  There is nothing an automated tool can do in
that case but it needs to be detected and be told the user
loudly.

