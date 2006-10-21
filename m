From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: VCS comparison table
Date: Sat, 21 Oct 2006 10:31:34 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610211007320.3962@g5.osdl.org>
References: <Pine.LNX.4.64.0610172014250.3962@g5.osdl.org>
	<4536EC93.9050305@utoronto.ca>
	<845b6e870610190002u420118b8ud634bb9594572c48@mail.gmail.com>
	<46d6db660610190149x32442596we4112cdd044185a@mail.gmail.com>
	<45373E27.3050209@op5.se> <vpqwt6wsmb5.fsf@ecrins.imag.fr>
	<72877ab10610190757u3d2b4df0o204c6ffd73af69b4@mail.gmail.com>
	<45379A02.1010105@utoronto.ca>
	<72877ab10610192014o3a7f66c6v79f94f48615e08f4@mail.gmail.com>
	<45384B0F.4040901@utoronto.ca>
	<20061021123027.GB29843@artax.karlin.mff.cuni.cz>
	<ehd5u7$c5g$1@sea.gmane.org> <453A513B.1070006@utoronto.ca>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: bazaar-ng@lists.canonical.com, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>
X-From: bazaar-ng-bounces@lists.canonical.com Sat Oct 21 19:31:57 2006
Return-path: <bazaar-ng-bounces@lists.canonical.com>
Envelope-to: gcvbg-bazaar-ng@m.gmane.org
Received: from esperanza.ubuntu.com ([82.211.81.173])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbKhP-0003AN-Un
	for gcvbg-bazaar-ng@m.gmane.org; Sat, 21 Oct 2006 19:31:56 +0200
Received: from localhost ([127.0.0.1] helo=esperanza.ubuntu.com)
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <bazaar-ng-bounces@lists.canonical.com>)
	id 1GbKhE-0004hY-KY; Sat, 21 Oct 2006 18:31:44 +0100
Received: from smtp.osdl.org ([65.172.181.4])
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <torvalds@osdl.org>) id 1GbKh8-0004gc-Vf
	for bazaar-ng@lists.canonical.com; Sat, 21 Oct 2006 18:31:40 +0100
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k9LHVZaX031264
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 21 Oct 2006 10:31:35 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k9LHVYqc028684;
	Sat, 21 Oct 2006 10:31:34 -0700
To: Aaron Bentley <aaron.bentley@utoronto.ca>
In-Reply-To: <453A513B.1070006@utoronto.ca>
X-Spam-Status: No, hits=-0.481 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.95__
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
X-BeenThere: bazaar-ng@lists.canonical.com
X-Mailman-Version: 2.1.8
Precedence: list
List-Id: bazaar-ng discussion <bazaar-ng.lists.canonical.com>
List-Unsubscribe: <https://lists.ubuntu.com/mailman/listinfo/bazaar-ng>,
	<mailto:bazaar-ng-request@lists.canonical.com?subject=unsubscribe>
List-Archive: <https://lists.ubuntu.com/archives/bazaar-ng>
List-Post: <mailto:bazaar-ng@lists.canonical.com>
List-Help: <mailto:bazaar-ng-request@lists.canonical.com?subject=help>
List-Subscribe: <https://lists.ubuntu.com/mailman/listinfo/bazaar-ng>,
	<mailto:bazaar-ng-request@lists.canonical.com?subject=subscribe>
Sender: bazaar-ng-bounces@lists.canonical.com
Errors-To: bazaar-ng-bounces@lists.canonical.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29640>



On Sat, 21 Oct 2006, Aaron Bentley wrote:
> 
> Any SCM worth its salt should support that.  AIUI, that's not what Tim
> wants.  He wants to intermix files from different repos in the same
> directory.
> 
> i.e.
> 
> project/file-1
> project/file-2
> project/.git-1
> project/.git-2

Ok, that's just insane.

It's going to always result in problems (ie some files are going to be 
considered "untracked" depending on which repository you're looking at 
right then and there).

That said, if you _really_ want this, you can do it. Here's now:

	# Create insane repository layout
	mkdir I-am-insane
	cd I-am-insane

	# Tell people we want to work with ".git-1"
	export GIT_DIR=.git-1

	git init-db
	echo "This is file 1 in repo 1" > file-1
	git add file-1
	git commit -m "Silly commit" 

	# Now we switch repos
	export GIT_DIR=.git-2

	git init-db
	echo "This is another file in repo 2" > file-2
	git add file-2
	git commit -m "Silly commit in another repo"

and now you literally have two repositories in the same subdirectory, and 
they don't know about each other, and you can switch your "attention" 
between them by simply doing

	export GIT_DIR=.git-1

(or .git-2). Then you can just do "git diff" etc normally, and work in the 
repo totally ignoring the other one in the same directory structure.

Of course, things like "git status" that show untracked files will always 
then show the "other" repository files as untracked - the two things will 
really be _totally_ independent, they don't at any point know about each 
others files, although they can actually _share_ checked-out files if you 
want to:

	echo "This is a shared file" > file-shared

	export GIT_DIR=.git-1
	git add file-shared
	git commit -m "Add shared file to repo 1"

	export GIT_DIR=.git-2
	git add file-shared
	git commit -m "Add shared file to repo 2"

and now if you change that file, both repositories will see it as being 
changed.

INSANE. And probably totally useless. But you can do it. If you really 
want to.

The git directories don't even have to be in the same subdirectory 
structure. You could have done

	export GIT_DIR=~/insane-git-setup/dir1

instead, and the git information for that thing would have been put in 
that subdirectory.

Note: the above literally creates two different repositories. You can do 
the same thing with a single object repository (so that any actual shared 
data shows up in a shared database) by still using different GIT_DIR 
variables, but using GIT_OBJECT_DIRECTORY to point to a shared database 
directory (which again could be anywhere - it could be under ".git-1", or 
it could be in a separate place in your home directory).

Or you could do it even _more_ differently by actually having just a 
single repository, and having two different branches in that repository, 
and just tracking them separately: in that case you would keep the same 
GIT_DIR/GIT_OBJECT_DIRECTORY (or keep them unset, which just means that 
they default to ".git" and ".git/objects" as normal), and then just switch 
the "index" file and the HEAD files around. That would mean that to switch 
from one "view" to the other, you'd do something like

	export GIT_INDEX_FILE=.git/index1
	git symbolic-ref HEAD refs/heads/branch1

to set your view to "branch1".

Anyway, I would strongly discourage people from actually doing anything 
like this. It should _work_, but quite frankly, if you actually want to do 
this, you have serious mental problems.

What's probably much better is to have two separate development 
repositories, and then perhaps mixing the end _result_ somewhere else. For 
example, you can use the

	git checkout-index -a -f --prefix=/usr/shared/result/

in both (separate) repositories, and you'll end up with basically a 
snapshot of the "union" in /usr/shared/result.

(Not that I see why you'd want to do that _either_, but hey, at least 
you're not going to be _totally_ confused by the end result).

Anyway. Git certainly allows you to do some really insane things. The 
above is just the beginning - it's not even talking about alternate object 
directories where you can share databases _partially_ between two 
otherwise totally independent repositories etc.

			Linus
