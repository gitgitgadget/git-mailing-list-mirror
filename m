From: Luca Barbieri <luca.barbieri@gmail.com>
Subject: Proposal for simplification and impovement of the git model
Date: Sat, 16 Apr 2005 15:35:24 +0200
Message-ID: <4261149C.7030704@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Apr 16 15:32:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMnP6-0005L6-KJ
	for gcvg-git@gmane.org; Sat, 16 Apr 2005 15:32:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262663AbVDPNfo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Apr 2005 09:35:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262664AbVDPNfo
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Apr 2005 09:35:44 -0400
Received: from rproxy.gmail.com ([64.233.170.207]:4303 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262663AbVDPNfZ (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Apr 2005 09:35:25 -0400
Received: by rproxy.gmail.com with SMTP id j1so746162rnf
        for <git@vger.kernel.org>; Sat, 16 Apr 2005 06:35:25 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:user-agent:x-accept-language:mime-version:to:subject:x-enigmail-version:x-enigmail-supports:content-type:content-transfer-encoding;
        b=TRYVzrskK8VWj0pvvNxKn2SWCsbLaI1FHsseBvNACEdg9Ivb2IoX5byHQU2PGOUPXRiZtpxTZD4J21U91mxP5XpxawJVOyik7oF/3bQuK2bNXz4ohHWvESH6MPoTcA9pKOAtlgS5OMmU4tUKKKn1VCoG689S8NRVU6Cit9zIYjc=
Received: by 10.38.92.16 with SMTP id p16mr3630015rnb;
        Sat, 16 Apr 2005 06:35:25 -0700 (PDT)
Received: from ?1.120.145.89? ([213.140.22.73])
        by mx.gmail.com with ESMTP id 64sm586268rna.2005.04.16.06.35.24;
        Sat, 16 Apr 2005 06:35:25 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0.2-1 (X11/20050323)
X-Accept-Language: en-us, en
To: git@vger.kernel.org, torvalds@osdl.org
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

In this message, a method to simplify and at the same time make more
powerful the git abstraction is presented.

I believe that the enhancements I propose make git adhere even more to
its "spirit" and make it more intuitive.

The proposal makes it much easier to build an SCM over git, obtaining in
particular the following advantages:

- Blob and tree objects become symmetric

- Commit objects are removed (their data is put inside tree objects)

- Commit comments are per-file

- A tree in a repository looks like a repository itself, with full
version information (now only the one mentioned in the commit object has
version information)

- File and directory renames are tracked

- Renames are tracked regardless of the way they are made (even with cp
and rm)

- Commit comments can be updated at any time by whoever made the change

- Doing the "blame" operation is trivial

- Minimizing disk space usage (at the expense of speed) by storing diffs
is easily doable



The basic idea is that rather than having single blob or tree revisions
as the base concept, the abstract base unit is the whole set of
modifications, with comments, leading to that state.

Of course, tracking that would be extremely space-inefficient, so we
instead track the current file contents, plus the public key of the
author and the hashes of all parents.


This is implemented with the following changes to git:


- The commit object is removed


- Each tree must have a ".git-commit" file that contains the information
previously in the commit object (only for immediate children, thus
having a ".git-commit" file in each directory), but with the author
public key instead of the comments


- Each blob will be hashed as the blob contents plus an header in a
canonical format that contains data similar to the data in the
".git-commit" file


- When checked out, the blob header is put in a C/C++ comment, a #
comment, or if the file format is unknown, in an extended attribute or a
separate file

An example of a C/C++ file with metadata is the following:

// @parent<SHA1_OF_PARENT1> @parent<SHA1_OF_PARENT2>
// @author<FINGERPRINT_OF_AUTHOR_PUBLIC_KEY>
#include <stdlib.h>

int main(int argc, char** argv)
{
	printf("Hello, world!\n");
	return 0;
}

Note that @parent<> and @author<> in checked out files are NOT the same
of the ones in the repository but are crafted so that there is a single
@parent pointing to the repository file and @author is taken from
$HOME/.gitrc


- When the file is checked in, the header is parsed and removed.

*  If there is a single parent, its header is added and the resulting
buffer is hashed and compared with the parent's hash. If equal, the file
is unchanged and not committed.

* Otherwise, the header data is added in a canonical format and the
buffer is hashed and committed


- A new class of objects is added, that is not named by their hash, but
rather by a public key (or fingerprint of it), a timestamp and a name.

The object is correct if and only if the contents plus name and
timestamp are signed with the private key corresponding to public key in
the name.

Object names are formatted as "<id>/<name>/<args>" where <url> is an
uuid or url that makes the <id>/<name> unique, <name> is the name, and
<args> is additional data.

File names formatted like "git/c/<sha1>" are interpreted as commit
comments for object <sha1>.


- For storage or network transmission purposes, a binary diff against
the parents can be stored instead of the contents af an object. This
will of course require to walk the whole history to rebuild it, but
smarter schemes are possible (e.g. "keyframes", "jump diffs", etc.).

