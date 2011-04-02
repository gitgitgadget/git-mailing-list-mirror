From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/2] fast-import: use struct hash_table for atom strings
Date: Fri, 1 Apr 2011 22:33:21 -0500
Message-ID: <20110402033321.GA7023@elie>
References: <1301572798-9973-1-git-send-email-david.barr@cordelta.com>
 <1301572798-9973-2-git-send-email-david.barr@cordelta.com>
 <20110402024209.GA6039@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Stephen Boyd <bebarino@gmail.com>
To: David Barr <david.barr@cordelta.com>
X-From: git-owner@vger.kernel.org Sat Apr 02 05:33:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5rai-0007cf-KZ
	for gcvg-git-2@lo.gmane.org; Sat, 02 Apr 2011 05:33:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752068Ab1DBDd3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Apr 2011 23:33:29 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:63882 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751393Ab1DBDd2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Apr 2011 23:33:28 -0400
Received: by iyb14 with SMTP id 14so4119751iyb.19
        for <git@vger.kernel.org>; Fri, 01 Apr 2011 20:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=bUmCd7ukCwe5HzQ3HQlJfX6wYysUEIEPBvDkQ4JBuyM=;
        b=bX0AaAeTm2rPJHi+nrDM4tdMyauAuPYjfeiZ0iw/rUW4uwp62KdXphXsJpQ2BD0MP4
         S51enZCvSYwUJW8GB5GiNvFpykN/9PVZMAJ3K5AErr/aJwTlWSF/UAau91XwLZYmYnAL
         tE6AtQKE7f8FFR53mkNLxNHJi7bCbnb55m93I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=v6g6d52eqWtKKvdhtCFhpkEMRwegwDdD2OXDY48141b5U9zy6bESdNaMbykuxDV6Mw
         xseoJSSCmmTEaahpAIQDsXiEYNsp2Nd7mvnupgS+VVZ3HyJCAEeHH8Zs33mqCJ/Jlj5Z
         giZrN6ah1599+pyW8Wofb7ut9MX5MHXXJSjks=
Received: by 10.231.193.68 with SMTP id dt4mr4582689ibb.123.1301715208131;
        Fri, 01 Apr 2011 20:33:28 -0700 (PDT)
Received: from elie (adsl-68-255-107-98.dsl.chcgil.ameritech.net [68.255.107.98])
        by mx.google.com with ESMTPS id i26sm1881911iby.7.2011.04.01.20.33.24
        (version=SSLv3 cipher=OTHER);
        Fri, 01 Apr 2011 20:33:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110402024209.GA6039@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170641>

Jonathan Nieder wrote:

>> @@ -691,8 +691,12 @@ static struct atom_str *to_atom(const char *s, unsigned short len)
>>  	c->str_len = len;
>>  	strncpy(c->str_dat, s, len);
>>  	c->str_dat[len] = 0;
>> -	c->next_atom = atom_table[hc];
>> -	atom_table[hc] = c;
>> +	c->next_atom = NULL;
>> +	pos = insert_hash(hc, c, &atom_table);
>> +	if (pos) {
>> +		c->next_atom = *pos;
>> +		*pos = c;
>> +	}
>
> If I understand correctly, this puts new atoms at the start of the
> chain, just like v1.7.4-rc0~40^2 (fast-import: insert new object
> entries at start of hash bucket, 2010-11-23) did for objects.  Did you
> measure and find this faster, or is it just for simplicity or
> consistency?  (I'd personally be fine with it either way, but it seems
> prudent to ask.)

Agh.  Too-quick reading on my part (or rather, I lazily made an
assumption and didn't pay much attention to the old code at all).  I
have no reason to believe inserting at the end of the bucket would be
better, and it would certainly be more complex.

Sorry, folks.  Don't mind me.
