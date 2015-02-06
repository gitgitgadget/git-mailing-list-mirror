From: Junio C Hamano <gitster@pobox.com>
Subject: [RFH] "diff -B -M"
Date: Fri, 06 Feb 2015 14:08:27 -0800
Message-ID: <xmqqvbjed76s.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 06 23:08:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YJr4q-00026Z-QC
	for gcvg-git-2@plane.gmane.org; Fri, 06 Feb 2015 23:08:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754636AbbBFWIb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Feb 2015 17:08:31 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:64626 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752664AbbBFWIa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Feb 2015 17:08:30 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5A443369AE;
	Fri,  6 Feb 2015 17:08:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=HO2AiklHe6k6HpNZQ8mUbAlHk
	jM=; b=uueIFYupZU94ReKBspCoS6LebvjjmUm0awFZp/X1SVf7C5pwMwJIYR1rn
	dp6vdYYRVPEmcm3MUcIZLbviCTc9J4odlC7D4a3uI8RY8TyID8mrwdreNWAfSQWF
	sp23EuC5rRGOr/nwWmN41TGYnOFYjeY8JRIQXoCoWh2wDq/yAE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=J0Yopxb0D+JuKvau0tf
	v04R4p974+NG1jaslStL2X+TuKFpDfJWdK818hD3Ceh//bU4yrgiWW5adNIl1jkX
	lJGKYMhpql0mxzp+JITuehXUwMDr1951PNcS9Md1yRw/4VTV9BSw1mNynLcDpp1/
	mm8oZXn5Nmk1ixyWbC4E6Vzg=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 50A58369AD;
	Fri,  6 Feb 2015 17:08:29 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9BEE5369AC;
	Fri,  6 Feb 2015 17:08:28 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: ADE9A37A-AE4C-11E4-8D20-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263430>

I've been thinking about "diff -B -M" for quite a while, and I am
finding a few interesting problems we have in our codebase.  Here is
a snapshot, with a few action items.

In this write-up of my current thinking, I'll use these terms:

patchset::
    Output from a single "git diff" invocation, which may contain
    one or more "patch".

patch::
    Part of a "patchset" from a line that begins with "diff --git"
    up to (but excluding) the next line that begins with "diff --git".

tree::
    "diff" compares two collections of files; each collection is a
    "tree".  Left and right sides of the comparison are called "old
    tree" and "new tree", respectively.  The "tree" we attempt to
    apply a patchset is the "target tree".  The "tree" we would get
    after successful application of a patchset is the "resulting
    tree".  A "tree" does not have to be a tree object--we may be
    comparing the index and the files in the working tree, for
    example.

preimage::
postimage::
    Lines in a "patch" that are prefixed by "-" or " " but not "+"
    that denote what the patched file ought to have for the patchset
    to apply ("preimage").  Lines with "+" or " " denote what the
    patch result ought to look like ("postimage").


1. Basics

=46irst the basics.  Let's think about a patchset with a single patch.
What does this patchset tell us?

    diff --git a/major-08.txt b/major-08.txt
    index 680c5f6..5de90cb 100644
    --- a/major-08.txt
    +++ b/major-08.txt
    @@ -1,3 +1,3 @@
    -8. Fortitude.
    +8. Strength.

     This is one of the cardinal virtues, of which I shall speak later.

It obviously tells us that the new tree changed "Fortitude", that
used to be in the old tree, to "Strength", but it actually tells us
a bit more about the old tree.  For this patch to apply, the target
tree must have a file named "major-08.txt" that begins with lines we
see as the preimage in the patch.


2. Renaming a file

Now let's get a bit fancier and study a patchset with a rename
patch, which I invented very early in the Git's life (it was done
while Linus was still running the project).

What does this patchset tell us?

    diff --git rws/major-08.txt marseille/major-11.txt
    similarity index 97%
    rename from major-08.txt
    rename to major-11.txt
    index 680c5f6..2ab22a0 100644
    --- rws/major-08.txt
    +++ marseille/major-11.txt
    @@ -1,3 +1,3 @@
    -8. Fortitude.
    +11. Fortitude.

     This is one of the cardinal virtues, of which I shall speak later.

We can see that this is going from the same old tree as the previous
one's old tree, renames major-08.txt to major-11.txt with slight
modification.  It tells us a lot more about the trees, compared to
the previous example.  For this patchset to apply, the target tree
must satisfy the same preconditon as the previous one about
"major-08.txt", and in addition it must lack "major-11.txt";
otherwise we wouldn't be renaming a new file to it.  Also, it tells
us that the resulting tree must lack "major-08.txt".

So far, these are straight-forward.

In summary:

 rule 1. a patch from file A to file A means file A exists in the
         target tree with contents that match the preimage of the
         patch.  file A will be in the resulting tree.

 rule 2. a patch renaming file A to file B requires that file A
         exists the target tree with contents that match the
         preimage of the patch, and file B does not exist in the
         target tree. file A will not exist in the resulting tree.

 rule 3. a patch that creates file A requires that file A does not exis=
t
         in the target tree.

 rule 4. a patch that deletes file A requires that file A exists in
         the target tree with contents that match the preimage of
         the patch.

The latter two I didn't illustrate with examples, but they should be
obvious.


3. First twist: cross renaming

Now, here is the first twist.  What does this patchset mean?

    diff --git rws/major-11.txt marseille/major-08.txt
    similarity index 99%
    rename from major-11.txt
    rename to major-08.txt
    index 517d9f8..44e8d3a 100644
    --- rws/major-11.txt
    +++ marseille/major-08.txt
    @@ -1,3 +1,3 @@
    -11. Justice.
    +8. La Justice

     That the Tarot, though it is of all reasonable antiquity, is not o=
f
    diff --git rws/major-08.txt marseille/major-11.txt
    similarity index 97%
    rename from major-08.txt
    rename to major-11.txt
    index 5de90cb..a101d5f 100644
    --- rws/major-08.txt
    +++ marseille/major-11.txt
    @@ -1,3 +1,3 @@
    -8. Strength.
    +11. La Force

     This is one of the cardinal virtues, of which I shall speak later.

This is a "swap" patchset, that swaps major-08.txt and major-11.txt
with small edit.  You would have done something like this to prepare
it:

    $ mv major-11.txt tmp
    $ mv major-08.txt major-11.txt
    $ mv tmp major-11.txt
    $ edit major-08.txt major-11.txt ;# just a little
    $ git commit -m swap major-08.txt major-11.txt
    $ git diff -B -M HEAD^

A patch renaming major-11.txt to major-08.txt (i.e. the first one in
this two-patch patchset) still requires that the major-11.txt must
exist in the target tree for the patchset to apply.  But the other
half of the "rename" rule we saw in the summary no longer holds.
The target of the rename, major-08.txt, has to exist in the target
patchset; otherwise we cannot rename it to major-11.txt in the
second patch in the patchset.

So the "renaming" rule needs to be tweaked, like this:

 rule 2. a patch renaming file A to file B requires that file A
         exists and file B does not exist in the target tree, unless
         another patch in the patchset renames file B to some other
         file (possibly but not necessarily file A), in which case
         file B must appear in the target tree.

It is important to have that "unless" part.  We need to make sure
that we do not allow a patchset in "2. Renaming a file" to overwrite
an existing file major-11.txt in the target tree blindly.


4. Second twist: rewriting and copying

The previous one showed how "diff -B -M" can be used to detect cross
renaming files and apply the resulting patchset (you can circularly
rename more than two, i.e. A -> tmp, B -> A, ..., Z -> Y, tmp -> Z).
It can also detect when you did:

    $ cp major-08.txt major-11.txt
    $ edit major-08.txt ;# extensively
    $ git add major-08.txt major-11.txt
    $ git commit -m 'create 11 out of 08, rewrite 08'
    $ git diff -B -M HEAD^

And you would see:

    diff --git a/major-08.txt b/major-08.txt
    dissimilarity index 99%
    index 5de90cb..44e8d3a 100644
    --- a/major-08.txt
    +++ b/major-08.txt
    @@ -1,10 +1,31 @@
    -8. Strength.
    -
    -This is one of the cardinal virtues, of which I shall speak later.
    -...
    -the principle of all force.
    +8. La Justice
    +
    +That the Tarot, though it is of all reasonable antiquity, is not o=
f
    +...
    +via prudenti=C3=A6.
    diff --git a/major-08.txt b/major-11.txt
    similarity index 97%
    copy from major-08.txt
    copy to major-11.txt
    index 5de90cb..a101d5f 100644
    --- a/major-08.txt
    +++ b/major-11.txt
    @@ -1,3 +1,3 @@
    -8. Strength.
    +11. La Force

     This is one of the cardinal virtues, of which I shall speak later.

The first patch in the patchset is "a patch from file A to file A",
even though it is an extensive rewrite.  The target tree is required
to have "major-08.txt" whose contents match the preimage of the
patch (rule 1).  The second patch copies from major-08.txt to create
a new file major-11.txt.  The target tree is required to lack
"major-11.txt" (rule 3; copying into A is creation of A).  It also
must have "major-08.txt" that begins with the preimage of the patch.

So far, all the examples shown above will work correctly with
today's code, and when you use the old tree as the target tree,
"git apply" will apply the patch and recreates "new tree" correctly.

But if you use the new tree of this example as the target tree and
try to "git apply -R" the patchset, it will _NOT_ work correctly.

Currently "git apply -R" does a nonsense.  It just swaps the
preimage and the postimage, and then swaps the names of the files in
the old tree and in the new tree.

But the reverse of "edit major-08 by changing Strength... to La
Justice...; create major-11 by copying major-08 into it and then
change Strength to La Force" is *NOT* "edit major-08 by changing La
Justice... to Strength...; create major-08 by copying major-11 into
it and then change La Force to Strength".  The first part of the
reversion is correct, but the second part is not.

What should we do to "reverse" a patchset that has copies?

Reverse of "create major-11 by copying major-08" should at least be
"remove major-11", and preferrably accompanied by "while making sure
that major-11 matches the postimage of the patch".

The "preferrably" part is a modereatly strong preference.  When the
copying was done without any modification, we would not see any
preimage or postimage to sanity check that the target tree of the
reverse application is similar enough to the new tree the patchset
was taken from (we would end up just checking "major-11 exists" and
then removing it).  Admittedly, the same "it feels unsafe" factor
exists when applying a bog-standard pure rename patch (imagine that
the example in "2. Renaming a file" was done without editing the
first line and kept the original "8. Fortutide." without renumbering
it), but as long as we have patch text that we can use for sanity
checking, we should use it, I would think.

	Action item: somebody look into fixing "apply -R" on a patch
	that creates a new file by copying.  The reverse of "create
	B by copying A" is not "create A by copying B".  It is
	"remove B but make sure B matches the postimage".

        Action item: warn users against using "apply -R" on a
        patchset with such a patch while this is fixed.


5. Third twist: rewriting by copying

If you started from two vastly different files, and did this:

    $ cp major-08.txt major-11.txt
    $ edit major-11.txt
    $ rm major-08.txt
    $ git commit -m 'rewrite 11 by copying 08' major-08.txt major-11.tx=
t
    $ git diff -B -M HEAD^

You would see this patchset:

    diff --git a/major-08.txt b/major-11.txt
    similarity index 97%
    rename from major-08.txt
    rename to major-11.txt
    index 5de90cb..a101d5f 100644
    --- a/major-08.txt
    +++ b/major-11.txt
    @@ -1,3 +1,3 @@
    -8. Strength.
    +11. La Force

     This is one of the cardinal virtues, of which I shall speak later.

This is the potentially buggy behaviour that led me to raise a
warning last week and to look into "diff -B -M".

The revised "rule 2." from "3. First twist" tells us that
"major-08.txt" must exist in the target tree, which is OK, but also
"major-11.txt", the target of the rename, must not exist.  This
makes the resulting patchset unapplicable to the old tree the
patchset was taken from, which is not, eh, ideal.  Also, the reverse
of this patchset would apply to the new tree to produce the old tree
correctly, which is a more serious bug (it can apply the patch in
reverse and recreates the original major-08.txt just fine, but the
other file major-11.txt is lost.  The patchset does not have any
information for us to recreate its original contents of we had in
the old tree.

One possible way to fix this is to include another patch in the same
patchset that shows the deletion of major-11.txt.  The rule 2. would
be further revised to something like:

 rule 2. a patch renaming file A to file B requires that file A
         exists and file B does not exist in the target tree, unless
         another patch in the patchset renames file B to some other
         file (possibly but not necessarily file A) or removed file
         B, in which case file B must appear in the target tree.

Such a patchset would look like this:

    diff --git a/major-08.txt b/major-11.txt
    similarity index 97%
    rename from major-08.txt
    rename to major-11.txt
    index 5de90cb..a101d5f 100644
    --- a/major-08.txt
    +++ b/major-11.txt
    @@ -1,3 +1,3 @@
    -8. Strength.
    +11. La Force

     This is one of the cardinal virtues, of which I shall speak later.
    diff --git a/major-11.txt b/major-11.txt
    deleted file mode 100644
    index 517d9f8..0000000
    --- a/major-11.txt
    +++ /dev/null
    @@ -1,31 +0,0 @@
    -11. Justice.
    -
    -That the Tarot, though it is of all reasonable antiquity, is not o=
f
    -...
    -via prudenti=C3=A6.

And these patches, under the re-revised rule 2. and rule 4., would
apply cleanly to the old tree.

What about the reverse application?  It would be a patchset that
creates major-11.txt from nothingness, and creates major-08.txt by
renaming major-11.txt and editing.  Is the rule 2. re-revised above
sufficient?

    renaming major-11.txt to major-08.txt requires that major-08.txt
    does not exist in the target tree, unless...

and the new tree (which is the target of the reverse application)
only has major-11.txt and not major-08.txt, so this rename should go
through.  The reverse of the deletion of major-11.txt is a creation
of it with the contents fully given as the pre-image of the
(original) patch before reversing it, so that should also be OK with
rule 3.

One disturbing thing about the above plan is that we have this
comment at the end of diffcore-rename.c:

	 * We would output this delete record if:
	 *
	 * (1) this is a broken delete and the counterpart
	 *     broken create remains in the output; or
	 * (2) this is not a broken delete, and rename_dst
	 *     does not have a rename/copy to move p->one->path
	 *     out of existence.
	 *
	 * Otherwise, the counterpart broken create
	 * has been turned into a rename-edit; or
	 * delete did not have a matching create to
	 * begin with.

That is, we have an explicit logic to omit the missing "delete
major-11.txt" patch from the patchset.  This comes from the very
first commit that introduced "diff -B" support (f345b0a0 ([PATCH]
Add -B flag to diff-* brothers., 2005-05-30), iow, it is plausible
that it was the lack of thinking in the original code and not
something we did to fix some bugs that would be introduced if we
"fix" the current issue under discussion.

So tentatively, I would say...

	Action item: do not filter delete-half of the broken pair
	out, even when the other create-half of the pair no longer
	is in the output.

	Action item: update "git apply" to honor the rule 2.
	re-revised above.
