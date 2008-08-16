From: Josh Triplett <josh@freedesktop.org>,
	Jamey Sharp <jamey@minilop.net>
Subject: Re: [RFC] Plumbing-only support for storing object metadata
Date: Fri, 15 Aug 2008 23:21:30 -0700
Message-ID: <20080816062130.GA4554@oh.minilop.net>
References: <20080810145019.GC3955@efreet.light.src> <20080809210733.GA6637@oh.minilop.net> <d411cc4a0808091449n7e0c9b7et7980cf668106aead@mail.gmail.com> <20080810035101.GA22664@spearce.org> <20080810112038.GB30892@cuci.nl> <20080809210733.GA6637@oh.minilop.net> <d411cc4a0808091449n7e0c9b7et7980cf668106aead@mail.gmail.com> <20080810035101.GA22664@spearce.org> <20080809210733.GA6637@oh.minilop.net> <20080810110925.GB3955@efreet.light.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jan Hudec <bulb@ucw.cz>, "Shawn O. Pearce" <spearce@spearce.org>,
	"Stephen R. van den Berg" <srb@cuci.nl>,
	Junio C Hamano <gitster@pobox.com>, david@lang.hm,
	Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 16 08:24:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUFDC-0001EY-Ux
	for gcvg-git-2@gmane.org; Sat, 16 Aug 2008 08:24:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752172AbYHPGWM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Aug 2008 02:22:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752130AbYHPGWM
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Aug 2008 02:22:12 -0400
Received: from svcs.cs.pdx.edu ([131.252.214.11]:56801 "EHLO svcs.cs.pdx.edu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752068AbYHPGWK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Aug 2008 02:22:10 -0400
Received: from jamey by svcs.cs.pdx.edu with local (Exim 4.63)
	(envelope-from <jamey@svcs.cs.pdx.edu>)
	id 1KUFAJ-0006DF-Nc; Fri, 15 Aug 2008 23:21:31 -0700
Content-Disposition: inline
In-Reply-To: <20080811101132.GB31686@cuci.nl> <alpine.DEB.1.10.0808101550570.32620@asgard.lang.hm> <7v7iao1oua.fsf@gitster.siamese.dyndns.org> <20080810201651.GB14237@cuci.nl> <20080810145019.GC3955@efreet.light.src> <20080810112038.GB30892@cuci.nl> <20080810035101.GA22664@spearce.org> <20080810110925.GB3955@efreet.light.src>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92535>

We want to reply to a few of the common points raised in this thread
first, and then we have a few point-by-point replies later in this mail.
In particular, we see two common questions: whether Git should include
support for metadata such as permissions and ownership at all, and
how Git should store this metadata if so.

We agree entirely with Jan Hudec's first point:

On Sun, Aug 10, 2008 at 01:09:25PM +0200, Jan Hudec wrote:
> I am glad you came up with this, as I think this is the only reasonable way
> to support things like etckeeper. The metastore and similar solutions are
> a kludge and fall apart in so many cases.

Metastore, etckeeper, and other existing "hook-based" solutions, which
attempt to handle permissions separately, have several fundamental
problems.  They do not integrate well with the normal Git workflow, they
often have race conditions that can lead to security problems, and they
store working-copy permissions separately from the filesystem
permissions where they can potentially become out of sync.

We want to emphasize that we really don't have a preference amongst the
various reasonable proposals for storing object metadata or for
presenting that metadata in porcelain.  We're happy that our proposal
stimulated discussion on the topic and that we now understand relevant
Git internals much better.  We made our proposal and test case to
demonstrate that we're willing to design and implement a solution, not
just complain that Git does not support permissions.

Among the proposals mentioned in this thread, we see some common
requirements:

- All of the proposals suggest referencing the properties from the tree
  containing the object they apply to, rather than creating an
  extra object to store both hashes together.  We originally thought
  that having a single object reference in the tree would make it easier
  to iterate over the tree, construct each object, and apply its
  permissions.  However, several of the proposals address that in other
  ways.

- Several proposals suggest storing the metadata as a tree object,
  rather than a custom "props" object.  This makes a lot of sense.  It
  allows Git to use existing logic for parsing, reachability
  checking, merging, and checkouts.  On the other hand, we want to
  optimize for the common cases such as POSIX permissions and ownership
  rather than the unusual cases like extended attributes, so it might
  make sense to store all the metadata for a particular object as a
  single blob.

- Several responses expressed concerns about merges and conflicts.  We
  propose implementing support for this in plumbing the same way Git
  does for everything else: put entries into the index with stages
  marked.  This works whether metadata storage uses a tree or a blob.
  Porcelains can choose how to resolve these merges and present
  conflicts to the user for resolution.

- Several proposals suggest using a magic suffix or special mode to
  distinguish object file entries from their metadata entries.  Either
  of these approaches seem fine.  In the case of a suffix, we think it
  makes the most sense to use '/' or "//" in this suffix; any other
  suffix would potentially conflict with legitimate filenames.  "//" has
  the advantage of working unambiguously in the index as well.  Either
  way, any porcelain on top of this could choose a different naming
  scheme for non-"rich" checkouts, or check out the properties as a
  separate top-level directory as Junio proposed.

- Several people complained about our initial proposal of printable
  ASCII for property names and values.  We used this approach solely
  because it seemed like a reasonable starting place.  Length-prefixed
  binary would work fine and provide 8-bit cleanness, as would the
  proposals that store properties as trees of blobs.

On Sun, Aug 10, 2008 at 01:09:25PM +0200, Jan Hudec wrote:
> Advantages (+), disadvantages (-) and possible (*) extensions of 1:
>  
>  + It should be possible to get to something useful with very little changes
>    to git. Basically all it needs to be useful for things like etckeeper is
>    to:
>     . Make sure both clean and smudge filter always get filehandle to the
>       disk file in question (I am /not/ suggesting path as the file may be
>       written in a staging area and moved into place later).
>     . Pass the blob id currently in index to the clean filter, so it can
>       maintain the data if they are not representable in this particular
>       checkout (eg. when checking out such repo on windows). Note, that this
>       would also be useful for ignoring insignificant changes, eg. when
>       a in some config file order is not important and the tool using it
>       randomly changes that order when changing that file.

It might prove possible to implement a reasonable and secure interface
for permissions on top of Git without standardizing the plumbing and
storage formats, true.  With enough specialized hooks, some of the
existing problems with solutions like etckeeper and metastore go away.
However, we feel that most of these solutions will have to deal with the
same problems, such as storage and merging, and the solutions will end
up re-solving problems already handled by Git plumbing.  Those who do
not understand Git's solutions are doomed to re-invent them poorly. :)

On Sat, Aug 09, 2008 at 08:51:01PM -0700, Shawn O. Pearce wrote:
> Nico and I have (at least in the past) agreed that type 0 is meant
> as an escape indicator.  If the type is set to 0 then the real type
> code appears in another byte of data which follows the object's
> inflated length.
>
> That leaves only type 5 available.
[...]
> So yea, there really aren't any new type bits available.

If consensus opinion was that new object types were a reasonable way to
solve this problem, then it sounds as if there's plenty of room to
create new types using this escape mechanism.  As a result we found your
subsequent comments a bit confusing since they seem to say only one more
new object type can exist.

> But tossing aside the type bit argument, I'm not sure I see the
> value in adding limited arbitrary properties to names in a tree.
> How does one edit these?  How do you inspect them before you get
> a checkout, assuming they might actually have an impact on the
> checkout process?  How the hell do you merge them?

Several of those questions depend on the porcelain.  The plumbing
would provide support for adding these properties to the index,
committing them, viewing them, and doing merges in the index.  The
porcelain would handle friendly editing, application to the working
tree, and friendly merges.

> A bad idea that will only clutter up the core object model, and
> the core processing code of that object model.  Extended attributes
> aren't used that much on local filesystems, because they are hard
> to work with and suck performance wise.  Performance in Git is
> a _feature_.  It matters.  Our clean object model really helps to
> make that possible.

If you mean that our proposal seems too general, like extended
attributes, then we can't argue with that. :)  We would have no problem
with a solution that only supported the standard POSIX info found in
"stat" (permissions, ownership, times).  We just felt that such a
specific proposal would not go over well; if consensus points toward a
more specialized solution, that works fine for us too.

We actually proposed the simple name/value storage for props objects
because we primarily cared about the case of small values like
permissions, not large values like arbitrary xattrs.

On Sun, Aug 10, 2008 at 03:34:37PM -0700, Junio C Hamano wrote:
> For merging such "metainfo", you would need to do your "flattish/unrich"
> checkout anyway,

Why not just put entries into the index for each stage as merging
currently does?  You could then compare the metadata in the index with
the filesystem metadata in the "rich" checkout, and resolve the conflict
by adding the desired metadata to the index as stage 0 as usual.  You
would just need some sort of interface like "git add --metadata file" to
add the metadata for file to the index.  Alternatively, you could have
some simple wrappers to directly edit the metadata in the index, much
like the existing "git update-index --chmod" does for the execute bit.

>  * Define a specific leading path, say ".attrs" the hierarchy to store the
>    attributes information.  Attributes to a file README and t/Makefile
>    will be stored in .attrs/README and .attrs/t/Makefile.  They are
>    probably just plain text file you can do your merges and parsing easily
>    but with this counterproposal the only requirement is they are simple
>    plain blobs.  The plumbing layer does not care what payload they carry.

Using a top-level tree to store all of the permissions makes sub-trees
not stand alone; the tree sha1 of a subdirectory doesn't give you enough
information to recreate the metadata for that subdirectory.

>  * When you want to "git setattr $path", the Porcelain mucks with
>    ".attr/$path".  Probably checkout codepath would give you a hook that
>    lets you reflect what ".attr/$path" records to "$path", and checkin
>    (i.e. not commit but update-index) codepath would have another hook to
>    let you grab attributes for "$path" and update ".attr/$path".

This hook would need to provide a way to process these updates before
the blob or tree contents get put into place.  For example, if you check
out /etc/shadow, you need to apply the non-world-readable permissions
*before* you write out the contents.

> So it will most likely boild down to a "Porcelain only" convention that
> different Porcelains would agree on.
> 
> My reaction for the initial proposal was very similar to the one given by
> Shawn.  I do not see much point on having plumbing side support (yet).

We agree in principle that a sufficiently rich set of hooks might make
it possible to implement metadata outside of the Git plumbing.  However,
in practice the set of hooks necessary for complete integration seems
quite large.  Furthermore, implementing these hooks efficiently seems
difficult.  We also don't want to force people to use a non-Git
porcelain just to get support for permissions.  Finally, we think that
along with a common storage format, these porcelains will all have a
common set of problems to solve, and it seems better to solve them once
correctly in Git using code that mostly already exists.

- Josh Triplett and Jamey Sharp
