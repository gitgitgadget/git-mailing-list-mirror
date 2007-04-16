From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Weird shallow-tree conversion state, and branches of shallow
 trees
Date: Mon, 16 Apr 2007 10:00:04 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704160934050.5473@woody.linux-foundation.org>
References: <20070412005336.GA18378@curie-int.orbis-terrarum.net>
 <fcaeb9bf0704142257x3761ef2cie3996420b3bcd24a@mail.gmail.com>
 <Pine.LNX.4.64.0704151115270.5473@woody.linux-foundation.org>
 <200704152051.35639.andyparkins@gmail.com> <Pine.LNX.4.64.0704151317180.5473@woody.linux-foundation.org>
 <20070416021729.GH2689@curie-int.orbis-terrarum.net> <20070416030103.GB27533@thunk.org>
 <20070416033209.GI2689@curie-int.orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Theodore Tso <tytso@mit.edu>,
	Git Mailing List <git@vger.kernel.org>,
	Andy Parkins <andyparkins@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: "Robin H. Johnson" <robbat2@gentoo.org>
X-From: git-owner@vger.kernel.org Mon Apr 16 19:00:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdUZE-0004c6-FC
	for gcvg-git@gmane.org; Mon, 16 Apr 2007 19:00:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030889AbXDPRAT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Apr 2007 13:00:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030891AbXDPRAT
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Apr 2007 13:00:19 -0400
Received: from smtp.osdl.org ([65.172.181.24]:41625 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030889AbXDPRAQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2007 13:00:16 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l3GH05Is028038
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 16 Apr 2007 10:00:06 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3GH04MZ007372;
	Mon, 16 Apr 2007 10:00:04 -0700
In-Reply-To: <20070416033209.GI2689@curie-int.orbis-terrarum.net>
X-Spam-Status: No, hits=-0.45 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44677>



On Sun, 15 Apr 2007, Robin H. Johnson wrote:
>
> The checksum file (named Manifest) we are talking about is for a single
> subdirectory, and is signed as proof that it was not modified between
> the developer and submission to the tree. 

Well, in git, you can actyally just take the tree entry for that 
subdirectory, and it already is cryptographic proof that two 
subdirectories match.

(It's not signed, but if you actually want to sign it, you can do so, 
either inside git - by using a tag object that points to that 
subdirectory - or outside git by just creating a Manifest that contains a 
list of subdirectories and their tree SHA1's, and signing that).

In fact, in git, there's an explicit command to generate that "Manifest of 
directories in the top level", and it's called

	git ls-tree HEAD

and it will give you cryptographic hashes of each file/directory in the 
top level of a repository. So just sign that, ie do

	git ls-tree HEAD > Manifest
	gpg -sa -u "$username" Manifest 

or something like that. And you're done. Add the "-r" flag to get the 
recursive manifest containing *all* files, rather than just the SHA1's of 
the directories themselves.

Of course, you could just sign and tag the HEAD itself, which is what the 
kernel does, since one signature will guarantee everything under it.

> As I wrote originally, this is the Gentoo distribution tree, it's NOT
> delineated by well-defined releases in the conventional sense.

We do that for the daily (or rather, nightly) snapshots for the kernel. 
There's no "Manifest", but look at

	http://www.kernel.org/pub/linux/kernel/v2.6/snapshots/

and you'll see files like

	patch-2.6.21-rc6-git8.bz2       15-Apr-2007 07:01   38K 	 
	patch-2.6.21-rc6-git8.bz2.sign  15-Apr-2007 07:01  248   
	patch-2.6.21-rc6-git8.gz        15-Apr-2007 07:01   42K  
	patch-2.6.21-rc6-git8.gz.sign   15-Apr-2007 07:01  248   
	patch-2.6.21-rc6-git8.id        15-Apr-2007 07:01   41   
	patch-2.6.21-rc6-git8.log       15-Apr-2007 07:01   63K  
	patch-2.6.21-rc6-git8.sign      15-Apr-2007 07:01  248  

where only the patches are signed, but the system *could* have signed the 
ID file too (the 41-byte "patch-2.6.21-rc6-git8.id" contains the 40-byte 
HEX representation of the SHA of the HEAD of the snapshot, and a newline).

That 41-byte ID file really is sufficient to describe the whole thing, 
after all (although you then need to have the git tree in question to 
actually get the list of files, aka the "Manifest", so if you want that 
list, you'd have to do the "git ls-tree" thing.

> There are presently 11571 Manifest files in the tree. Our tools will
> not allow commits to each package of things that radically break the
> package (semantic correctness and some automatic validation, but thinkos
> can still get through the checks).

Sure. And every single Manifest file is pointless *inside* git, since git 
maintains its own cryptographically secure manifest file anyway. But it's 
trivial to generate them for external use, if you want to.

> The 'release' process for the tree runs automatically every 30 minutes,
> and consists of more validation checks, updating a cache directory,
> producing a signed master Manifest [1] and publishing everything to the
> rsync servers.

That sounds like the nightly snapshots the kernel does, except we only do 
them nightly, and we don't actually validate anythign at all, we just sign 
things as being from the "master.kernel.org" site (so the signature does 
mean something, but only that *that* site thinks it is valid).

> The entire point of the checksums is to allow end users to validate
> content that has been exported, with only minimal tools.

If you do a single 41-byte thing, you could use git itself to validate the 
whole tree. But if you want to have people able to validate any random 
single file in a tar-file without having git installed, you'd have to:

 - have the "full manifest" (aka "git ls-tree -r HEAD")

 - have a trivial script that generates "git ID's" of files, which looks 
   something like this:

	#!/bin/sh
	# generate a "git ID" for one or more files
	while test -n "$1"
	do
		file="$1"
		len=$(stat --format "%s" "$file")
		echo -n " $file (blob $len): "
		# Generate the "git ID" for a blob:
		( echo -e -n "blob $len\0" ; cat "$file") | sha1sum
		shift
	done

and now you can check each file in the Manifest even without having git 
installed.

			Linus
