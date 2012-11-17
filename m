From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC/PATCH 5/5] completion: refactor __gitcomp_1
Date: Sat, 17 Nov 2012 12:27:40 +0100
Message-ID: <CAMP44s3OG+dzxZNpR+qELvcS37KDWh+Bnf0K1zGze4f3P4OWNg@mail.gmail.com>
References: <1353116298-11798-1-git-send-email-felipe.contreras@gmail.com>
	<1353116298-11798-6-git-send-email-felipe.contreras@gmail.com>
	<20121117105837.GC12052@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Bj=C3=B6rn_Gustavsson?= <bgustavsson@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Robert Zeh <robert.a.zeh@gmail.com>,
	Peter van der Does <peter@avirtualhome.com>,
	Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
To: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Sat Nov 17 12:29:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZgaO-0003RY-U0
	for gcvg-git-2@plane.gmane.org; Sat, 17 Nov 2012 12:29:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751480Ab2KQL1m convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 17 Nov 2012 06:27:42 -0500
Received: from mail-ob0-f174.google.com ([209.85.214.174]:49827 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751268Ab2KQL1l convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 17 Nov 2012 06:27:41 -0500
Received: by mail-ob0-f174.google.com with SMTP id wc20so3596947obb.19
        for <git@vger.kernel.org>; Sat, 17 Nov 2012 03:27:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=hrUu2RBEwW9h5kZ9aOL2rmaQXMTJ1O9MsAVgMI7E/bc=;
        b=jN/E0c+YLtKgrlFAgvPHAnO3/1dtw5+LztnYQJWvhXO15OKBhRt1sSe2YHKZvLmzeK
         VAF5OdR6/8JM3ro3ocz5odZ8Smf4gWgPHrWvwjww+IhN/wYYBRGPD0KcSZ3kZLwrcT9T
         FXYs5preXrK3gT9fXsvtcrNEQp2whDZZyHypWf5e09sd8MALw5CLENrquHMDTUIrsOz+
         dsIt+s7NEgi2heyTh3TZ12OO0IUKeHCFcSmF1ft4WmV3FqHTKMEWavxOrp16TRVCNKpF
         NSLnBF7zXK6e098H3gsGgTYEmQbL54ESQBas/rma22A8iY57gDGQZ8+7bDrr819NmIOS
         NB8w==
Received: by 10.60.14.101 with SMTP id o5mr3682533oec.85.1353151660980; Sat,
 17 Nov 2012 03:27:40 -0800 (PST)
Received: by 10.60.4.74 with HTTP; Sat, 17 Nov 2012 03:27:40 -0800 (PST)
In-Reply-To: <20121117105837.GC12052@goldbirke>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209948>

On Sat, Nov 17, 2012 at 11:58 AM, SZEDER G=C3=A1bor <szeder@ira.uka.de>=
 wrote:

>>  # The following function is based on code from:
>> @@ -249,10 +246,16 @@ __gitcomp ()
>>       --*=3D)
>>               ;;
>>       *)
>> -             local IFS=3D$'\n'
>> -             __gitcompadd "$(__gitcomp_1 "${1-}" "${4-}")" "${2-}" =
"$cur_" ""
>> +             local c IFS=3D$' \t\n'
>> +             for c in ${1-}; do
>> +                     c=3D`__gitcomp_1 "$c${4-}"`
>
> 1. Backticks.
> 2. A subshell for every word in the wordlist?

=46ine, lets make it hard for zsh then:

--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -56,19 +56,6 @@ __gitdir ()
        fi
 }

-__gitcomp_1 ()
-{
-       local c IFS=3D$' \t\n'
-       for c in $1; do
-               c=3D"$c$2"
-               case $c in
-               --*=3D*|*.) ;;
-               *) c=3D"$c " ;;
-               esac
-               printf '%s\n' "$c"
-       done
-}
-
 # The following function is based on code from:
 #
 #   bash_completion - programmable completion functions for bash 3.2+
@@ -241,12 +228,22 @@ __gitcomp ()
                COMPREPLY=3D()
                ;;
        *)
-               local IFS=3D$'\n'
-               COMPREPLY=3D($(compgen -P "${2-}" \
-                       -W "$(__gitcomp_1 "${1-}" "${4-}")" \
-                       -- "$cur_"))
+               local c i IFS=3D$' \t\n'
+               i=3D0
+               for c in ${1-}; do
+                       c=3D"$c${4-}"
+                       case $c in
+                       --*=3D*|*.) ;;
+                       *) c=3D"$c " ;;
+                       esac
+                       if [[ "$c" =3D "$cur_"* ]]; then
+                               (( i++ ))
+                               COMPREPLY[$i]=3D"${2-}$c"
+                       fi
+               done
                ;;
        esac
+
 }

 # Generates completion reply with compgen from newline-separated possi=
ble

--=20
=46elipe Contreras
