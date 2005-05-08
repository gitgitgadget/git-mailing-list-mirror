From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH Cogito] Make use of external editor work like CVS
Date: Sun, 08 May 2005 17:43:10 +0200
Message-ID: <1115566990.9031.108.camel@pegasus>
References: <1115564550.9031.96.camel@pegasus>
	 <20050508152529.GU9495@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-pBfauJviknU+wKCFYfSb"
Cc: GIT Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 08 17:36:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DUnp8-0005fV-Of
	for gcvg-git@gmane.org; Sun, 08 May 2005 17:36:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262871AbVEHPnA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 May 2005 11:43:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262882AbVEHPnA
	(ORCPT <rfc822;git-outgoing>); Sun, 8 May 2005 11:43:00 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:53933 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S262871AbVEHPms
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 8 May 2005 11:42:48 -0400
Received: from pegasus (p5487D02F.dip.t-dialin.net [84.135.208.47])
	by mail.holtmann.net (8.12.3/8.12.3/Debian-7.1) with ESMTP id j48Fi5WX003713
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO);
	Sun, 8 May 2005 17:44:05 +0200
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050508152529.GU9495@pasky.ji.cz>
X-Mailer: Evolution 2.2.2 
X-Virus-Scanned: ClamAV version 0.83, clamav-milter version 0.83 on coyote.holtmann.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--=-pBfauJviknU+wKCFYfSb
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Petr,

> > this is a modified version of my patch that integrates the your latest
> > modifications to cg-commit and also fixes the cleanup of the temporary
> > files when we abort the operation.
> 
> ...and I've just pushed more modifications. I'm so evil.

attached is another version of the patch.

> > [PATCH] Make use of external editor work like CVS
> > 
> > The lines starting with `CG:' should be a trailer and not at the top
> > of the message presented in the editor. Also extend the number of `-'
> > up to 74 characters so that people know when they should start a new
> > line. If it's not a merge and no commit text is given as parameter
> > then add an extra empty line at the top. And don't forget to take
> > care of the temporary files when a commit is unneeded or canceled.
> > 
> > Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> 
> What is so special about 74 columns? Why not 75 (fmt default), or 72
> (emails)?

I ended up with 74, because "CG" has only two letters instead of "CVS"
which has three. And cg-log uses a prefix of four whitespaces. This
leaves two free characters at the end of a line if your terminal uses a
width of 80 characters. The decision was of cosmetic nature.

> Also, I'd prefer the empty line to be always there in front of the CG:
> stuff (two empty lines in case of merge - I want to encourage people to
> keep possible details w.r.t. the merge separated by an empty line from
> the merge information), and when reading it back cg-commit should strip
> any trailing empty lines.

I think we should differentiate between the merges. There is no need for
additional information if it is an automatic merge (no conflicts) and in
general it makes no sense to open the editor (until forced). I wanted to
address this later. And yes in case of a manual merge it is a good idea
to add two extra empty lines at the top.

Another good idea is maybe to remove empty lines at the top and bottom
before doing the commit.

> > Index: cg-commit
> > ===================================================================
> > --- 8bb38f8bfdc7411460c300c811da1987173f412f/cg-commit  (mode:100755)
> > +++ be440e169fa3b5ec5450fa9574cd8789b0e3ab20/cg-commit  (mode:100755)
> >  if [ "$merging" ]; then
> > -	echo -n 'Merge with ' >>$LOGMSG
> > -	[ "$msgs" ] && echo -n 'Merge with '
> > +	echo -n "Merge with " >>$LOGMSG
> > +	[ "$msgs" ] && echo -n "Merge with "
> 
> We aren't too consistent about this anyway now, so you might as well
> let it not clutter your patch. ;-)

I was moving parts of the code so I addressed it ;)

> >  cp $LOGMSG $LOGMSG2
> >  if tty -s; then
> >  	if ! [ "$msgs" ]; then
> > -		${EDITOR:-vi} $LOGMSG2
> > -		[ $LOGMSG2 -nt $LOGMSG ] || die 'Commit message not modified, commit aborted'
> > +		${EDITOR:-vi} $LOGMSG
> > +		if [ ! $LOGMSG -nt $LOGMSG2 ]; then
> > +			rm $LOGMSG $LOGMSG2
> > +			die 'Commit message not modified, commit aborted.'
> > +		fi
> >  	fi
> >  else
> > -	cat >>$LOGMSG2
> > +	cat >>$LOGMSG
> >  fi
> > -grep -v ^CG: $LOGMSG2 >$LOGMSG
> > -rm $LOGMSG2
> > +grep -v ^CG: $LOGMSG >$LOGMSG2
> > +mv $LOGMSG2 $LOGMSG
> 
> Why are you messing with the $LOGMSG variables here?

This is only cosmetic. Using vim it displays the name of the temporary
file and confusing the user with gitci2.XXXX instead of gitci.XXX is
weird. Even using gitci as basename looks not good to me, but I left it
for now.

Regards

Marcel


--=-pBfauJviknU+wKCFYfSb
Content-Disposition: attachment; filename=patch
Content-Type: text/plain; name=patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

[PATCH] Make use of external editor work like CVS

The lines starting with `CG:' should be a trailer and not at the top
of the message presented in the editor. Also extend the number of `-'
up to 74 characters so that people know when they should start a new
line. If it's not a merge and no commit text is given as parameter
then add an extra empty line at the top. And don't forget to take
care of the temporary files when a commit is unneeded or canceled.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>

---
commit a2c4e793a4dfb21f43494ad90c7b887df10e1be2
tree cb61efa8a01400150162af9b0f3773f21d502fe9
parent 79f86b0174159f016540734ac18560566389b823
author Marcel Holtmann <marcel@holtmann.org> Sun, 08 May 2005 17:30:01 +0200
committer Marcel Holtmann <marcel@holtmann.org> Sun, 08 May 2005 17:30:01 +0200

 cg-commit |   61 +++++++++++++++++++++++++++++++++++--------------------------
 1 files changed, 35 insertions(+), 26 deletions(-)

Index: cg-commit
===================================================================
--- f00d7589973e8ea65d2264f5fbac82e1b217dc8f/cg-commit  (mode:100755)
+++ cb61efa8a01400150162af9b0f3773f21d502fe9/cg-commit  (mode:100755)
@@ -67,26 +67,10 @@
 
 LOGMSG=$(mktemp -t gitci.XXXXXX)
 LOGMSG2=$(mktemp -t gitci2.XXXXXX)
-echo CG: ---------------------------------------------------------- >>$LOGMSG
-echo CG: Lines beggining with CG: will be automatically removed     >>$LOGMSG
-echo CG:                                                            >>$LOGMSG
-if [ ! "$ignorecache" ]; then
-	if [ ! "${commitfiles[*]}" ]; then
-		echo 'Nothing to commit.' >&2
-		exit 2
-	fi
-	for file in "${commitfiles[@]}"; do
-		# Prepend a letter describing whether it's addition,
-		# removal or update. Or call git status on those files.
-		echo CG: $file >>$LOGMSG
-		[ "$msgs" ] && echo $file
-	done
-	echo CG: >>$LOGMSG
-fi
 
 if [ "$merging" ]; then
-	echo -n 'Merge with ' >>$LOGMSG
-	[ "$msgs" ] && echo -n 'Merge with '
+	echo -n "Merge with " >>$LOGMSG
+	[ "$msgs" ] && echo -n "Merge with "
 	[ -s .git/merging-sym ] || cp .git/merging .git/merging-sym
 	for sym in $(cat .git/merging-sym); do
 		uri=$(cat .git/branches/$sym)
@@ -94,30 +78,55 @@
 		echo "$uri" >>$LOGMSG
 		[ "$msgs" ] && echo "$uri"
 	done
-	echo >>$LOGMSG
+else
+	first=1
 fi
-first=1
+
 for msg in "${msgs[@]}"; do
 	if [ "$first" ]; then
 		first=
 	else
 		echo >>$LOGMSG
 	fi
-	echo $msg | fmt >>$LOGMSG
+	echo $msg | fmt -s -w 74 >>$LOGMSG
 done
+
+if [ "$first" ]; then
+	echo >>$LOGMSG
+fi
+
+echo "CG: ----------------------------------------------------------------------" >>$LOGMSG
+echo "CG: Enter Log.  Lines beginning with \`CG:' are removed automatically"      >>$LOGMSG
+if [ ! "$ignorecache" ]; then
+	if [ ! "${commitfiles[*]}" ]; then
+		rm $LOGMSG $LOGMSG2
+		die 'Nothing to commit.'
+	fi
+	echo "CG: " >>$LOGMSG
+	echo "CG: Modified Files:" >>$LOGMSG
+	for file in "${commitfiles[@]}"; do
+		# Prepend a letter describing whether it's addition,
+		# removal or update. Or call git status on those files.
+		echo "CG:    $file" >>$LOGMSG
+		[ "$msgs" ] && echo $file
+	done
+fi
+echo "CG: ----------------------------------------------------------------------" >>$LOGMSG
+
 cp $LOGMSG $LOGMSG2
 if tty -s; then
 	if ! [ "$msgs" ] || [ "$forceeditor" ]; then
-		${EDITOR:-vi} $LOGMSG2
+		${EDITOR:-vi} $LOGMSG
 	fi
-	if ! [ "$msgs" ] && ! [ $LOGMSG2 -nt $LOGMSG ]; then
-		die 'Commit message not modified, commit aborted'
+	if ! [ "$msgs" ] && ! [ $LOGMSG -nt $LOGMSG2 ]; then
+		rm $LOGMSG $LOGMSG2
+		die 'Commit message not modified, commit aborted.'
 	fi
 else
 	cat >>$LOGMSG2
 fi
-grep -v ^CG: $LOGMSG2 >$LOGMSG
-rm $LOGMSG2
+grep -v ^CG: $LOGMSG >$LOGMSG2
+mv $LOGMSG2 $LOGMSG
 
 if [ ! "$ignorecache" ]; then
 	if [ "$customfiles" ]; then

--=-pBfauJviknU+wKCFYfSb--

