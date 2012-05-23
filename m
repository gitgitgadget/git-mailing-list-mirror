From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PATCH v4 2/2] submodule: fix handling of relative superproject
 origin URLs
Date: Thu, 24 May 2012 08:17:19 +1000
Message-ID: <CAH3AnrrYm_KeP64yDc+gujkYqj-kiuLQ4URHX5Z57vj5XXLfKw@mail.gmail.com>
References: <1337791554-31294-1-git-send-email-jon.seymour@gmail.com>
	<1337791554-31294-3-git-send-email-jon.seymour@gmail.com>
	<4FBD5B8C.60605@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Thu May 24 00:18:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXJsW-0008BE-OG
	for gcvg-git-2@plane.gmane.org; Thu, 24 May 2012 00:18:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751203Ab2EWWRV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 May 2012 18:17:21 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:53544 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750838Ab2EWWRV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 May 2012 18:17:21 -0400
Received: by wibhj8 with SMTP id hj8so5122425wib.1
        for <git@vger.kernel.org>; Wed, 23 May 2012 15:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=EWsPrAHRT3iJP/Qu0KlOQVLspPAz/qrp3kaZu+jGLvE=;
        b=mhe/uUcmoUoTdKFwnjwzanbmn2+lCOimwm46F9QxjPaymRUalInXHk+U0QBEJPhNlI
         hJJFNZ2hY1gBYV1W4mk5CT3Ld8wH3RS4x5Kk406gL63MWyXbHxljBlO1MOZqUXMaRRDP
         BDHD6qv+H9xs6beZc8iah1ghiFClpXYbGRFPRN6gwuHtd9SsCohmmmhax/6j7Zn76eiU
         b2D7IK1np739SlydjS6Osvr6/6ZpYl6VrsMeJQPm2uhIp9Q/n0SZWJq/Ybh2dGGApPsh
         Or5HWkjO2gG6kOlxVbXuyrvSyWLgRgMrCXbNGOc4aCfLckEBs8Sp1Q8qudhLr+/i9tnj
         /Zew==
Received: by 10.216.143.223 with SMTP id l73mr15013182wej.97.1337811439872;
 Wed, 23 May 2012 15:17:19 -0700 (PDT)
Received: by 10.180.146.166 with HTTP; Wed, 23 May 2012 15:17:19 -0700 (PDT)
In-Reply-To: <4FBD5B8C.60605@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198330>

On Thu, May 24, 2012 at 7:50 AM, Jens Lehmann <Jens.Lehmann@web.de> wro=
te:
> Am 23.05.2012 18:45, schrieb Jon Seymour:
>
> As mentioned last time I'd rather use $2 directly at the only site
> where $prefix is used. (On the other hand it might also make sense
> to give the parameters a descriptive name at the beginning of the
> function, but then I'd vote for a descriptive name like "urlprefix"
> or similar to make its meaning clearer)

Ok, I was favouring your latter heuristic. Are you ok if I use up_path =
here?

>
>> + =C2=A0 =C2=A0 remoteurl=3D$(echo "$remoteurl" | sed "s|^[^/:\\.][^=
:]*\$|./&|")
>
> A comment describing what this line actually does would be nice.
>

Sure, will do. What it does is to allow URLs of the form foo/ or
foo/bar to be handled by the .*/* case in the switch below by
rewriting the URL to prefix ./ in that case.

It doesn't do it for URLs that already begin with . (don't need it), /
(mustn't have it) or : (assuming that any path beginning with : should
probably be handled by the *:* case).

>> =C2=A0 =C2=A0 =C2=A0 remoteurl=3D${remoteurl%/}
>> =C2=A0 =C2=A0 =C2=A0 sep=3D/
>> =C2=A0 =C2=A0 =C2=A0 while test -n "$url"
>> @@ -45,6 +47,11 @@ resolve_relative_url ()
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ../*)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 url=3D"${url#../}"
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 case "$remoteurl" in
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 .*/*)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 remoteurl=3D"${remoteurl%/*}"
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 remoteurl=3D"${remoteurl#./}"
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 remoteurl=3D"${prefix}${remoteurl}"
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ;;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 */*)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 remoteurl=3D"${remoteurl%/*}"
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ;;
>> @@ -64,7 +71,7 @@ resolve_relative_url ()
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 break;;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 esac
>> =C2=A0 =C2=A0 =C2=A0 done
>> - =C2=A0 =C2=A0 echo "$remoteurl$sep${url%/}"
>> + =C2=A0 =C2=A0 echo "${remoteurl%/.}$sep${url%/}"
>
> Wouldn't that better be handled in the ".*/*)" case above to avoid
> accidentally affecting the other cases?

Yes, I think you are right. Thanks.

>
>> =C2=A0}
>>
>> =C2=A0#
>> @@ -964,8 +971,14 @@ cmd_sync()
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Possibly a url re=
lative to parent
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case "$url" in
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ./*|../*)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 up_path=3D"$(echo "$sm_path" | sed "s/[^/]*/../g")" &&
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 up_path=3D${up_path%/}/ &&
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 remoteurl=3D$(resolve_relative_url "$url" "$up_path") &&
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 url=3D$(resolve_relative_url "$url") || exit
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 ;;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 remoteurl=3D"$url"
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 ;;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 esac
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if git config "subm=
odule.$name.url" >/dev/null 2>/dev/null
>> @@ -979,7 +992,7 @@ cmd_sync()
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 clear_local_git_env
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cd "$sm_path"
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 remote=3D$(get_default_remote)
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 git config remote."$remote".url "$url"
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 git config remote."$remote".url "$remot=
eurl"
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 )
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 fi
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fi
>
> I still have to wrap my head around these two hunks (I suspect it's
> too late for that in my timezone ;-), but I really wonder how you get
> away without changing cmd_add and cmd_init like you did last time.
> This looks much different than #2 and #4 of your v3 combined, which
> makes me suspicious in what direction this is evolving. Maybe you cou=
ld
> tell us what you found out addressing the last problem you mentioned
> and how you handled it?

So, I subsequently noticed that v3 broke the clone done by a
subsequent update in the case of paths of the form ../foo/bar That was
because I had violated an implicit invariant - namely that the
submodule.{name}.url configuration variable in the superproject is
always a path relative to the working tree of the superproject. In v3,
I had effectively made this value relative to the working tree of the
submodule. I mostly only need to modify sync behaviour, because that
is the only path that modifies the remote.origin.url of the submodule
- the other two paths modify the submodule.{name}.url variable of the
superproject and this behaviour is mostly correct (sans normalisation
issues).

This series respects the implicit invariant that relative paths in
configuration properties (submodule.{name}.url and
remote.{remote}.url) are always relative to the working tree of the
repository in which the configuration variable is defined.

I'll try to find a way to inject aspects of this commentary into the co=
mments.

>
>
> The only changes following here should be from test_expect_failure
> to test_expect_success as mentioned in my response to your first patc=
h.
>

Sure.

Thanks for your review.

jon.
