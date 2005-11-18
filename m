From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: [RFC] Applying a graft to a tree and "rippling" the changes through the history
Date: Fri, 18 Nov 2005 09:49:34 +0100
Organization: {M:U} IT Consulting
Message-ID: <pan.2005.11.18.08.49.30.32345@smurf.noris.de>
References: <436E85DA.1080904@michonline.com> <7vll01ut6j.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Fri Nov 18 09:54:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ed1zZ-0000Gz-C3
	for gcvg-git@gmane.org; Fri, 18 Nov 2005 09:53:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030589AbVKRIwv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Nov 2005 03:52:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030590AbVKRIwv
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Nov 2005 03:52:51 -0500
Received: from main.gmane.org ([80.91.229.2]:47808 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1030589AbVKRIwu (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Nov 2005 03:52:50 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Ed1xd-0008AW-95
	for git@vger.kernel.org; Fri, 18 Nov 2005 09:51:09 +0100
Received: from run.smurf.noris.de ([192.109.102.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 18 Nov 2005 09:51:09 +0100
Received: from smurf by run.smurf.noris.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 18 Nov 2005 09:51:09 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: run.smurf.noris.de
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12216>

Hi, Junio C Hamano wrote:

> Ryan Anderson <ryan@michonline.com> writes:
> 
>> I've written a tool that will take a single commit, add it as a parent
>> of another commit, and recreate the history above that second commit in
>> a fully compatible manner.
> 
You're not the only one. My tool is different, however, in that it accepts
a list of old=>new commits. I have used it successfully to re-graft my
changes from a CVS->GIT tree to the corresponding CVS->SVN->GIT tree
(which cannot be identical, because (a) SVN's timestamps are not accurate
enough and (b) SVN's CVS import is more accurate in reproducing CVS
archives than cvsps can be).

> Also another rhetorical, tongue-in-cheek question.  What is your
> plan to ripple the graft through to update signed tags?  ;-)

I'd suggest adding the capability of grafting something onto a tag...


#!/usr/bin/python

# This is a simple script which clones a git subtree to another.

import sys,re,optparse,os,subprocess

parser = optparse.OptionParser("corresponding_file [ old_commit ]", conflict_handler="resolve", description="""\
Transfer a list of commits from one repository to another.

The first argument is a list of SHA1 entries of the form
	old new
It lists which commits are "the same".

old_commit and those of its parents which are not listed in the
corresponding_file are copied, i.e. new commit objects are created.
Their SHA1s are added to the file so that you may repeat the process
with other commits, or run it incrementally.

""")
parser.add_option("-h","--help","-?", action="help",
                    help="Print this help message and exit")
parser.add_option("-v", "--verbose", dest="verbose", action="store_true",
                    help="Report progress")

(options, args) = parser.parse_args()

if len(args) < 1 or len(args) > 3:
	parser.error("requires one to three arguments")


def end(p):
	try:
		retcode = p.wait()
	except OSError,e:
		print >>sys.stderr, "git-rev-list failed:", e
	else:
		if retcode < 0:
			print >>sys.stderr, "git-rev-list was terminated by signal", -retcode
			sys.exit(1)
		elif retcode > 0:
			print >>sys.stderr, "git-rev-list exited with non-zero exit code", retcode
			sys.exit(1)


re_cmt = re.compile(r'\s*#.*')
corr = {}
for l in open(args[0]):
	l = re_cmt.sub("",l).strip()
	if l == "": continue
	try:
		a,b = l.split()
	except ValueError:
		continue
	if len(a) != 40: continue
	if len(b) != 40: continue
	corr[a]=b

corrf=open(args[0],"a")

if len(args) >= 2:
	srctag = args[1]
else:
	srctag = "HEAD"

srcrepo = os.path.curdir

commits=[]
cmd = ["git-rev-list",srctag]
for k in corr.iterkeys():
	cmd.append("^"+k)
if options.verbose:
	print cmd

p=subprocess.Popen(cmd, stdout=subprocess.PIPE)
for l in p.stdout:
	l = l.strip()
	commits.append(l)
end(p)

while len(commits):
	c = commits.pop()
	if c in corr: continue
	if options.verbose:
		print "Processing:",c

	p=subprocess.Popen(["git-cat-file","commit",c], stdout=subprocess.PIPE)
	qf=os.tempnam()
	try:
		q=open(qf,"w")
		nx=False
		for l in p.stdout:
			if nx:
				q.write(l)
				continue
			l = l.strip()
			if l == "":
				nx=True
				q.write("\n")
				continue
			a,b = l.split(" ",1)
			if a == "parent":
				b = corr[b]
			print >>q,a,b
		q.close()
		q=subprocess.Popen(["git-hash-object","-w","-t","commit",qf], stdout=subprocess.PIPE)
		d = q.stdout.read().strip()
		end(q)
	finally:
		os.unlink(qf)
	end(p)
	corr[c] = d
	print >>corrf, c,d
	if options.verbose:
		print c,d,l

# OK, everything is done.
corrf.close()
print d

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
It's not what you know or what you do, it's who you know.
