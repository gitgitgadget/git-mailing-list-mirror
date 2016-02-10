From: Shawn Pearce <spearce@spearce.org>
Subject: RFC: Resumable clone based on hybrid "smart" and "dumb" HTTP
Date: Wed, 10 Feb 2016 10:59:42 -0800
Message-ID: <CAJo=hJtHgE_vye_1sPTDsvJ0X=Cs72HKLgRH8btpW-pMrDdk9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 10 20:00:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTZzo-0005my-7W
	for gcvg-git-2@plane.gmane.org; Wed, 10 Feb 2016 20:00:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753175AbcBJTAF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Feb 2016 14:00:05 -0500
Received: from mail-vk0-f53.google.com ([209.85.213.53]:36343 "EHLO
	mail-vk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753108AbcBJTAD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Feb 2016 14:00:03 -0500
Received: by mail-vk0-f53.google.com with SMTP id c3so20402691vkb.3
        for <git@vger.kernel.org>; Wed, 10 Feb 2016 11:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        bh=qxWbBho3oWPhXqkxQrdqUAOEu8P8UBMWfjhp/zpRB+s=;
        b=IhHUNw/jg33NMz7xqj8CZOTqNIP9bgW/2DkeuC7XnWkDrnPswbfi5LEf2QywPvaof4
         gS+Kz7Ch550iE0LrXDoko3s6dXb1hkybis83jG9M8CkGIbnRbJnzynDeQ1k3m0WG/pfM
         wTPiNXW96t5GNaCdWhw76qHfe8FPwkJoxcjzc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-type:content-transfer-encoding;
        bh=qxWbBho3oWPhXqkxQrdqUAOEu8P8UBMWfjhp/zpRB+s=;
        b=nNmqCajFIHIxECsn10oGqDkOKI8ObkbdKb4dmV7qw6NR0tl5c2JLgGsf0ar3aR5t/k
         JYTreT+6bjWT2tq+GXDyMr3Buni8UuAhzKn5hgce5xRoBsVvVHX4kfHTZE8RDBeHqUmY
         1WcI/r7xVvsL9Tzcw4qCiNDV/fwaMJAsSSkgvb4cWPYWQsXD24u7HddtXPYJ0SDlBiWx
         +2a+NUssaEOUTNMXdl/vxpEg2iemkWgMbIbWxsirxPBZ5y6Oln76Oxr55JSKY/Spbuv7
         HaZ30kqTbDrhT+e5Puf1rNOA0WX0VjAZGAolhMlDZL+lA44nPQbRA7u3xl94PmfkrEHv
         2j+g==
X-Gm-Message-State: AG10YOTgGGNdpK5qAm17iyaRtvHacNE+CMqzPz6h2kj7NA5FAdpxkygo7rr0L+qJ/j+BOdNnY5vh1w7of2HI+g==
X-Received: by 10.31.133.19 with SMTP id h19mr31124949vkd.127.1455130802068;
 Wed, 10 Feb 2016 11:00:02 -0800 (PST)
Received: by 10.103.71.211 with HTTP; Wed, 10 Feb 2016 10:59:42 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285921>

Sorry, no code, only words today. Previously people have proposed a
few different options for resumable clone, like "clone.bundle"
(currently used by Android as a hack) or "skip start of regenerated
pack". Here is another option.

We could implement resumable clone by making a bit of a hybrid of the
smart and dumb HTTP protocol.


Overview
--------
During `git gc` break out the refs/heads/* namespace into its own
packfile, and pack the remaining references into an "other" pack file.
This is already done by JGit's DfsGarbageCollector and normal
filesystem based GC, we have many years of experience with this
approach working well.

The GC process saves the roots used for the "head" pack to a new
pack-$HASH.info file, which is written as a sibling to the existing
=2Epack, .idx, and .bitmap files produced by GC. The .info file contain=
s
metadata about the pack in a text format such as:

  pack-name objects/pack/pack-$HASH.pack
  pack-trailer $FOOTER_HASH
  pack-size $LENGTH_IN_BYTES

  ff4ea6004fb48146330d663d64a71e7774f059f9 refs/heads/master
  ced85554d3d871f66dc4442631320a96a5d702f5 refs/heads/next

Ideally $HASH =3D $FOOTER_HASH here so that any repack with the same
object set but different compression settings yields a different
pack-name in the info file.


During `git clone` HTTP clients first fetch:

  https://host/repo/info/clone

This returns the most recent pack-*.info file available in the
repository, assuming the client has read permission on all branches
contained in the info file. If there is no info file present or the
client has read restrictions that requires eliding content, the URL
404s. On 404 the client tries a normal smart HTTP ref advertisement
(/info/refs?service=3Dgit-upload-pack).

With the info file in hand the client writes this to a temporary file
under $GIT_DIR and then uses dumb HTTP byte range requests to download
the pack identified by pack-name:

  https://host/repo/$pack-name
aka
  https://host/repo/objects/pack/pack-$HASH.pack

Smart HTTP servers that have info/clone support will need to return
this pack as-is to clients, if the client still has read permission
over all branches in the associated pack-*.info file.

Clients store the file data locally and check the last 20 bytes
matches $FOOTER_HASH from the info file before running git-index-pack
to verify the contents and build the local .idx file. If the footer
hash does not match or any resume attempt for the pack-name URL fails,
the client deletes everything and starts over from the beginning.


Post Clone Fetch
----------------
After the pack file is downloaded and indexed the client creates local
tracking references matching the info file it obtained at the start.
Once the references are created the client issues a standard `git
fetch` with the origin server to become current.

Since the client is working off the server=E2=80=99s last GC pack, the =
client
will be very close to the server, and the final fetch will be very
small, however this depends on the frequency of the server=E2=80=99s GC=
s. With
a volume based GC trigger such as `git gc` in a post-receive hook,
clients will be very close to the server after this clone.


Redirects
---------
Clients should follow HTTP redirects, allowing servers to position
both the info/clone file and the pack-name on CDNs. Clients should not
remember the redirected locations and instead always use the base
repository URL during resume. This allows servers to embed short-lived
authentication tokens into the redirect URL for processing at the edge
CDN.


Parallel Download
-----------------
Servers may optionally include a header indicating they are willing to
perform parallel download of a file iff the client is well connected:

  parallel-download 5 8388608

in the header of the info/clone file indicates the server will allow
clients to send up to 5 parallel byte-range requests on 8 MiB
alignments.

Clients should start 1 HTTP download, track incoming bandwidth, then
add a parallel download for a later segment of the file. If bandwidth
increases with the additional stream, clients may try adding a 3rd
stream, etc. until the maximum of 5 streams is reached.


Racing with GC
--------------
Servers may choose to keep a pack file around several hours after GC
to permit clients to continue to resume and download a repository they
started cloning before the GC began.

By sending the most recent pack-*.info file to new clients, servers
can choose to keep older packs on disk for a time window (e.g. 4
hours) that older sessions can continue to retrieve before the file is
unlinked from the filesystem and its disk is reclaimed.

This is an optional service that is subject to disk constraints on the
server. Unlike clone.bundle, the server does not need 2x disk capacity
for all repositories; the additional disk required depends on GC rate
and size of repositories.


End user experience
-------------------
=46rom the end-user side experience, I think we want the following to h=
appen:

1. When initiating a `git clone`, the user does not have to do anything=
 special.

2. A `git clone` eventually calls into the transport layer, and
git-remote-curl will probe for the info/clone URL; if the resource
fails to load, everything goes through the traditional codepath.

3. When git-remote-curl detects the support of dumb clone, it does the
"retry until successfully download the pack data fully" dance
internally, tentatively updates the remote tracking refs, and then
pretends as if it was asked to do an incremental fetch. If this
succeeds without any die(), everybody is happy.

4. If the above step 3. has to die() for some reason (including
impatience hitting ^C), leave the $GIT_DIR, downloaded .info file and
partially downloaded .pack file. Tell the user that the cloning can be
resumed and how.

5. `git clone --resume` would take the leftover $GIT_DIR and friends
from step 4. `git clone --resume`, when it is given a $GIT_DIR that
lacks .info, will refuse to start. When `--resume` is given, there is
no other option acceptable (perhaps other than naming which $GIT_DIR
the partial result lives).


=2E.. Thoughts?
