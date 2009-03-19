From: Scott Chacon <schacon@gmail.com>
Subject: Git Large Object Support Proposal
Date: Thu, 19 Mar 2009 15:14:52 -0700
Message-ID: <d411cc4a0903191514n1e524ebava5895d708a2927c4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 19 23:16:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkQXp-0007lp-NI
	for gcvg-git-2@gmane.org; Thu, 19 Mar 2009 23:16:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759509AbZCSWO4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Mar 2009 18:14:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759599AbZCSWOz
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 18:14:55 -0400
Received: from rv-out-0506.google.com ([209.85.198.233]:6484 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759691AbZCSWOy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Mar 2009 18:14:54 -0400
Received: by rv-out-0506.google.com with SMTP id f9so772100rvb.1
        for <git@vger.kernel.org>; Thu, 19 Mar 2009 15:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=DyeIVXHBlikqdrv2PwdKz+1FskiFsn3qRv1sJx4acRU=;
        b=FJ0B6qaVjjwHnpW0NBq3VlZNjVjpyulGRRpFKxL9jzM0QSVxhxwVSFkdpjiWvPDqYP
         MgTtKNIyrTVvDQVVlY3Yzjaa8hti7Dpv2Vw/vfvgbEE/qE47grwb0P3eOkoTp1W28u6W
         RiZLo0fuliuFaxs4M9WKqme/MgTbUn9OPaEsw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=BVm3VY3YEEyBXtw3ziajqOp/kJs7wf3im1HBa6JTfC2ojSrefskJCiOZMWBDnAQ3N3
         EoTCBKuIOcWGxX4id02gcLTdqyIOYrMly6cBCpHjhAJb8Bspmw22iLzMRPDpV09qZWWL
         QZhu8WVhD1muvQGPYimabBKLg1cFQzuLzfsQA=
Received: by 10.141.48.10 with SMTP id a10mr989101rvk.250.1237500892738; Thu, 
	19 Mar 2009 15:14:52 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113849>

I have been thinking about this for a while, so I wanted to get some
feedback. I've been seeing a number of people interested in using Git
for game development and whatnot, or otherwise committing huge files.
This will occasionally wreak some havoc on our servers (GitHub)
because of the memory mapping involved. =C2=A0Thus, we would really lik=
e to
see a nicer way for Git to handle big files.

There are two proposals on the GSoC page to deal with this - the
'remote alternates/lazy clone' idea and the 'sparse/narrow clone'
idea. =C2=A0I'm wondering if instead it might be an interesting idea to
concentrate on the 'stub objects' for large blobs that Jakub was
talking about a few months ago:

http://markmail.org/message/my4kvrhsza2yjmlt

But where Git instead stores a stub object and the large binary object
is pulled in via a separate mechanism. I was thinking that the client
could set a max file size and when a binary object larger than that is
staged, Git instead writes a stub blob like:

=3D=3D
blob [size]\0
[sha of large blob]
=3D=3D

Then in the tree, we give the stubbed large file a special mode or type=
:

=3D=3D
100644 blob 3bb0e8592a41ae3185ee32266c860714980dbed7 README
040000 tree 557b70d2374ae77869711cb583e6d59b8aad5e8b lib
150000 blob 502feb557e2097d38a643e336f722525bc7ea077 big-ass-file.mpeg
=3D=3D

Sort of like a symlink, but instead of the blob it points to
containing the link path, it just contains the SHA of the real blob.
Then we can have a command like 'git media' or something that helps
manage those, pull them down from a specified server (specified in a
=2Egitmedia file) and transfer new ones up before a push is allowed,
etc.  This makes it sort of a cross between a symlink and a submodule.

=3D=3D .git/config
[media]
    push-url =3D [aws/scp/sftp/etc server]
    password =3D [write password]
    token =3D [write token]

=3D=3D .gitmedia
[server]
    pull-url =3D [aws/scp/sftp/etc read only url]

This might be nice because all the objects would be local, so most of
the changes to tools should be rather small - we can't
merge/diff/blame large binary stuff really anyhow, right?  Also, the
really large files could be written and served over protocols that are
better for large file transfer (scp, sftp, etc) - the media server
could be different than the git server.  Then our servers can stop
choking when someone tries to add and push a 2 gig file.

If two users have different settings, one would simply have the stub
and the other not, the 'git media update' could check the local db
first before fetching.  If you change the max-file-size at some point,
the trees would just either stop using the stubs (if you lowered it)
for anything that now fits under the size limit, or start using stubs
for files that are now over it.

The workflow may go something like this:

$ cd git-repo
$ cp ~/huge-file.mpg .
$ git media add s3://chacon-media
# wrote new media server url to .gitmedia
$ git add .
# huge-file.mpg is larger than max-file-size (10M) and will be added
as media (see 'git media')
$ git status
# On branch master
#
# Changes to be committed:
#   (use "git reset HEAD <file>..." to unstage)
#
#	new file:   .gitmedia
#	new media:   huge-file.mpg
#
$ git push
Uploading new media to s3://chacon-media
Uploading media files 100% (5/5), done.
New media uploaded, pushing to Git server
Counting objects: 14, done.
Compressing objects: 100% (9/9), done.
Writing objects: 100% (10/10), 1.04 KiB, done.
Total 10 (delta 4), reused 0 (delta 0)
To git@github.com:schacon/mediaproject.git
 + dbb5d00...9647674 master -> master


On the client side we would have something like this:

$ git clone git://github.com/schacon/mediaproject.git
Initialized empty Git repository in /private/tmp/simplegit/.git/
remote: Counting objects: 270, done.
remote: Compressing objects: 100% (148/148), done.
remote: Total 270 (delta 103), reused 198 (delta 77)
Receiving objects: 100% (270/270), 24.31 KiB, done.
Resolving deltas: 100% (103/103), done.
# You have unfetched media, run 'git media update' to get large media f=
iles
$ git status
# On branch master
#
# Media files to be fetched:
#   (use "git media update <file>..." to fetch)
#
#	unfetched:   huge-file.mpg
#
$ git media update
=46etching media from s3://chacon-media
=46etching media files 100% (1/1), done.


Anyhow, you get the picture.  I would be happy to try to get a proof
of concept of this done, but I wanted to know if there are any serious
objections to this approach to large media.
