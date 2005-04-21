From: Denys Duchier <duchier@ps.uni-sb.de>
Subject: Re: [Gnu-arch-users] Re: [GNU-arch-dev] [ANNOUNCEMENT] /Arch/ embraces `git'
Date: Thu, 21 Apr 2005 02:05:22 +0200
Message-ID: <867jixata5.fsf@speedy.lifl.fr>
References: <200504202304.QAA17069@emf.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Cc: gnu-arch-dev@lists.seyza.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 21 02:02:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOP8l-0001VT-NF
	for gcvg-git@gmane.org; Thu, 21 Apr 2005 02:01:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261845AbVDUAGM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Apr 2005 20:06:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261846AbVDUAGM
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Apr 2005 20:06:12 -0400
Received: from uni-sb.de ([134.96.252.33]:62448 "EHLO uni-sb.de")
	by vger.kernel.org with ESMTP id S261845AbVDUAF4 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Apr 2005 20:05:56 -0400
Received: from cs.uni-sb.de (cs.uni-sb.de [134.96.252.31])
	by uni-sb.de (8.13.4/2005033000) with ESMTP id j3L05Uc8013559;
	Thu, 21 Apr 2005 02:05:30 +0200 (CEST)
Received: from mail.cs.uni-sb.de (mail.cs.uni-sb.de [134.96.254.200])
	by cs.uni-sb.de (8.13.4/2005033000) with ESMTP id j3L05Tdo001005;
	Thu, 21 Apr 2005 02:05:30 +0200 (CEST)
Received: from ps.uni-sb.de (grizzly.ps.uni-sb.de [134.96.186.68])
	by mail.cs.uni-sb.de (8.13.4/2005033000) with ESMTP id j3L05SPF021278;
	Thu, 21 Apr 2005 02:05:28 +0200 (CEST)
X-Authentication-Warning: mail.cs.uni-sb.de: Host grizzly.ps.uni-sb.de [134.96.186.68] claimed to be ps.uni-sb.de
Received: from ps.uni-sb.de (localhost [127.0.0.1])
	by ps.uni-sb.de (8.12.10/8.12.10) with ESMTP id j3L05SUd027810;
	Thu, 21 Apr 2005 02:05:28 +0200
Received: from localhost (localhost [[UNIX: localhost]])
	by ps.uni-sb.de (8.12.10/8.12.10/Submit) id j3L05QQm027808;
	Thu, 21 Apr 2005 02:05:26 +0200
To: gnu-arch-users@gnu.org
In-Reply-To: <200504202304.QAA17069@emf.net> (Tom Lord's message of "Wed, 20
	Apr 2005 16:04:00 -0700 (PDT)")
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

--=-=-=

Tom Lord <lord@emf.net> writes:

> Thank you for your experiment.

you are welcome.

> I think that to a large extent you are seeing artifacts
> of the questionable trade-offs that (reports tell me) the
> ext* filesystems make.   With a different filesystem, the 
> results would be very different.

No, this is not the only thing that we observe.  For example, here are the
reports for the following two experiments:

Indexing method = [2]

Max keys at level  0:     256
Max keys at level  1:     108
Total number of dirs:     257
Total number of keys:   21662
Disk footprint      :    1.8M

Indexing method = [4 4]

Max keys at level  0:   18474
Max keys at level  1:       5
Max keys at level  2:       1
Total number of dirs:   40137
Total number of keys:   21662
Disk footprint      :    157M

Notice the huge number of directories in the second experiment and they don't
help at all in performing discrimination.

> I'm imagining a blob database containing may revisions of the linux
> kernel.  It will contain millions of blobs.

It is very easy to write code that uses an adaptive discrimination method
(i.e. when a directory becomes too full, introduce an additional level of
discrimination and rehash).  In fact I have code that does that (rehashing if
the size of a leaf directory exceed 256), but the [2] method above doesn't even
need it even though it has 21662 keys.

Just in case there is some interest, I attach below the python scripts which I
used for my experiments:

To create an indexed archive:

	python build.py SRC DST N1 ... Nk

where SRC is the root directory of the tree to be indexed, and DST names the
root directory of the indexed archive to be created.  N1 through Nk are integers
that each indicate how many chars to chop off the key to create the next level
indexing key.

	python info.py DST

collects and then prints out statistics about an indexed archive.

For example, the invocation that relates to your original proposal would be:

	python build.py /usr/src/linux store 4 4
        python info.py store


--=-=-=
Content-Disposition: attachment; filename=build.py
Content-Description: script to build an indexed archive

import os,os.path,stat,sha

tree      = None
archive   = None
slices    = []
lastslice = (0,-1)

def recurse(path):
    s = os.stat(path)
    if stat.S_ISDIR(s.st_mode):
        print path
        contents = []
        for n in os.listdir(path):
            uid = recurse(os.path.join(path,n))
            contents.append('\t'.join((n,uid)))
        contents = '\n'.join(contents)
        buf = sha.new(contents)
        uid = buf.hexdigest()
        uid = ','.join((uid,str(len(contents))))
        store(uid)
        return uid
    else:
        fd = file(path,"rb")
        contents = fd.read()
        fd.close()
        buf = sha.new(contents)
        uid = ','.join((buf.hexdigest(),str(s.st_size)))
        store(uid)
        return uid

def store(uid):
    p = archive
    if not os.path.exists(p):
        os.mkdir(p)
    for s in slices:
        p = os.path.join(p,uid[s[0]:s[1]])
        if not os.path.exists(p):
            os.mkdir(p)
    p = os.path.join(p,uid[lastslice[0]:lastslice[1]])
    fd = file(p,"wb")
    fd.close()

if __name__ == '__main__':
    import sys
    from optparse import OptionParser
    from types import IntType
    parser = OptionParser(usage="usage: %prog TREE ARCHIVE N1 ... Nk")
    (options, args) = parser.parse_args()
    if len(args) < 3:
        print sys.stderr, "expected at least 3 positional arguments"
        sys.exit(1)
    tree    = args[0]
    archive = args[1]
    prev    = 0
    for a in args[2:]:
        try:
            next = prev+int(a)
            slices.append((prev,next))
            prev = next
        except:
            print >>sys.stderr, "positional argument is not an integer:",a
            sys.exit(1)
    lastslice = (next,-1)
    recurse(tree)
    sys.exit(0)

--=-=-=
Content-Disposition: attachment; filename=info.py
Content-Description: script to print statistics about an indexed archive

import os,os.path,stat

info = []
archive = None
total_keys = 0
total_dirs = 0

def collect_info(path,i):
    global total_dirs,total_keys
    s = os.stat(path)
    if stat.S_ISDIR(s.st_mode):
        total_dirs += 1
        l = os.listdir(path)
        n = len(l)
        if i==len(info):
            info.append(n)
        elif n>info[i]:
            info[i] = n
        i += 1
        for f in l:
            collect_info(os.path.join(path,f),i)
    else:
        total_keys += 1

def print_info():
    i = 0
    for n in info:
        print "Max keys at level %2s: %7s" % (i,n)
        i += 1
    print "Total number of dirs: %7s" % total_dirs
    print "Total number of keys: %7s" % total_keys
    fd = os.popen("du -csh %s" % archive,"r")
    s = fd.read()
    fd.close()
    s = s.split()[0]
    print "Disk footprint      : %7s"  % s

if __name__ == '__main__':
    import sys
    from optparse import OptionParser
    parser = OptionParser(usage="usage: %prog ARCHIVE")
    (options, args) = parser.parse_args()
    if len(args) != 1:
        print sys.stderr, "expected exactly 1 positional argument"
        sys.exit(1)
    archive = args[0]
    collect_info(archive,0)
    print_info()
    sys.exit(0)

--=-=-=


Cheers,

PS: I should mention again, that my indexed archives only contain empty files
because I am only interested in measuring overhead.

-- 
Dr. Denys Duchier - IRI & LIFL - CNRS, Lille, France
AIM: duchierdenys

--=-=-=--
