From: Rocco Rutte <pdmef@gmx.net>
Subject: mercurial to git
Date: Tue, 6 Mar 2007 21:06:29 +0000
Organization: Berlin University of Technology
Message-ID: <20070306210629.GA42331@peter.daprodeges.fqdn.th-h.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="1yeeQ81UyVL57Vl7"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 06 22:06:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOgrr-0007OS-JI
	for gcvg-git@gmane.org; Tue, 06 Mar 2007 22:06:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932231AbXCFVGf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Mar 2007 16:06:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932272AbXCFVGf
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Mar 2007 16:06:35 -0500
Received: from mail.gmx.net ([213.165.64.20]:35371 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932231AbXCFVGe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2007 16:06:34 -0500
Received: (qmail invoked by alias); 06 Mar 2007 21:06:32 -0000
Received: from cable-62-117-25-74.cust.blue-cable.de (EHLO peter.daprodeges.fqdn.th-h.de) [62.117.25.74]
  by mail.gmx.net (mp043) with SMTP; 06 Mar 2007 22:06:32 +0100
X-Authenticated: #1642131
X-Provags-ID: V01U2FsdGVkX18ox4Nxl2MoJz+X5bGgJmRgXbPDKutMkQadwLK4Oe
	fJCBwb9yTyPIzx
Received: from peter.daprodeges.fqdn.th-h.de (peter [192.168.0.5])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by peter.daprodeges.fqdn.th-h.de (Postfix) with ESMTP id DE57920F0D
	for <git@vger.kernel.org>; Tue,  6 Mar 2007 21:06:30 +0000 (UTC)
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
X-GnuPG-Key: http://user.cs.tu-berlin.de/~pdmef/rrutte.gpg
X-Blog: http://user.cs.tu-berlin.de/~pdmef/horst.cgi?o
X-System: peter.daprodeges.fqdn.th-h.de (FreeBSD 6.2-STABLE i386)
User-Agent: Mutt/1.5.14-pdmef (2007-02-28)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41592>


--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

Hi,

attached are two files of take #1 of writing a hg2git converter/tracker 
using git-fast-import. It basically works so use at your own risk and 
send patches... :)

"Basically" means that it gets tags, branches and merges right (working 
tree md5 sums match after imports). It also means that it is horribly 
slow for the repos I tested it own (only mutt and hg-crew).

The performance bottleneck is hg exporting data, as discovered by people 
on #mercurial, the problem is not really fixable and is due to hg's 
revlog handling. As a result, I needed to let the script feed the full 
contents of the repository at each revision we walk (i.e. all for the 
initial import) into git-fast-import. This is horribly slow. For mutt 
which contains several tags, a handfull of branches and only 5k commits 
this takes roughly two hours at 1 commit/sec. My earlier version not 
using 'deleteall' and feeding only files that changed took 15 minutes 
alltogether, git-fast-import from a textfile 1 min 30 sec.

As I'll use this my for daily work (more or less), I'll think I'll 
"maintain" and keep improving it, so if anyone has comments, critics, 
hints, patches, ...

Somewhat related: It would be really nice to teach git-fast-import to 
init from a previously saved mark file. Right now I use hg revision 
numbers as marks, let git-fast-import save them, and read them back next 
time. These are needed to map hg revisions to git SHA1s in case I need 
to reference something in an incremental import from an earlier run. It 
would be nice if git-fast-import could do this on its own so that all 
consumers can benefit and can have persistent marks accross sessions.

About the attached files: hg2git.py is the worker script using the 
mercurial python package so that no more slow shell or pipes including 
fork are needed for the raw export, hg2git.sh is a convenience shell 
wrapper taking core of the state files for incremental imports.

   bye, Rocco
-- 
:wq!

--1yeeQ81UyVL57Vl7
Content-Type: application/x-sh
Content-Disposition: attachment; filename="hg2git.sh"
Content-Transfer-Encoding: quoted-printable

#!/bin/sh=0A=0AUSAGE=3D'[-m max] repo'=0ALONG_USAGE=3D'Import hg repository=
 <repo> up to either tip or <max>'=0AROOT=3D"`dirname $0`"=0AREPO=3D""=0AMA=
X=3D"-1"=0APFX=3D"hg2git"=0ASFX_MARKS=3D"marks"=0ASFX_HEADS=3D"heads"=0ASFX=
_STATE=3D"state"=0A=0A. git-sh-setup=0Acd_to_toplevel=0A=0Awhile case "$#" =
in 0) break ;; esac=0Ado=0A  case "$1" in=0A    -m)=0A      shift=0A      M=
AX=3D"$1"=0A      ;;=0A    -*)=0A      usage=0A      ;;=0A    *)=0A      br=
eak=0A      ;;=0A  esac=0A  shift=0Adone=0A=0Aif [ "$#" !=3D 1 ] ; then=0A =
 usage=0A  exit 1=0Afi=0A=0AREPO=3D"$1"=0A=0A# make sure we have a marks ca=
che=0Aif [ ! -f "$GIT_DIR/$PFX-$SFX_MARKS" ] ; then=0A  touch "$GIT_DIR/$PF=
X-$SFX_MARKS"=0Afi=0A=0AGIT_DIR=3D"$GIT_DIR" python "$ROOT/hg2git.py" \=0A =
 "$REPO" \=0A  "$MAX" \=0A  "$GIT_DIR/$PFX-$SFX_MARKS" \=0A  "$GIT_DIR/$PFX=
-$SFX_HEADS" \=0A  "$GIT_DIR/$PFX-$SFX_STATE" \=0A| git-fast-import --expor=
t-marks=3D"$GIT_DIR/$PFX-$SFX_MARKS.tmp" \=0A|| die 'Git fast-import failed=
'=0A=0A# move recent marks cache out of the way...=0Aif [ -f "$GIT_DIR/$PFX=
-$SFX_MARKS" ] ; then=0A  mv "$GIT_DIR/$PFX-$SFX_MARKS" "$GIT_DIR/$PFX-$SFX=
_MARKS.old"=0Aelse=0A  touch "$GIT_DIR/$PFX-$SFX_MARKS.old"=0Afi=0A=0A# ...=
to create a new merged one=0Acat "$GIT_DIR/$PFX-$SFX_MARKS.old" "$GIT_DIR/$=
PFX-$SFX_MARKS.tmp" \=0A| uniq > "$GIT_DIR/$PFX-$SFX_MARKS"=0A=0A# cleanup=
=0Arm -rf "$GIT_DIR/$PFX-$SFX_MARKS.old" "$GIT_DIR/$PFX-$SFX_MARKS.tmp"=0A=
=0A# save SHA1s of current heads for incremental imports=0A# and connectivi=
ty (plus sanity checking)=0Afor head in `git branch | sed 's#^..##'` ; do=
=0A  id=3D"`git-rev-parse $head`"=0A  echo ":$head $id"=0Adone > "$GIT_DIR/=
$PFX-$SFX_HEADS"=0A=0A# check diff with color:=0A# ( for i in `find . -type=
 f | grep -v '\.git'` ; do diff -u $i $REPO/$i ; done | cdiff ) | less -r=0A
--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="hg2git.py"
Content-Transfer-Encoding: quoted-printable

#!/usr/bin/env python

# Copyright (c) 2007 Rocco Rutte <pdmef@gmx.net>
# License: GPLv2

"""hg2git.py - A mercurial-to-git filter for git-fast-import(1)
Usage: hg2git.py <hg repo url> <marks file> <heads file> <tip file>
"""

=66rom mercurial import repo,hg,cmdutil,util,ui,revlog
=66rom tempfile import mkstemp
import re
import sys
import os

# silly regex to see if user field has email address
user_re=3Dre.compile('[^<]+ <[^>]+>$')
# git branch for hg's default 'HEAD' branch
cfg_master=3D'master'
# insert 'checkpoint' command after this many commits
cfg_checkpoint_count=3D1000

def usage(ret):
  sys.stderr.write(__doc__)
  return ret

def setup_repo(url):
  myui=3Dui.ui()
  return myui,hg.repository(myui,url)

def get_changeset(ui,repo,revision):
  def get_branch(name):
    if name=3D=3D'HEAD':
      name=3Dcfg_master
    return name
  def fixup_user(user):
    if user_re.match(user)=3D=3DNone:
      if '@' not in user:
        return user+' <none@none>'
      return user+' <'+user+'>'
    return user
  node=3Drepo.lookup(revision)
  (manifest,user,(time,timezone),files,desc,extra)=3Drepo.changelog.read(no=
de)
  tz=3D"%+03d%02d" % (-timezone / 3600, ((-timezone % 3600) / 60))
  branch=3Dget_branch(extra.get('branch','master'))
  return (manifest,fixup_user(user),(time,tz),files,desc,branch,extra)

def gitmode(x):
  return x and '100755' or '100644'

def wr(msg=3D''):
  print msg
  #map(lambda x: sys.stderr.write('\t[%s]\n' % x),msg.split('\n'))

def checkpoint(count):
  count=3Dcount+1
  if count%cfg_checkpoint_count=3D=3D0:
    sys.stderr.write("Checkpoint after %d commits\n" % count)
    wr('checkpoint')
    wr()
  return count

def get_parent_mark(parent,marks):
  p=3Dmarks.get(str(parent),None)
  if p=3D=3DNone:
    # if we didn't see parent previously, assume we saw it in this run
    p=3D':%d' % (parent+1)
  return p

def export_commit(ui,repo,revision,marks,heads,last,max,count):
  sys.stderr.write('Exporting revision %d (tip %d) as [:%d]\n' % (revision,=
max,revision+1))

  (_,user,(time,timezone),files,desc,branch,_)=3Dget_changeset(ui,repo,revi=
sion)
  parents=3Drepo.changelog.parentrevs(revision)

  # we need this later to write out tags
  marks[str(revision)]=3D':%d'%(revision+1)

  wr('commit refs/heads/%s' % branch)
  wr('mark :%d' % (revision+1))
  wr('committer %s %d %s' % (user,time,timezone))
  wr('data %d' % (len(desc)+1)) # wtf?
  wr(desc)
  wr()

  src=3Dheads.get(branch,'')
  link=3D''
  if src!=3D'':
    # if we have a cached head, this is an incremental import: initialize it
    # and kill reference so we won't init it again
    wr('from %s' % src)
    heads[branch]=3D''
  elif not heads.has_key(branch) and revision>0:
    # newly created branch and not the first one: connect to parent
    tmp=3Dget_parent_mark(parents[0],marks)
    wr('from %s' % tmp)
    sys.stderr.write('Link new branch [%s] to parent [%s]\n' %
        (branch,tmp))
    link=3Dtmp # avoid making a merge commit for branch fork

  if parents:
    l=3Dlast.get(branch,revision)
    for p in parents:
      # 1) as this commit implicitely is the child of the most recent
      #    commit of this branch, ignore this parent
      # 2) ignore nonexistent parents
      # 3) merge otherwise
      if p=3D=3Dl or p=3D=3Drevision or p<0:
        continue
      tmp=3Dget_parent_mark(p,marks)
      # if we fork off a branch, don't merge via 'merge' as we have
      # 'from' already above
      if tmp=3D=3Dlink:
        continue
      sys.stderr.write('Merging branch [%s] with parent [%s] from [r%d]\n' %
          (branch,tmp,p))
      wr('merge %s' % tmp)

  last[branch]=3Drevision
  heads[branch]=3D''

  # just wipe the branch clean, all full manifest contents
  wr('deleteall')

  ctx=3Drepo.changectx(str(revision))
  man=3Dctx.manifest()

  #for f in man.keys():
  #  fctx=3Dctx.filectx(f)
  #  d=3Dfctx.data()
  #  wr('M %s inline %s' % (gitmode(man.execf(f)),f))
  #  wr('data %d' % len(d)) # had some trouble with size()
  #  wr(d)

  for fctx in ctx.filectxs():
    f=3Dfctx.path()
    d=3Dfctx.data()
    wr('M %s inline %s' % (gitmode(man.execf(f)),f))
    wr('data %d' % len(d)) # had some trouble with size()
    wr(d)

  wr()
  return checkpoint(count)

def export_tags(ui,repo,cache,count):
  l=3Drepo.tagslist()
  for tag,node in l:
    if tag=3D=3D'tip':
      continue
    rev=3Drepo.changelog.rev(node)
    ref=3Dcache.get(str(rev),None)
    if ref=3D=3DNone:
      sys.stderr.write('Failed to find reference for creating tag'
          ' %s at r%d\n' % (tag,rev))
      continue
    (_,user,(time,timezone),_,desc,branch,_)=3Dget_changeset(ui,repo,rev)
    sys.stderr.write('Exporting tag [%s] at [hg r%d] [git %s]\n' % (tag,rev=
,ref))
    wr('tag %s' % tag)
    wr('from %s' % ref)
    wr('tagger %s %d %s' % (user,time,timezone))
    msg=3D'hg2git created tag %s for hg revision %d on branch %s on (summar=
y):\n\t%s' % (tag,
        rev,branch,desc.split('\n')[0])
    wr('data %d' % (len(msg)+1))
    wr(msg)
    wr()
    count=3Dcheckpoint(count)
  return count

def load_cache(filename):
  cache=3D{}
  if not os.path.exists(filename):
    return cache
  f=3Dopen(filename,'r')
  l=3D0
  for line in f.readlines():
    l+=3D1
    fields=3Dline.split(' ')
    if fields=3D=3DNone or not len(fields)=3D=3D2 or fields[0][0]!=3D':':
      sys.stderr.write('Invalid file format in [%s], line %d\n' % (filename=
,l))
      continue
    # put key:value in cache, key without ^:
    cache[fields[0][1:]]=3Dfields[1].split('\n')[0]
  f.close()
  return cache

def save_cache(filename,cache):
  f=3Dopen(filename,'w+')
  map(lambda x: f.write(':%s %s\n' % (str(x),str(cache.get(x)))),cache.keys=
())
  f.close()

def verify_heads(ui,repo,cache):
  def getsha1(branch):
    f=3Dopen(os.getenv('GIT_DIR','/dev/null')+'/refs/heads/'+branch)
    sha1=3Df.readlines()[0].split('\n')[0]
    f.close()
    return sha1

  for b in cache.keys():
    sys.stderr.write('Verifying branch [%s]\n' % b)
    sha1=3Dgetsha1(b)
    c=3Dcache.get(b)
    if sha1!=3Dc:
      sys.stderr.write('Warning: Branch [%s] modified outside hg2git:'
        '\n%s (repo) !=3D %s (cache)\n' % (b,sha1,c))
  return True

if __name__=3D=3D'__main__':
  if len(sys.argv)!=3D6: sys.exit(usage(1))
  repourl,m,marksfile,headsfile,tipfile=3Dsys.argv[1:]
  _max=3Dint(m)

  marks_cache=3Dload_cache(marksfile)
  heads_cache=3Dload_cache(headsfile)
  state_cache=3Dload_cache(tipfile)

  ui,repo=3Dsetup_repo(repourl)

  if not verify_heads(ui,repo,heads_cache):
    sys.exit(1)

  tip=3Drepo.changelog.count()

  min=3Dint(state_cache.get('tip',0))
  max=3D_max
  if _max<0:
    max=3Dtip

  c=3Dint(state_cache.get('count',0))
  last=3D{}
  for rev in range(min,max):
    c=3Dexport_commit(ui,repo,rev,marks_cache,heads_cache,last,tip,c)

  c=3Dexport_tags(ui,repo,marks_cache,c)

  state_cache['tip']=3Dmax
  state_cache['count']=3Dc
  state_cache['repo']=3Drepourl
  save_cache(tipfile,state_cache)

--1yeeQ81UyVL57Vl7--
