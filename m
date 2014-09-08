From: =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [RFH] renaming strcmp/strncmp-icase
Date: Mon, 08 Sep 2014 21:31:02 +0200
Message-ID: <540E03F6.3010100@web.de>
References: <xmqqmwaalzb4.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 08 21:31:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XR4eg-0004me-9g
	for gcvg-git-2@plane.gmane.org; Mon, 08 Sep 2014 21:31:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754036AbaIHTbI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Sep 2014 15:31:08 -0400
Received: from mout.web.de ([212.227.15.14]:56846 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752748AbaIHTbH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Sep 2014 15:31:07 -0400
Received: from macce.local ([78.72.74.102]) by smtp.web.de (mrweb001) with
 ESMTPSA (Nemesis) id 0Lj2TO-1XwZNu0qJa-00dBli; Mon, 08 Sep 2014 21:31:04
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.0
In-Reply-To: <xmqqmwaalzb4.fsf@gitster.dls.corp.google.com>
X-Provags-ID: V03:K0:TZc1DaJOmcxLN03ZYUwzlwnsOw9365c4g5HfV5vqOI5DMh3cAvY
 uI7dBozYJBPUPgZOk3LPezWrT0uFFMdciXyjsBc4pvZtUQRB2XB8bfhw2VOA9X8wFXp2Wo2
 1ZyB3a8ywcE8ZxmdBh8v6u4CJpfAxSFtT7qee6z9aGY/DxXONFcffHFGgosMjvRFOgw0Uv5
 G6P82EQpw28MXojdd0m5A==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256671>

On 2014-09-08 20.52, Junio C Hamano wrote:
> There are these two functions in dir.c that has only a handful of
> callers outside:
> 
>     int strcmp_icase(const char *a, const char *b);
>     int strncmp_icase(const char *a, const char *b, size_t count);
> 
> How many of you would think these are about comparing two strings in
> a case-insensitive way?
> 
> If you raised your hand (like I did), you were wrong.  These do
> comparison case-insensitively only on a case-insensitive filesystem,
> and hence calling it makes sense only for pathnames you grabbed out
> of the filesystem via readdir() (or the user gave us, intending to
> name paths).
> 
> To avoid confusion, I think they should be renamed to stress the
> fact that these are about comparing *PATHS*.  As I always say, I am
> bad at naming things and good suggestions are appreciated.
> 
> FYI, there are names I thought about and haven't managed to convince
> myself that they are good.
> 
> A good name for the non-n variant may be "compare_paths()", but that
> is used in "combine-diff.c".  "compare_pathnames()" may be a
> compromise.
> 
> However, either of these makes it hard to come up with a
> corresponding name for the "n" (counted) variant.  The best I could
> do was "compare_pathnames_counted()", but a nice similarity to
> strcmp()/strncmp() pair is lost.
> 
> pathnamecmp()/pathnamencmp() perhaps?
> 
> I dunno.
And then we have this in name-hash.c:
(Which may explain the "icase" suffix ?)

static int same_name(const struct cache_entry *ce, const char *name, int namelen, int icase)
{
	int len = ce_namelen(ce);

	/*
	 * Always do exact compare, even if we want a case-ignoring comparison;
	 * we do the quick exact one first, because it will be the common case.
	 */
	if (len == namelen && !memcmp(name, ce->name, len))
		return 1;

	if (!icase)
		return 0;

	return slow_same_name(name, namelen, ce->name, len);
}

-----------
static int slow_same_name(const char *name1, int len1, const char *name2, int len2)
{
	if (len1 != len2)
		return 0;

	while (len1) {
		unsigned char c1 = *name1++;
		unsigned char c2 = *name2++;
		len1--;
		if (c1 != c2) {
			c1 = toupper(c1);
			c2 = toupper(c2);
			if (c1 != c2)
				return 0;
		}
	}
	return 1;
}
