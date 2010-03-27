From: Eric Raymond <esr@thyrsus.com>
Subject: CIA hook for contrib/
Date: Sat, 27 Mar 2010 06:26:32 -0400
Organization: Eric Conspiracy Secret Labs
Message-ID: <20100327102632.GA5043@thyrsus.com>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="vtzGhvizbBRQ85DL"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 27 11:26:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvTE0-0001Gv-S7
	for gcvg-git-2@lo.gmane.org; Sat, 27 Mar 2010 11:26:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752097Ab0C0K0f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Mar 2010 06:26:35 -0400
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:37378
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751878Ab0C0K0d (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Mar 2010 06:26:33 -0400
Received: by snark.thyrsus.com (Postfix, from userid 23)
	id DC5D9475FEF; Sat, 27 Mar 2010 06:26:32 -0400 (EDT)
Content-Disposition: inline
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143325>


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Summary:
* The CIA hooks for git are presently dusty and somewhat broken.
* I am requesting that they be given a home in git contrib/.
* I am supplying working, updated versions.
* I will accept maintainance responsibility if required.

Many listmembers will be aware of CIA.vc, a useful service that echoes
commits from open-source projects to IRC channels and maintains
various interesting statistics on commit activity.  Under git, it is
supported by one of two hook scripts: ciabot.pl and ciabot.pl.

In the course of migrating the GPSD project from Subversion to git, I
discovered that the 2006 version of ciabot.sh available from CIA.vc is
broken.  It requires, but does not have, a PATH adjustment to cope
with the fact that various git tools it uses now go in a commands
directory private to git.  The 2008 version of ciabot.sh made
available on the git wiki also has no PATH adjustment.

Upon investigating further, I find that ciabot.sh seems to be a
derivative of ciabot.pl, which is a dangling bit of the moribund
Cogito project.  I have been unable to get responses from the authors
of either ciabot.sh or ciabot.pl.

A fixed and working version in shell is enclosed.  It has some advantages
over the 2006 and 2008 versions:

* It uses only POSIX features.  Thus, it will work with Debian/Ubuntu
  dash and BSD's non-bash shells.

* It's faster, because it uses a lighter-weight shell.

* It's much closer to being autoconfiguring.  In the normal case, all
  the person installing an instance need supply is the project name.

* It is considerably better documented.

* It can support cgit as well as gitweb installations.

I am also enclosing a rewrite in Python. This has a serious functional
advantage over either Perl or sh; the batteries-included effect of the
Python libraries means it's not dependent on things like the path
location of sendmail or whether the hosting site will allow it to
run wget.

I think the broad usage of CIA.vc justifies adding one of these as an
official ciabot hook to git contrib/, and am so proposing. Should it
be required, I will accept maintainance responsibility; I expect the
amount of effort involved to be minimal.

Both versions have been live-tested on the GPSD project repo.  The
Python version is now in production use there.

Code is enclosed.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>

--vtzGhvizbBRQ85DL
Content-Type: application/x-sh
Content-Disposition: attachment; filename="ciabot.sh"
Content-Transfer-Encoding: quoted-printable

#!/bin/sh=0A# Distributed under the terms of the GNU General Public License=
 v2=0A# Copyright (c) 2006 Fernando J. Pereda <ferdy@gentoo.org>=0A# Copyri=
ght (c) 2008 Natanael Copa <natanael.copa@gmail.com>=0A# Copyright (c) 2010=
 Eric S. Raymond <esr@thyrsus.com>=0A#=0A# Originally based on Git ciabot.p=
l by Petr Baudis.=0A# This script contains porcelain and porcelain byproduc=
ts.=0A#=0A# It is meant to be run either on a post-commit hook or in an upd=
ate=0A# hook:=0A#=0A# post-commit: It parses latest commit and current HEAD=
 to get the=0A# information it needs.=0A#=0A# update: You have to call it o=
nce per merged commit:=0A#=0A#       refname=3D$1=0A#       oldhead=3D$2=0A=
#       newhead=3D$3=0A#       for merged in $(git rev-list ${oldhead}..${n=
ewhead} | tac) ; do=0A#               /path/to/ciabot.bash ${refname} ${mer=
ged}=0A#       done=0A#=0A=0A#=0A# The project as known to CIA. You will wa=
nt to change this:=0A#=0Aproject=3D"GPSD"=0A=0A#=0A# You may not need to ch=
ange these:=0A#=0A=0A# Name of the repository.=0A# You can hardwire this to=
 make the script faster.=0Arepo=3D"`basename ${PWD}`"=0A=0A# Fully qualifie=
d domain name of the repo host.=0A# You can hardwire this to make the scrip=
t faster.=0Ahost=3D`hostname --fqdn`=0A=0A# Changeset URL prefix for your r=
epo: when the commit ID is appended=0A# to this, it should point at a CGI t=
hat will display the commit=0A# through gitweb or something similar. The de=
faults will probably=0A# work if you have a typical gitweb/cgit setup.=0A#u=
rlprefix=3D"http://${host}/cgi-bin/gitweb.cgi?p=3D${repo};a=3Dcommit;h=3D"=
=0Aurlprefix=3D"http://${host}/cgi-bin/cgit.cgi/${repo}/commit/?id=3D"=0A=
=0A#=0A# You probably will not need to change the following:=0A#=0A=0A# Ide=
ntify the script. Should change only wghen the script itself  =0Agenerator=
=3D"http://www.catb.org/~esr/ciabot.py"=0A=0A# Addresses for the e-mail=0Af=
rom=3D"${LOGNAME}@${host}"=0Ato=3D"cia@cia.vc"=0A=0A# SMTP client to use - =
may need to edit the absolute pathname for your system=0Asendmail=3D"sendma=
il -t -f ${from}"=0A=0A#=0A# No user-serviceable parts below this line:=0A#=
=0A=0A# Should include both places sendmail is likely to lurk =0A# and the =
git private command directory.=0APATH=3D"$PATH:/usr/sbin/:`git --exec-path`=
"=0A=0Aif [ $# -eq 0 ] ; then=0A	refname=3D$(git symbolic-ref HEAD 2>/dev/n=
ull)=0A	merged=3D$(git rev-parse HEAD)=0Aelse=0A	refname=3D$1=0A	merged=3D$=
2=0Afi=0A=0A# This tries to turn your gitwebbish URL into a tinyurl so it w=
ill take up=0A# less space on the IRC notification line. Some repo sites (I=
'm looking at=0A# you, berlios.de!) forbid wget calls for security reasons.=
  On these,=0A# the code will fall back to the full un-tinyfied URL.=0Along=
url=3D${urlprefix}${merged}=0Aurl=3D$(wget -O - -q http://tinyurl.com/api-c=
reate.php?url=3D${longurl} 2>/dev/null)=0Aif [ -z "$url" ]; then=0A	url=3D"=
${longurl}"=0Afi=0A=0Arefname=3D${refname##refs/heads/}=0A=0Agitver=3D$(git=
 --version)=0Agitver=3D${gitver##* }=0A=0Arev=3D$(git describe ${merged} 2>=
/dev/null)=0A# ${merged:0:12} was the only bashism left in the 2008 version=
 of this=0A# script, according to checkbashisms.  Replace it with ${merged}=
 here=0A# because it was just a fallback anyway, and it's worth taking acce=
pting=0A# a longer fallback for faster execution and removing the bash deoe=
ndency.=0A[ -z ${rev} ] && rev=3D${merged}=0A=0Arawcommit=3D$(git cat-file =
commit ${merged})=0Aauthor=3D$(echo "$rawcommit" | sed -n -e '/^author .*<\=
([^@]*\).*$/s--\1-p')=0Alogmessage=3D$(echo "$rawcommit" | sed -e '1,/^$/d'=
 | head -n 1)=0Alogmessage=3D$(echo "$logmessage" | sed 's/\&/&amp\;/g; s/<=
/&lt\;/g; s/>/&gt\;/g')=0Ats=3D$(echo "$rawcommit" | sed -n -e '/^author .*=
> \([0-9]\+\).*$/s--\1-p')=0A=0Aout=3D"=0A<message>=0A  <generator>=0A    <=
name>CIA Shell client for Git</name>=0A    <version>${gitver}</version>=0A =
   <url>${generator}</url>=0A  </generator>=0A  <source>=0A    <project>${p=
roject}</project>=0A    <branch>$repo:${refname}</branch>=0A  </source>=0A =
 <timestamp>${ts}</timestamp>=0A  <body>=0A    <commit>=0A      <author>${a=
uthor}</author>=0A      <revision>${rev}</revision>=0A      <files>=0A     =
   $(git diff-tree -r --name-only ${merged} |=0A          sed -e '1d' -e 's=
-.*-<file>&</file>-')=0A      </files>=0A      <log>${logmessage} ${url}</l=
og>=0A      <url>${url}</url>=0A    </commit>=0A  </body>=0A</message>"=0A=
=0A${sendmail} << EOM=0AMessage-ID: <${merged}.${author}@${project}>=0AFrom=
: ${from}=0ATo: ${to}=0AContent-type: text/xml=0ASubject: DeliverXML=0A${ou=
t}=0AEOM=0A=0A# vim: set tw=3D70 :=0A
--vtzGhvizbBRQ85DL
Content-Type: text/x-python; charset=us-ascii
Content-Disposition: attachment; filename="ciabot.py"

#!/usr/bin/env python
# Distributed under the terms of the GNU General Public License v2
# Copyright (c) 2010 Eric S. Raymond <esr@thyrsus.com>
#
# This script contains porcelain and porcelain byproducts.
# It's Python because the Python standard libraries avoid portability/security
# issues raised by callouts in the ancestral Perl and sh scripts.  It should
# be compatible back to Python 2.1.5.
#
# It is meant to be run either on a post-commit hook or in an update
# hook:
#
# post-commit: It queries for current HEAD and latest commit ID to get the
# information it needs.
#
# update: You have to call it once per merged commit:
#
#       refname=$1
#       oldhead=$2
#       newhead=$3
#       for merged in $(git rev-list ${oldhead}..${newhead} | tac) ; do
#               /path/to/ciabot.py ${refname} ${merged}
#       done
#
# Note: this script uses mail, not XML-RPC, in order to avoid stalling
# until timeout when the XML-RPC server is down. 
#
# Call with -n to see the notification mail dumped to stdout rather
# than shipped to CIA.
#
import os, sys, commands, socket, urllib
#
# The project as known to CIA. You will want to change this:
#
project="GPSD"

#
# You may not need to change these:
#

# Name of the repository.
# You can hardwire this to make the script faster.
repo = os.path.basename(os.getcwd())

# Fully-qualified domain name of this host.
# You can hardwire this to make the script faster.
host = socket.getfqdn()

# Changeset URL prefix for your repo: when the commit ID is appended
# to this, it should point at a CGI that will display the commit
# through gitweb or something similar. The default will probably
# work if you have a typical gitweb/cgit setup.
#
#urlprefix="http://%(host)s/cgi-bin/gitweb.cgi?p=%(repo)s;a=commit;h="%locals()
urlprefix="http://%(host)s/cgi-bin/cgit.cgi/%(repo)s/commit/?id="%locals()

#
# No user-serviceable parts below this line:
#

def do(command):
    return commands.getstatusoutput(command)[1]

# Addresses for the e-mail. The from address is a dummy, since CIA
# will never reply to this mail.
fromaddr = "CIABOT-NOREPLY@" + host
toaddr = "cia@cia.vc"

# Identify the generator script.
# Should only change when the script itself has a new home
generator="http://www.catb.org/~esr/ciabot.sh"

# Should add to the command path both places sendmail is likely to lurk, 
# and the git private command directory.
os.environ["PATH"] += ":/usr/sbin/:" + do("git --exec-path")

# Call this script with -n tp dump the notification mail to stdout
mailit = True 
if sys.argv[1] == '-n':
    mailit = False
    sys.argv.pop(1)

# Script wants a reference to head followed by the commit ID to notify about. 
if len(sys.argv) == 1:
    refname = do("git symbolic-ref HEAD 2>/dev/null")
    merged = do("git rev-parse HEAD")
else:
    refname = sys.argv[1]
    merged = sys.argv[2]

# This tries to turn your gitwebbish URL into a tinyurl so it will take up
# less space on the IRC notification line. You can tweak the tinyfier
# service if you need to.
tinyifier = "http://tinyurl.com/api-create.php?url="
try:
    url = open(urllib.urlretrieve(tinyifier + urlprefix + merged)[0]).read()
except:
    url = urlprefix + merged

refname = os.path.basename(refname)
gitver = do("git --version").split()[0]	# Git version number

rev = do("git describe ${merged} 2>/dev/null") or merged[:12]
rawcommit = do("git cat-file commit " + merged)
files=do("git diff-tree -r --name-only '"+ merged +"' | sed -e '1d' -e 's-.*-<file>&</file>-'")

inheader = True
headers = {}
logmessage = ""
for line in rawcommit.split("\n"):
    if inheader:
        if line:
            fields = line.split()
            headers[fields[0]] = " ".join(fields[1:])
        else:
            inheader = False
    else:
        logmessage = line
        break
(author, ts) = headers["author"].split(">")
author = author.replace("<", "").split("@")[0].split()[-1]
ts = ts.strip()

out = '''\
<message>
  <generator>
    <name>CIA Shell client for Git</name>
    <version>%(gitver)s</version>
    <url>%(generator)s</url>
  </generator>
  <source>
    <project>%(project)s</project>
    <branch>%(repo)s:%(refname)s</branch>
  </source>
  <timestamp>%(ts)s</timestamp>
  <body>
    <commit>
      <author>%(author)s</author>
      <revision>%(rev)s</revision>
      <files>
        %(files)s
      </files>
      <log>%(logmessage)s %(url)s</log>
      <url>%(url)s</url>
    </commit>
  </body>
</message>
''' % locals()

message = '''\
Message-ID: <%(merged)s.%(author)s@%(project)s>
From: %(fromaddr)s
To: %(toaddr)s
Content-type: text/xml
Subject: DeliverXML

%(out)s''' % locals()

if mailit:
    import smtplib
    server = smtplib.SMTP('localhost')
    server.sendmail(fromaddr, [toaddr], message)
    server.quit()
else:
    print message

#End

--vtzGhvizbBRQ85DL--
