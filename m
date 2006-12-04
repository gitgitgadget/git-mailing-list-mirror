X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] gitweb: Add committags support (take 2)
Date: Mon, 4 Dec 2006 12:33:19 +0100
Message-ID: <200612041233.19377.jnareb@gmail.com>
References: <200612040001.13640.jnareb@gmail.com> <200612041133.44816.jnareb@gmail.com> <7vmz64ortu.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Mon, 4 Dec 2006 11:31:31 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=XRVxjPNqNzTCQin75LTN32SvjURIfanNx6vtVpdfkUPdAwndBOgJ7Bd5+fHgKxh4nx6TIEfjcIL4xIWTmKmLa3F1eAgy2ZYBzX60AWNWjQJnrVBXIqcm84ote7tumo6WAXAT0z9OwB4seSf34aulQ+8bH0VJF6xBYvYQUsILmgs=
User-Agent: KMail/1.9.3
In-Reply-To: <7vmz64ortu.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33189>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrC2g-00061i-Ow for gcvg-git@gmane.org; Mon, 04 Dec
 2006 12:31:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S936044AbWLDLbY convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Mon, 4 Dec 2006 06:31:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936048AbWLDLbY
 (ORCPT <rfc822;git-outgoing>); Mon, 4 Dec 2006 06:31:24 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:15636 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S936044AbWLDLbX
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 4 Dec 2006 06:31:23 -0500
Received: by ug-out-1314.google.com with SMTP id 44so2965719uga for
 <git@vger.kernel.org>; Mon, 04 Dec 2006 03:31:18 -0800 (PST)
Received: by 10.66.232.9 with SMTP id e9mr11832264ugh.1165231877664; Mon, 04
 Dec 2006 03:31:17 -0800 (PST)
Received: from host-81-190-24-209.torun.mm.pl ( [81.190.24.209]) by
 mx.google.com with ESMTP id i39sm26018651ugd.2006.12.04.03.31.16; Mon, 04 Dec
 2006 03:31:17 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Dnia poniedzia=B3ek 4. grudnia 2006 11:53, Junio C Hamano napisa=B3:
> Jakub Narebski <jnareb@gmail.com> writes:
>=20
>> I have one gripe about "git-cat-file -t". I'd like it to have=20
>> -q/--quiet, -s/--silent, --hush (or --dont-spew-errors-on-stdout)
>> which would prohibit writing "object not found" errors on stderr
>> (and in gitweb case to webserver logs). I know I can use
>> "git-cat-file -e" to check if object exists, or modify git_get_type
>> subroutine=20
>>
>>   # get type of given object
>>   sub git_get_type {
>> 	my $hash =3D shift;
>>   	my $git_command =3D git_cmd_str();
>>  =20
>>   	open my $fd, "-|",
>>   		"$git_command cat-file -t $hash 2>/dev/null"
>>   		or return '';
>=20
> It is one thing if you tend to randomly throw garbage at this
> function and use it to check for object's existence, but I hope
> you are already checking the user input (which is what $hash is,
> I think, here), and the object is supposed to exist in the
> repository you are looking at.  In such a case, I think you and
> your server administrator have right to know about that
> situation; I do not see why you would want to squelch it.

I'm sorry, I should mention that this "quiet" mode of operation is=20
needed _only_ for committags support, for example by using
git_get_type($hash_text, -quiet=3D>1) in 'sha1' committag subroutine.

You might have sha1 ids in commit message which no longer point to vali=
d=20
(existing) object, for example commit which is result of=20
"git cherry-pick -x" from no longer existing temporary branch, or commi=
t=20
which is result of "git revert" on a branch which got rebased (but not=20
reorganized), or shortened sha1 which is no longer unique. This should=20
not cause errors to be written to webserver log.
=20

By the way, is it better to use anonymous subroutines for committags=20
subs, or use explicit subroutines?

>>> I do not know how this %committags{} is used per project.  With
>>> a setting like repo.or.cz, it is likely that one instance of
>>> gitweb is serving unrelated projects that have their issue
>>> tracker at different locations using different "committags"
>>> convention.  Is the idea to eventually allow enabling/disabling
>>> elements from the global %committags per repository somehow
>>> (perhaps not just enable/disable but even overriding patterns or
>>> parameters)?
>>
>> I have thought about putting %committags and @committags before
>> loading config file
>>   do $GITWEB_CONFIG if -e $GITWEB_CONFIG;
>> which can load config file depending on the project, but perhaps
>> it is too complicated solution.
>=20
> I think you are talking about a gitweb-instance wide
> customization, but that's not what I meant.  I meant per-project
> configuration where w/git-gui.git and w/git.git are served by
> the same instance of gitweb but have pointers to different issue
> trackers.

You can always use $ENV{PATH_INFO} in $GITWEB_CONFIG value,
or check out path_info and/or $cgi->params('p') in the config file.
Or perhaps other way to set-up per repository config file.
But this is a bit complicated to set up.

I don't have definite answer about how configure committags
(both the committags enabled and sequence of committags, and
committags parameters) per repository. We can use gitweb.committags=20
config variable for committags enables/sequence, but how configure=20
committags? gitweb.committag.<name>?

BTW in some cases (e.g. xmms2 projects) issue tracker is common for
all projects hosted.

>>>> 3. To not split message into many fragments we concatenate strings
>>>> if possible.
>>>=20
>>> I do not know why "avoiding splits" is needed, if it raises=20
>>> issues that you need to ask the list about in a message like
>>> this...
>>
>> "Avoiding splits" is needed first for performance, and second to
>> avoid situation where pattern would match on the boundary between
>> two strings in a list of tokens to process.
>=20
> I wouldn't know if constantly splitting and then concatenating
> is faster than just concatenatting once before output without
> benchmarking, so I'd refrain from talking about performance.
> Two string case may be a valid concern, though.

With current implementation it is very easy to switch this one and off.
You simply either use push, or push_or_append (or make push_or_append
do just push).

Previous (not published) version used $acc variable to concatenate=20
strings, but I think this solution is better (and simpler).

--=20
Jakub Narebski
