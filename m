From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH/RFC v3 6/8] Add case insensitivity support when using
 git ls-files
Date: Mon, 4 Oct 2010 02:49:16 -0500
Message-ID: <20101004074916.GK24884@burratino>
References: <4CA847D5.4000903@workspacewhiz.com>
 <1286099806-25774-7-git-send-email-avarab@gmail.com>
 <AANLkTimH8Lj69qcOCmR3+5HYfgKnr5nyMvQU=9h0=FaB@mail.gmail.com>
 <201010032019.09244.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Adam <thomas@xteddy.org>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Joshua Jensen <jjensen@workspacewhiz.com>,
	Brandon Casey <drafnel@gmail.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Mon Oct 04 09:52:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2fqm-0001Ir-0y
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 09:52:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752768Ab0JDHwf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Oct 2010 03:52:35 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:36844 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752185Ab0JDHwb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Oct 2010 03:52:31 -0400
Received: by iwn5 with SMTP id 5so6592606iwn.19
        for <git@vger.kernel.org>; Mon, 04 Oct 2010 00:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=RPYvwzCTVq26LnvSkW9WSkcxXmUT1OOuVbk88V7v99A=;
        b=Uvlu03tgVDVCAnZ2x0BZvlzVwI9MfVcobmf0Ek13dlVaeznSl599+Eu+9b7MC3cUQv
         G3dQtpvHFZfOr7ZirbVatFay5IPw+1oF/TNifmbnRHyPNuELIGfh8ZSHTOGBlz8A0FsA
         yTPrHMp7C8Fe1unaHRipULl0+njpm+7v32OdA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=cjOGwHwQCeohujAWLgNGIVNulfx3Y3y+EUKoC9THXSuUk2xhJgSgd59cozhotQ/xjR
         2qBmT3Bn9Xpj84jaBKbyh+D4ecBoG/KXJscBoezonMOmJjTAtxFwbw7Vgn1XH3KnQ/ny
         LE9C9qTPwDCKNM7I5FESw8g0gZ37zdbln3tpU=
Received: by 10.231.35.66 with SMTP id o2mr1878869ibd.30.1286178751254;
        Mon, 04 Oct 2010 00:52:31 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id u6sm3003805ibd.18.2010.10.04.00.52.29
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 04 Oct 2010 00:52:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <201010032019.09244.j6t@kdbg.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158003>

Johannes Sixt wrote:
> On Sonntag, 3. Oktober 2010, Thomas Adam wrote:

>> It's a real shame about the code duplication here.  Can we not avoid
>> it just by doing:
>>
>> unsigned char c1 = (ignore_case) ? tolower(*match) : *match;
>> unisgned char c2 = (ignore_case) ? tolower(*name) : *name;
>>
>> I appreciate that to some it might look like perl golf, but...
>
> It has been discussed, and IIRC, the concensus was to keep the code 
> duplication because this is an inner loop.

Did anyone time it?  If it really is not dwarfed by other computation,
then how about (warning: ugly!)

static inline int step(unsigned char c1, unsigned char c2,
                       const char **match, const char **name, int *namelen)
{
	if (c1 == '\0' || is_glob_special(c1))
		return 1;	/* break */
	if (c1 != c2)
		return 0;	/* found mismatch! */
	(*match)++;
	(*name)++;
	(*namelen)--;
	return 2;	/* continue */
}
...

int r = 1;
if (!ignore_case) {
	while ((r = step(*match, *name, &match, &name, &namelen)) == 2)
		; /* matches so far */
} else {
	while ((r = step(tolower(*match), tolower(*name),
	                 &match, &name, &namelen)) == 2)
		; /* matches so far */
}
if (!r)	/* found mismatch! */
	return 0;
