From: "Herbert Nachtnebel" <Herbert.Nachtnebel@tuwien.ac.at>
Subject: [RFC] Using GIT techniques to backup and synchronize file systems - replica
Date: Tue, 21 Feb 2006 14:21:19 +0100
Message-ID: <2B5D02300B16934F8F8491F19E7775D52D7A2B@centaurus.agcad.local>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-From: git-owner@vger.kernel.org Tue Feb 21 14:21:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FBXSZ-0003kt-Le
	for gcvg-git@gmane.org; Tue, 21 Feb 2006 14:21:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030261AbWBUNV2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Feb 2006 08:21:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030263AbWBUNV2
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Feb 2006 08:21:28 -0500
Received: from [83.64.124.250] ([83.64.124.250]:8537 "EHLO post.fiss-oeaw.at")
	by vger.kernel.org with ESMTP id S1030261AbWBUNV2 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Feb 2006 08:21:28 -0500
Content-class: urn:content-classes:message
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC] Using GIT techniques to backup and synchronize file systems - replica
Thread-Index: AcY26bP0AdkE+253TUKugH7R5kA99g==
To: <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16529>

Hi,

in the last weeks some ideas were floated here on the list to make git
usable not only for source code tracking, but also for synchronizing
mail storage folders or even complete file systems. Time to throw some
code to the list:

http://members.chello.at/replica/replica-20060220-1.tar.gz

In advance of the description of the code, I want to point out some
interesting properties of git. Git has some similarities with two
distinct application areas: backup and synchronisation. Consider the
object database alone, it contains snapshots in time of the state of the
file system - exactly the same what a backup application does.
Currently, git only holds a subset of the complete meta data of the
files in it's database and should gain some support for directory meta
data, non-regular files, statically linked files, and sparse files. But
then it would be comparable to tar or other backup tools.

Regarding the second point, synchronisation with others is clearly what
git is all about. Furthermore, in contrast to synchronising file systems
like coda, intermezzo and what ever they are called, git's merging tools
are far more sophisticated. In fact too sophisticated for synchronizing
file systems. On file systems merging on the level of files is fully
sufficient and without additional knowledge over the properties and
meaning of the individual files even dangerous! Combining these two
points, it is self-evident that git is more than a source code control
system and folks are looking for ways to use it in other ways.

A little drawback of git sacrifices the portability to other
architectures: the frequent use of scripting languages to implement
important parts of functionality. Of course, for git that's an advantage
since the development is so much faster. But for a porting git to
architectures beside Unix, it's a real problem. I for one would love to
use it to synchronize between Sun, Linux and Windows machines in our
department. Additional, when git is used for synchronizing large
datasets, the scripts may easily become a performance bottleneck. I
realize that it is nearly impossible to change git to not depend on
scripting in the near future but for the application I have in mind, I
would like to solve that; that's the cause I started to playing around
with the code presented above.

Speaking of performance, looking on the index file handling code I
suspect that it is not fast enough to handle really large datasets. For
instance, reading an index file is O(N) since it is reading in each
individual dataset and interprets it then. The same applies to
operations on the index file - a pointer to each dataset is held in a
linear array which must be manipulated when inserting or deleting a
dataset - or writing out the index file. I expect that that could be
improved if the layout of the index file is changed slightly;  each
dataset should have the same size. And as Linus has recently shown, more
speed improvements could be gained if merging is handled directly on
tree files instead of in the index: more evidence to play around with
some code.

But one difference in the usage pattern between the source code version
control and backup/synchronizing requires some basic changes to the git
algorithms which I suspect will not be acceptable and therefore requires
a distinct implementation: when checking in source code, it is known
that the files checked in do not change on disc. In the case of backup
and synchronization such garanties can _not_ be made. Such an
application should be a background task, hence stopping the generation
of new data or altering existing data is generally no option. But it's
interesting that the git techniques are a natural solution to this
problem: the index file together with the object database allows to
split the task needed to synchronize with other sides into three phases.
First, updating the index from the file system and altering the object
database, then merging the _constant_ index file with the other sides
and finally, updating the file system (may be altered in the mean time)
with the updates stored in the index file, but not altering changed data
in the file system. What does this change in git? Only one basic
assumption. The size of blobs are stored in the blob header and in git
it is assumed, that this size is correct. In the backup/synchronization
usage case this can not be held. During reading-in data files into the
object database they may change their size on disk and the header of the
blob may become out of sync. But this should be tolerated.

In summary, using git techniques for backup and synchronisation is an
interesting possibility, if some shortcomings could be solved. First, it
should handle all file types like tar handles them. Second, the merging
tools should be simplified; merging on file level is sufficient: when
conflicts occure tell the user, but don't try to merge automatically.
Third, it would be fine if it would be completely implemented in C to
make it easily portable. Forth, it should handle any amount of data
efficiently and should be able to synchronize arbitrarily contents
between synchronization partners; of course even complete git
repositories (another hint that that what I have in mind should be
realized outside of git).

And there we go, the presented application, replica, tries to realize
the above points. It is ment to be a distributed synchronization tool.
Think of it as a two-way rsync with a permanent state (therefore
minimizing the workload on the servers). What is implemented so far?
Well, not that much: reading in a filesystem into the object database
and generating tree (filenames converted to unicode) and commit objects
and some debugging code. Therefore, synchronization with other sides is
comming next, but I think, you should be made aware about my current
efforts. One difference to git is the index file handling; it may become
interesting also for git itself. I have tried to implement it in a
simple but efficient way. Basically, may version of the index file is
built up of AVL trees with an 1:1 relationship to the directory tree
store on disk. In difference to git, also directory entries representing
subdirectories are held in the index file together with their meta data.
Hence, even empty directories may be handled as expected by the user.

I want to highlight the realisation of the AVL trees. The most
interesting property of them is that they are position independent. One
is able to map the index file into the memory space and then use it
directly without changing any values in it. Hence, reading the index
file and writing it out is essentially O(1); well, neglecting the time
needed to read the contents from disk or writing it out of course. All
AVL tree pointers are not pointers per se, but are realized as offsets
to their neighbors. I think (and hope), this implementation may prove
useful to be used in git also.

Herbert.

PS.: Sorry about this long posting but hopefully, some may find my work
interesting.
