From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: large files and low memory
Date: Tue, 5 Oct 2010 15:34:50 -0500
Message-ID: <20101005203450.GA2096@burratino>
References: <20101004092046.GA4382@nibiru.local>
 <AANLkTimbdrAqoWMxiteT5zNYmwHp8M698BEv1FLuiAxx@mail.gmail.com>
 <20101004185854.GA6466@burratino>
 <AANLkTin-mbzt93DWtp71vYBEUcDLHgo=G-6zynT5NC_r@mail.gmail.com>
 <20101004191657.GC6466@burratino>
 <alpine.LFD.2.00.1010051518570.3107@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Shawn Pearce <spearce@spearce.org>, weigelt@metux.de,
	git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Tue Oct 05 22:38:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3EHG-0005PV-EY
	for gcvg-git-2@lo.gmane.org; Tue, 05 Oct 2010 22:38:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753823Ab0JEUiQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Oct 2010 16:38:16 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:40426 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752070Ab0JEUiP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Oct 2010 16:38:15 -0400
Received: by fxm4 with SMTP id 4so746269fxm.19
        for <git@vger.kernel.org>; Tue, 05 Oct 2010 13:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=kH+lwydqbqZTmv0Idsog85DVQEObaQMhsZSwGTFeshU=;
        b=EE0D97RouBYaEWh2gY65ZAbH3kMXOJaObQY62II0MwcS60Zw4gNyqbkHNhCYJUWGCr
         9kkkuSlEGutp9N45bNPUkVShHOiW7zqYryRLL00ozSRUTTH8r6T+ZQI0srts2MWjC+kQ
         3vMY0dnJLk5yr31lpQBNV2kmNYhnAP93a0e3U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=uRlhphGIG116sF5ptoP0FA5zN1eUWJNrc7IgLy/Hrz+FXG1ZHLIOYLeDOQhbKBgAKK
         IMlXk+r14X9lCJjOU02vu3Ke76eQLvEdWnZDmxzA+xxnPM29kJ2QIdfYMXXJRNBK5V7E
         YuRsz5Ntf7cQlv2Y56Lkbk/QMtXmYFlVOSbZ4=
Received: by 10.223.1.146 with SMTP id 18mr11362279faf.80.1286311094229;
        Tue, 05 Oct 2010 13:38:14 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id k15sm3188300fai.40.2010.10.05.13.38.11
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 05 Oct 2010 13:38:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1010051518570.3107@xanadu.home>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158236>

Nicolas Pitre wrote:

> You can't do a one-pass  calculation.  The first one is required to 
> compute the SHA1 of the file being added, and if that corresponds to an 
> object that we already have then the operation stops right there as 
> there is actually nothing to do.

Ah.  Thanks for a reminder.

> In the case of big files, what we need to do is to stream the file data 
> in, compute the SHA1 and deflate it, in order to stream it out into a 
> temporary file, then rename it according to the final SHA1.  This would 
> allow Git to work with big files, but of course it won't be possible to 
> know if the object corresponding to the file is already known until all 
> the work has been done, possibly just to throw it away.

To make sure I understand correctly: are you suggesting that for big
files we should skip the first pass?

I suppose that makes sense: for small files, using a patch application
tool to reach a postimage that matches an existing object is something
git historically needed to expect, but for typical big files:

 - once you've computed the SHA1, you've already invested a noticeable
   amount of time.
 - emailing patches around is difficult, making "git am" etc less important
 - hopefully git or zlib can notice when files are uncompressible,
   making the deflate not cost so much in that case.
