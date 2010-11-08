From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [RFC/PATCH 1/5] gettext: fix bug in git-sh-i18n's eval_gettext()
 by using envsubst(1)
Date: Mon, 8 Nov 2010 23:39:49 +0100
Message-ID: <AANLkTimjRwSxkemMffASvHCxK009b1fnvNRs05_T_1DF@mail.gmail.com>
References: <AANLkTikOgMGqw5fc95c2VGwXxKu9rmsA+=z5_jykD92=@mail.gmail.com>
	<1288524860-538-2-git-send-email-avarab@gmail.com>
	<4CCFCCC8.7080603@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Nov 08 23:40:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFaNc-0001tx-5w
	for gcvg-git-2@lo.gmane.org; Mon, 08 Nov 2010 23:40:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755922Ab0KHWjw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Nov 2010 17:39:52 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:39483 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755401Ab0KHWjv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Nov 2010 17:39:51 -0500
Received: by fxm16 with SMTP id 16so4492843fxm.19
        for <git@vger.kernel.org>; Mon, 08 Nov 2010 14:39:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=sXmXdIGcc4XQXBEvNDcpSaBqLmE02m0PWJ5vVGGo0R8=;
        b=ECIcLymDrAUPv2DlmdPIE7EqLrz4qimcM+OQhaTS2bAvNmx7tMcLzH/OForwxrYaa1
         Ge1YB0d5pofv8Czm701TIUouukgKGjMIRLwC+bBpTVlDihhtZ2ifQxEMdbEB8vNiMIDs
         8yFBT5lCnZ700NMGP5QUB9I7WvBUrkZEkq1gk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=pKNLExJTzUjjJ9P4zHM0ORdYiwJgIWCzTFcdz3MtP0H6/N5AqYF2n3DWZZBw0pYV5o
         80igTTMQm3Htj9jmhi7pF8rC3IZ8l7+AdVLAd4aA926lleP81UIdG/TX514/7CZFaJ++
         KhoYBtR/I43DOZ26KVFrhhpf4JmWF2+k8M4pg=
Received: by 10.223.86.6 with SMTP id q6mr4305041fal.144.1289255990023; Mon,
 08 Nov 2010 14:39:50 -0800 (PST)
Received: by 10.223.105.78 with HTTP; Mon, 8 Nov 2010 14:39:49 -0800 (PST)
In-Reply-To: <4CCFCCC8.7080603@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161005>

On Tue, Nov 2, 2010 at 09:33, Johannes Sixt <j.sixt@viscovery.net> wrot=
e:
> Am 10/31/2010 12:34, schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>> Change eval_gettext(1) in git-sh-i18n.sh to use a modified version o=
f
>> gettext's envsubst(1) program, instead of using a clever (but broken=
)
>> printf + eval + printf trick.
>>
>> Our previous fallback would incorrectly handle cases where the
>> variable being interpolated contained spaces. E.g.:
>>
>> =C2=A0 =C2=A0 cmd=3D"git foo"; eval_gettext "command: \$cmd"
>>
>> Would emit "command: gitfoo", instead of the correct "command: git
>> foo". This happened with a message in git-am.sh that used the $cmdli=
ne
>> variable.
>>
>> To work around this, and to improve our variable expansion behavior
>> (eval has security issues) I've imported a stripped-down version of
>> gettext's envsubst(1) program.
>
> Would this help the case mentioned above at all? To pass the value of
> 'cmd' to envsubst, you have to export it. But the code snippet above
> doesn't do that.

Right, I had a major brainfart. GNU gettext.sh actually works like:

    eval_gettext () {
      gettext "$1" | (export PATH `envsubst --variables "$1"`; envsubst=
 "$1")
    }

So I need to re-make this patch to support --variables.

> Wouldn't it be much simpler to dodge variable substitutions in the
> translated string entirely by rewriting such texts as (e.g.)
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0gettext_printf "command: %s\n" "$cmd"
>
> and use printf in the implementation. I don't know how compatible you=
 can
> make this with existing gettext implementations, though.

Using named variables is easier to use, and works drop-in with the GNU =
gettext
way of doing things. Once I implement --variables (or rather,
un-un-implement them)
it'll just work.

Thanks for the review, and for spotting this sillyness.
