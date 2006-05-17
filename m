From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Implement git-quiltimport (take 2)
Date: Wed, 17 May 2006 16:34:34 -0700
Message-ID: <7vy7x09qet.fsf@assigned-by-dhcp.cox.net>
References: <m1k68l6hga.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.64.0605161001190.3866@g5.osdl.org>
	<m1bqtx6el6.fsf@ebiederm.dsl.xmission.com>
	<7vbqtxaj5k.fsf@assigned-by-dhcp.cox.net>
	<m13bf95ixo.fsf@ebiederm.dsl.xmission.com>
	<7v1wut2p5z.fsf@assigned-by-dhcp.cox.net>
	<m1bqtw4hk7.fsf_-_@ebiederm.dsl.xmission.com>
	<7vsln8cwn6.fsf@assigned-by-dhcp.cox.net>
	<m1zmhg31cm.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 18 01:34:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FgVXL-00029y-Di
	for gcvg-git@gmane.org; Thu, 18 May 2006 01:34:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750726AbWEQXeg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 May 2006 19:34:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750736AbWEQXeg
	(ORCPT <rfc822;git-outgoing>); Wed, 17 May 2006 19:34:36 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:43167 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1750726AbWEQXef (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 May 2006 19:34:35 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060517233435.OQNY18458.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 17 May 2006 19:34:35 -0400
To: ebiederm@xmission.com (Eric W. Biederman)
In-Reply-To: <m1zmhg31cm.fsf@ebiederm.dsl.xmission.com> (Eric W. Biederman's
	message of "Wed, 17 May 2006 13:20:09 -0600")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20252>

ebiederm@xmission.com (Eric W. Biederman) writes:

> Junio C Hamano <junkio@cox.net> writes:
>
>> What's the expected workflow for you to work on a 1300 patch
>> series you get from Andrew in the next installment to deal with
>> 88 unattributed patches?  Answer the question 88 times and make
>> sure you get the answers right every time?  Or abort and
>> hand-edit them to help mailinfo to notice the correct
>> attribution and re-run?
>
> For the internal consumption case it isn't a big deal.  I
> can specify --author with something bogus and it works. 

Yes.

>> I know I am guilty of suggesting "going interactive", but I have
>> a feeling that having an optional file that maps patch-name to
>> author might be easier to work with.  If the old patches are
>> recycled in the updated -mm set, you probably can reuse the
>> mapping for them, adding entries for newly introduced "unnamed"
>> patches as needed.
>
> Short of getting the script where it has a sane restart in the
> middle mode going interactive and asking questions makes a lot
> of sense.  Especially with smaller trees.

Yes perhaps on smaller trees, but that does not mean much.  For
smaller trees and/or smaller patch series almost anything would
do.

How about doing something like this, so that the user can record
the fixup information, especially with --dry-run patch?  Then
the next round from the updated -mm tree the user would not have
to retype them again ("then..fi" part should be indented in the
final version, but I did not want indentation changes to
distract you):

 	# Parse the author information
 	export GIT_AUTHOR_NAME=$(sed -ne 's/Author: //p' "$tmp_info")
 	export GIT_AUTHOR_EMAIL=$(sed -ne 's/Email: //p' "$tmp_info")
+	already_tried_fixup=
 	while test -z "$GIT_AUTHOR_EMAIL" && test -z "$GIT_AUTHOR_NAME" ; do
 		if [ -n "$quilt_author" ] ; then
 			GIT_AUTHOR_NAME="$quilt_author_name";
 			GIT_AUTHOR_EMAIL="$quilt_author_email";
 		else
+			if test -z "$already_tried_fixup"
+			then
+				patch_author=`grep author-fixup "$patch_name"`
+				already_tried_fixup=t
+			fi
+			if test -z "$patch_author"
+			then
 			echo "No author found in $patch_name";
 			echo "---"
 			cat $tmp_msg
 			echo -n "Author: ";
 			read patch_author
+			fi
 
 			echo "$patch_author"

> For Andrews tree before I play anymore with technical solutions I
> need to talk to Andrew and see if we can improve the situation
> upstream.  Possibly with a quilt-audit script that finds problem
> patches.

Yes, that sounds very sensible.
