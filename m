From: Jeff King <peff@peff.net>
Subject: Re: Fwd: Git and Large Binaries: A Proposed Solution
Date: Fri, 21 Jan 2011 17:24:42 -0500
Message-ID: <20110121222440.GA1837@sigill.intra.peff.net>
References: <AANLkTin=UySutWLS0Y7OmuvkE=T=+YB8G8aUCxLH=GKa@mail.gmail.com>
 <AANLkTimPua_kz2w33BRPeTtOEWOKDCsJzf0sqxm=db68@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Eric Montellese <emontellese@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 21 23:25:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PgPPs-0005D3-E1
	for gcvg-git-2@lo.gmane.org; Fri, 21 Jan 2011 23:25:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754512Ab1AUWYv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 21 Jan 2011 17:24:51 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:51714 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754384Ab1AUWYu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Jan 2011 17:24:50 -0500
Received: (qmail 21673 invoked by uid 111); 21 Jan 2011 22:24:47 -0000
Received: from 70-36-146-98.dsl.dynamic.sonic.net (HELO sigill.intra.peff.net) (70.36.146.98)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Fri, 21 Jan 2011 22:24:47 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 21 Jan 2011 17:24:42 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTimPua_kz2w33BRPeTtOEWOKDCsJzf0sqxm=db68@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165399>

On Fri, Jan 21, 2011 at 01:57:21PM -0500, Eric Montellese wrote:

> I did a search for this issue before posting, but if I am touching on
> an old topic that already has a solution in progress, I apologize. =C2=
=A0As

It's been talked about a lot, but there is not exactly a solution in
progress. One promising direction is not very different from what you'r=
e
doing, though:

> Solution:
> The short version:
> ***Don't track binaries in git. =C2=A0Track their hashes.***

Yes, exactly. But what your solution lacks, I think, is more integratio=
n
into git. Specifically, using clean/smudge filters you can have git tak=
e
care of tracking the file contents automatically.

At the very simplest, it would look like:

-- >8 --
cat >$HOME/local/bin/huge-clean <<'EOF'
#!/bin/sh

# In an ideal world, we could actually
# access the original file directly instead of
# having to cat it to a new file.
temp=3D"$(git rev-parse --git-dir)"/huge.$$
cat >"$temp"
sha1=3D`sha1sum "$temp" | cut -d' ' -f1`

# now move it to wherever your permanent storage is
# scp "$root/$sha1" host:/path/to/big_storage/$sha1
cp "$temp" /tmp/big_storage/$sha1
rm -f "$temp"

echo $sha1
EOF

cat >$HOME/local/bin/huge-smudge <<'EOF'
#!/bin/sh

# Get sha1 from stored blob via stdin
read sha1

# Now retrieve blob. We could optionally do some caching here.
# ssh host cat /path/to/big/storage/$sha1
cat /tmp/big_storage/$sha1
EOF
-- 8< --

Obviously our storage mechanism (throwing things in /tmp) is simplistic=
,
but obviously you could store and retrieve via ssh, http, s3, or
whatever.

You can try it out like this:

  # set up our filter config and fake storage area
  mkdir /tmp/big_storage
  git config --global filter.huge.clean huge-clean
  git config --global filter.huge.smudge huge-smudge

  # now make a repo, and make sure we mark *.bin files as huge
  mkdir repo && cd repo && git init
  echo '*.bin filter=3Dhuge' >.gitattributes
  git add .gitattributes
  git commit -m 'add attributes'

  # let's do a moderate 20M file
  perl -e 'print "foo\n" for (1 .. 5000000)' >foo.bin
  git add foo.bin
  git commit -m 'add huge file (foo)'

  # and then another revision
  perl -e 'print "bar\n" for (1 .. 5000000)' >foo.bin
  git commit -a -m 'revise huge file (bar)'

Notice that we just add and commit as normal.  And we can check that th=
e
space usage is what you expect:

  $ du -sh repo/.git
  196K    repo/.git
  $ du -sh /tmp/big_storage
  39M     /tmp/big_storage

Diffs obviously are going to be less interesting, as we just see the
hash:

  $ git log --oneline -p foo.bin
  39e549c revise huge file (bar)
  diff --git a/foo.bin b/foo.bin
  index 281fd03..70874bd 100644
  --- a/foo.bin
  +++ b/foo.bin
  @@ -1 +1 @@
  -50a1ee265f4562721346566701fce1d06f54dd9e
  +bbc2f7f191ad398fe3fcb57d885e1feacb4eae4e
  845836e add huge file (foo)
  diff --git a/foo.bin b/foo.bin
  new file mode 100644
  index 0000000..281fd03
  --- /dev/null
  +++ b/foo.bin
  @@ -0,0 +1 @@
  +50a1ee265f4562721346566701fce1d06f54dd9e

but if you wanted to, you could write a custom diff driver that does
something more meaningful with your particular binary format (it would
have to grab from big_storage, though).

Checking out other revisions works without extra action:

  $ head -n 1 foo.bin
  bar
  $ git checkout HEAD^
  HEAD is now at 845836e... add huge file (foo)
  $ head -n 1 foo.bin
  foo

And since you have the filter config in your ~/.gitconfig, clones will
just work:

  $ git clone repo other
  $ du -sh other/.git
  204K    other/.git
  $ du -sh other/foo.bin
  20M

So conceptually it's pretty similar to yours, but the filter integratio=
n
means that git takes care of putting the right files in place at the
right time.

It would probably benefit a lot from caching the large binary files
instead of hitting big_storage all the time. And probably the
putting/getting from storage should be factored out so you can plug in
different storage. And it should all be configurable. Different users o=
f
the same repo might want different caching policies, or to access the
binary assets by different mechanisms or URLs.

> I imagine these features (among others):
>=20
> 1. In my current setup, each large binary file has a different name (=
a
> revision number). =C2=A0This could be easily solved, however, by gene=
rating
> unique names under the hood and tracking this within git.

In the scheme above, we just index by their hash. So you can easily fsc=
k
your big_storage by making sure everything matches its hash (but you
can't know that you have _all_ of the blobs needed unless you
cross-reference with the history).

> 2. A lot of the steps in my current setup are manual. =C2=A0When I wa=
nt to
> add a new binary file, I need to manually create the hash and manuall=
y
> upload the binary to the joint server. =C2=A0If done within git, this=
 would
> be automatic.

I think the scheme above takes care of the manual bits.

> 3. In my setup, all of the binary files are in a single "binrepo"
> directory. =C2=A0If done from within git, we would need a non-kludgey=
 way
> to allow large binaries to exist anywhere within the git tree. =C2=A0=
If git

Any scheme, whether it uses clean/smudge filters or not, should probabl=
y
tie in via gitattributes.

> 4. User option to download all versions of all binaries, or only the
> version necessary for the position on the current branch. =C2=A0If yo=
u want
> to be able to run all versions of the repository when offline, you ca=
n
> download all versions of all binaries. =C2=A0If you don't need to do =
this,
> you can just download the versions you need.  Or perhaps have the
> option to download all binaries smaller than X-bytes, but skip the bi=
g
> ones.

The scheme above will download on an as-needed basis. If caching were
implemented, you could just make the cache infinitely big and do a "git
log -p" which would download everything. :)

Probably you would also want the smudge filter to return "blob not
available" when operating in some kind of offline mode.

> 5. Command to purge all binaries in your "binrepo" that are not neede=
d
> for the current revision (if you're running out of disk space
> locally).

In my scheme, just rm your cache directory (once it exists).

> 6. Automatically upload new versions of files to the "binrepo" (rathe=
r
> than needing to do this manually)

Handled by the clean filter above.


So obviously this is not very complete. And there are a few changes to
git that could make it more efficient (e.g., letting the clean filter
touch the file directly instead of having to make a copy via stdin). Bu=
t
the general idea is there, and it just needs somebody to make a nice
polished script that is configurable, does caching, etc. I'll get to it
eventually, but if you'd like to work on it, be my guest.

-Peff
