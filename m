From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Git is not scalable with too many refs/*
Date: Tue, 14 Jun 2011 13:12:07 -0700
Message-ID: <BANLkTi=GZDLu-ey1=h8LLDbWssoSpsM_jd7R-oFr+b+82Otb8g@mail.gmail.com>
References: <BANLkTimnCqaEBVreMhnbRBV3r-r1ZzkFcg@mail.gmail.com>
 <7vtybtm3dl.fsf@alter.siamese.dyndns.org> <BANLkTimNoh3-Jde_-arzwBa=aUR+KK3Xhw@mail.gmail.com>
 <201106141202.46720.johan@herland.net> <20110614170214.GB26764@sigill.intra.peff.net>
 <BANLkTin0CjnM_hMaEpMroZdDhhavaoKAv00_4xBqeHj9biToVA@mail.gmail.com> <20110614194749.GA1567@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johan Herland <johan@herland.net>,
	Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Andreas Ericsson <ae@op5.se>,
	NAKAMURA Takumi <geek4civic@gmail.com>,
	A Large Angry SCM <gitzilla@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 14 22:12:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWZyT-0005NN-QN
	for gcvg-git-2@lo.gmane.org; Tue, 14 Jun 2011 22:12:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752207Ab1FNUM2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Jun 2011 16:12:28 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:33676 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750977Ab1FNUM1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Jun 2011 16:12:27 -0400
Received: by mail-gx0-f174.google.com with SMTP id 21so3689770gxk.19
        for <git@vger.kernel.org>; Tue, 14 Jun 2011 13:12:27 -0700 (PDT)
Received: by 10.146.109.6 with SMTP id h6mr7024147yac.6.1308082347135; Tue, 14
 Jun 2011 13:12:27 -0700 (PDT)
Received: by 10.147.182.11 with HTTP; Tue, 14 Jun 2011 13:12:07 -0700 (PDT)
In-Reply-To: <20110614194749.GA1567@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175796>

On Tue, Jun 14, 2011 at 12:47, Jeff King <peff@peff.net> wrote:
> On Tue, Jun 14, 2011 at 12:20:29PM -0700, Shawn O. Pearce wrote:
>
>> > We would want to store the cache in an on-disk format that could b=
e
>> > searched easily. Possibly something like the packed-refs format wo=
uld be
>> > sufficient, if we mmap'd and binary searched it. It would be dirt =
simple
>> > if we used an existing key/value store like gdbm or tokyocabinet, =
but we
>> > usually try to avoid extra dependencies.
>>
>> Yea, not a bad idea. Use a series of SSTable like things, like Hadoo=
p
>> uses. It doesn't need to be as complex as the Hadoop SSTable concept=
=2E
>> But a simple sorted string to string mapping file that is immutable,
>> with edits applied by creating an overlay file that contains
>> new/updated entries.
>>
>> As you point out, we can use the notes tree to tell us the validity =
of
>> the cache, and do incremental updates. If the current cache doesn't
>> match the notes ref, compute the tree diff between the current cache=
's
>> source tree and the new tree, and create a new SSTable like thing th=
at
>> has the relevant updates as an overlay of the existing tables. After
>> some time you will have many of these little overlay files, and a GC
>> can just merge them down to a single file.
>
> I was really hoping that it would be fast enough that we could simply
> blow away the old mapping and recreate it from scratch. That gets us =
out
> of writing any journaling-type code with overlays. For something like
> svn revisions, it's probably fine to take an extra second or two to
> build the cache after we do a fetch. But it wouldn't scale to somethi=
ng
> that was getting updated frequently.
>
> If we're going to start doing clever database-y things, I'd much rath=
er
> use a proven key/value db solution like tokyocabinet. I'm just not su=
re
> how to degrade gracefully when the db library isn't available. Don't
> allow reverse mappings? Fallback to something slow?

This is why I would prefer to build the solution into Git.

Its not that bad to do a sorted string file. Take something simple
that is similar to a pack file:

  GSST | vers | rcnt | srctree | base
  [ klen key vlen value ]*
  [ roff ]*
  SHA1(all_of_above)

Where vers is a version number, rcnt is the number of records, srctree
is the SHA-1 of the notes tree this thing indexed from, and base is
the SHA-1 of the notes tree this "applies on top of". There are then
rcnt records in the file, each using a variable length key length and
value length field (klen, vlen), with variable length key and values.
At the end of the file are rcnt 4 byte offsets to the start of each
key.

When writing the file, write all of the above to a temporary file,
then rename it to $GIT_DIR/cache/db-$SHA1.db, as its a unique name.
Its easy to prepare the list of entries in memory as an array of
structs of key/value pairs, sort them with qsort(), write them out and
update offsets as you go, then dump out the offset table at the end.
One could compress the offset table by only storing every N offsets,
readers perform binary search until they find the first key that is
before their desired key, then sequentially scan records until they
locate the correct entry... but I'm not sure the space savings is
really worthwhile here.

When reading, scan the directory and read the headers of each file. If
the file has your target srctree, your cache is current and you can
read it. If a key isn't in this file, you open the file named
$GIT_DIR/cache/db-$base.db and try again there, walking back along
that base chain until base is '0'x40. (or some other marker in the
header to denote there is no base file).

GC is just a matter of merging the sorted files together. Follow along
all of the base pointers, open all of them, scan through the records
and write out the first key that is defined. I guess we need a small
"delete" bit in the record to indicate a particular key/value was
removed from the database. Since this is a reverse mapping, duplicates
are possible, and readers that want all values need to scan back to
the base file, but skip base entries that were marked deleted in a
newer file.

Updating is just preparing a new file that uses the current srctree as
your base, and only inserting/sorting the paths that were different in
the notes.

We probably need to store these files keyed by their notes ref, so we
can find "svn/revisions" differently from "bugzilla" (another
hypothetical mapping of Bugzilla bug ids to commit SHA-1s, based on
notes that attached bug numbers to commits).

I don't think its that bad. Maybe its a bit too much complexity for
version 1 to have these incremental update files be supported, but it
shouldn't be that hard.

>> The only problem is, you probably want this "reverse notes index" to
>> be indexing a portion of the note blob text, not all of it. That is,
>> we want the SVN note text to say something like "SVN Revision: r1828=
"
>> so `git log --notes=3Dsvn` shows us something more useful than just
>> "r1828". But in the reverse index, we may only want the key to be
>> "r1828". So you need some sort of small mapping function to decide
>> what to put into that reverse index.
>
> I had assumed that we would just be writing r1828 into the note. The
> output via git log is actually pretty readable:
>
> =A0$ git notes --ref=3Dsvn/revisions add -m r1828
> =A0$ git show --notes=3Dsvn/revisions
> =A0...
> =A0Notes (svn/revisions):
> =A0 =A0 =A0r1828
>
> Of course this is just one use case.

Thanks, I keep forgetting that the notes prints the note ref name out
before the text, so its already got this annotation present. This
makes it much more likely that the bare "r1828" text is acceptable in
the note, and that the reverse index is just the entire content of the
blob as the key.  :-)

> For that matter, we have to figure out how one would actually referen=
ce
> the reverse mapping. If we have a simple, pure-reverse mapping, we ca=
n
> just generate and cache them on the fly, and give a special syntax.
> Like:
>
> =A0$ git log notes/svn/revisions@{revnote:r1828}

Uhm. Ick.

> The syntaxes are not as nice as having a real ref. In the last exampl=
e,
> we could probably look for the contents of "@{}" as a possible revnot=
e
> mapping (since we've already had to name it via the configuration), t=
o
> make it "r1828@{svn}". Or you could even come up with a default set o=
f
> revnotes to consider, so that if we lookup "r1828" and it isn't a rea=
l
> ref, we fall back to trying r1828@{revnote:svn}.

Or, what about setting up a fake ref namespace:

  git config ref.refs/remotes/svn/*.from refs/notes/svn/revisions

Then `git log svn/r1828` works. But these aren't real references. We
would only want to consider them if a request matched the glob, so
`git for-each-ref` and `git upload-pack` aren't reporting these things
by default, and neither is `git log --all` or `gitk --all`.

I agree a syntax that works out of the box without a configuration
file change would be nicer. But we are running out of operators to do
that with. `git log notes/svn/revisions@{revnote:r1828}` as you
propose above is at least workable...

--=20
Shawn.
