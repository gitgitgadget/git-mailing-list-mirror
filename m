From: Jakub Narebski <jnareb@gmail.com>
Subject: Tests for "Understanding Version Control" by Eric S. Raymond
Date: Wed, 4 Feb 2009 23:14:49 +0100
Message-ID: <200902042314.50690.jnareb@gmail.com>
References: <200902021948.54700.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: "Eric S. Raymond" <esr@thyrsus.com>, Theodore Tso <tytso@mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 04 23:16:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUq2u-0005nc-EK
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 23:16:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758704AbZBDWO4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 17:14:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756610AbZBDWO4
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 17:14:56 -0500
Received: from fg-out-1718.google.com ([72.14.220.157]:41142 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758704AbZBDWOy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 17:14:54 -0500
Received: by fg-out-1718.google.com with SMTP id 16so1365959fgg.17
        for <git@vger.kernel.org>; Wed, 04 Feb 2009 14:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=1GECWg8s2fkLwKj1UCbEtdaFhzDQHKO1mu23KfVT+8k=;
        b=f8JVxyXiU+i8Tu98RifBU0n1lXLOkrB2yCuAd5hv0T8uRcYYlQeAbpmAwMeLtrPlLq
         GQBKzvTUW2HioOs0Dy0OBAFGy7iAFG3H6XqTVSqXk9dMEFwYPUgoJtZzCXhNHfmLQH30
         jqhQus5dBZOMQ+TkDLtE/LruBnuouT+T+yl/Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=r67v80mZUfxKpRhbpynW30NPQAYW88A+5+2v9Fh3Ac/k6lWENkBEYc6L2+aFkI7jCi
         Kti2AvlxWQVtfVRNjBhtc/rjaPGHF204Fv5C+CqlVn78efBBjIc95YhCRiSuXwZPs/Zl
         upco+ciqBR9uv1acV1HynR6hzX6++niTJAyNQ=
Received: by 10.86.76.20 with SMTP id y20mr1388975fga.37.1233785691597;
        Wed, 04 Feb 2009 14:14:51 -0800 (PST)
Received: from ?192.168.1.13? (abwq247.neoplus.adsl.tpnet.pl [83.8.240.247])
        by mx.google.com with ESMTPS id 4sm3515239fge.4.2009.02.04.14.14.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 04 Feb 2009 14:14:50 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <200902021948.54700.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108444>

Sometimes code speaks louder than words. I think it is the case in
understanding how intelligent merge should deal with the presence
of renames; well commented examples (use cases) are (might be?) better
than talking about it.

Instead of talking about 'container identities' it would be, in my
opinion, to examine what challenges version control system has to
overcome if it wants to tell that it supports renames.  Example tests,
example use cases might be a good choice.  With those examples we
can check what are the limitations, strong and weak sides of different
ways of dealing with renames: container identities (or 'file-ids'),
tracking rename information, and heuristic rename detection.


Below there are proposed tests which are meant to check how good merge
algorithm (strategy) used by given SCM supports renames.  In all cases
we have two branch: branch 'a' (ours) and branch 'b' (theirs), and we
usually would be merging branch 'b' into (ours) branch 'a'.

Note that for Git we want example files be large enough that
similarity based heuristic rename detection works.  At the bottom
there are proposed files, taken from t/t6022-merge-rename.sh test
from git.git repository (which, along with t/t6032-merge-large-rename.sh,
might be a good start for more comprehensive test suite for SCMs).

 * merging renames: if one side renamed file you should get rename
   on merge; renaming a file and then merging that rename.

     <switch to branch b>
     [on branch b]$ scm mv foo bar
     [on branch b]$ scm commit ... # to commit file rename

     <switch to branch a>
     [on branch a]$ scm commit ... # to not have fast-forward case
     [on branch a]$ scm merge b    # merge branch b (with rename)

   expected result:
     you have file 'bar', and do not have file 'foo'

 * applying change to correct file: if our side renamed a file (or
   rename directory it is in, which does rename full pathname of a
   file indirectly), and possibly change it, and the other side
   changed file, we would want merge to bring changes to file after
   rename.

     <switch to branch a>
     [on branch a]$ scm mv foo bar
     [on branch a]$ edit bar && scm commit # optionally

     <switch to branch b>
     [on branch b]$ edit foo
     [on branch b]$ scm commit -m 'FOO'    # commit changes

     <switch to branch a>
     [on branch a]$ scm merge b

   expected result: 
     you have changes made on branch 'b' to file 'foo'
     (commit 'FOO') in file 'bar'

   Note that like in example in previous item all operations take place
   _after_ branching point (after creation of branch b off branch a).

   This is I guess what most people think when talking about
   rename-aware (intelligent) merging.

 * renamed directories bring another complication (described for example
   on Mark Shuttleworth blog in articles about DVCS, promoting Bazaar-NG),
   namely how to deal with merging changes where other side creates
   _new files_ in renamed directory.

     <switch to branch a>
     [on branch a]$ scm mv subdir-foo/ subdir-bar/

     <switch to branch b>
     [on branch b]$ scm add subdir-foo/baz   # add new file in old dir

     <switch to branch b>
     [on branch a]$ scm merge b

   expected result:
     New file subdir-bar/baz
     Either automatic merge, or a conflict (no commit)

   There is a bit of controversy about this feature, as for example in
   some programming languages (e.g. Java) or in some project build tool
   info it is not posible to simply move a file (or create new file in
   different directory) without changing file contents.  Some say that
   is better to fail than to do wrongly clean merge.

 * independent adding of a file: this is the case where both sides add
   the same (or nearly the same) file independently, so the file in
   question doesn't have common ancestor in per-file history.  It
   might happen because of applying patch independently, for example.
   I _suspect_ that 'file-id' based solutions would have problems...

   Below there is table of cases that might happen:

              |  1  |  2  |  3  |  4  |  5  |
     ---------|-----|-----|-----|-----|-----|
     filename |  =  |  =  | !=  |  =  | !=  |
     contents |  =  | !=  |  =  | ~=  | ~=  |

   where 
     '=' means that both sides use the same filename, 
         or exactly the same contents; 
    '!=' means files have different contents,
         or files _started_ with different names
    '~=' means that sides have slightly different contents,
         but similarity score is high enough for rename detection.

   Let us examine most complicated case 5 in above table; one can
   simply omit some commends to get cases 1, 3 and 4.  Note that
   COPYING file is GNU GPL text.

     <switch to branch a>
     [on branch a]$ cp ../COPYING COPYING
     [on branch a]$ scm add COPYING
     [on branch a]$ scm commit -m 'Added COPYING'

     <switch to branch b>
     [on branch b]$ cp ../COPYING LICENSE   # optional rename
     [on branch b]$ sed -e 's/HOWEVER/However/' <LICENSE >LICENSE.1 &&
                    mv -f LICENSE.1 LICENSE # optional change
     [on branch b]$ scm add LICENSE
     [on branch b]$ scm commit -m 'Added LICENSE'
     [on branch b]$ scm mv LICENSE COPYING
     [on branch b]$ scm commit -m 'Renamed LICENSE to COPYING'

     <switch to branch a>
     [on branch a]$ scm merge b

   expected result: 
     Either clean merging changes from branch 'b', or cleanly
     marked conflict, e.g. CONFLICT (add/add).  What we do not
     want is one side vanishing.

   But that series of commands was only a preparation.  We now
   want to repeat merging from branch 'b' into branch 'a', or
   do reverse merging 'a' into 'b'.

     <switch to branch b>
     [on branch b]$ sed -e 's/GPL/G.P.L/g' <COPYING >COPYING1 &&
                    mv -f COPYING COPYING
     [on branch b]$ scm commit COPYING -m 'Changed COPYING'

     <switch to branch a>
     [on branch a]$ scm commit ... # to not have fast-forward case
     [on branch a]$ scm merge b    # merge branch b

   expected result:
     Clean merge of changes done on branch 'b' into COPYING


==================================================
##################################################
==================================================

Files for testing rename detection in Git

........................................

t/t6022-merge-rename.sh
t/t6022-merge-rename-nocruft.sh

cat >A <<\EOF &&
a aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
b bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
c cccccccccccccccccccccccccccccccccccccccccccccccc
d dddddddddddddddddddddddddddddddddddddddddddddddd
e eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
f ffffffffffffffffffffffffffffffffffffffffffffffff
g gggggggggggggggggggggggggggggggggggggggggggggggg
h hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh
i iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii
j jjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjj
k kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk
l llllllllllllllllllllllllllllllllllllllllllllllll
m mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
n nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn
o oooooooooooooooooooooooooooooooooooooooooooooooo
EOF

cat >M <<\EOF &&
A AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
B BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB
C CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
D DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD
E EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE
F FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
G GGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGG
H HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH
I IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII
J JJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJ
K KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK
L LLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLL
M MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
N NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN
O OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO
EOF

sed -e "/^g /s/.*/g : master changes a line/" <A >A+
sed -e "/^g /s/.*/g : white changes a line/" <A >B
sed -e "/^G /s/.*/G : colored branch changes a line/" <M >N
sed -e "/^g /s/.*/g : red changes a line/" <A >B
sed -e "/^G /s/.*/G : colored branch changes a line/" <M >N
[...]


-- 
Jakub Narebski
Poland
