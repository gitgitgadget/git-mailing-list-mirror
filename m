From: "Jason Pyeron" <jpyeron@pdinc.us>
Subject: RFC: update hook for GPG signed submission on secured branches
Date: Fri, 16 Jan 2015 14:03:51 -0500
Organization: PD Inc
Message-ID: <BBE88A3EA44D47159C483F1046AC747E@black>
Reply-To: <git@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 16 20:04:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YCCBb-00010O-8O
	for gcvg-git-2@plane.gmane.org; Fri, 16 Jan 2015 20:03:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932137AbbAPTDy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Jan 2015 14:03:54 -0500
Received: from mail.pdinc.us ([67.90.184.27]:56410 "EHLO mail.pdinc.us"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932120AbbAPTDx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Jan 2015 14:03:53 -0500
Received: from black (nsa1.pdinc.us [67.90.184.2])
	(authenticated bits=0)
	by mail.pdinc.us (8.12.11.20060308/8.12.11) with ESMTP id t0GJ3qhW021670
	for <git@vger.kernel.org>; Fri, 16 Jan 2015 14:03:52 -0500
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AdAxvyq1RKWtQ2wZTrql3pEDbuTjHg==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.4913
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262561>

Dev & users:

I would like your feedback.

I am working on a continuous integration (CI) system for CipherShed.org and we want to allow any fork to submit their patch to our CI server farm which will do integration testing. We want it to be easy to submit code, but to not allow interference with other submitters branches or fetching of other people's (any for bandwidth and simplicity) branches.

What would you change? Any bugs that you see?

-Jason (no cc please, I am on the list)

Here are the 2 configs.

$ cat config
[core]
        repositoryformatversion = 0
        filemode = true
        bare = true
[http]
        receivepack = true
        uploadpack = false
        getanyfile = false

$ cat hooks/update
#!/bin/bash

# (c) 2015 PD Inc. License found at http://www.apache.org/licenses/LICENSE-2.0 .

# --- Command line
refname="$1"
oldrev="$2"
newrev="$3"

# --- Safety check
if [ -z "$GIT_DIR" ]; then
        echo "Don't run this script from the command line." >&2
        echo " (if you want, you could supply GIT_DIR then run" >&2
        echo "  $0 <ref> <oldrev> <newrev>)" >&2
        exit 1
fi

if [ -z "$refname" -o -z "$oldrev" -o -z "$newrev" ]; then
        echo "usage: $0 <ref> <oldrev> <newrev>" >&2
        exit 1
fi

sigkey=$(\
 git cat-file $newrev -p |\
 sed -e '/^ /{H;$!d;}; x;/^gpgsig /!d; s/^gpgsig//;' |\
 cut -c 2- |\
 gpg --list-packets --textmode |\
 sed '/keyid/!d; s/.*keyid \([0-9A-F]\{16\}\).*/\1/I' \
)

if [ -z "$sigkey" ]; then
        echo no GPG signature on commit $newrev
        exit 1
fi

if ! gpg -k "$sigkey" 2> /dev/null > /dev/null; then
        # "$sigkey" not known
        RES="$(gpg --keyserver hkp://pgp.mit.edu --recv-keys "$sigkey" 2>&1)"
        if [ $? -ne 0 ]; then
                echo "$RES"
                exit 1
        fi
fi

sigstatus=$(git log $newrev --pretty=format:%G? -n 1)

case "$sigstatus" in
        G)
                #ok, trusted
                ;;
        U)
                #ok, untrusted
                ;;
        *)
                #not ok
                echo sigstatus: $sigstatus
                git log $newrev --pretty=format:%GG -n 1
                exit 1;
                ;;
esac

if [[ $refname != refs/heads/* ]]; then
        echo only heads may be pushed, illegal ref: $refname
        exit 1;
fi

head="${refname:11}"

shopt -s nocasematch

case "$head" in
        ${sigkey}-*)
                #ok
                ;;
        ${sigkey}/*)
                #ok
                ;;
        ${sigkey:(-8)}-*)
                #ok
                ;;
        ${sigkey:(-8)}/*)
                #ok
                ;;
        *)
                #not your branch
                echo "you (a.k.a. $sigkey) are not authorized to push to branch: $head"
                echo "try making a branch like: $sigkey-... or $sigkey/*"
                echo "you can use a less secure ${sigkey:(-8)} too"
                exit 1
                ;;
esac

exit 0

--
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
-                                                               -
- Jason Pyeron                      PD Inc. http://www.pdinc.us -
- Principal Consultant              10 West 24th Street #100    -
- +1 (443) 269-1555 x333            Baltimore, Maryland 21218   -
-                                                               -
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
This message is copyright PD Inc, subject to license 20080407P00.
