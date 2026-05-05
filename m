Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87FE480959
	for <git@vger.kernel.org>; Tue,  5 May 2026 15:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777993479; cv=none; b=V/HoPAn2K2IjA3x9iMQfPrPeCNXn9+LVKsUqRETGlEk7yPBD+8whB5USXakSPniPlH/o0pV25hEz5vH6N0i2Gki9O+hxjwGr7YAqRN5JjVFL1gjtaZPNnSOibmdvCoCorDmzPzOG+uwYYkD1WatqApg41ZX99nly9UYFZRgg0J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777993479; c=relaxed/simple;
	bh=E4gykmB9hpsNGOs6BXTLfBMtx6NOhE77B5vHXDnN+kQ=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=MOsdfba4EVaHb0GyV8sgc2mE3x9v2xR3yvxWDwwxXljBMAaxRCOkdWK9xKKZocvHTSSOYF3DSF9SjQO5YoBxqJPNrnMzt6Z5zCNfLVyDw707/Pe/ggfVqbENHHhTQq+WGZ/OrhJDLyVQNoE7TeRTO91y1TVB4vjNoN754C1RaIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 645F4XE31756995
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 5 May 2026 15:04:34 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Junio C Hamano'" <gitster@pobox.com>
Cc: <git@vger.kernel.org>
References: <079201dcdbe7$162d5430$4287fc90$@nexbridge.com> <xmqqzf2em2v8.fsf@gitster.g>
In-Reply-To: <xmqqzf2em2v8.fsf@gitster.g>
Subject: RE: Question on Clean/Smudge Infrastructure
Date: Tue, 5 May 2026 11:04:28 -0400
Organization: Nexbridge Inc.
Message-ID: <082601dcdca0$7bcb6e80$73624b80$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQEXd0ASMgVxZWv2C4qpmK03Dso5ogJqZiyJt3b+3vA=
X-Antivirus: Norton (VPS 260505-2, 5/5/2026), Outbound message
X-Antivirus-Status: Clean

On May 5, 2026 8:56 AM, Junio C Hamano wrote:
> <rsbecker@nexbridge.com> writes:
> 
> > Hi Git,
> >
> > I have a edge use case that I would like to ask about.
> >
> > Given a directory with a large number, say 100, text files, and a few
> > scattered binary files - specified in .gitattributes as binary, what
> > does clean smudge do with the binary files if they match the filter
> > specification pattern? Are they ignored or processed. I am not sure
> > that passing binary via stdin is necessarily portable. However, I
> > would like to be able to explicitly ignore the binary files in my
> > clean/smudge filters - either by doing a copy stdin/stdout (as I said,
> > probably not portable), or sending a non-zero exit code, or some other
> > mechanism.
> > The root of the use case is that the directory is subject to
> > significant changes over time, and errors are sneaking in when people
> > forget to update .gitattributes or name the files incorrectly. I would
> > like to make their situation more stable to errors.
> >
> > Thanks,
> > Randall
> >
> > --
> > Brief whoami: NonStop&UNIX developer since approximately
> > UNIX(421664400)
> > NonStop(211288444200000000)
> > -- In real life, I talk too much.
> 
> 
> * Passing binary via stdin is perfetly normal.  Otherwise, it would
>   not work to set "exif" as the textconv filter on JPEG image files.
> 
> * The "filter" attribute is orthogonal to other attributes like
>   "text" or "diff".  If "filter" somehow paid attention to
>   binary-ness of the payload and refrained from working at all, then
>   it would make it impossible to filter binary contents.
> 
> * If you want to apply your "filter" attribute to a subset of the
>   files you have, you need to sift your files into two classes, ones
>   that your filter would be used, and the other the remainder.  And
>   they give your filter attribute only to the former.  Perhaps you
>   only want *.txt to go through clean/smudge, and then you would
>   have
> 
>     *.txt filter=mytextfilter
> 
>   in your .gitattributes, and in your .git/config, you would have
>   lines to speicify the executable you can use on each system.
> 
>    [filter "mytextfilter"]
> 	clean = ... your system specific command comes here ...
> 	smudge = ... your system specific command comes here ...

Thanks. I'm going to add a mechanism to auto-add file extensions
for this situation. That will allow me to select by pattern and
improve long-term manageability.

Regards,
Randall

