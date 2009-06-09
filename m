From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: [PATCHv3 1/4] parse-remote: function to get the tracking branch 
	to be merge
Date: Tue, 9 Jun 2009 14:16:03 +0200
Message-ID: <adf1fd3d0906090516l6b1d5ec1rdc78ffffa116b765@mail.gmail.com>
References: <1244451651-22651-2-git-send-email-santi@agolina.net>
	 <7v8wk2wbfs.fsf@alter.siamese.dyndns.org>
	 <adf1fd3d0906090029s2aa7fe19j7b1005997d70b92c@mail.gmail.com>
	 <adf1fd3d0906090107w994de3chb39071e5911a59ae@mail.gmail.com>
	 <7veittrete.fsf@alter.siamese.dyndns.org>
	 <adf1fd3d0906090150k575c538ds28cd8c1a96909e9e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 09 14:16:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ME0G1-0005Se-2s
	for gcvg-git-2@gmane.org; Tue, 09 Jun 2009 14:16:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754867AbZFIMQF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Jun 2009 08:16:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754510AbZFIMQE
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jun 2009 08:16:04 -0400
Received: from mail-bw0-f213.google.com ([209.85.218.213]:58131 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752927AbZFIMQC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Jun 2009 08:16:02 -0400
Received: by bwz9 with SMTP id 9so3768346bwz.37
        for <git@vger.kernel.org>; Tue, 09 Jun 2009 05:16:03 -0700 (PDT)
Received: by 10.204.103.129 with SMTP id k1mr13835bko.22.1244549763028; Tue, 
	09 Jun 2009 05:16:03 -0700 (PDT)
In-Reply-To: <adf1fd3d0906090150k575c538ds28cd8c1a96909e9e@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121170>

2009/6/9 Santi B=E9jar <santi@agolina.net>:
> 2009/6/9 Junio C Hamano <gitster@pobox.com>:
>> Santi B=E9jar <santi@agolina.net> writes:
>>
>>>> git pull --rebase tags v1.6.0
>>>
>>> In fact: git pull --rebase remote tags v1.6.0
>>>
>>> But this still works because oldremoteref defaults to defaults_merg=
e.
>>> So the only behavior change is when a remote branch is
>>> rebased/retagged, and you have worst problems then. I think noone u=
sed
>>> the rebased functionality in this way, so I don't think it is worth=
 to
>>> support it. But if someone think it is important I'll do it.
>>
>> I personally do not think supporting such a form of input is absolut=
ely
>> necessary. =A0Even though technically it might be a regression, if i=
t is so
>> rare a form, we can simply say "this strange form used to work, but =
now it
>> does not; you can use this form instead to do the same thing", and m=
ove
>> on.
>
> OK.
>

At the end it was a little patch to get this corner case working. Here
it is the patch to squash (I'll send later a proper patch mail, with a
test).

And this additional sentence in the commit log:

No behavior changes. The new function behaves like the old code used in
"git pull --rebase".

diff --git i/git-parse-remote.sh w/git-parse-remote.sh
index 8b3ba72..4ac277f 100755
--- i/git-parse-remote.sh
+++ w/git-parse-remote.sh
@@ -238,8 +238,12 @@ get_remote_merge_branch () {
 	    shift
 	    # FIXME: It should return the tracking branch
 	    #        Currently only works with the default mapping
-	    for ref
-	    do
+	    case "$1" in
+	    tag)
+		[ -n "$2" ] && echo "refs/tags/${ref}"
+		;;
+	    *)
+		ref=3D$1
 		case "$ref" in
 		+*)
 			ref=3D$(expr "z$ref" : 'z+\(.*\)')
@@ -251,12 +255,11 @@ get_remote_merge_branch () {
 		'' | HEAD ) remote=3DHEAD ;;
 		heads/*) remote=3D${remote#heads/} ;;
 		refs/heads/*) remote=3D${remote#refs/heads/} ;;
-		refs/* | tags/* | remotes/* ) break
+		refs/* | tags/* | remotes/* ) remote=3D
 		esac

-		echo "refs/remotes/$repo/$remote"
-		break
-	    done
+		[ -n "$remote" ] && echo "refs/remotes/$repo/$remote"
+	    esac
 	    ;;
 	esac
 }

(Sorry, if it gets corrupted)

Santi
