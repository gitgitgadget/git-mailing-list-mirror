From: Johan Herland <johan@herland.net>
Subject: Re: Submodule using different repository URLs
Date: Mon, 13 Jul 2009 14:43:25 +0200
Message-ID: <200907131443.25719.johan@herland.net>
References: <5BE6F3DC-4B00-4D84-8D0E-41057735483F@petervoss.org> <64652870-CF95-49A7-920A-0F9A6C202B40@petervoss.org> <200907131428.43652.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Peter Voss <info@petervoss.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 13 14:43:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MQKsh-0003OR-Q1
	for gcvg-git-2@gmane.org; Mon, 13 Jul 2009 14:43:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755629AbZGMMne (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jul 2009 08:43:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755542AbZGMMne
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Jul 2009 08:43:34 -0400
Received: from sam.opera.com ([213.236.208.81]:40962 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755461AbZGMMnd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jul 2009 08:43:33 -0400
Received: from pc107.coreteam.oslo.opera.com (pat-tdc.opera.com [213.236.208.22])
	(authenticated bits=0)
	by smtp.opera.com (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id n6DChP5X029277
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 13 Jul 2009 12:43:31 GMT
User-Agent: KMail/1.9.9
In-Reply-To: <200907131428.43652.johan@herland.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123190>

On Monday 13 July 2009, Johan Herland wrote:
> On Monday 13 July 2009, Peter Voss wrote:
> > On 13.07.2009, at 12:59, Johan Herland wrote:
> > > You might be able to pull this off using relative submodule URLs.
> >
> > That's a good hint. Unfortunately I can't use this to go up 2
> > directories. I.e. I can't get from
> > git@github.com:xxx/mymodule.git
> > to
> > git@github.com:yyy/foo.git
> >
> > Using the relative URL ../../yyy/foo.git leads to the result:
> > Clone of 'git@github.com:xxx/yyy/foo.git' into submodule path 'foo'
> > failed
> >
> > So I basically cannot replace the xxx part.
>
> This is due to a small bug in git-submodule.sh. In the
> resolve_relative_url() function, when repeatedly unwrapping '../'s
> from $url in the while loop, the line remoteurl="${remoteurl%/*}"
> removes everything _after_ the last slash, which does not work for
> the git@github.com:xxx part of your URL.
>
> This should be relatively easy to fix, although maybe not as
> straightforwardly trivial as it might seem at first sight.
>
> I don't have the time to look into this now, so feel free to take a
> stab at it.

Here's a first stab at it (TOTALLY UNTESTED). Obviously it needs a
testcase (typically in t7400-submodule-basic.sh) as well.


Have fun! :)

...Johan


diff --git a/git-submodule.sh b/git-submodule.sh
index ebed711..7d8f7a7 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -27,12 +27,19 @@ resolve_relative_url ()
 		die "remote ($remote) does not have a url defined in .git/config"
 	url="$1"
 	remoteurl=${remoteurl%/}
+	sep="/"
 	while test -n "$url"
 	do
 		case "$url" in
 		../*)
 			url="${url#../}"
-			remoteurl="${remoteurl%/*}"
+			newremoteurl="${remoteurl%/*}"
+			if test "$newremoteurl" = "$remoteurl" -a "$sep" = "/"
+			then
+				newremoteurl="${remoteurl%:*}"
+				sep=":"
+			fi
+			remoteurl="$newremoteurl"
 			;;
 		./*)
 			url="${url#./}"
@@ -41,7 +48,7 @@ resolve_relative_url ()
 			break;;
 		esac
 	done
-	echo "$remoteurl/${url%/}"
+	echo "$remoteurl$sep${url%/}"
 }
 
 #


-- 
Johan Herland, <johan@herland.net>
www.herland.net
