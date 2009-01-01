From: Adeodato =?utf-8?B?U2ltw7M=?= <dato@net.com.org.es>
Subject: Re: [PATCH 0/3] Teach Git about the patience diff algorithm
Date: Thu, 1 Jan 2009 21:46:52 +0100
Message-ID: <20090101204652.GA26128@chistera.yi.org>
References: <20081104004001.GB29458@artemis.corp> <alpine.DEB.1.00.0811040627020.24407@pacific.mpi-cbg.de> <20081104083042.GB3788@artemis.corp> <alpine.DEB.1.00.0811041447170.24407@pacific.mpi-cbg.de> <20081104152351.GA21842@artemis.corp> <alpine.DEB.1.00.0901011730190.30769@pacific.mpi-cbg.de> <alpine.LFD.2.00.0901011134210.5086@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="YZ5djTAD1cGYuMQK"
Content-Transfer-Encoding: 8bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Pierre Habouzit <madcoder@debian.org>, davidel@xmailserver.org,
	Francis Galiegue <fg@one2team.net>,
	Git ML <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jan 01 21:48:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LIUSr-0002jA-2U
	for gcvg-git-2@gmane.org; Thu, 01 Jan 2009 21:48:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751859AbZAAUq7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Jan 2009 15:46:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751806AbZAAUq6
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Jan 2009 15:46:58 -0500
Received: from 226.Red-80-25-139.staticIP.rima-tde.net ([80.25.139.226]:3129
	"EHLO etc.inittab.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751774AbZAAUq5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jan 2009 15:46:57 -0500
Received: from chistera.yi.org (unknown [192.168.254.34])
	by etc.inittab.org (Postfix) with ESMTP id C459C801BF8F;
	Thu,  1 Jan 2009 21:46:53 +0100 (CET)
Received: from userid 1000 by justin with local (Exim 4.69) 
	  id 1LIURQ-0006qQ-Uj; Thu, 01 Jan 2009 21:46:52 +0100
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0901011134210.5086@localhost.localdomain>
X-No-CC: Please respect my Mail-Followup-To header
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104316>


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

* Linus Torvalds [Thu, 01 Jan 2009 11:45:21 -0800]:

> On Thu, 1 Jan 2009, Johannes Schindelin wrote:

> > Nothing fancy, really, just a straight-forward implementation of the
> > heavily under-documented and under-analyzed paience diff algorithm.

> Exactly because the patience diff is so under-documented, could you 
> perhaps give a few examples of how it differs in the result, and why it's 
> so wonderful? Yes, yes, I can google, and no, no, nothing useful shows up 
> except for *totally* content-free fanboisms. 

> So could we have some actual real data on it?

For me, the cases where I find patience output to be of substantial
higher readability are those involving a rewrite of several consecutive
paragraphs (i.e., lines of code separated by blank lines). Compare:

-8<- git -8<-
@@ -51,29 +51,30 @@ def mbox_update(bug):
             f.close()
     else:
         # make a list of Message-Id we have
-        fp1 = file(path, 'ab+')
-        ids1 = [ x.get('Message-Id') for x in mailbox.UnixMailbox(fp1) ]
+        msgids = { x.get('Message-Id') for x in mailbox.mbox(path) }
 
-        # get remote mbox again
-        fp2 = tempfile.TemporaryFile()
-        retrieve_mbox(bug, fp2)
+        with tempfile.NamedTemporaryFile() as tmpfd:
+            # retrieve the remote mbox again
+            retrieve_mbox(bug, tmpfd)
 
-        # parse its messages
-        fp2.seek(0)
-        parser = email.Parser.Parser()
-        msgs2 = dict((x['Message-Id'], x)
-                    for x in mailbox.UnixMailbox(fp2, parser.parse))
+            # parse its messages
+            parser = email.parser.Parser()
+            new_msgids = { x['Message-Id']: x
+                            for x in mailbox.mbox(tmpfd.name, parser.parse) }
 
-        # now append the new ones
-        for msgid in set(msgs2.keys()) - set(ids1):
-            fp1.write('\n' + msgs2[msgid].as_string(unixfrom=True))
+        with open(path, 'a+') as fd:
+            # now append the new messages
+            for msgid in new_msgids.keys() - msgids:
+                fd.write('\n' + new_msgids[msgid].as_string(unixfrom=True))
 
     return path
->8- git ->8-

with:

-8<- bzr patience -8<-
@@ -51,29 +51,30 @@
             f.close()
     else:
         # make a list of Message-Id we have
-        fp1 = file(path, 'ab+')
-        ids1 = [ x.get('Message-Id') for x in mailbox.UnixMailbox(fp1) ]
-
-        # get remote mbox again
-        fp2 = tempfile.TemporaryFile()
-        retrieve_mbox(bug, fp2)
-
-        # parse its messages
-        fp2.seek(0)
-        parser = email.Parser.Parser()
-        msgs2 = dict((x['Message-Id'], x)
-                    for x in mailbox.UnixMailbox(fp2, parser.parse))
-
-        # now append the new ones
-        for msgid in set(msgs2.keys()) - set(ids1):
-            fp1.write('\n' + msgs2[msgid].as_string(unixfrom=True))
+        msgids = { x.get('Message-Id') for x in mailbox.mbox(path) }
+
+        with tempfile.NamedTemporaryFile() as tmpfd:
+            # retrieve the remote mbox again
+            retrieve_mbox(bug, tmpfd)
+
+            # parse its messages
+            parser = email.parser.Parser()
+            new_msgids = { x['Message-Id']: x
+                            for x in mailbox.mbox(tmpfd.name, parser.parse) }
+
+        with open(path, 'a+') as fd:
+            # now append the new messages
+            for msgid in new_msgids.keys() - msgids:
+                fd.write('\n' + new_msgids[msgid].as_string(unixfrom=True))
 
     return path
->8- bzr patience ->8-

I don't know about you, but I find the latter much easier to read,
because the whole context of each version is always available.

As you see, in (at least) this case is just a matter of considering the
blank lines worthy of presented as common, or not.

I'll note that in this particular case, `git diff` yielded the very same
results with or without --patience. I don't know why that is, Johannes?
I'll also note that /usr/bin/diff produces (in this case) something
closer to patience than to git.

I'm attaching both versions of the file in case they are useful to
anybody.

-- 
Adeodato Simó                                     dato at net.com.org.es
Debian Developer                                  adeodato at debian.org
 
I promise you. Once I enter into an exclusive relationship, I sleep with
very few people.
                -- Denny Crane

--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename=bdo0
Content-Transfer-Encoding: 8bit

#! /usr/bin/python
## vim: fileencoding=utf-8

"""Open Debian BTS mboxes with Mutt, à la /usr/bin/bts show --mbox.

A cache of mboxes is kept, and changed mboxes will be merged with existing
files instead of replacing them, so that e.g. read-status is preserved for each
message.
"""

import os
import re
import sys
import urllib
import mailbox
import tempfile
import email.Parser

MBOX_DIR = os.path.expanduser('~/.mail/y.bug-cache')

##

def main():
    if len(sys.argv) != 2:
        print >>sys.stderr, 'Usage: %s <bugnumber>' % (sys.argv[0],)
        sys.exit(1)

    bug = re.sub(r'[^0-9]', '', sys.argv[1])
    if not re.match(r'\d{4,}$', bug):
        print >>sys.stderr, \
            'E: %s does not seem a valid number' % (sys.argv[1],)
        sys.exit(1)

    path = mbox_update(bug)
    invoke_mailer(path)

##

def mbox_update(bug):
    """Return a path with an up-to-date copy of the mbox for bug."""
    path = os.path.join(MBOX_DIR, bug + '.mbox')

    if not os.path.exists(path):
        f = file(path, 'wb')
        try:
            retrieve_mbox(bug, f)
        except:
            os.unlink(path)
            raise
        else:
            f.close()
    else:
        # make a list of Message-Id we have
        fp1 = file(path, 'ab+')
        ids1 = [ x.get('Message-Id') for x in mailbox.UnixMailbox(fp1) ]

        # get remote mbox again
        fp2 = tempfile.TemporaryFile()
        retrieve_mbox(bug, fp2)

        # parse its messages
        fp2.seek(0)
        parser = email.Parser.Parser()
        msgs2 = dict((x['Message-Id'], x)
                    for x in mailbox.UnixMailbox(fp2, parser.parse))

        # now append the new ones
        for msgid in set(msgs2.keys()) - set(ids1):
            fp1.write('\n' + msgs2[msgid].as_string(unixfrom=True))

    return path

def retrieve_mbox(bug, fileobj):
    """Retrieve mbox for bug from bugs.debian.org, writing it to fileobj."""
    for line in urllib.urlopen(
            'http://bugs.debian.org/cgi-bin/bugreport.cgi?mboxstatus=yes;mboxmaint=yes;mbox=yes;bug=%s' % (bug,)):
        fileobj.write(line)

def invoke_mailer(path):
    """Exec mutt, opening path."""
    os.execlp('mutt', 'mutt', '-f', path)

##

if __name__ == '__main__':
    try:
        sys.exit(main())
    except KeyboardInterrupt:
        print >>sys.stderr, '\nCancelled.'
        sys.exit(1)

--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename=bdo1
Content-Transfer-Encoding: 8bit

#! /usr/bin/python3

"""Open Debian BTS mboxes with Mutt, à la /usr/bin/bts show --mbox.

A cache of mboxes is kept, and changed mboxes will be merged with existing
files instead of replacing them, so that e.g. read-status is preserved for each
message.
"""

import os
import re
import sys
import mailbox
import tempfile
import email.parser
import urllib.request

MBOX_DIR = os.path.expanduser('~/.mail/y.bug-cache')

##

def main():
    if len(sys.argv) != 2:
        print('Usage: {0} <bugnumber>'.format(sys.argv[0]), file=sys.stderr)
        return 1
    else:
        bug = re.sub(r'[^0-9]', '', sys.argv[1])

    if not re.search(r'^\d{4,}$', bug):
        print('E: {0} does not seem a valid number'.format(sys.argv[1]),
              file=sys.stderr)
        return 1

    path = mbox_update(bug)
    invoke_mailer(path)

##

def mbox_update(bug):
    """Return a path with an up-to-date copy of the mbox for bug."""
    path = os.path.join(MBOX_DIR, bug + '.mbox')

    if not os.path.exists(path):
        f = open(path, 'wb')
        try:
            retrieve_mbox(bug, f)
        except:
            os.unlink(path)
            raise
        else:
            f.close()
    else:
        # make a list of Message-Id we have
        msgids = { x.get('Message-Id') for x in mailbox.mbox(path) }

        with tempfile.NamedTemporaryFile() as tmpfd:
            # retrieve the remote mbox again
            retrieve_mbox(bug, tmpfd)

            # parse its messages
            parser = email.parser.Parser()
            new_msgids = { x['Message-Id']: x
                            for x in mailbox.mbox(tmpfd.name, parser.parse) }

        with open(path, 'a+') as fd:
            # now append the new messages
            for msgid in new_msgids.keys() - msgids:
                fd.write('\n' + new_msgids[msgid].as_string(unixfrom=True))

    return path

def retrieve_mbox(bug, fileobj):
    """Retrieve mbox for bug from bugs.debian.org, writing it to fileobj."""
    url = urllib.request.urlopen(
            'http://bugs.debian.org/cgi-bin/bugreport.cgi?'
            'mboxstatus=yes;mboxmaint=yes;mbox=yes;bug={0}'.format(bug))
    for line in url.fp: # http://bugs.python.org/issue4608
        fileobj.write(line)

def invoke_mailer(path):
    """Exec mutt, opening path."""
    os.execlp('mutt', 'mutt', '-f', path)

##

if __name__ == '__main__':
    try:
        sys.exit(main())
    except KeyboardInterrupt:
        print('\nCancelled.', file=sys.stderr)
        sys.exit(1)

--YZ5djTAD1cGYuMQK--
