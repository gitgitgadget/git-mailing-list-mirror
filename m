From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC/PATCH 4/5] completion: get rid of compgen
Date: Sat, 17 Nov 2012 12:42:38 +0100
Message-ID: <CAMP44s21CUb3_KhHBfJXW+Eqd45kz1hcbx3GCbs+f0HNRDEAzw@mail.gmail.com>
References: <1353116298-11798-1-git-send-email-felipe.contreras@gmail.com>
	<1353116298-11798-5-git-send-email-felipe.contreras@gmail.com>
	<20121117110031.GE12052@goldbirke>
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
X-From: git-owner@vger.kernel.org Sat Nov 17 12:42:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZgnV-000833-FV
	for gcvg-git-2@plane.gmane.org; Sat, 17 Nov 2012 12:42:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751603Ab2KQLmk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 17 Nov 2012 06:42:40 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:61321 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751490Ab2KQLmj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 17 Nov 2012 06:42:39 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so3588803oag.19
        for <git@vger.kernel.org>; Sat, 17 Nov 2012 03:42:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=1vlZeT1sllNq+m/ivmWpBclJ8LbRsJCTDoxKLh5WUS8=;
        b=r/FTOHGwZxaBK0SnVqUDAlAD4MIW8b1CuLp65QLDhr24mr4Nb9cvamMa2P0c/cECpM
         Vf0cg1JH2JtWOT2l4aXEgFtqPvO34t9XCcWzH8xG+tBXtD4vC66SxRxYRJ9Qud/w2zD2
         lnXaZGGnm6MhTvf3UGb2B3uXzNFEcoPk5OjAlffm9BZDUp3rhzPWSRrIH2nep189z6Wy
         +A0K/E5aMGccoWmR9AgUWSbyJ9UePIw2+6p3wQhDqmL/BNuZkBINebWZR7yAUXGoeQ99
         yhx58Dc5Q0tMuycXCo9W8hzU6xnsPOGVHuHUgOM4g62CUXKrlU0Z6rxb1b01tHQEAFX+
         LhWA==
Received: by 10.60.14.101 with SMTP id o5mr3701349oec.85.1353152558910; Sat,
 17 Nov 2012 03:42:38 -0800 (PST)
Received: by 10.60.4.74 with HTTP; Sat, 17 Nov 2012 03:42:38 -0800 (PST)
In-Reply-To: <20121117110031.GE12052@goldbirke>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209950>

On Sat, Nov 17, 2012 at 12:00 PM, SZEDER G=C3=A1bor <szeder@ira.uka.de>=
 wrote:
> On Sat, Nov 17, 2012 at 02:38:17AM +0100, Felipe Contreras wrote:
>> The functionality we use is very simple, plus, this fixes a known
>> breakage 'complete tree filename with metacharacters'.
>>
>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>> ---
>>  contrib/completion/git-completion.bash | 6 +++++-
>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/contrib/completion/git-completion.bash b/contrib/comple=
tion/git-completion.bash
>> index 975ae13..ad3e1fe 100644
>> --- a/contrib/completion/git-completion.bash
>> +++ b/contrib/completion/git-completion.bash
>> @@ -227,7 +227,11 @@ fi
>>
>>  __gitcompadd ()
>>  {
>> -     COMPREPLY=3D($(compgen -W "$1" -P "$2" -S "$4" -- "$3"))
>> +     for x in $1; do
>> +             if [[ "$x" =3D "$3"* ]]; then
>> +                     COMPREPLY+=3D("$2$x$4")
>> +             fi
>> +     done
>
> The whole point of creating __gitcomp_nl() back then was to fill
> COMPREPLY without iterating through all words in the wordlist, making
> completion faster for large number of words, e.g. a lot of refs, or
> later a lot of symbols for 'git grep' in a larger project.
>
> The loop here kills that optimization.

So your solution is to move the loop to awk? I fail to see how that
could bring more optimization, specially since it includes an extra
fork now.

--=20
=46elipe Contreras
