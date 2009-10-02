From: Marius Storm-Olsen <mstormo@gmail.com>
Subject: Re: MSVC build broken (on cygwin)
Date: Fri, 02 Oct 2009 10:49:42 +0200
Message-ID: <4AC5BEA6.5000102@gmail.com>
References: <4AC4E2C2.6030509@ramsay1.demon.co.uk> <4AC5B4AE.5070307@gmail.com> <81b0412b0910020123j13c74497w874e301c38cddec9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	GIT Mailing-list <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 02 10:49:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mtdpq-0000O6-MI
	for gcvg-git-2@lo.gmane.org; Fri, 02 Oct 2009 10:49:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750870AbZJBItp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Oct 2009 04:49:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750725AbZJBItp
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Oct 2009 04:49:45 -0400
Received: from ey-out-2122.google.com ([74.125.78.25]:52380 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750815AbZJBIto (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Oct 2009 04:49:44 -0400
Received: by ey-out-2122.google.com with SMTP id 4so186126eyf.19
        for <git@vger.kernel.org>; Fri, 02 Oct 2009 01:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=bBB1z9rc8grD+UnjcP4HoQZm2uIm/X/tW9hpy0ElFkU=;
        b=qz0ajIycQcnQJ25HcFm/sKeBNl4jgw7rY9tvzPg7x4DIEjG3waZip83Trrhq5YamoO
         eDBpcGF7znLs/OtlzFLmV0plbRS87quTHty/UjM8t+CKZYrTlZPJx98PAg4ZRgvMhnUE
         Ry+gPFHw8hfGcW7ZqyWXAs+UrjLDU+y1mj4vw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=amUSKZF5z/y4MI+RsNiWlvZK2UwDgU8cASKjMkUxZ5h4XaHQy2M146J8e+jpVPcImH
         mi6OxNiicwxxmmN++2w/HqIADdEs4ZW+HuYTjkXbomY5AuyD3QHig+o7D8ns+I5vc4Rq
         bsA27aCVNtqipzGFWTW6hfM6hKIlqZKDrcoUE=
Received: by 10.210.154.9 with SMTP id b9mr9152489ebe.34.1254473386894;
        Fri, 02 Oct 2009 01:49:46 -0700 (PDT)
Received: from ?172.24.90.95? ([62.70.27.104])
        by mx.google.com with ESMTPS id 10sm2028601eyd.21.2009.10.02.01.49.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 02 Oct 2009 01:49:46 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.23) Gecko/20090812 Lightning/0.9 Thunderbird/2.0.0.23 ThunderGit/0.1a Mnenhy/0.7.6.666
In-Reply-To: <81b0412b0910020123j13c74497w874e301c38cddec9@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129436>

Alex Riesen said the following on 02.10.2009 10:23:
> MSVC (all versions) define a compiler specific _MSC_VER, if that's of any use.

In this case it was define guards to let both MSVC and MinGW through 
:) Both use _WIN32 and WIN32, which Cygwin gcc normally doesn't, 
unless, as Ramsay said, you specify -mno-cygwin, or include windows.h 
apparently.

Maybe we should allow Cygwin to also include the LEAN_AND_MEAN 
windows.h in git-compat-util.h, and rather fix up the guards to 
cleanly differ between Cygwin and non-Cygwin on Windows?

Apparently, nothing is broken in neither Cygwin, MinGW or MSVC after 
Ramsays whitespace fix, but I'm sure it might get hairy later, if/when 
we get more Windows contributions. Keeping the guards right could get 
tricky.

So, something like this maybe, in git-compat-util.h:

#if defined(__MINGW32__) || defined(_MSC_VER)
#  defined API_WIN32
#  defined OS_WINDOWS
#elif defined(__CYGWIN__)
#  defined API_POSIX
#  defined OS_WINDOWS
#else
#  defined API_POSIX
#endif

So, then we can use #ifdef API_WIN32 when using the Win32 API is the 
only option/preferred for MinGW or MSVC; and use #ifdef OS_WINDOWS 
when there are things that affect all the Windows builds.

Opinions?

--
.marius
