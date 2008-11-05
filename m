From: "Sam Liddicott" <sam@liddicott.com>
Subject: Re: let git-diff allow patch to delete empty files?
Date: Wed, 05 Nov 2008 14:49:59 -0000
Organization: Liddicott.com
Message-ID: <4911B297.2070800@liddicott.com>
References: <49118FEE.30408@liddicott.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010105010800040602020500"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 05 15:51:51 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kxjja-0000Qp-Ot
	for gcvg-git-2@gmane.org; Wed, 05 Nov 2008 15:51:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753205AbYKEOuh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Nov 2008 09:50:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752836AbYKEOuh
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Nov 2008 09:50:37 -0500
Received: from timbuctoo.liddicott.com ([206.123.89.57]:38862 "EHLO
	timbuctoo.liddicott.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752669AbYKEOug (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Nov 2008 09:50:36 -0500
Received: from [192.168.0.180] (82.153.158.114 [82.153.158.114])
	by timbuctoo.liddicott.com; Wed, 05 Nov 2008 14:50:01 -0000
User-Agent: Thunderbird 2.0.0.17 (X11/20080925)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100159>

This is a multi-part message in MIME format.
--------------010105010800040602020500
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

* Sam Liddicott wrote, On 05/11/08 12:22:
> In some cases "patch" cannot apply diff's generated using git-diff, I've
> had a "git diff" output look like this when an empty file was removed as
> the only change:
>
> ..
> However this equivalent pair works by making the file non-empty and then
> deleting it.
>
> diff -Nru 1/here 2/here
> --- 1/here    2008-11-05 09:43:55.000000000 +0000
> +++ 2/here    2008-11-05 09:43:58.000000000 +0000
> @@ -0,0 +1 @@
> +
> diff -Nru 1/here 2/here
> --- 1/here    2008-11-05 09:37:23.000000000 +0000
> +++ 2/here    1970-01-01 01:00:00.000000000 +0100
> @@ -1 +0,0 @@
> -
>   
The same problem occurs with new empty files.

Attached is an awk filter which will expand out these git notes into the
2-part unified diff's.
It would be nicer if git did it natively.
Sam

--------------010105010800040602020500
Content-Type: text/plain;
 name="git-new-delete-filter.awk"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="git-new-delete-filter.awk"

#! /usr/bin/awk -f

function do_empty() {
  if (diff!="" && deleted!="" && indx!="") {
    printf("Make patch give the file 1 line\n");
    printf("--- %s\n",diff);
    printf("+++ %s\n",diff);
    printf("@@ -0,0 +1 @@\n+\n");
    printf("Make patch delete the 1 line file\n");
    printf("--- %s\t\n",diff);
    printf("+++ /dev/null\t1970-01-01 01:00:00.000000000\n");
    printf("@@ -1 +0,0 @@\n-\n");
  }
  if (diff!="" && created!="" && indx!="") {
    printf("Make patch create the file with 1 line\n");
    printf("--- %s\n",diff);
    printf("+++ %s\n",diff);
    printf("@@ -0,0 +1 @@\n+\n");
    printf("Make patch create delete the line but keep the file\n");
    printf("--- %s\n",diff);
    printf("+++ %s\n",diff);
    printf("@@ -1 +0,0 @@\n-\n");
  }
  no_empty();
}

function no_empty() {
  diff="";
  deleted="";
  created="";
  indx="";
}

{
  if (in_hunk > 0) in_hunk--;
}

/^diff --git / {
  do_empty();
  if (! in_hunk) diff=$3;
}

/^deleted file mode / {
  if (! in_hunk && diff!="") deleted=$0;
}

/^new file mode / {
  if (! in_hunk && diff!="") created=$0;
}

/^index / {
  if (! in_hunk && diff!="") indx=$0;
}

/^--- / {
  no_empty();
}

/^@@ / {
  # read the hunk size
  p=index($2,",");
  if (p==0) c1=1;
  else c1=strtonum(substr($2, p+1));

  p=index($3,",");
  if (p==0) in_hunk=1;
  else in_hunk=strtonum(substr($2, p+1));

  if (c1 > in_hunk) in_hunk=c1;
}

{
  print;
}

END {
  do_empty();
}

--------------010105010800040602020500--
