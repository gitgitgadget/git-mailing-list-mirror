From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [GSoC update] Sequencer for inclusion
Date: Wed, 13 Jul 2011 15:11:54 +0530
Message-ID: <CALkWK0=EDZ9E1qYg=bEt2h3jmUUvERoiR1TpkUupRO2XrYyt9A@mail.gmail.com>
References: <1310396048-24925-1-git-send-email-artagnon@gmail.com>
 <20110711171713.GA5963@elie> <7vpqlgbjmd.fsf@alter.siamese.dyndns.org>
 <20110711221419.GE30155@sigill.intra.peff.net> <CALkWK0n41LZ8-ZU2M1oD_ddJ2g2A47MxuO8w+5Ew6Php8gvF+g@mail.gmail.com>
 <20110712064706.GA13375@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Miles Bader <miles@gnu.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jul 13 11:42:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QgvxV-0006UV-EP
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jul 2011 11:42:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965206Ab1GMJmQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Jul 2011 05:42:16 -0400
Received: from mail-ww0-f42.google.com ([74.125.82.42]:45192 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965169Ab1GMJmP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Jul 2011 05:42:15 -0400
Received: by wwg11 with SMTP id 11so308798wwg.1
        for <git@vger.kernel.org>; Wed, 13 Jul 2011 02:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=k9m3prOPclaAL290552cFQyreyzKkospcxcddN0yNAE=;
        b=PFrOlwes8KeRwRjl3x+G1v0x9p1GFia58N4Nlj/TS1p067Afb4fRKbxB3AIRc75UY6
         7EPBhDHGEdVtj0X+esit/MXazeJo7JljD0hEHpbGIenTQ2E8djJQxPFQ/SxNMdm0YMhB
         Vh85rJvZN3C6Qwgma9e+iwhyVY3AzINAc63vM=
Received: by 10.216.8.204 with SMTP id 54mr745236wer.92.1310550134155; Wed, 13
 Jul 2011 02:42:14 -0700 (PDT)
Received: by 10.216.175.198 with HTTP; Wed, 13 Jul 2011 02:41:54 -0700 (PDT)
In-Reply-To: <20110712064706.GA13375@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177021>

Hi Jeff,

Jeff King writes:
> On Tue, Jul 12, 2011 at 12:11:44PM +0530, Ramkumar Ramachandra wrote:
>> Yes, it's a little like the information in .git/rebase-apply. =C2=A0=
We
>> should give the user the ability to tweak it by hand: the result fro=
m
>> sq_quote_argv and sq_dequote_argv would look very ugly. =C2=A0Hm, I =
don't
>> like the one-file-per-command-line-option approach because: we might
>> only have a few options now, but when the sequencer is built to
>> support many actions and options, the directory will be polluted wit=
h
>> lots of files. =C2=A0I was thinking more along the lines of somethin=
g that
>> can be parsed using gitconfig.
>
> I don't consider having lots of files there "pollution", but rather "=
a
> well-used key/value store". But I suppose it is in the eye of the
> beholder. :)

Ha, true.  After all .git/objects/ is "polluted" with lots of files :p
A couple of questions arise:
1. Would opening, writing, closing many files not put too much strain
on I/O, and hence affect performance significantly?
2. Will two options from different instructions (when we extend the
instruction sheet to accommodate them) have the same name, but
different effects?  Having a gitconfig-like configuration file doesn't
solve this problem either, so it's not a "configfile versus key-value
store" question.

> Using git-config is maybe a little more self-documenting than somethi=
ng
> like "sq_quote_argv". And probably not much more code (maybe even les=
s,
> since it can handle the file update for you).

Yeah :)

> I recently used the config code to write out a non-standard config fi=
le.
> My two complaints were:
>
> =C2=A01. You can't queue up a bunch of changes and then write the fil=
e once.
> =C2=A0 =C2=A0 Every time you call git_config_set, it rewrites the who=
le file.
>
> =C2=A02. There's no way to write to a nonstandard file short of the h=
orribly
> =C2=A0 =C2=A0 hack-ish:
>
> =C2=A0 =C2=A0 =C2=A0 const char *saved =3D config_exclusive_filename;
> =C2=A0 =C2=A0 =C2=A0 config_exclusive_filename =3D "foo.conf";
> =C2=A0 =C2=A0 =C2=A0 git_config_set(...);
> =C2=A0 =C2=A0 =C2=A0 config_exclusive_filename =3D saved;
>
> Point (2) is pretty easy to fix. But point (1) might be a bit more
> involved. I haven't really looked yet.

Thanks for pointing these out.  Yes, I'm aware of these issues, and
it's part of the reason I implemented my own parser.  It'll take some
time to refactor config.c so that it's usable by others in a sane
manner, no?  What do you suggest I do until then?  Can I try to get my
custom parser merged (and replaced by a more generic configparser when
it's ready), or should I throw away my parser and go with the
key-value store?

Just to clarify, here's an example to illustrate what I understand
when you say key-value store (please correct me if I got the idea
wrong):
=2Egit/sequencer/opts/ will have files like:
$ cat ff
true
$ cat record-origin
true
$ cat mainline
1
$ cat strategy
ours
$ cat strategy-option
patience + renormalize

-- Ram
