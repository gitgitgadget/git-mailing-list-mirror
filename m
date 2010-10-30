From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v8 1/5] Introduce bulk-move detection in diffcore.
Date: Fri, 29 Oct 2010 19:26:00 -0500
Message-ID: <20101030002600.GC21410@burratino>
References: <1288303712-14662-1-git-send-email-ydirson@altern.org>
 <1288303712-14662-2-git-send-email-ydirson@altern.org>
 <20101029014540.GB28984@burratino>
 <20101029211852.GB5695@home.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Yann Dirson <ydirson@free.fr>
X-From: git-owner@vger.kernel.org Sat Oct 30 02:26:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBzGw-00029A-1i
	for gcvg-git-2@lo.gmane.org; Sat, 30 Oct 2010 02:26:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751916Ab0J3A0I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Oct 2010 20:26:08 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:41917 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751564Ab0J3A0H (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Oct 2010 20:26:07 -0400
Received: by gwj21 with SMTP id 21so2329769gwj.19
        for <git@vger.kernel.org>; Fri, 29 Oct 2010 17:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=7vwVwV3bnyZq0mX+TF6jmkW8iPRuQqm1hS/bX79fhf0=;
        b=uN0VXIN9bSnqC5ofzALm25x6dCJRXvlF9nvSHHU5HhTjjRVjpM7QULjLVQPm9RSyUS
         Bu1hmuhtmFTeVWmOQnoavrM4pnnMV1hg5kePQ/7i4fNh5asELqsQRplFAm55Vgs+SI0O
         4acE6rHe6k9q4DCdsrjcSkXaZ3TKqisSUaiis=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=ndAYRIfGuMt/5BB8JoSnjWmFsQkjCvR3eR1s93zuWstZWQIShjEpDPFrICSoaOxlGk
         6+V+gfh4wZcEs5IBTxpGJBMGLFkDcUEnxbvKrm8n7P9M8qnQG04O+qZ7d8s5sY0RXc0W
         NlJgOOOcc8N3eZq/WMcaQqA+24Gcg3/pZulQs=
Received: by 10.229.95.212 with SMTP id e20mr6959475qcn.20.1288398365585;
        Fri, 29 Oct 2010 17:26:05 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id k15sm2897041qcu.47.2010.10.29.17.26.03
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 29 Oct 2010 17:26:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101029211852.GB5695@home.lan>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160369>

Yann Dirson wrote:

> Hm, I fear too much granularity would become meaningless :)
[...]
>                 If the code needs to be easier to understand, I'd
> rather add some more doc, than added commits that are basically
> "useless for bisect".

Yes, the example list was probably a little overboard.  Even so, the
idea was to maintain bisectability by introducing a few tests at a
time.  That way, the fallout of a subfeature can easily be found with
"git bisect", among other benefits[1].

I might try it out some time soon; don't worry about it if you don't
like the idea. :)

> On Thu, Oct 28, 2010 at 08:45:40PM -0500, Jonathan Nieder wrote:

>> 1. introduce DETECT_DIRECTORY_RENAMES flag and hidden UI for it.
>
> What do you mean by "hidden UI" ?

PARSE_OPT_HIDDEN (i.e., a commandline option not tempting readers by
listing in -h).

>> Is the debugging output infrequent enough to just use a function
>> unconditionally?
>
> You mean, keep funccalls even with DEBUG_BULKMOVE is not set ?  No,
> there are too many traces for that.

Yep, that's what I meant.  Alas.

Will the debugging output still be useful once the code is known
to work reliably?  If not, I guess we can remove it at that point
(avoiding the need to worry about patches that may introduce

	debug_bulkmove(expression that does not even
		       typecheck);

down the line).

> Ah, sure the dst==src case can be improved.  But I'm not sure
> factorizing writing NUL is worth the cost of re-computing where to put
> it when using mempcpy would avoid.  Wouldn't the following be more
> adequate ?
> 
> 	if (dst != src) {
> 		end = mempcpy(dst, src, slash - src + 1);
> 		*end = '\0';
> 	} else
> 		dst[slash - src + 1] = '\0';
> 	return dst;

I doubt the difference is measurable.  But that looks fine (micronit:
I suppose one should put the dst == src case first in that case).

Jonathan

[1] The example that set me on this path to madness:
http://thread.gmane.org/gmane.comp.version-control.git/151086/focus=158913
