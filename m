From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [TopGit PATCHv2] provide global temporary directory
Date: Sun, 10 Oct 2010 09:47:47 +0200
Message-ID: <AANLkTikuEa6TQpEnv=0y3v18W9H8sC4SQ+5vdTvBW7LF@mail.gmail.com>
References: <d351f9124a96f212fe66ee85b4241753be94ab2b.1286660467.git.bert.wesarg@googlemail.com>
	<20101009215302.GR29673@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, pasky@suse.cz,
	martin f krafft <madduck@madduck.net>
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Sun Oct 10 09:48:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4qdb-0000uy-0i
	for gcvg-git-2@lo.gmane.org; Sun, 10 Oct 2010 09:48:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752341Ab0JJHrt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Oct 2010 03:47:49 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:52977 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751921Ab0JJHrs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Oct 2010 03:47:48 -0400
Received: by iwn6 with SMTP id 6so2054838iwn.19
        for <git@vger.kernel.org>; Sun, 10 Oct 2010 00:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=031H3YgQgi7nr7odxyd5WtdqMd+WT+fr116UtDpBO7w=;
        b=lUY0iYzoNt23j4KtvvrKJnZWT2MoykNYHEt+3WmyoeLfb5IPyB7I4bPqe8fAGxlLIr
         yAgP+rlGD7kppeJNqEC8QPikHraiWgcfmw2gb0Bqz6faB/8wens2LQT8NQ1NRaCGB4Jv
         tT9nflx162wkerGMrv4ToLToyLiHbIDTL3BQU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=cmZO5pBgiLB/xa8N+NOy9fEKThRL2mhze+x7dXObrdnz2/sKTp3WPKkjxjBNeu7Cez
         iqJRzLRZcWaUoLcF9GlBAzDXcUcTRoqtU8RIG8w1mmnrHjr6rdyLc5V8BjC9tZX8LJZt
         B4PYXhmcKBPQFS46KtVtLLOaahqk1d4X+h4yY=
Received: by 10.42.163.70 with SMTP id b6mr990847icy.338.1286696867387; Sun,
 10 Oct 2010 00:47:47 -0700 (PDT)
Received: by 10.231.147.80 with HTTP; Sun, 10 Oct 2010 00:47:47 -0700 (PDT)
In-Reply-To: <20101009215302.GR29673@pengutronix.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158649>

2010/10/9 Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>:
> On Sat, Oct 09, 2010 at 11:41:47PM +0200, Bert Wesarg wrote:
>> +# get_temp NAME [-d]
> I like your patch in general, but would prefer to have
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0# get_temp [-d] NAME

But that would complicate the argument evaluation, wouldn't it:

get_temp()
{
    if [ $# -eq 2 ]; then
        mktemp $1 "$tg_tmp_dir/$2.XXXXXX"
    else
        mktemp "$tg_tmp_dir/$1.XXXXXX"
    fi
}

This and the functions with [-i | -w] are internal and won't be called
by the user, so we have full control over the calling convention and
should make it easy for us. And putting the optional argument at the
end is easy. I should probably remove the die call in cat_file,
because that would be an programmer error not an user error.

>
>> +# creates a new temporary file (or directory with -d) in the global
>> +# temporary directory $tg_tmp_dir with pattern prefix NAME
>> +get_temp()
>> +{
>> + =C2=A0 =C2=A0 mktemp ${2-} "$tg_tmp_dir/$1.XXXXXX"
> Does the - makes any difference? =C2=A0If yes, is it portable (enough=
)?

=46or me its an indicator, that it doesn't matter whether $2 was given
or not. Also you could run under set -u without error. But I don't do
this.

It's in POSIX [1].

Bert

[1] Statement given without interpretation.

> Best regards
> Uwe
>
> --
> Pengutronix e.K. =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | Uwe Kleine-K=C3=B6nig =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|
> Industrial Linux Solutions =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 | http://www.pengutronix.de/ =C2=A0|
>
