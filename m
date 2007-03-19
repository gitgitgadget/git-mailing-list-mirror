From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: any info getting a birdview of Git and its test suite?
Date: Mon, 19 Mar 2007 02:31:47 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703190120270.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <3b051c1a0703180043n1dec45by90e5cee3393d2b4d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: F <ff.pptux@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 19 02:32:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HT6jG-0000Zg-5o
	for gcvg-git@gmane.org; Mon, 19 Mar 2007 02:32:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751739AbXCSBbv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Mar 2007 21:31:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932887AbXCSBbv
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Mar 2007 21:31:51 -0400
Received: from mail.gmx.net ([213.165.64.20]:49174 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751661AbXCSBbt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Mar 2007 21:31:49 -0400
Received: (qmail invoked by alias); 19 Mar 2007 01:31:48 -0000
X-Provags-ID: V01U2FsdGVkX1/ga1QOsyLg40Kc/6Z+8VA4zs7LXw2CuoX6DH87Zn
	ElGo+v8Co8NHSy
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <3b051c1a0703180043n1dec45by90e5cee3393d2b4d@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42556>

Hi,

On Sun, 18 Mar 2007, F wrote:

>    As said in the gitwiki page, I'm new to Git and Open Source 
> Development. I just know the basic usage and cannot figure out how one 
> component interacts with each other in a few days. It's hard for me to 
> write a decent plan on how to impove existing test scripts and on 
> writing a new one. So is there any infomation getting a birdview of 
> architecture of Git and its test suite? Or the only way is to read the 
> code?

Okay, I'll have a try at a short HOWTO find out how things are organized 
in Git's source code.

I think a good idea is to look at the contents of the initial commit:
e83c5163316f89bfbde7d9ab23ca2e25604af290

Tip: you can see what files are in there with

$ git show e83c5163316f89bfbde7d9ab23ca2e25604af290:

and look at those files with something like

$ git show e83c5163316f89bfbde7d9ab23ca2e25604af290:cache.h

Be sure to read the README in that revision _after_ you are familiar with 
the terminology (Documentation/glossary.txt should help), since the 
terminology has changed a little since then. For example, we call the 
things "commits" now, which are described in that README as "changesets".

Actually a lot of the structure as it is now can be explained by that 
initial commit.

For example, we do not call it "cache" any more, but "index", however, the 
file is still called "cache.h". (Not much reason to change it now, 
especially since there is no good single name for it anyway, because it is 
basically _the_ header file which is included by _all_ Git C sources).

If you grasp the ideas in that initial commit (and I keep harping on it, 
since it is really _small_ and you can get into it really fast, and it 
will help you recognize things in the much larger code base we have now), 
you should go on skimming cache.h, object.h and commit.h.

By now, you know what the index is (and find the corresponding data 
structures in cache.h), and that there are just a couple of objects 
(blobs, trees, commits and tags) which inherit their common structure from 
"struct object", which is their first member (and thus, you can case e.g. 
(struct object *)commit to achieve the _same_ as &commit->object, i.e. get 
at the object name and flags).

Okay. End of first lesson.

Next step: get familiar with the object naming. Read "SPECIFYING 
REVISIONS" in Documentation/rev-parse.txt. There are quite a few ways to 
name an object (and not only revisions!). All of these are handled in 
sha1_name.c.

This is just to get you into the groove for the most libified part of Git: 
the revision walker.

Basically, the initial version of "git log" was a shell script:

$ git-rev-list --pretty $(git-rev-parse --default HEAD "$@") | \
	LESS=-S ${PAGER:-less}

What does this mean?

git-rev-list is the original version of the revision walker, which 
_always_ printed a list of revisions to stdout. It is still functional, 
and needs to, since most new programs start out as scripts using rev-list.

git-rev-parse is not as important any more; it was only used to filter out 
options that were relevant for the different plumbing commands that were 
called by the script.

Most of what rev-list did is contained in revision.[ch]. It wraps the 
options in a struct named rev_info, which controls how and what revisions 
are walked, and more.

Nowadays, git-log is a builtin, which means that it is _contained_ in the 
command `git`. The source side of a builtin is

- a function called cmd_<bla>, typically defined in builtin-<bla>.c, and 
  declared in builtin.h,

- an entry in the commands[] array in git.c, and

- an entry in BUILTIN_OBJECTS in the Makefile.

Sometimes, more than one builtins are contained in one source file. For 
example, cmd_whatchanged() and cmd_log() both reside in builtin-log.c, 
since they share quite a bit of code. In that case, the commands which are 
_not_ named like the .c file they are defined in have to be listed in 
BUILT_INS in the Makefile.

git-log looks more complicated in C than it does in script, but that 
allows for a much greater flexibility and performance.

End of lesson two.

Lesson three is: study the code. Really, it is the best way to learn about 
the organization of Git (after you know the basic concepts).

So, think about something which you are interested in, say, "how can I 
access a blob just knowing the object name of it?". The first step is to 
find a Git command with which you can do it. In this example, it is either 
"git show" or "git cat-file".

For the sake of clarity, I will stay with cat-file, because it

- is plumbing, and

- was around even in the initial commit (it literally went only through 
  some 20 revisions as cat-file.c, was renamed to builtin-cat-file.c when 
  made a builtin, and then saw less than 10 versions).

So, look into builtin-cat-file.c, search for cmd_cat_file() and look what 
it does.

        git_config(git_default_config);
        if (argc != 3)
                usage("git-cat-file [-t|-s|-e|-p|<type>] <sha1>");
        if (get_sha1(argv[2], sha1))
                die("Not a valid object name %s", argv[2]);

I'll not bore you with obvious details; the only really interesting part 
here is the call to get_sha1(). It tries to interpret argv[2] as an object 
name, and if it refers to an object which is present in the current 
repository, it writes the resulting SHA-1 into the variable "sha1".

Two things are interesting here:

- get_sha1() returns 0 on _success_. This might surprise some new 
  Git hackers, but there is a long tradition in UNIX to return different 
  negative numbers in case of different errors -- and 0 on success.

- the variable "sha1" in the function signature of get_sha1() is "unsigned 
  char *", but is actually expected to be a pointer to "unsigned 
  char[20]". This variable will contain the big endian version of the 
  40-character hex string representation of the SHA-1.

You will see both of these things throughout the code.

Now, for the meat:

        case 0:
                buf = read_object_with_reference(sha1, argv[1], &size, NULL);

This is how you read a blob (actually, not only a blob, but any type of 
object). To know how the function read_object_with_reference() actually 
works, find the source code for it (I usually just something like "git 
grep read_object_with | grep ":[a-z]"" in the git repository), and read 
the source.

To find out how the result can be used, just read on in cmd_cat_file():

        write_or_die(1, buf, size);

Sometimes, you do not know where to look for a feature. I like to search 
through the output of git-log, and then git-show the corresponding commit.

Example: I know that there was some test case for git-bundle, but I do not 
remember where it was (yes, I could "git grep bundle t/", but that does 
not illustrate my point!):

$ git log --no-merges t/

In the pager ("less"), I just search for "bundle", go a few lines back, 
and see that it is in commit 18449ab0... I just copy this object name, and 
paste it into the command line

$ git show 18449ab0

Voila.

Another example: Find out what to do in order to make some script a 
builtin:

$ git log --no-merges --diff-filter=A builtin-*.c

You see, Git is actually the best tool to find out about the source of Git 
itself!

I hope that this gives you a fast track into the organization of Git's 
source code. If not, please feel free to ask questions...

Ciao,
Dscho
