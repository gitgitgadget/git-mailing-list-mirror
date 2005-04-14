From: Petr Baudis <pasky@ucw.cz>
Subject: Re: Re: Merge with git-pasky II.
Date: Thu, 14 Apr 2005 21:35:07 +0200
Message-ID: <20050414193507.GA22699@pasky.ji.cz>
References: <20050413212546.GA17236@64m.dyndns.org> <20050414004504.GW25711@pasky.ji.cz> <Pine.LNX.4.58.0504132020550.7211@ppc970.osdl.org> <7vfyxtsurd.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0504140051550.7211@ppc970.osdl.org> <7v64ypsqev.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0504140201130.7211@ppc970.osdl.org> <7vvf6pr4oq.fsf@assigned-by-dhcp.cox.net> <20050414121624.GZ25711@pasky.ji.cz> <7vll7lqlbg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 14 21:33:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMA4j-0000au-La
	for gcvg-git@gmane.org; Thu, 14 Apr 2005 21:32:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261603AbVDNTfr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Apr 2005 15:35:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261604AbVDNTfr
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Apr 2005 15:35:47 -0400
Received: from w241.dkm.cz ([62.24.88.241]:714 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261603AbVDNTfJ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Apr 2005 15:35:09 -0400
Received: (qmail 29108 invoked by uid 2001); 14 Apr 2005 19:35:07 -0000
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vll7lqlbg.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Thu, Apr 14, 2005 at 08:12:35PM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> told me that...
> >>>>> "PB" == Petr Baudis <pasky@ucw.cz> writes:
> 
> PB> Bah, you outran me. ;-)
> 
> Just being in a different timezone, I guess.
> 
> PB> I'll change it to use the cool git-pasky stuff (commit-id etc) and its
> PB> style of committing - that is, it will merely record the update-caches
> PB> to be done upon commit, and it will read-tree the branch we are merging
> PB> to instead of the ancestor. (So that git diff gives useful output.)
> 
> Sorry, I have not seen what you have been doing since pasky 0.3,
> and I have not even started to understand the mental model of
> the world your tool is building.  That said, my gut feeling is
> that telling this script about git-pasky's world model might be
> a mistake.  I'd rather see you consider the script as mere "part
> of the plumbing".  Maybe adding an extra parameter to the script
> to let the user explicitly specify the common ancestor to use
> would be needed, but I would prefer git-pasky-merge to do its
> own magic (converting symbolic commit names into raw commit
> names and such) before calling this low level script.
> 
> That way people like me who have not migrated to your framework
> can still keep using it.  All the script currently needs is a
> bare git object database; i.e., nothing other than what is in
> .git/objects and a couple of commit record SHA1s as its
> parameters.  No .git/heads/, no .git/HEAD.local, no .git/tags,
> are involved for it to work, and I would prefer to keep things
> that way if possible.

I see, and I actually agree with it. However, I'll want merge-tree.pl to
do a little less than it does now for that, though. The mechanics in
"kernel" is fine as long as I can control policy in my "userspace". ;-)

BTW, the git* name sorta imply my toilet instead of the core plumbing, and
it'd be more consistent with the current plumbnaming; and could we have
it with the .pl extension, please? :-)

What I would like your script to do is therefore just do the merge in a
given already prepared (including built index) directory, with a passed
base. The base should be determined by a separate tool (I already saw
some patches); most future "science" will probably go to a clever
selection of this base, anyway.

This will give the tool maximal flexibility. E.g., then someone who
wants to can just merge with his working copy (if you don't give
checkout-cache -f - but why would you anyway), or do whatever other
cleverness he wants.

> >> * show-diff updates to add -r flag to squelch diffs for files not in
> >> the working directory.  This is mainly useful when verifying the
> >> result of an automated merge.
..snip..
> was too tired and did not think of a letter when I wrote it.  I
> guess '-r' stood for removed, but I agree it is a bad choice.
> Any objections to '-q'?

None here.

> >> +# Create a temporary directory and go there.
> >> +system 'rm', '-rf', ',,merge-temp';
> 
> PB> Can't we call it just ,,merge?
> 
> I'd rather have a command line option '-o' (scrapping the
> current '-o' and renaming it to something else; as you can see I
> am terrible at picking option names ;-)) to mean "output to this
> directory".  I am not really an Arch person so I do not
> particulary care about /^,,/.  How about "git~merge~$$"?

I'm all for an -o, and I don't mind ,, - I just don't want it uselessly
long. I hope "git~merge~$$" was a joke... :-)

> >> +for ((',,merge-temp', '.git')) { mkdir $_; chdir $_; }
> >> +symlink "../../.git/objects", "objects";
> >> +chdir '..';
> >> +
> >> +my $ancestor_tree = read_commit_tree($common);
> >> +system 'read-tree', $ancestor_tree;
> >> +
> >> +my %tree0 = read_diff_tree($ancestor_tree, read_commit_tree($ARGV[0]));
> >> +my %tree1 = read_diff_tree($ancestor_tree, read_commit_tree($ARGV[1]));
> >> +
> >> +my @ancestor_file = read_show_files();
> >> +my %ancestor_file = map { $_ => 1 } @ancestor_file;
> >> +
> >> +for (@ancestor_file) {
> >> +    if (! exists $tree0{$_} && ! exists $tree1{$_}) {

By the way, what about indentation with tabs? If you have a strong
opinion about this, I don't insist - but if you really don't mind/care
either way, it'd be great to use tabs as in the rest of the git code.

> >> +	if ($full_checkout) {
> >> +	    system 'checkout-cache', $_;
> >> +	}
> >> +	print STDERR "O - $_\n";
> 
> PB> Huh, what are you trying to do here? I think you should just record
> PB> remove, no? (And I wouldn't do anything with my read-tree. ;-)
> 
> At this moment in the script, we have run "read-tree" the
> ancestor so the dircache has the original.  %tree0 and %tree1
> both did not touch the path ($_ here) so it is the same as
> ancestor.  When '-f' is specified we are populating the output
> working tree with the merge result so that is what that
> 'checkout-cache' is about.  "O - $path" means "we took the
> original".

Aha! Thanks.

Is there a fundamental reason why the directory cache contains the
ancestor instead of the destination branch? It makes no sense to me and
I think the script actually does not fundamentally depend on it. My main
motivation is that the user can then trivially see what is he actually
going to commit to his destination branch, which would be bought for
free by that.

> The idea is to populate the dircache of merge-temp with the
> merge result and leave uncertain stuff as in the common ancestor
> state, so that the user can fix them starting from there.

And this is another thing I dislike a lot. I'd like merge-tree.pl to
leave my directory cache alone, thank you very much. You know, I see
what goes to the directory cache as actually part of the policy part.

What you actually do is interfering with my different policy choice,
which is to record stuff to index only at the time of commit (I've asked
about this and noone replied, so I assume it's an ok choice). show-diff
does the right thing for me then, and I don't need to care about losing
*any* information when replacing/rebuilding the index for any reason. I
have full control, and I like that. :-)

I'd be happy with parsing merge-tree.pl output and doing the right thing
on my side. Of course I could then blast away the tediously modified
index with my one, but I didn't need to do any such hacking before and
I'd prefer not to now either.

Actually, the only time I need to do explicit update-cache (with my
policy) when doing git merge is when deleting stuff or adding new stuff;
both of this is not so common as modifying, when I need not to do
anything.

> Maybe it is a good time for me to summarize the output somewhere
> in a document.
> 
>     O - $path	Tree-A and tree-B did not touch this; the result
>                 is taken from the ancestor (O for original).
> 
>     A D $path	Only tree-A (or tree-B) deleted this and the other
>     B D $path   branch did not touch this; the result is to delete.
> 
>     A M $path	Only tree-A (or tree-B) modified this and the other
>     B M $path   branch did not touch this; the result is to use one
>                 from tree-A (or tree-B).  This includes file
>                 creation case.

Could we please have the file creation case separately? Modification
is much more common and creation has pretty different consequences
(especially that it can't combine with anything else :-).

>     *DD $path	Both tree-A and tree-B deleted this; the result
>                 is to delete.
> 
>     *DM $path   Tree-A deleted while tree-B modified this (or
>     *MD $path   vice versa), and manual conflict resolution is
>                 needed; dircache is left as in the ancestor, and
>                 the modified file is saved as $path~A~ in the
>                 working directory.  The user can rename it to $path
>                 and run show-diff to see what Tree-A wanted to do
>                 and decide before running update-cache.
> 
>     *MM $path   Tree-A and tree-B did the exact same
>                 modification; the result is to use that.
> 
>     MRG $path   Tree-A and tree-B have different modifications;
>                 run "merge" and the merge result is left as
>                 $path in the working directory.

Hmm. I actually don't like this naming. I think it's not too consistent,
is irregular, therefore parsing it would be ugly. What I propose:

12c\tname <- legend
          <- original file
D         <- tree #1 removed file
 D        <- tree #2 removed file
DD        <- both trees removed file
M         <- tree #1 modified file
 M
DM*       <- conflict, tree #1 removed file, tree #2 modified file
MD*
MM        <- exact same modification
MM*       <- different modifications, merging

This is generic, theoretically scales well even to more trees, is easy
to parse trivially, still is human readable (actually the asterisk in
the 'conflict' column is there basically only for the humans), is
completely regular and consistent.

Now that we have the notion of tree A and tree B gone, I'd prefer to use
numbers instead of letters for the ~1~ and ~2~ suffixes. Not insisting,
though.

What do you think?

> In cases other than *DM, *MD, and MRG, the result is trivial and
> is recorded in the dircache.  Without '-o' (to be renamed ;-)
> nor '-f' there will not be a file checked out in the working
> directory for them.  The three merge cases need human attention.
> The dircache is not touched in these cases and left as the
> ancestor version, and the working directory gets some file as
> described above.
> 
> NOTE NOTE NOTE: I am not dealing with a case where both branches
> create the same file but with different contents.  In such a
> case the current code falls into MRG path without having a
> common ancestor, which is nonsense---I can use /dev/null as the
> common ancestor, I guess.  Also NOTE NOTE NOTE I need to detect

That might be the best way at least for the start, although I suspect
that merge will fail horribly this way even in the case of slightest
differences; still better than nothing.

> the case where one branch creates a directory while the other
> creates a file.  There is nothing an automated tool can do in
> that case but it needs to be detected and be told the user
> loudly.

Or when both branches create directories... ;-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
