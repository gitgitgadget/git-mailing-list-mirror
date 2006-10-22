From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [PATCH 3/3] Teach git-branch -v and -w options
Date: Sun, 22 Oct 2006 21:55:52 +0200
Message-ID: <8c5c35580610221255n521e84e2u8594016297c6cf87@mail.gmail.com>
References: <1161516626749-git-send-email-hjemli@gmail.com>
	 <11615166273819-git-send-email-hjemli@gmail.com>
	 <7vmz7o5eki.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Sun Oct 22 21:56:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbjQT-0003FZ-K7
	for gcvg-git@gmane.org; Sun, 22 Oct 2006 21:56:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751212AbWJVT4A convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 22 Oct 2006 15:56:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751218AbWJVT4A
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Oct 2006 15:56:00 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:11698 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751212AbWJVTz7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Oct 2006 15:55:59 -0400
Received: by nf-out-0910.google.com with SMTP id c2so2136760nfe
        for <git@vger.kernel.org>; Sun, 22 Oct 2006 12:55:57 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LgbDI4DU1b8yI5UxuV6r18JOpeVMax8/ruThpzxDmsmXrhtgx/4e/+9/Yn79hDrbBc92lmu8d6khK/4NxrgYhrOjBRZTm+5IuddovY92rXggCy1i8HJTHYyJ6c2EXkqe0a7lh65B2Lhguu8heR58FOFLVUKoLEnsdnxMS7DFWvg=
Received: by 10.82.101.3 with SMTP id y3mr1146276bub;
        Sun, 22 Oct 2006 12:55:57 -0700 (PDT)
Received: by 10.82.171.10 with HTTP; Sun, 22 Oct 2006 12:55:52 -0700 (PDT)
To: git@vger.kernel.org
In-Reply-To: <7vmz7o5eki.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29780>

On 10/22/06, Junio C Hamano <junkio@cox.net> wrote:
> If you are going in this direction, probably you would want to
> refactor 2/3 a bit differently, so that you do not have to
> duplicate the same printf for local and remote cases?
>

I actually did, but then abandoned it since it would change the output
for remote branches (two spaces indent). I didn't want to cause any
regressions :-)

But if that's ok, my abandoned patch contained this:

@@ -48,14 +48,35 @@ If you are sure you want to delete it, r
    exit 0
 }

-ls_remote_branches () {
-    git-rev-parse --symbolic --all |
-    sed -ne 's|^refs/\(remotes/\)|\1|p' |
-    sort
-}
-+width=3D20
+sedmatch=3D"^refs/heads/"
+sedsubst=3D
+verbose=3D
 force=3D
 create_log=3D
+
+ls_refs () {
+       git-rev-parse --symbolic --all |
+       sed -ne "s|$sedmatch|$sedsubst|p" |
+       sort |
+       while read ref
+       do
+               if test "$headref" =3D "$ref"
+               then
+                       pfx=3D'*'
+               else
+                       pfx=3D' '
+               fi
+               if test "$verbose" =3D "yes"
+               then
+                       log=3D$(git-log --max-count=3D1 --pretty=3Donel=
ine $ref)
+                       printf "%s %-*s %s\n" "$pfx" "$width" "$ref" "$=
log"
+               else
+                       echo "$pfx $ref"
+               fi
+       done
+}
+
 while case "$#,$1" in 0,*) break ;; *,-*) ;; *) break ;; esac
 do
       case "$1" in
@@ -64,8 +85,8 @@ do
               exit
               ;;
       -r)
-               ls_remote_branches
-               exit
+               sedmatch=3D"^refs/\(remotes/\)"
+               sedsubst=3D"\1"
               ;;
       -f)
               force=3D"$1"
@@ -73,6 +94,13 @@ do
       -l)
               create_log=3D"yes"
               ;;
+       -v)
+               verbose=3D"yes"
+               ;;
+       -w)
+               shift
+               width=3D$1
+               ;;
       --)
               shift
               break
@@ -86,18 +114,7 @@ done

 case "$#" in
 0)
-       git-rev-parse --symbolic --branches |
-       sort |
-       while read ref
-       do
-               if test "$headref" =3D "$ref"
-               then
-                       pfx=3D'*'
-               else
-                       pfx=3D' '
-               fi
-               echo "$pfx $ref"
-       done
+       ls_refs
       exit 0 ;;
 1)
       head=3DHEAD ;;


And then I added -a and -t (for "all" and "tags", obviously), and felt
I went over the top :-)

Btw: in the meantime, Kristian H=F8gsberg pointed me to an earlier
thread regarding making git-branch a builtin, which I'm going to look
at tonight.

So many options, so little time :-)

I'm open for suggestions/preferences etc...

--
larsh
