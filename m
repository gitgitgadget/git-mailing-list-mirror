From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: error: git-svn died of signal 13
Date: Wed, 9 Dec 2009 01:53:19 -0600
Message-ID: <20091209075319.GA4201@progeny.tock>
References: <20091209053602.GA2739@progeny.tock>
 <20091209055824.GA22941@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
To: Frederik Hohlfeld <frederik.hohlfeld@gmail.com>,
	Adam Borowski <kilobyte@angband.pl>,
	David =?iso-8859-1?Q?F=F6rster?= <david@dfoerster.de>
X-From: git-owner@vger.kernel.org Wed Dec 09 08:40:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NIH9a-0007nA-23
	for gcvg-git-2@lo.gmane.org; Wed, 09 Dec 2009 08:40:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757293AbZLIHjx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Dec 2009 02:39:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757280AbZLIHjw
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Dec 2009 02:39:52 -0500
Received: from mail-gx0-f226.google.com ([209.85.217.226]:40086 "EHLO
	mail-gx0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757270AbZLIHjw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Dec 2009 02:39:52 -0500
Received: by gxk26 with SMTP id 26so5883702gxk.1
        for <git@vger.kernel.org>; Tue, 08 Dec 2009 23:39:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=w1xXZwNTMPOM8DHYgWO8GZVP5AFhyCuSN0vSLFQmaU4=;
        b=BPKQBAgEbLwe1Gy2Mdy0klgoik4PdAVqB6y7BopvfC3S6o4ihTo7PmJsHUBJXpkLhU
         ptLOi0EUcqWBLq8ay25ECUvpojt0M7F0H4Aug8BDpGHMwkRwOY+bitiTaIAPw//MHsTG
         kiTCB/HUKWMTV3aY9w8ONWNzD2zdidhW5ykrw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=dU2oajN+N9tQXhTqpmqycJLk64nLwZZWec6zEXyJqDb1cZ1dQ0z09SYrtdggfht7yC
         V+gyOnreqJAasSG7x2yiTm5xsGsr+aka/3t6rRrkbq8pVkf6xuONIhvJ/AUnSE5KqhjZ
         9+WC0wbcfF/SlEGq72vsr7UKhg/ElRmHlRS8s=
Received: by 10.91.18.5 with SMTP id v5mr1636926agi.91.1260344398303;
        Tue, 08 Dec 2009 23:39:58 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 21sm4658117iwn.14.2009.12.08.23.39.56
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 08 Dec 2009 23:39:57 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20091209055824.GA22941@dcvr.yhbt.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134945>

CCing those who reported the problem.  There is some debugging advice b=
elow,
for anyone who wants to take a further stab at tracking this down.

Eric Wong wrote:
> Jonathan Nieder <jrnieder@gmail.com> wrote:

>> Just wanted to pass on a few reports about git-svn dying with SIGPIP=
E
>> when trying to fetch large repositories.  It seems to fetch a few
>> revisions, then die; the repositories can eventually be fetched
>> successfully by restarting 'git svn fetch' again and again.
>>=20
>> Some bug reporters have been very patient, but I don=E2=80=99t reall=
y know
>> where to look or ask in solving this.  Attempts at tracing so far ha=
ve
>> given either too little or too much information to make any sense.
>>=20
>> The problem goes back at least to v1.5.6.5.
>
> Hi Jonathan,
>
> Thanks for taking the time to look into this.  This has been a
> problem for a long time and very difficult to track down.
>
> One factor is that git svn continues happily afterwards so it's hard =
to
> reproduce and there's less incentive to look for a fix.
>
>> At the end of the git-svn process=E2=80=99s life, the last few funct=
ion calls
>> are these:
>>=20
>>  - SVN::Ra::Reporter::finish_report and related functions
>>  - _p_apr_pool_t::DESTROY (libsvn-perl cleaning up, presumably)
>>  - SVN::Ra::Callbacks::open_tmp_file, called from
>>    SVN::_Ra::svn_ra_do_update, called from
>>    Git::SVN::Ra::do_update, called from
>>    Git::SVN::Ra::gs_do_update
>>  - Git::SVN::_set_repos_root
>>  - starting a 'git update-index -z --index-info' to feed commands to
>>=20
>> Maybe /tmp is filling up?  It is hard to know, since the SIGPIPE sto=
ps
>> everything and we do not get any nice, simple error message describi=
ng
>> what read or write would have received EPIPE.
>>=20
>> See <http://bugs.debian.org/526989>, <http://bugs.debian.org/540150>=
,
>> <http://thread.gmane.org/gmane.comp.version-control.git/85868/>.
>>=20
>> Any insights?
>
> Can somebody get an strace or core dump for the "git update-index"
> call?  Or even an strace -f of the entire git svn invocation as well.=
=2E.
